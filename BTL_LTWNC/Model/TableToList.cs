using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;

namespace BTL_LTWNC.Model
{
    public class TableToList<T> where T : new()
    {
        public static List<T> ConvertDataTableToList(DataTable dt) 
        {
            List<T> list = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                T obj = new T();
                foreach (DataColumn col in dt.Columns)
                {
                    PropertyInfo propertyInfo = obj.GetType().GetProperty(col.ColumnName);
                    var value = row[col];
                    if (propertyInfo != null && value != DBNull.Value)
                    {
                        if (propertyInfo.PropertyType == typeof(DateTime?))
                        {
                            propertyInfo.SetValue(obj, new DateTime?(Convert.ToDateTime(value)), null);

                        }
                        else
                        {
                            propertyInfo.SetValue(obj, Convert.ChangeType(value, propertyInfo.PropertyType), null);

                        }

                    }
                   


                }
                list.Add(obj);
            }
            return list;
        }
    }
}