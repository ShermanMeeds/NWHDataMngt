using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace DataMngt.MyCode
{
    public class SalesPlanRow
    {
        private int _colP13 = 0;
        private int _colP12 = 0;
        private int _colP11 = 0;
        private int _colP10 = 0;
        private int _colP9 = 0;
        private int _colP8 = 0;
        private int _colP7 = 0;
        private int _colP6 = 0;
        private int _colP5 = 0;
        private int _colP4 = 0;
        private int _colP3 = 0;
        private int _colP2 = 0;
        private int _colP1 = 0;
        private int _colPAST = 0;
        private int _colINV = 0;
        private int _colW00MON = 0;
        private int _colW00TUE = 0;
        private int _colW00WED = 0;
        private int _colW00THU = 0;
        private int _colW00FRI = 0;
        private int _colW01MON = 0;
        private int _colW01TUE = 0;
        private int _colW01WED = 0;
        private int _colW01THU = 0;
        private int _colW01FRI = 0;
        private int _colW02MON = 0;
        private int _colW02TUE = 0;
        private int _colW02WED = 0;
        private int _colW02THU = 0;
        private int _colW02FRI = 0;
        private int _colW03FRI = 0;
        private int _colW04FRI = 0;
        private int _colW05FRI = 0;
        private int _colW06FRI = 0;
        private int _colW07FRI = 0;
        private int _colW08FRI = 0;
        private int _colW09FRI = 0;
        private int _colW10FRI = 0;
        private int _colW11FRI = 0;
        private int _colW12FRI = 0;
        private int _colW13FRI = 0;
        private int _colW14FRI = 0;
        private int _colW15FRI = 0;
        private int _colW16FRI = 0;
        private int _colW00SAT = 0;
        private int _colW00SUN = 0;
        private StringBuilder _Orders = new StringBuilder(2000);
        private StringBuilder _Details = new StringBuilder(8000); 

        public int colP13
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

        public int colP12
        {
            get
            {
                return _colP12;
            }
            set
            {
                _colP12 = value;
            }
        }

        public int colP11
        {
            get
            {
                return _colP11;
            }
            set
            {
                _colP11 = value;
            }
        }

        public int colP10
        {
            get
            {
                return _colP10;
            }
            set
            {
                _colP10 = value;
            }
        }

        public int colP9
        {
            get
            {
                return _colP9;
            }
            set
            {
                _colP9 = value;
            }
        }

        public int colP8
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

        public int colP7
        {
            get
            {
                return _colP7;
            }
            set
            {
                _colP7 = value;
            }
        }

        public int colP6
        {
            get
            {
                return _colP6;
            }
            set
            {
                _colP6 = value;
            }
        }

        public int colP5
        {
            get
            {
                return _colP5;
            }
            set
            {
                _colP5 = value;
            }
        }

        public int colP4
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

        public int colP3
        {
            get
            {
                return _colP3;
            }
            set
            {
                _colP3 = value;
            }
        }

        public int colP2
        {
            get
            {
                return _colP2;
            }
            set
            {
                _colP2 = value;
            }
        }

        public int colP1
        {
            get
            {
                return _colP1;
            }
            set
            {
                _colP1 = value;
            }
        }

        public int colPAST
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

        public int colINV
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

        public int colW00MON
        {
            get
            {
                return _colW00MON;
            }
            set
            {
                _colW00MON = value;
            }
        }

        public int colW00TUE
        {
            get
            {
                return _colW00TUE;
            }
            set
            {
                _colW00TUE = value;
            }
        }

        public int colW00WED
        {
            get
            {
                return _colW00WED;
            }
            set
            {
                _colW00WED = value;
            }
        }

        public int colW00THU
        {
            get
            {
                return _colW00THU;
            }
            set
            {
                _colW00THU = value;
            }
        }

        public int colW00FRI
        {
            get
            {
                return _colW00FRI;
            }
            set
            {
                _colW00FRI = value;
            }
        }

        public int colW01MON
        {
            get
            {
                return _colW01MON;
            }
            set
            {
                _colW01MON = value;
            }
        }

        public int colW01TUE
        {
            get
            {
                return _colW01TUE;
            }
            set
            {
                _colW01TUE = value;
            }
        }

        public int colW01WED
        {
            get
            {
                return _colW01WED;
            }
            set
            {
                _colW01WED = value;
            }
        }

        public int colW01THU
        {
            get
            {
                return _colW01THU;
            }
            set
            {
                _colW01THU = value;
            }
        }

        public int colW01FRI
        {
            get
            {
                return _colW01FRI;
            }
            set
            {
                _colW01FRI = value;
            }
        }

        public int colW02MON
        {
            get
            {
                return _colW02MON;
            }
            set
            {
                _colW02MON = value;
            }
        }

        public int colW02TUE
        {
            get
            {
                return _colW02TUE;
            }
            set
            {
                _colW02TUE = value;
            }
        }

        public int colW02WED
        {
            get
            {
                return _colW02WED;
            }
            set
            {
                _colW02WED = value;
            }
        }

        public int colW02THU
        {
            get
            {
                return _colW02THU;
            }
            set
            {
                _colW02THU = value;
            }
        }

        public int colW02FRI
        {
            get
            {
                return _colW02FRI;
            }
            set
            {
                _colW02FRI = value;
            }
        }

        public int colW03FRI
        {
            get
            {
                return _colW03FRI;
            }
            set
            {
                _colW03FRI = value;
            }
        }

        public int colW04FRI
        {
            get
            {
                return _colW04FRI;
            }
            set
            {
                _colW04FRI = value;
            }
        }

        public int colW05FRI
        {
            get
            {
                return _colW05FRI;
            }
            set
            {
                _colW05FRI = value;
            }
        }      

        public int colW06FRI
        {
            get
            {
                return _colW06FRI;
            }
            set
            {
                _colW06FRI = value;
            }
        }

        public int colW07FRI
        {
            get
            {
                return _colW07FRI;
            }
            set
            {
                _colW07FRI = value;
            }
        }

        public int colW08FRI
        {
            get
            {
                return _colW08FRI;
            }
            set
            {
                _colW08FRI = value;
            }
        }

        public int colW09FRI
        {
            get
            {
                return _colW09FRI;
            }
            set
            {
                _colW09FRI = value;
            }
        }

        public int colW10FRI
        {
            get
            {
                return _colW10FRI;
            }
            set
            {
                _colW10FRI = value;
            }
        }

        public int colW11FRI
        {
            get
            {
                return _colW11FRI;
            }
            set
            {
                _colW11FRI = value;
            }
        }

        public int colW12FRI
        {
            get
            {
                return _colW12FRI;
            }
            set
            {
                _colW12FRI = value;
            }
        }

        public int colW13FRI
        {
            get
            {
                return _colW13FRI;
            }
            set
            {
                _colW13FRI = value;
            }
        }

        public int colW14FRI
        {
            get
            {
                return _colW14FRI;
            }
            set
            {
                _colW14FRI = value;
            }
        }

        public int colW15FRI
        {
            get
            {
                return _colW15FRI;
            }
            set
            {
                _colW15FRI = value;
            }
        }

        public int colW16FRI
        {
            get
            {
                return _colW16FRI;
            }
            set
            {
                _colW16FRI = value;
            }
        }

        public int colW00SAT
        {
            get
            {
                return _colW00SAT;
            }
            set
            {
                _colW00SAT = value;
            }
        }

        public int colW00SUN
        {
            get
            {
                return _colW00SUN;
            }
            set
            {
                _colW00SUN = value;
            }
        }

        public string ORDNUM
        {
            get
            {
                return _Orders.ToString();
            }
            set
            {
                if (_Orders.Length > 0)
                {
                    if (!string.IsNullOrWhiteSpace(value))
                    {
                        _Orders.Append("|");
                        _Orders.Append(value);
                    }
                }
            }
        }

        public string DETAIL
        {
            get
            {
                return _Details.ToString();
            }
            set
            {
                if (_Details.Length > 0)
                {
                    if (!string.IsNullOrWhiteSpace(value))
                    {
                        _Details.Append("|");
                        _Details.Append(value);
                    }
                }
            }
        }
    }
}