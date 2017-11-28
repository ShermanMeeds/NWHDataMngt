using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Xml.Serialization;
using System.IO;
using System.Reflection;
using System.ComponentModel;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Handles persistance of grid layouts to the file system and to the database in
  /// and XML format.
  /// </summary>
  /// <remarks>This class fully supports serialization and can be persisted to either
  /// a file or to the database.</remarks>
  [Serializable(), XmlRoot("GridLayout")]
  public sealed class GridLayout
  {
    #region Properties

    private string _key = string.Empty;
    private bool _showAltRows = false;
    private bool _showGroupBy = false;
    private bool _navBarVisible = true;
    private Color _altRowColor = Color.FromArgb(220, 243, 222);
    private List<ColumnInfo> _columns0 = null;
    private List<SortColumnInfo> _sortColumns0 = null;
    private List<ColumnInfo> _columns1 = null;
    private List<SortColumnInfo> _sortColumns1 = null;
    private bool _hasBand1 = false;

    /// <summary>
    /// Gets or sets the unique key associated with this layout.  This is used to generate the 
    /// filename and as the database primary key.  Normally this corresponds to the
    /// name of the business object.
    /// </summary>
    [XmlAttribute("Key"), DefaultValue("")]
    public string Key { get { return _key; } set { _key = value; } }
    
    /// <summary>
    /// Gets or sets the alternate row color.
    /// </summary>
    [XmlIgnore()]
    public Color AltRowColor { get { return _altRowColor; } set { _altRowColor = value; } }
    
    /// <summary>
    /// Gets or sets the alternate row color ARGB value.
    /// </summary>
    /// <remarks>This property is serializable.</remarks>
    [XmlAttribute("AltRowArgb")]
    public int AltRowArgb
    {
      get { return AltRowColor.ToArgb(); }
      set { AltRowColor = Color.FromArgb(value); }
    }

    /// <summary>
    /// Whether the AltRowArgb property should be serialized.
    /// </summary>
    /// <returns>True to serialize the AltRowArgb property.</returns>
    public bool ShouldSerializeAltRowArgb() { return AltRowColor != Color.FromArgb(220, 243, 222); }

    /// <summary>
    /// Gets or sets whether the navigation bar is visible.
    /// </summary>
    [XmlAttribute("NavBarVisible"), DefaultValue(true)]
    public bool NavBarVisible { get { return _navBarVisible; } set { _navBarVisible = value; } }
   
    /// <summary>
    /// Gets or sets whether the group by section is visible.
    /// </summary>
    [XmlAttribute("ShowGroupBy"), DefaultValue(false)]
    public bool ShowGroupBy { get { return _showGroupBy; } set { _showGroupBy = value; } }
    
    /// <summary>
    /// Gets or sets whether to show alternate rows in the alternate row color.
    /// </summary>
    [XmlAttribute("ShowAltRows"), DefaultValue(false)]
    public bool ShowAltRows { get { return _showAltRows; } set { _showAltRows = value; } }
    
    /// <summary>
    /// Gets the list of column definitions for band 0 of this layout.
    /// </summary>
    /// <value>A List of ColumnInfo objects.</value>
    [XmlElement("Columns0")]
    public List<ColumnInfo> Columns0
    {
      get
      {
        if (_columns0 == null) { _columns0 = new List<ColumnInfo>(); }
        return _columns0;
      }
    }

    /// <summary>
    /// Gets the list of sorted columns for band 0.
    /// </summary>
    /// <value>A List of SortColumnInfo objects.</value>
    [XmlElement("SortColumns0")]
    public List<SortColumnInfo> SortColumns0
    {
      get
      {
        if (_sortColumns0 == null) { _sortColumns0 = new List<SortColumnInfo>(); }
        return _sortColumns0;
      }
    }

    /// <summary>
    /// Gets or sets whether this layout includes band 1 column and sort
    /// column definitions.
    /// </summary>
    [XmlAttribute("HasBand1"), DefaultValue(false)]
    public bool HasBand1 { get { return _hasBand1; } set { _hasBand1 = value; } }

    /// <summary>
    /// Gets the list of column definitions for band 1 of this layout.
    /// </summary>
    /// <value>A List of ColumnInfo objects.</value>
    [XmlElement("Columns1"), DefaultValue(null)]
    public List<ColumnInfo> Columns1
    {
      get
      {
        if (_columns1 == null) { _columns1 = new List<ColumnInfo>(); }
        return _columns1;
      }
    }

    /// <summary>
    /// Gets the list of sorted columns for band 1.
    /// </summary>
    /// <value>A List of SortColumnInfo objects.</value>
    [XmlElement("SortColumns1"), DefaultValue(null)]
    public List<SortColumnInfo> SortColumns1
    {
      get
      {
        if (_sortColumns1 == null) { _sortColumns1 = new List<SortColumnInfo>(); }
        return _sortColumns1;
      }
    }

    #endregion

    #region Static Properties

    private static string _configpath = null;

    /// <summary>
    /// Gets or sets the full path to the configuration directory.
    /// </summary>
    public static string ConfigPath
    {
      get
      {
        if (_configpath == null)
        {
          _configpath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
            @"MorphoTrak\Agile\");
        }
        return _configpath;
      }
      set { _configpath = value; }
    }

    #endregion

    #region File

    /// <summary>
    /// Saves the current layout to a file.  The name will be created in the ConfigPath directory and will
    /// be named after the Key.
    /// </summary>
    public void ToFile()
    {
      DirectoryInfo di = new DirectoryInfo(ConfigPath);
      if (!di.Exists) { di.Create(); }

      XmlSerializer s = new XmlSerializer(typeof(GridLayout));
      using (TextWriter w = new StreamWriter(Path.Combine(ConfigPath, Key + ".config")))
      {
        s.Serialize(w, (GridLayout)this);
        //w.Close();
      }
    }

    /// <summary>
    /// Deletes the stored layout.  This will cause the object to revert to default values on next load.
    /// </summary>
    public void DeleteFile()
    {
      FileInfo fi = new FileInfo(Path.Combine(ConfigPath, Key + ".config"));
      if (fi.Exists) { fi.Delete(); }
    }

    /// <summary>
    /// Deletes the stored layout for the specified key.  This will cause the object to revert to default
    /// values on next load.
    /// </summary>
    /// <param name="key">The key of the layout to delete.</param>
    public static void DeleteFile(string key)
    {
      FileInfo fi = new FileInfo(Path.Combine(ConfigPath, key + ".config"));
      if (fi.Exists) { fi.Delete(); }
    }

    /// <summary>
    /// Creates a new layout from the contents of the specified file.  If the file does not exist
    /// then null will be returned.
    /// </summary>
    /// <param name="key">The key (filename).</param>
    /// <returns>A new layout.</returns>
    public static GridLayout FromFile(string key)
    {
      FileInfo fi = new FileInfo(Path.Combine(ConfigPath, key + ".config"));
      if (!fi.Exists) { return null; }

      XmlSerializer s = new XmlSerializer(typeof(GridLayout));
      GridLayout newLayout;
      using (TextReader r = new StreamReader(fi.FullName))
      {
        newLayout = (GridLayout)s.Deserialize(r);
        //r.Close();
      }

      return newLayout;
    }

    #endregion

    #region Database

    /// <summary>
    /// Saves the specified layout to the database.
    /// </summary>
    /// <param name="cn">The database connection to use.</param>
    /// <param name="instance">The layout to save.</param>
    public static void SaveToDatabase(SqlConnection cn, GridLayout instance)
    {
      // Save the layout
      using (SqlCommand cmd = new SqlCommand())
      {
        cmd.Connection = cn;
        cmd.CommandText = "up_SaveGridLayout";
        cmd.Parameters.AddWithValue("@layoutKey", instance.Key);
        SqlParameter param = new SqlParameter("@layoutXml", SqlDbType.Xml);
        using (MemoryStream ms = new MemoryStream())
        {
          XmlSerializer xmlSer = new XmlSerializer(typeof(GridLayout));
          xmlSer.Serialize(ms, instance);
          UTF8Encoding encoding = new UTF8Encoding();
          param.Value = encoding.GetString(ms.ToArray());
        }
        cmd.Parameters.Add(param);
        cmd.ExecuteNonQuery();
      }
    }

    /// <summary>
    /// Creates a new layout from the database record that matches the specified key.
    /// </summary>
    /// <param name="cn">The database connection to use.</param>
    /// <param name="key">The unique key for the layout.</param>
    /// <returns>A new layout.</returns>
    public static GridLayout LoadFromDatabase(SqlConnection cn, string key)
    {
      GridLayout newLayout = null;
      using (SqlCommand cmd = new SqlCommand())
      {
        cmd.Connection = cn;
        cmd.CommandText = "SELECT LayoutXml FROM GridLayout WHERE Key=@key";
        cmd.Parameters.AddWithValue("@key", key);
        using (SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow))
        {
          if (dr.Read())
          {
            XmlSerializer s = new XmlSerializer(typeof(GridLayout));
            using (System.Xml.XmlReader r = dr.GetSqlXml(0).CreateReader())
            {
              newLayout = (GridLayout)s.Deserialize(r);
              //r.Close();
            }
          }
        }
      }

      return newLayout;
    }

    #endregion

    #region Type

    /// <summary>
    /// Gets a new layout based on the LayoutAttributes defined in the specified
    /// Type.
    /// </summary>
    /// <param name="type">The Type of object to get a layout for.</param>
    /// <returns>A new GridLayout.</returns>
    public static GridLayout FromType(Type type)
    {
      GridLayout layout = new GridLayout();
      PropertyInfo[] props = type.GetProperties();
      if (props.Length == 0) { throw new Exception("Target type does not have any properties."); }
      foreach (PropertyInfo prop in props)
      {
        // Get BrowsableAttribute
        System.ComponentModel.BrowsableAttribute ba = null;
        object[] browseattributes;
        browseattributes = prop.GetCustomAttributes(typeof(System.ComponentModel.BrowsableAttribute), false);
        if (browseattributes.Length > 0) { ba = (System.ComponentModel.BrowsableAttribute)browseattributes[0]; }

        if (ba == null || ba.Browsable == true)
        {
          // Get layout attribute
          Framework.LayoutAttribute la = null;
          object[] layoutattributes;
          layoutattributes = prop.GetCustomAttributes(typeof(Framework.LayoutAttribute), false);
          if (layoutattributes.Length > 0) { la = (Framework.LayoutAttribute)layoutattributes[0]; }

          ColumnInfo ci = new ColumnInfo();
          ci.Name = prop.Name;
          if (la != null)
          {
            ci.Caption = la.Caption;
            ci.DisplayPosition = la.DisplayPosition;
            ci.Format = la.Format;
            ci.Summary = la.ShowSummary;
            ci.Visible = !la.Hidden;
            ci.Width = la.Width;
            ci.HAlign = la.HAlign;
          }
          layout.Columns0.Add(ci);
        }
      }
      return layout;
    }

    /// <summary>
    /// Gets a new dual-band layout based on the LayoutAttributes defined in the specified
    /// Types.
    /// </summary>
    /// <param name="type1">The type of object in band 0.</param>
    /// <param name="type2">The type of object in band 1.</param>
    /// <returns>A new GridLayout.</returns>
    public static GridLayout FromType(Type type1, Type type2)
    {
      GridLayout layout = new GridLayout();

      PropertyInfo[] props = type1.GetProperties();
      if (props.Length == 0) { throw new Exception("Target type 1 does not have any properties."); }
      foreach (PropertyInfo prop in props)
      {
        // Get BrowsableAttribute
        System.ComponentModel.BrowsableAttribute ba = null;
        object[] browseattributes;
        browseattributes = prop.GetCustomAttributes(typeof(System.ComponentModel.BrowsableAttribute), false);
        if (browseattributes.Length > 0) { ba = (System.ComponentModel.BrowsableAttribute)browseattributes[0]; }

        if (ba == null || ba.Browsable == true)
        {
          // Get layout attribute
          Framework.LayoutAttribute la = null;
          object[] layoutattributes;
          layoutattributes = prop.GetCustomAttributes(typeof(Framework.LayoutAttribute), false);
          if (layoutattributes.Length > 0) { la = (Framework.LayoutAttribute)layoutattributes[0]; }

          ColumnInfo ci = new ColumnInfo();
          ci.Name = prop.Name;
          if (la != null)
          {
            ci.Caption = la.Caption;
            ci.DisplayPosition = la.DisplayPosition;
            ci.Format = la.Format;
            ci.Summary = la.ShowSummary;
            ci.Visible = !la.Hidden;
            ci.Width = la.Width;
            ci.HAlign = la.HAlign;
          }
          layout.Columns0.Add(ci);
        }
      }

      props = type2.GetProperties();
      if (props.Length == 0) { throw new Exception("Target type 2 does not have any properties."); }
      foreach (PropertyInfo prop in props)
      {
        // Get BrowsableAttribute
        System.ComponentModel.BrowsableAttribute ba = null;
        object[] browseattributes;
        browseattributes = prop.GetCustomAttributes(typeof(System.ComponentModel.BrowsableAttribute), false);
        if (browseattributes.Length > 0) { ba = (System.ComponentModel.BrowsableAttribute)browseattributes[0]; }

        if (ba == null || ba.Browsable == true)
        {
          // Get layout attribute
          Framework.LayoutAttribute la = null;
          object[] layoutattributes;
          layoutattributes = prop.GetCustomAttributes(typeof(Framework.LayoutAttribute), false);
          if (layoutattributes.Length > 0) { la = (Framework.LayoutAttribute)layoutattributes[0]; }

          ColumnInfo ci = new ColumnInfo();
          ci.Name = prop.Name;
          if (la != null)
          {
            ci.Caption = la.Caption;
            ci.DisplayPosition = la.DisplayPosition;
            ci.Format = la.Format;
            ci.Summary = la.ShowSummary;
            ci.Visible = !la.Hidden;
            ci.Width = la.Width;
            ci.HAlign = la.HAlign;
          }
          layout.Columns1.Add(ci);
        }
      }
      layout.HasBand1 = true;

      return layout;
    }

    #endregion
  }

  #region ColumnInfo

  /// <summary>
  /// Represents a single column in a grid layout.
  /// </summary>
  [Serializable(), XmlRoot("ColumnInfo")]
  public class ColumnInfo
  {
    /// <summary>
    /// Gets or sets the name of the column.
    /// </summary>
    [XmlAttribute("Name"), DefaultValue("")]
    public string Name = string.Empty;

    /// <summary>
    /// Gets or sets the caption.
    /// </summary>
    [XmlAttribute("Caption"), DefaultValue("")]
    public string Caption = string.Empty;

    /// <summary>
    /// Gets or sets the zero-based display position.
    /// </summary>
    [XmlAttribute("DisplayPosition"),DefaultValue(-1)]
    public int DisplayPosition = -1;

    /// <summary>
    /// Gets or sets whether the column is visible.
    /// </summary>
    [XmlAttribute("Visible"), DefaultValue(true)]
    public bool Visible = true;

    /// <summary>
    /// Gets or sets the preferred width.
    /// </summary>
    [XmlAttribute("Width"), DefaultValue(-1)]
    public int Width = -1;

    /// <summary>
    /// Gets or sets a format to apply to displayed values.
    /// </summary>
    [XmlAttribute("Format"), DefaultValue("")]
    public string Format = string.Empty;

    /// <summary>
    /// Gets or sets whether to display summaries.
    /// </summary>
    [XmlAttribute("Summary"), DefaultValue(false)]
    public bool Summary = false;

    /// <summary>
    /// Gets or sets the horizontal alignment for text.
    /// </summary>
    [XmlAttribute("HAlign"), DefaultValue(ColumnHAlign.Default)]
    public ColumnHAlign HAlign = ColumnHAlign.Default;

    /// <summary>
    /// Creates a new instance of a ColumnInfo object.
    /// </summary>
    public ColumnInfo() { }

    /// <summary>
    /// Creates a new instance of a ColumnInfo object and specified all paramaters.
    /// </summary>
    /// <param name="name">The name of the column.</param>
    /// <param name="caption">The caption.</param>
    /// <param name="displayPosition">The display position.</param>
    /// <param name="visible">Whether the column is visible.</param>
    /// <param name="width">The preferred width.</param>
    /// <param name="format">The display format.</param>
    /// <param name="summary">Whether to show summaries.</param>
    /// <param name="hAlign">The column alignment.</param>
    public ColumnInfo(string name, string caption, int displayPosition, bool visible, int width, string format, bool summary, ColumnHAlign hAlign)
    {
      Name = name;
      Caption = caption;
      DisplayPosition = displayPosition;
      Visible = visible;
      Width = width;
      Format = format;
      Summary = summary;
      HAlign = hAlign;
    }
  }

  #endregion

  #region SortColumnInfo

  /// <summary>
  /// Represents a sorted or grouped column in a grid layout
  /// </summary>
  [Serializable(), XmlRoot("SortColumnInfo")]
  public class SortColumnInfo
  {
    /// <summary>
    /// Gets or sets the name of the column.
    /// </summary>
    [XmlAttribute("Name"), DefaultValue("")]
    public string Name= string.Empty;

    /// <summary>
    /// Gets or sets whether this is a grouped column.
    /// </summary>
    [XmlAttribute("GroupBy"), DefaultValue(false)]
    public bool GroupBy = false;

    /// <summary>
    /// Gets or sets whether this column is sorted descending.
    /// </summary>
    [XmlAttribute("Descending"), DefaultValue(false)]
    public bool Descending = false;

    /// <summary>
    /// Creates a new instance of this object.
    /// </summary>
    public SortColumnInfo() { }

    /// <summary>
    /// Creates a new instance of this object and specifies all parameters.
    /// </summary>
    /// <param name="name">The name of the column.</param>
    /// <param name="groupBy">Whether this is a group.</param>
    /// <param name="descending">Whether the sort is descending.</param>
    public SortColumnInfo(string name, bool groupBy, bool descending)
    {
      Name = name;
      GroupBy = groupBy;
      Descending = descending;
    }
  }

  #endregion

}
