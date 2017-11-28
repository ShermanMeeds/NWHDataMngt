using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Script.Serialization;

namespace DataMngt
{
	/// <summary>
	/// JSON Serialization and Deserialization Assistant Class
	/// </summary>
	public static class JsonHelper
	{
		/// <summary>
		/// JSON Serialization
		/// </summary>
		public static string JsonSerializer<T>(T t)
		{
			DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
			MemoryStream ms = new MemoryStream();
			ser.WriteObject(ms, t);
			string jsonString = Encoding.UTF8.GetString(ms.ToArray());
			ms.Close();
			return jsonString;
		}
		/// <summary>
		/// JSON Deserialization
		/// </summary>
		public static T JsonDeserialize<T>(string jsonString)
		{
			DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
			MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
			T obj = (T)ser.ReadObject(ms);
			return obj;
		}

		public static string toJSONfmTbl(DataTable tbl)
		{
			System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
			Dictionary<string, object> row = null;

			foreach (DataRow dr in tbl.Rows)
			{
				row = new Dictionary<string, object>();
				foreach (DataColumn col in tbl.Columns)
				{
					row.Add(col.ColumnName.Trim(), dr[col]);
				}
				rows.Add(row);
			}
			return serializer.Serialize(rows);
		}

		public static string ToJSON(this object obj)
		{
			JavaScriptSerializer serializer = new JavaScriptSerializer();
			return serializer.Serialize(obj);
		}

		//public static string ToJSON(this object obj, int recursionDepth)
		//{
		//	JavaScriptSerializer serializer = new JavaScriptSerializer();
		//	serializer.RecursionLimit = recursionDepth;
		//	return serializer.Serialize(obj);
		//}

	}
}