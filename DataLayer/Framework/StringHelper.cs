using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Additional useful functions to assist in manipulating and parsing string values.
  /// </summary>
  public static class StringHelper
  {
    /// <summary>
    /// Converts the given month int to month name
    /// </summary>
    /// <param name="month">month in</param>
    /// <param name="abbrev">return abbreviated or not</param>
    /// <returns>Short or long month name</returns>
    public static string MonthName(int month, bool abbrev)
    {
      DateTime date = new DateTime(1900, month, 1);
      if (abbrev) return date.ToString("MMM");
      return date.ToString("MMMM");
    }

    /// <summary>
    /// Indicates whether the regular expression specified in "pattern" could be found in the "text".
    /// </summary>
    /// <param name="text">The string to search for a match</param>
    /// <param name="pattern">The pattern to find in the "text" string (supports the *, ? and # wildcard characters).</param>
    /// <param name="ignoreCase">True for a case-insensitive match.</param>
    /// <returns>Returns true if the regular expression finds a match otherwise returns false.</returns>
    /// <remarks>
    /// ?			Matches any single character (between A-Z and a-z)
    /// #			Matches any single digit. For example, 7# matches numbers that include 7 followed by another number, such as 71, but not 17. 
    /// *			Matches any one or more characters. For example, new* matches any text that includes "new", such as newfile.txt. 
    /// 
    /// This functionality is based on the following article:
    /// http://msdn.microsoft.com/library/default.asp?url=/library/en-us/vsintro7/html/vxgrfwildcards.asp
    /// 
    /// Thanks to Stefan Schletterer for corrections.
    /// </remarks>
    public static bool Like(string text, string pattern, bool ignoreCase)
    {
      // Check input parameters
      if (pattern == null || text == null || pattern.Length == 0 || text.Length == 0 || pattern == "*.*" == true)
      {
        // Default return is true
        return true;
      }

      // Escape all strings
      System.Text.StringBuilder regPattern = new System.Text.StringBuilder(Regex.Escape(pattern));

      // Replace the LIKE patterns with regular expression patterns
      regPattern = regPattern.Replace(Regex.Escape("*"), ".*");
      regPattern = regPattern.Replace(Regex.Escape("?"), @".");
      regPattern = regPattern.Replace(Regex.Escape("#"), @"[0-9]");
      regPattern = regPattern.Replace(Regex.Escape("[!"), @"[!");
      regPattern = regPattern.Replace(Regex.Escape("["), @"[");
      regPattern = regPattern.Replace(Regex.Escape("]"), @"]");

      // Add begin and end blocks (to match on the whole string only)
      regPattern.Insert(0, "^");
      regPattern.Append("$");

      if (ignoreCase == false)
      {
        return Regex.IsMatch(text, regPattern.ToString());
      }
      else
      {
        return Regex.IsMatch(text, regPattern.ToString(), RegexOptions.IgnoreCase);
      }
    }
  }
}
