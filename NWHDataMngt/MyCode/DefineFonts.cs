using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace DataMngt.MyCode
{
    public struct DefineFont
    {
        public string fontFamily { get; set; }
        public int fontSize { get; set; }
        public bool isBold { get; set; }
        public bool isItalic { get; set; }
        public bool isUnderlined { get; set; }
        public BaseColor foreColor { get; set; }
    }
}