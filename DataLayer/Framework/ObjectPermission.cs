using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Describes the permissions for the current user for a specifiec named object.
  /// </summary>
  public class ObjectPermission
  {
    internal const string SelectCommand = "SELECT{0} Name,Select,Update,Insert,Delete "
      + "FROM dbo.up_GetObjectPermissions WITH (NOLOCK){1}{2}";

    #region CTOR

    private ObjectPermission() { }  // Require use of factory methods

    private static ObjectPermission GetNew(string name)
    {
      ObjectPermission op = new ObjectPermission();
      op._name = name;
      return op;
    }

    /// <summary>
    /// Creates a new object permission object using the provided parameters.
    /// </summary>
    /// <param name="name">The name of the target object.</param>
    /// <param name="select">Whether select/view is permitted</param>
    /// <param name="update">Whether update is permitted</param>
    /// <param name="insert">Whether insert is permitted</param>
    /// <param name="delete">Whether delete is permitted</param>
    /// <returns>An ObjectPermission object with the specified permissions.</returns>
    /// <remarks>This method can be used to set custom permissions.</remarks>
    public static ObjectPermission GetNew(string name, int select, int update, int insert, int delete)
    {
      ObjectPermission op = new ObjectPermission();
      op._name = name;
      op._select = select;
      op._update = update;
      op._insert = insert;
      op._delete = delete;
      return op;
    }

    /// <summary>
    /// Creates a new object permission object using the provided parameters.
    /// </summary>
    /// <param name="name">The name of the target object.</param>
    /// <param name="select">Whether select/view is permitted</param>
    /// <param name="update">Whether update is permitted</param>
    /// <param name="insert">Whether insert is permitted</param>
    /// <param name="delete">Whether delete is permitted</param>
    /// <returns>An ObjectPermission object with the specified permissions.</returns>
    /// <remarks>This method can be used to set custom permissions.</remarks>
    public static ObjectPermission GetNew(string name, bool select, bool update, bool insert, bool delete)
    {
      ObjectPermission op = new ObjectPermission();
      op._name = name;
      op._select = select ? 1 : 0;
      op._update = update ? 1 : 0;
      op._insert = insert ? 1 : 0;
      op._delete = delete ? 1 : 0;
      return op;
    }

    /// <summary>
    /// Gets the effective database permissions for the current user for the
    /// specified object.  The object must have a TableAttribute tag.
    /// </summary>
    /// <param name="objectType">The Type of object to get permissions for.</param>
    /// <returns>A new ObjectPermission containing the current users permissions
    /// for the specified object type.</returns>
    public static ObjectPermission Load(Type objectType)
    {
      // use reflection to extract custom attributes from designated type
      System.Reflection.MemberInfo inf = objectType;

      // Get Table attribute
      object[] tableattributes;
      tableattributes = inf.GetCustomAttributes(typeof(Framework.TableAttribute), false);
      if (tableattributes.Length != 1)
      { throw new Exception("Unable to get schema for business object, missing Table attribute."); }
      TableAttribute att = (TableAttribute)tableattributes[0];

      return Load(att.Name);
    }

    /// <summary>
    /// Gets the effective database permissions for the current user for the
    /// specified object.
    /// </summary>
    /// <param name="objectName">The name of the object to get permissions for.</param>
    /// <returns>A new ObjectPermission containing the current users permissions
    /// for the specified object.</returns>
    public static ObjectPermission Load(string objectName)
    {
      ObjectPermission perm = GetNew(objectName);
	  using (SqlConnection cn = DBConnect.NewDataConnection())
      {
        using (SqlCommand cmd = cn.CreateCommand())
        {
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.CommandText = "dbo.up_GetObjectPermissions";
          cmd.Parameters.AddWithValue("@objectName", objectName);
          using (SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow))
          {
            if (dr.Read()) { Fill(perm, dr); }
          }
        }
        //cn.Close();
      }
      return perm;
    }

    internal static void Fill(ObjectPermission item, SqlDataReader dr)
    {
      item._name = dr["Name"] as string;
      item._select = (dr["Select"] as int?) ?? 0;
      item._update = (dr["Update"] as int?) ?? 0;
      item._insert = (dr["Insert"] as int?) ?? 0;
      item._delete = (dr["Delete"] as int?) ?? 0;
    }

    #endregion

    #region Business Methods

    private string _name;
    private int _select = 0;
    private int _update = 0;
    private int _insert = 0;
    private int _delete = 0;

    /// <summary>
    /// Gets the the type name of object.
    /// </summary>
    [Layout(Caption = "Name", DisplayPosition = 0)]
    public string Name { get { return _name; } }

    /// <summary>
    /// Gets whether the user can view the objects of the named type.
    /// </summary>
    public bool CanSelect { get { return (_select != 0); } }

    /// <summary>
    /// Gets whether the user can update objects of the named type.
    /// </summary>
    public bool CanUpdate { get { return (_update != 0); } }

    /// <summary>
    /// Gets whether the user can create new objects of the named type.
    /// </summary>
    public bool CanInsert { get { return (_insert != 0); } }

    /// <summary>
    /// Gets whether the user can delete objects of the named type.
    /// </summary>
    public bool CanDelete { get { return (_delete != 0); } }

    #endregion
  }
}

