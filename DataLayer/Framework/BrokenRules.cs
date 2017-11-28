using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Represents a list of broken validation rules for the business framework.
  /// </summary>
  public class BrokenRules : ICloneable 
  {
    private Dictionary<string, string> _brokenlist;

    #region Methods

    /// <summary>
    /// Adds or removes a broken rule from the collection.  If the message
    /// is an empty string then the broken rule associated with the column is
    /// removed, otherwise it is added.
    /// </summary>
    /// <param name="columnName">The column that this rule applies to.</param>
    /// <param name="message">The validation message, or an empty string
    /// to remove the validation rule from this column.</param>
    public void RuleBroken(string columnName, string message)
    {
      if (message!=null)
      {
        if (_brokenlist == null) { _brokenlist = new Dictionary<string, string>(); }
        if (_brokenlist.ContainsKey(columnName)) { _brokenlist[columnName] = message; }
        else { _brokenlist.Add(columnName, message); }
        OnBrokenRule();
      }
      else
      {
        if (_brokenlist == null) { return; }
        if (_brokenlist.ContainsKey(columnName)) { _brokenlist.Remove(columnName); }
        if (_brokenlist.Count == 0) { OnNoBrokenRules(); }
      }
    }

    /// <summary>
    /// Gets the text of the broken rule associated with the specified column.
    /// </summary>
    /// <param name="columnName">The column to get broken rules for.</param>
    /// <returns>The message associated with the broken rule, or an empty
    /// string if the specified column is valid.</returns>
    public string this[string columnName]
    {
      get
      {
        if (_brokenlist == null) { return string.Empty; }
        string message;
        if (_brokenlist.TryGetValue(columnName, out message))
        {
          return message;
        }
        return string.Empty;
      }
    }

    /// <summary>
    /// Gets the number of broken rules
    /// </summary>
    public int Count
    {
      get
      {
        if (_brokenlist == null) { return 0; }
        return _brokenlist.Count;
      }
    }

    /// <summary>
    /// Clears the broken rules collection, essentially making the associated object valid.
    /// </summary>
    public void Clear()
    {
      if (_brokenlist == null) { return; }
      _brokenlist.Clear();
      OnNoBrokenRules();
    }

    /// <summary>
    /// Returns a list of all broken rules.
    /// </summary>
    /// <returns>A list of all broken rules.</returns>
    public override string ToString()
    {
      if (_brokenlist == null) { return null; }
      StringBuilder sb = new StringBuilder(100);
      foreach (KeyValuePair<string, string> item in _brokenlist)
      {
        sb.AppendLine(string.Format("{0}", item.Value));
      }
      return sb.ToString();
    }

    #endregion

    #region Events

    /// <summary>
    /// Raised when there are no longer any broken rules.  In other words, indicates
    /// that the object has become valid.
    /// </summary>
    public event EventHandler NoBrokenRules;

    /// <summary>
    /// Call this method when the object becomes valid.
    /// </summary>
    protected void OnNoBrokenRules()
    {
      if (NoBrokenRules != null) { NoBrokenRules(this, EventArgs.Empty); }
    }

    /// <summary>
    /// Raised the first time a rule is broken for this object.  In other words,
    /// indicates that the object is not invalid.
    /// </summary>
    public event EventHandler BrokenRule;

    /// <summary>
    /// Called when a business rule is broken.  Raises the BrokenRule event.
    /// </summary>
    protected void OnBrokenRule()
    {
      if (BrokenRule != null) { BrokenRule(this, EventArgs.Empty); }
    }

    #endregion

    #region ICloneable Members

    /// <summary>
    /// Creates a deep-copy clone of the source BrokenRules list.
    /// </summary>
    /// <param name="source">The BrokenRules open to deep-copy.</param>
    /// <returns>A deep-copy of the source BrokenRules object.</returns>
    public static BrokenRules Clone(BrokenRules source)
    {
      if (source == null) { return null; }
      BrokenRules clone = new BrokenRules();
      if (source._brokenlist != null)
      {
        clone._brokenlist = new Dictionary<string, string>();
        foreach (var item in source._brokenlist)
        {
          clone._brokenlist.Add(item.Key, item.Value);
        }
      }
      return clone;
    }

    /// <summary>
    /// Returns a deep-copy clone of the BrokenRules list.
    /// </summary>
    /// <returns>A deep-copy clone of this object.</returns>
    public object Clone() { return BrokenRules.Clone(this); }

    #endregion
  }
}
