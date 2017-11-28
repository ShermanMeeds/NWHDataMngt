using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DataMngt.MyCode
{
    public class SalesPlanLevels
    {
        private string _colName = string.Empty;
        private Type _colDataType;
        private object _colDataValue = null;
        private int _linesContained = 0;

        public string colName
        {
            get
            {
                return _colName;
            }
            set
            {
                _colName = value;
            }
        }

        public Type colDataType
        {
            get
            {
                return _colDataType;
            }
            set
            {
                _colDataType = value;
            }
        }

        public object colDataValue
        {
            get
            {
                return _colDataValue;
            }
            set
            {
                _colDataValue = value;
            }
        }

        public int linesContained
        {
            get
            {
                return _linesContained;
            }
            set 
            {
                _linesContained = value;
            }
        }
    }
}