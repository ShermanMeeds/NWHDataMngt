using System;
using System.Collections.Generic;
using System.Text;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Exception thrown when an error occurs while attempting to persist an
  /// object to the database.
  /// </summary>
  [Serializable]
  public class DataException : System.Exception
  {
    /// <summary>
    /// Creates a new instance of this exception, specifying the message and 
    /// inner exception.
    /// </summary>
    /// <param name="message">The message that describes this exception.</param>
    /// <param name="innerException">The exception that caused the current exception, or null
    /// if there is no inner exception.</param>
    public DataException(string message, System.Exception innerException)
      : base(message, innerException)
    { }

    /// <summary>
    /// Creates a new instance of this exception, specifying the message.
    /// </summary>
    /// <param name="message">The message that describes this exception.</param>
    public DataException(string message)
      : base(message)
    { }

    /// <summary>
    /// Creates a new instance of this exception.
    /// </summary>
    public DataException() { }
  }
}
