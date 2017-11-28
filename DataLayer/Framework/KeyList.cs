using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.ComponentModel;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Implements a Cached Keyset List similar to the way that Microsoft Access handles keyed row retrievals.
  /// When the Fill method is invoked only the resulting keys are returned from the database.  This keyset is
  /// then used to provide the list limits and order.  The actual associated business objects are then loaded
  /// on demand by using the keys in the keyset.  Finally, an internal cache is used to store up to 400 
  /// business objects.  When the cache overflows, it is automatically pruned back to the maximum
  /// size by removing the least recently accessed business objects. 
  /// </summary>
  /// <typeparam name="TKey">The type of key that identifies a unique business object in the list.</typeparam>
  /// <typeparam name="TValue">The type of business object in the list.  The business object must
  /// implement the IBusinessObject interface.</typeparam>
  /// <remarks>To optimize data retrieval, the SQL commands are prepared on the server.  This requires
  /// that this object maintain a single connection for the life of the object.  If necessary, the
  /// connection to use can be specified when creating an instance of the class.</remarks>
  public class KeyList<TKey, TValue> : IDisposable, IList<TValue>, IList, IKeyList 
    where TValue : class, IBusinessObject
  {
    private readonly object _syncRoot = new object();
    private List<TKey> _keys;
    private Dictionary<TKey, CacheValue<TValue>> _values;
    private int _maxSize = 400;
    private int _blockSize = 15;

    private SqlConnection _connection;
    private TableSchema<TValue> _schema;
    private ColumnAttribute _keyColumn;
    private string _selectKeyListTemplate;
    private string _selectValuesTemplate;
    private SqlCommand _selectOneCommand;
    private SqlCommand _selectBlockCommand;
    private MethodInfo _loadNewMethod;
    private bool _sharedConnection = false;

    private int _position = -1;
    private long _readCount = 0;
    private long _cacheHits = 0;
    private bool _disposed = false;

    #region ctor

    private KeyList() { }

    /// <summary>
    /// Creates a new instance of a KeyList object, specifying the SQLConnection
    /// to use for data retrievals.
    /// </summary>
    /// <param name="connection">The SQLConnection to use.</param>
    public KeyList(SqlConnection connection)
    {
      _connection = connection;
      _sharedConnection = true;
      Initialize();
    }

    /// <summary>
    /// Disposes the KeyList object and frees any allocated resources.
    /// </summary>
    ~KeyList()
    {
      Dispose(false);
    }

    private void Initialize()
    {
      // Get Schema
      _schema = TableSchema<TValue>.GetSchema();
      if (_schema.Keys.Count != 1) { throw new ArgumentException("The specified type does not have a valid Schema.  The KeyList class requires a single-part key"); }

      // Get LoadNew Method
      _loadNewMethod = (typeof(TValue)).GetMethod("LoadNew", BindingFlags.NonPublic | BindingFlags.Static);
      if (_loadNewMethod == null) { throw new ArgumentException("The specified type does not have a compatible static LoadNew method."); }

      // Get database name of key column
      foreach (var col in _schema.Keys)
      {
        _keyColumn = col.Value;
        break;
      }

      // Check for SelectCommand in type, if it is there use it!
      System.Reflection.FieldInfo fi = (typeof(TValue)).GetField("SelectCommand", BindingFlags.NonPublic | BindingFlags.Static);
      if (fi != null)
      {
        _selectValuesTemplate = (string)fi.GetValue(null);
        _selectKeyListTemplate = CrudFactory.MakeSelectKeyTemplate(_schema, _selectValuesTemplate);
      }
      else
      {
        _selectValuesTemplate = CrudFactory.MakeSelectTemplate(_schema);
        _selectKeyListTemplate = CrudFactory.MakeSelectKeyTemplate(_schema);
      }

      // Get select templates
      _selectOneCommand = CreateSelectOneCommand();
      _selectOneCommand.Prepare();
      _selectBlockCommand = CreateSelectBlockCommand();
      _selectBlockCommand.Prepare();
    }

    #endregion

    #region Navigation

    /// <summary>
    /// Moves the cursor to the first index in the key list.
    /// </summary>
    public void MoveFirst()
    {
      if (_keys.Count > 0) { _position = 0; }
    }

    /// <summary>
    /// Moves the cursor to the last index in the key list.
    /// </summary>
    public void MoveLast()
    {
      if (_keys.Count > 0) { _position = _keys.Count - 1; }
    }

    /// <summary>
    /// Moves the cursor to next index in the key list.
    /// </summary>
    public void MoveNext()
    {
      if (_position < _keys.Count) { _position++; }
    }

    /// <summary>
    /// Moves the cursor to the previous index in the key list.
    /// </summary>
    public void MovePrevious()
    {
      if (_position > 0) { _position--; }
    }

    /// <summary>
    /// Gets or sets the current cursor position in the key list.
    /// </summary>
    /// <exception cref="ArgumentOutOfRangeException">Position is out of range - value must be between 0 and the size of the list.</exception>
    public int Position
    {
      get { return _position; }
      set
      {
        if (_position < 0 || _position > _keys.Count) { throw new ArgumentOutOfRangeException("Position", value, "Position is out of range - value must be between 0 and the size of the list"); }
        _position = value;
      }
    }

    /// <summary>
    /// Moves the cursor to the position in the key list that matches the specified key.
    /// </summary>
    /// <param name="key">The key to find.</param>
    /// <exception cref="ArgumentException">The specified key is not in the list.</exception>
    public void MoveToKey(TKey key)
    {
      int index = _keys.IndexOf(key);
      if (index == -1) { throw new ArgumentException("The specified key is not in the list"); }
      _position = index;
    }

    /// <summary>
    /// Gets the business object at the current cursor position.
    /// </summary>
    /// <value>The business object at the current cursor position, or null if the list is empty.</value>
    public TValue Value
    {
      get
      {
        if (_position == -1) { return null; }
        return GetValueAtIndex(_position);
      }
    }

    #endregion

    #region Public Methods

    /// <summary>
    /// Returns the type of item contained in the list.
    /// </summary>
    /// <returns>The Type of item the list contains.</returns>
    public Type GetItemType()
    {
      return typeof(TValue);
    }

    IBusinessObject IKeyList.GetNewItem() { return GetNewItem(); }

    /// <summary>
    /// Gets a new instance of the type of item contained in the list.  
    /// </summary>
    /// <returns>A new object of type TValue.</returns>
    /// <remarks>This is intended to be used when creating new business objects to add
    /// to the list.  Reflection is used to invoke the static GetNew method of the
    /// business object.</remarks>
    public TValue GetNewItem()
    {
      // use reflection to find the static GetNew method of the TValue type
      MethodInfo mi = typeof(TValue).GetMethod("GetNew", BindingFlags.Static | BindingFlags.Public);
      return (TValue)mi.Invoke(null, null);
    }

    /// <summary>
    /// Fills the KeyList from the database based on the provided SqlFilter.  Any existing list
    /// will be cleared.
    /// </summary>
    /// <param name="filter">A SqlFilter that describes the filter, order and row limit.</param>
    public void Fill(SqlFilter filter)
    {
      lock (_syncRoot)
      {
        // Clear everything!
        Clear();

        //TValue x = new TValue();
        // Get new Keys List
        // Load the list from the database
        using (SqlCommand cmd = Framework.CrudFactory.GetSelectCommand(_selectKeyListTemplate, filter))
        {
          cmd.Connection = _connection;
          using (SqlDataReader rs = cmd.ExecuteReader())
          {
            while (rs.Read()) { _keys.Add((TKey)rs[0]); }
          }
        }

        // Pre-Load first value in keylist
        if (_keys.Count > 0)
        {
          _position = 0;
          GetOne(_keys[_position]);
        }
      }
    }

    /// <summary>
    /// Gets the business object with the specified key.  If necessary, the object will be retrieved from
    /// the database and cached.
    /// </summary>
    /// <param name="key">The key of the object to retrieve.</param>
    /// <returns>The business object with the specified key.</returns>
    public TValue GetValue(TKey key)
    {
      _readCount++;
      // Return item if already in cache
      CacheValue<TValue> cacheItem;
      if (_values.TryGetValue(key, out cacheItem))
      {
        _cacheHits++;
        return cacheItem.Value;
      }
      // Otherwise get item and add to cache
      lock (_syncRoot) { return GetNew(key); }
    }

    /// <summary>
    /// Gets the business object with the key at the specified index in the key list.  If necessary,
    /// the object will be retrieved from the database and cached.
    /// </summary>
    /// <param name="index">The index of the object to retrieve.</param>
    /// <returns>The business object with the key at the specified index in the key list.</returns>
    public TValue GetValueAtIndex(int index)
    {
      TKey key = _keys[index];
      return GetValue(key);
    }

    /// <summary>
    /// Gets the current size of the value cache
    /// </summary>
    public int CacheSize { get { return _values.Count; } }

    /// <summary>
    /// Gets the percentage of cache hits when retreiving business objects. 
    /// </summary>
    public float CacheHitPercent
    {
      get
      {
        if (_readCount == 0) { return 0; }
        return (Single)_cacheHits / (Single)_readCount; 
      }
    }

    /// <summary>
    /// Adds a new business object to the list and caches it.
    /// </summary>
    /// <param name="item">The business object to add.  Must be of type TValue.</param>
    public void AddItem(IBusinessObject item)
    {
      if (!(item is TValue))
        throw new Exception("Item is the wrong type for this keylist.");

      TValue newValue = (TValue)item;
      TKey newKey = GetKeyFromItem(newValue);
      _keys.Add(newKey);
      AddValueToCache(newKey, newValue, false);
    }

    #endregion

    #region Helper Methods

    // Gets and caches a new value for the specified key, nearby values
    // will be cached as well.
    private TValue GetNew(TKey key)
    {
      // Read-ahead cache
      // Attempt to read up to blockSize non-cached values within +,- of current position.
      TValue result = null;
      IList<TKey> keyList = GetKeyBlock(key);
      SqlCommand cmd;
      if (keyList.Count == 1)
      {
        // Get a single key from the database.
        cmd = _selectOneCommand;
        cmd.Parameters[0].Value = key;
      }
      else
      {
        // Get a block of keys from the database as needed to fill the cache.
        cmd = _selectBlockCommand;
        SetBlockSelectParams(cmd, _blockSize, keyList);
      }        

      using (SqlDataReader rs = cmd.ExecuteReader())
      {
        while (rs.Read())
        {
          TValue newValue = (TValue)_loadNewMethod.Invoke(null, new object[] { rs });
          TKey newKey = GetKeyFromItem(newValue);
          AddValueToCache(newKey, newValue, false);
          if (newKey.Equals(key)) { result = newValue; }
        }
      }
      PruneCache();
      return result;
    }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    private SqlCommand CreateSelectOneCommand()
    {
      SqlCommand tmpCmd = null;
      SqlCommand cmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        SqlDbType ptype = GetDBType(typeof(TKey));
        string filter = string.Format(" WHERE {0}=@P0", _keyColumn.Name);
        tmpCmd.CommandText = string.Format(_selectValuesTemplate, "", filter, "");
        tmpCmd.Parameters.Add("P0", ptype, _keyColumn.Size);
        tmpCmd.CommandType = CommandType.Text;
        tmpCmd.Connection = _connection;
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    private SqlCommand CreateSelectBlockCommand()
    {
      SqlCommand tmpCmd = null;
      SqlCommand cmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        SqlDbType ptype = GetDBType(typeof(TKey));
        StringBuilder sb = new StringBuilder();
        sb.Append(" WHERE ");
        for (int nx = 0; nx < _blockSize; nx++)
        {
          string paramName = "@P" + nx.ToString();
          sb.Append(string.Format("{0}{1}={2}", nx == 0 ? "" : " OR ", _keyColumn.Name, paramName));
          tmpCmd.Parameters.Add(paramName, ptype, _keyColumn.Size);
        }
        tmpCmd.CommandText = string.Format(_selectValuesTemplate, "", sb.ToString(), "");
        tmpCmd.CommandType = CommandType.Text;
        tmpCmd.Connection = _connection;
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    private static SqlDbType GetDBType(Type theType)
    {
      SqlParameter p1 = new SqlParameter();
      System.ComponentModel.TypeConverter tc = System.ComponentModel.TypeDescriptor.GetConverter(p1.DbType);
      if (tc.CanConvertFrom(theType))
        p1.DbType = (DbType)tc.ConvertFrom(theType.Name);
      else
      {
        //Try brute force
        try
        {
          p1.DbType = (DbType)tc.ConvertFrom(theType.Name);
        }
        catch { } //Do Nothing
      }
      return p1.SqlDbType;
    }

    private static void SetBlockSelectParams(SqlCommand cmd, int blockSize, IList<TKey> keyList)
    {
      for (int nx = 0; nx < blockSize; nx++)
      {
        if (nx >= keyList.Count) { cmd.Parameters[nx].Value = DBNull.Value; }
        else { cmd.Parameters[nx].Value = keyList[nx]; }
      }
    }

    private TValue GetOne(TKey key)
    {
      TValue result = null;
      SqlCommand cmd = _selectOneCommand;
      cmd.Parameters[0].Value = key;
      using (SqlDataReader rs = cmd.ExecuteReader(CommandBehavior.SingleRow))
      {
        if (rs.Read())
        {
          TValue newValue = (TValue)_loadNewMethod.Invoke(null, new object[] { rs });
          TKey newKey = GetKeyFromItem(newValue);
          AddValueToCache(newKey, newValue, true);
          result = newValue;
        }
      }
      return result;
    }

    // Gets a block of uncached keys near the current position
    // Searches forward blockSize rows and then backward blockSize rows
    private List<TKey> GetKeyBlock(TKey startKey)
    {
      var keyList = new List<TKey>();
      keyList.Add(startKey);
      int startIndex = _keys.IndexOf(startKey);
      int endIndex = Math.Min(startIndex + _blockSize, _keys.Count);
      for (int nx = startIndex + 1; nx < endIndex; nx++)
      {
        TKey key = _keys[nx];
        if (!_values.ContainsKey(key)) { keyList.Add(key); }
      }
      if (keyList.Count < _blockSize)
      {
        endIndex = Math.Max(startIndex - _blockSize, 0);
        for (int nx = startIndex - 1; nx > endIndex; nx--)
        {
          TKey key = _keys[nx];
          if (!_values.ContainsKey(key)) { keyList.Add(key); }
        }
      }
      return keyList;
    }

    private static TKey GetKeyFromItem(TValue item)
    {
      var ikey = item as IKeyedObject<TKey>;
      if (ikey == null) { throw new Exception("Target item does not implement IKeyedObject"); }
      return ikey.GetKeyFromItem();
    }

    private void AddValueToCache(TKey key, TValue value, bool prune)
    {
      // Add new value to cache
      _values.Add(key, new CacheValue<TValue>(value));

      // Prune Cache
      if (prune) { PruneCache(); }
    }

    // Prunes the cache by removing the excess items that were least recently
    // accessed.
    private void PruneCache()
    {
      // Only prune if cache has overflowed
      int pruneCount = _values.Count - _maxSize;
      if (pruneCount <= 0) { return; }

      // Get the oldest non-locked records and remove them
      IList<TKey> pruneList = GetOldestCacheItems(pruneCount);
      foreach (var item in pruneList)
      {
        _values.Remove(item);
      }
    }

    // Gets a list of keys for the least recently access items
    private IList<TKey> GetOldestCacheItems(int count)
    {
      SortedList<long,TKey> oldList = new SortedList<long,TKey>();
      long threshold = long.MaxValue;
      int nx = -1;
      foreach (var item in _values)
      {
        nx++;
        if (nx != _position && !item.Value.Locked)
        {
          long tick = item.Value.Tick;
          if (oldList.Count < count)
          {
            oldList.Add(tick, item.Key);
            threshold = oldList.Keys[oldList.Count - 1];
          }
          else if(tick < threshold)
          {
            if (oldList.Count == count) { oldList.RemoveAt(count - 1); }
            oldList.Add(tick, item.Key);
            threshold = oldList.Keys[count - 1];
          }
        }
      }
      return oldList.Values;
    }

    #endregion

    #region IList<TValue> Members

    /// <summary>
    /// Gets the index of the business object in the list.
    /// </summary>
    /// <param name="item">The business object to find.</param>
    /// <returns>The index of the business object in the list, or -1 if the object was not found.</returns>
    public int IndexOf(TValue item) { return _keys.IndexOf(GetKeyFromItem(item)); }

    /// <summary>
    /// Inserts an item at the specified location.
    /// </summary>
    /// <param name="index">The index in the collection.</param>
    /// <param name="item">The item to insert.</param>
    public void Insert(int index, TValue item)
    {
      lock (_syncRoot)
      {
        TKey key = GetKeyFromItem(item);
        _keys.Insert(index, key);
        AddValueToCache(key, item, true);
      }
    }

    /// <summary>
    /// Removes the item at the specified index.  The corresponding cached business object, if any, will be
    /// cleared as well.
    /// </summary>
    /// <param name="index">The index of the item to remove.</param>
    public void RemoveAt(int index)
    {
      lock (_syncRoot)
      {
        TKey key = _keys[index];
        _keys.Remove(key);
        if (_values.ContainsKey(key)) { _values.Remove(key); }
      }
    }

    /// <summary>
    /// Gets or sets the business object at the specified index.
    /// </summary>
    /// <param name="index">The index of the business object.</param>
    /// <returns>The business object at the specified index.</returns>
    public TValue this[int index]
    {
      get { return GetValueAtIndex(index); }
      set
      {
        lock (_syncRoot)
        {
          // Remove old item from keys and cache.
          TKey oldKey = _keys[index];
          _keys.RemoveAt(index);
          if (_values.ContainsKey(oldKey)) { _values.Remove(oldKey); }
          // Add new key at specified index.
          TKey newKey = GetKeyFromItem(value);
          _keys.Insert(index, newKey);
          AddValueToCache(newKey, value, false);
        }
      }
    }

    #endregion

    #region ICollection<TValue> Members

    /// <summary>
    /// Adds the specified business object to the end of the list.
    /// </summary>
    /// <param name="item">The business object to add.</param>
    public void Add(TValue item)
    {
      lock (_syncRoot)
      {
        TKey key = GetKeyFromItem(item);
        _keys.Add(key);
        int index = _keys.Count - 1;
        AddValueToCache(key, item, true);
      }
    }

    /// <summary>
    /// Clears the list and the internal value cache.
    /// </summary>
    public void Clear()
    {
      lock (_syncRoot)
      {
        if (_keys == null) { _keys = new List<TKey>(); } else { _keys.Clear(); }
        if (_values == null) { _values = new Dictionary<TKey, CacheValue<TValue>>(); } else { _values.Clear(); }
        _position = -1;
      }
    }

    /// <summary>
    /// Gets whether the specified business object is in the key list.
    /// </summary>
    /// <param name="item">The business object to find.</param>
    /// <returns>True if the business object is in the list, otherwise false.</returns>
    public bool Contains(TValue item)
    {
      TKey key = GetKeyFromItem(item);
      return _keys.Contains(key);
    }

    /// <summary>
    /// Copies elements to an array from a given start index.
    /// </summary>
    /// <param name="array">The array to copy to.</param>
    /// <param name="arrayIndex">The index in the array to start from.</param>
    public void CopyTo(TValue[] array, int arrayIndex)
    {
      throw new NotImplementedException();
    }

    /// <summary>
    /// Gets a value that indicates whether the list is readonly.  For this implementation
    /// this will always return false.
    /// </summary>
    /// <value>Whether the list is readonly.</value>
    public bool IsReadOnly { get { return false; } }

    /// <summary>
    /// Removes the specified business object from the list.  The corresponding cached
    /// business object, if any, will be removed as well.
    /// </summary>
    /// <param name="item">The business object to remove.</param>
    /// <returns>True if the item was removed, otherwise false.</returns>
    public bool Remove(TValue item)
    {
      lock (_syncRoot)
      {
        TKey key = GetKeyFromItem(item);
        if (_keys.Contains(key))
        {
          _keys.Remove(key);
          if (_values.ContainsKey(key)) { _values.Remove(key); }
          return true;
        }
        return false;
      }
    }

    #endregion

    #region IEnumerable<TValue> Members

    /// <summary>
    /// Returns an enumerator that iterates through this keylist.
    /// </summary>
    /// <returns>An enumerator that iterates through this keylist.</returns>
    public IEnumerator<TValue> GetEnumerator()
    {
      return new KeyListEnumerator(this);
    }

    #endregion

    #region IEnumerable Members

    IEnumerator IEnumerable.GetEnumerator()
    {
      return new KeyListEnumerator(this);
    }

    #endregion

    #region IDisposable Members

    /// <summary>
    /// Releases all resources used by this KeyList.
    /// </summary>
    public void Dispose()
    {
      Dispose(true);
      GC.SuppressFinalize(this);
    }

    /// <summary>
    /// Releases all resources used by this KeyList
    /// </summary>
    /// <param name="disposing">True to release both managed and unmanaged resources;
    /// false to release only unmanaged resources.</param>
    protected virtual void Dispose(bool disposing)
    {
      if (!_disposed)
      {
        if (disposing)
        {
          // dispose-only, i.e. non-finalizable logic
          if (_selectBlockCommand != null) { _selectBlockCommand.Dispose(); }
          _selectBlockCommand = null;
          if (_selectOneCommand != null) { _selectOneCommand.Dispose(); }
          _selectOneCommand = null;
          if (_connection != null && !_sharedConnection)
          {
            if (_connection.State != ConnectionState.Closed) { _connection.Close(); }
            _connection.Dispose(); 
          }
          _connection = null;
          if (_keys != null) { _keys.Clear(); }
          _keys = null;
          if (_values != null) { _values.Clear(); }
          _values = null;
        }

        // shared cleanup logic
        _disposed = true;
      }
    }

    #endregion

    #region CacheValue Class

    /// <summary>
    /// Maintains a cached business object for a KeyList.
    /// </summary>
    /// <typeparam name="T">A business object.</typeparam>
    private class CacheValue<T> where T : IBusinessObject
    {
      static long _nexttick = 0;
      private T _value;
      private int _accessCount = 0;
      private long _tick = _nexttick++;
      private bool _locked = false;

      /// <summary>
      /// Creates a new instance of a CacheValue for the specified business object.
      /// </summary>
      /// <param name="value">The business object to cache.  Must implement IBusinessObject.</param>
      public CacheValue(T value) { _value = value; }

      /// <summary>
      /// Gets the cached business object and updates the last access time.
      /// </summary>
      public T Value
      {
        get
        {
          _tick = _nexttick++;
          _accessCount++;
          return _value;
        }
      }

      /// <summary>
      /// Gets the tick count corresponding to the last access.
      /// </summary>
      public long Tick { get { return _tick; } }

      /// <summary>
      /// Gets the number of times the cached object was retrieved.
      /// </summary>
      public int AccessCount { get { return _accessCount; } }

      /// <summary>
      /// Gets or sets whether to lock this item in the cache.  If locked, the item
      /// will not be implicitly removed.
      /// </summary>
      public bool Locked { get { return _locked; } set { _locked = value; } }
    }

    #endregion

    #region KeyListEnumerator class

    private class KeyListEnumerator : IEnumerator<TValue>
    {
      private KeyList<TKey, TValue> _keyList;
      int _index;

      #region ctor

      public KeyListEnumerator(KeyList<TKey, TValue> keyList)
      {
        _keyList = keyList;
        Reset();
      }

      ~KeyListEnumerator()
      {
        Dispose(false);
      }

      #endregion

      #region IEnumerator<T> Members

      public TValue Current
      {
        get { return _keyList.GetValueAtIndex(_index); }
      }

      #endregion

      #region IDisposable Members

      public void Dispose()
      {
        Dispose(true);
        GC.SuppressFinalize(this);
      }

      protected virtual void Dispose(bool disposing)
      {
        if (disposing)
        {
          // Clean up all managed resources
          _keyList = null;
        }
        // Clean up all native resources
      }

      #endregion

      #region IEnumerator Members

      object IEnumerator.Current
      {
        get { return _keyList.GetValueAtIndex(_index); }
      }

      public bool MoveNext()
      {
        if (++_index >= _keyList.Count)
          return (false);
        else
          return (true);
      }

      public void Reset()
      {
        _index = -1;
      }

      #endregion
    }

    #endregion

    #region IList Members

    int IList.Add(object value)
    {
      TValue item = value as TValue;
      if (item == null) { throw new InvalidCastException(string.Format("value is not a {0}", typeof(TValue).Name)); }
      Add(item);
      return _keys.Count - 1;
    }

    void IList.Clear() { Clear(); }

    bool IList.Contains(object value)
    {
      TValue item = value as TValue;
      if (item == null) { return false; }
      return Contains(item);
    }

    int IList.IndexOf(object value)
    {
      TValue item = value as TValue;
      if (item == null) { return -1; }
      return IndexOf(item);
    }

    void IList.Insert(int index, object value)
    {
      TValue item = value as TValue;
      if (item == null) { throw new InvalidCastException(string.Format("value is not a {0}", typeof(TValue).Name)); }
      Insert(index, item);
    }

    /// <summary>
    /// Gets a value indicating whether the KeyList has a fixed size.
    /// </summary>
    /// <value>This property always returns false.</value>
    public bool IsFixedSize { get { return false; } }

    bool IList.IsReadOnly { get { return IsReadOnly; } }

    void IList.Remove(object value)
    {
      TValue item = value as TValue;
      if (item == null) { throw new InvalidCastException(string.Format("value is not a {0}", typeof(TValue).Name)); }
      Remove(item);
    }

    void IList.RemoveAt(int index) { RemoveAt(index); }

    object IList.this[int index]
    {
      get { return this[index]; }
      set
      {
        TValue item = value as TValue;
        if (item == null) { throw new InvalidCastException(string.Format("value is not a {0}", typeof(TValue).Name)); }
        this[index] = item;
      }
    }

    #endregion

    #region ICollection Members

    /// <summary>
    /// Copies the collection to a compatible one-dimensional System.Array, starting at the specified index of the target array.
    /// </summary>
    /// <param name="array">The one-dimensional System.Array that is the destination of the elements copied from
    /// KeyList. The System.Array must have zero-based indexing.</param>
    /// <param name="index">The zero-based index in array at which copying begins.</param>
    /// <remarks> CopyTo is not currently supported by this class.  Calling this method will throw
    /// a NotImplementedException.</remarks>
    public void CopyTo(Array array, int index)
    {
      throw new NotImplementedException();
    }

    /// <summary>
    /// Gets a value indicating whether access to a System.Collections.SortedList object is synchronized (thread safe).
    /// </summary>
    /// <value>true.</value>
    public bool IsSynchronized { get { return true; } }

    /// <summary>
    /// Gets the number of items in the list.
    /// </summary>
    public int Count { get { return _keys.Count; } }

    /// <summary>
    /// Gets an object that can be used to synchronize access to the list.
    /// </summary>
    public object SyncRoot { get { return this.SyncRoot; } }

    #endregion
  }
}
