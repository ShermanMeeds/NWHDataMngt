using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace DataLayer
{
	public static class Log
	{
		public static void WriteLogEntry(string msg, string path)
		{
			using (StreamWriter oFile = File.AppendText(path))
				{
					
					oFile.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(), msg);
				}
		}

		public static void WriteErrorLogEntry(string msg, string path, Exception ex)
		{
			using (StreamWriter oFile = File.AppendText(path))
			{
				//string myDocPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
				oFile.WriteLine("{0} {1}: {2}", DateTime.Now.ToLongTimeString(), msg, ex.Message);
			}
		}
	}
}
