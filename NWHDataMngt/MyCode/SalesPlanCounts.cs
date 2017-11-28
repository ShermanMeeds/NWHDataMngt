using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace DataMngt.MyCode
{
    public class SalesPlanCounts
    {
        private double _colP13 = 0;
        private double _colP8 = 0;
        private double _colP4 = 0;
        private double _colPAST = 0;
        private double _colINV = 0;
        private double _colTotals = 0;
        private double _colW00 = 0;
        private double _colW01 = 0;
        private double _colW02 = 0;
        private double _colW03 = 0;
        private double _colW04 = 0;
        private double _colW05 = 0;
        private double _colW06 = 0;
        private double _colW07 = 0;
        private double _colW08 = 0;
        private double _colW09 = 0;
        private double _colW10 = 0;
        private double _colW11 = 0;
        private double _colW12 = 0;
        private double _colW13 = 0;

        private string _Orders = string.Empty;
        private string _Details = string.Empty;

        private string _ptr = string.Empty;

        public double colP13
        {
            get
            {
                return _colP13;
            }
            set
            {
                _colP13 = value;
            }
        }
        
        public double colP8
        {
            get
            {
                return _colP8;
            }
            set
            {
                _colP8 = value;
            }
        }
        
        public double colP4
        {
            get
            {
                return _colP4;
            }
            set
            {
                _colP4 = value;
            }
        }
        
        public double colPAST
        {
            get
            {
                return _colPAST;
            }
            set
            {
                _colPAST = value;
            }
        }

        public double colINV
        {
            get
            {
                return _colINV;
            }
            set
            {
                _colINV = value;
            }
        }

        public double colTotals
        {
            get
            {
                return _colTotals;
            }
            set
            {
                _colTotals = value;
            }
        }

        public double colW00
        {
            get
            {
                return _colW00;
            }
            set
            {
                _colW00 = value;
            }
        }

        public double colW01
        {
            get
            {
                return _colW01;
            }
            set
            {
                _colW01 = value;
            }
        }
        
        public double colW02
        {
            get
            {
                return _colW02;
            }
            set
            {
                _colW02 = value;
            }
        }

        public double colW03
        {
            get
            {
                return _colW03;
            }
            set
            {
                _colW03 = value;
            }
        }

        public double colW04
        {
            get
            {
                return _colW04;
            }
            set
            {
                _colW04 = value;
            }
        }

        public double colW05
        {
            get
            {
                return _colW05;
            }
            set
            {
                _colW05 = value;
            }
        }      

        public double colW06
        {
            get
            {
                return _colW06;
            }
            set
            {
                _colW06 = value;
            }
        }

        public double colW07
        {
            get
            {
                return _colW07;
            }
            set
            {
                _colW07 = value;
            }
        }

        public double colW08
        {
            get
            {
                return _colW08;
            }
            set
            {
                _colW08 = value;
            }
        }

        public double colW09
        {
            get
            {
                return _colW09;
            }
            set
            {
                _colW09 = value;
            }
        }

        public double colW10
        {
            get
            {
                return _colW10;
            }
            set
            {
                _colW10 = value;
            }
        }

        public double colW11
        {
            get
            {
                return _colW11;
            }
            set
            {
                _colW11 = value;
            }
        }

        public double colW12
        {
            get
            {
                return _colW12;
            }
            set
            {
                _colW12 = value;
            }
        }

        public double colW13
        {
            get
            {
                return _colW13;
            }
            set
            {
                _colW13 = value;
            }
        }
        
        public string ORDNUM
        {
            get
            {
                return _Orders;
            }
            set
            {
                 _Orders = value;
            }
        }

        public string DETAIL
        {
            get
            {
                return _Details;
            }
            set
            {
                _Details = value;
            }
        }
        
        public string ptr
        {
            set
            {
                _ptr = value;
            }
        }

        public double coldoubleValues
        {
            get
            {
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colP13) == 0)
                {
                    return _colP13;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colP8) == 0)
                {
                    return _colP8;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colP4) == 0)
                {
                    return _colP4;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colPAST) == 0)
                {
                    return _colPAST;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colINV) == 0)
                {
                    return _colINV;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colTotal) == 0)
                {
                    return _colTotals;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW00) == 0)
                {
                    return _colW00;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW01) == 0)
                {
                    return _colW01;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW02) == 0)
                {
                    return _colW02;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW03) == 0)
                {
                    return _colW03;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW04) == 0)
                {
                    return _colW04;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW05) == 0)
                {
                    return _colW05;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW06) == 0)
                {
                    return _colW06;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW07) == 0)
                {
                    return _colW07;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW08) == 0)
                {
                    return _colW08;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW09) == 0)
                {
                    return _colW09;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW10) == 0)
                {
                    return _colW10;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW11) == 0)
                {
                    return _colW11;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW12) == 0)
                {
                    return _colW12;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW13) == 0)
                {
                    return _colW13;
                }

                return 0;

            }
            set
            {
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colP13) == 0)
                {
                    _colP13 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colP8) == 0)
                {
                    _colP8 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colP4) == 0)
                {
                    _colP4 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colPAST) == 0)
                {
                    _colPAST = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colINV) == 0)
                {
                    _colINV = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colTotal) == 0)
                {
                    _colTotals = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW00) == 0)
                {
                    _colW00 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW01) == 0)
                {
                    _colW01 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW02) == 0)
                {
                    _colW02 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW03) == 0)
                {
                    _colW03 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW04) == 0)
                {
                    _colW04 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW05) == 0)
                {
                    _colW05 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW06) == 0)
                {
                    _colW06 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW07) == 0)
                {
                    _colW07 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW08) == 0)
                {
                    _colW08 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW09) == 0)
                {
                    _colW09 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW10) == 0)
                {
                    _colW10 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW11) == 0)
                {
                    _colW11 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW12) == 0)
                {
                    _colW12 = value;
                }
                if (string.Compare(_ptr, DataLayer.SalesPlanResources.colW13) == 0)
                {
                    _colW13 = value;
                }
            }
        }
    }
}