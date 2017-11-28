using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Defines column layout properties for use by a bound grid or control.
  /// </summary>
  [AttributeUsage(AttributeTargets.Property, Inherited = true, AllowMultiple = false)]
  public class LayoutAttribute : Attribute
  {
    /// <summary>
    /// Construct a database column attribute
    /// </summary>
    public LayoutAttribute() { }  // Parameterless constructor means always use named params.

    /// <summary>
    /// Gets or sets the display position used to determine the column order.
    /// </summary>
    public int DisplayPosition = 0;

    /// <summary>
    /// Gets or sets the defualt width of the column.
    /// </summary>
    public int Width = 75;

    /// <summary>
    /// Gets or sets the caption to use in the header of the column.  If this is an empty
    /// string then the name of the column will be used.
    /// </summary>
    public string Caption = string.Empty;

    /// <summary>
    /// Gets or sets whether this column should be hidden in the layout.
    /// </summary>
    public bool Hidden = false;

    /// <summary>
    /// Gets or sets the format to use when formatting values for display.
    /// </summary>
    public string Format = string.Empty;

    /// <summary>
    /// Gets or sets whether to show a summary for the column.
    /// </summary>
    public bool ShowSummary = false;

    /// <summary>
    /// Gets or sets the alignment to use for data in the column.
    /// </summary>
    public ColumnHAlign HAlign = ColumnHAlign.Default;
  }

  /// <summary>
  /// Indicates how text should be aligned.
  /// </summary>
  public enum ColumnHAlign
  {
    /// <summary>Do not align text.</summary>
    Default = -1,
      /// <summary>Align left.</summary>
    Left = 0,
    /// <summary>Align center.</summary>
    Center = 1,
    /// <summary>Align right.</summary>
    Right = 2
  }
}
