using System;
using System.Collections.Generic;
using System.Text;

namespace MorphoDataLayer.Framework
{
  public interface IDocBlob
  {
    string DocBlobFileName { get; }
    System.IO.Stream GetDocBlob();
    decimal FileSize { get; }
    int? DocID { get; }
  }
}
