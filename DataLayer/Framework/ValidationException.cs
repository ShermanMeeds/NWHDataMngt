using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Exception thrown when an attempt is made to save an invalid object
  /// </summary>
  [Serializable]
  public sealed class ValidationException : System.Exception
  {
    /// <summary>
    /// Creates a new instance of this exception, specifying the message and 
    /// inner exception.
    /// </summary>
    /// <param name="message">The message that describes this exception.</param>
    /// <param name="innerException">The exception that caused the current exception, or null
    /// if there is no inner exception.</param>
    public ValidationException(string message, System.Exception innerException)
      : base(message, innerException)
    {}

    /// <summary>
    /// Creates a new instance of this exception, specifying the message.
    /// </summary>
    /// <param name="message">The message that describes this exception.</param>
    public ValidationException(string message)
      : base(message)
    {}

    /// <summary>
    /// Creates a new instance of this exception.
    /// </summary>
    public ValidationException() { }
  }
}
