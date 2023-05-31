using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

using System.Linq;
using System.Web;

namespace BtlLtwnc.Data
{

    public class DataContext
    {
        string connectDatabase = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;

        public DataTable getTableWithProc(List<SqlParameter> parames, string proc)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(connectDatabase))
                {
                    using (SqlCommand cmd = cnn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        if(parames != null)
                        {
                            foreach (var item in parames)
                            {
                                cmd.Parameters.Add( new SqlParameter(item.ParameterName, item.Value));
                            }
                        }
                        cmd.CommandText = proc;

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            return dt;
                        }

                    }
                }
            }catch(Exception e)
            {
                return null;
            }
        }

        public DataSet getTableDataSetWithProc(List<SqlParameter> parames, string proc)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(connectDatabase))
                {
                    using (SqlCommand cmd = cnn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        if (parames != null)
                        {
                            foreach (var item in parames)
                            {
                                cmd.Parameters.Add(item);
                            }
                        }
                        cmd.CommandText = proc;

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataSet ds = new DataSet();
                            da.Fill(ds);
                           
                            return ds;
                        }

                    }
                }
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public DataTable getTableWithQuerySql(string sql)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(connectDatabase))
                {
                    using (SqlCommand cmd = cnn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = sql;

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            return dt;
                        }

                    }
                }
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public bool ThucThiProc(List<SqlParameter> sqlParameters,string proc)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(connectDatabase))
                {
                    using (SqlCommand cmd = cnn.CreateCommand())
                    {       
                        cmd.CommandType = CommandType.StoredProcedure;
                        if (sqlParameters != null)
                        {
                            foreach (var item in sqlParameters)
                            {
                                cmd.Parameters.Add(new SqlParameter(item.ParameterName, item.Value));
                            }
                        }
                        cmd.CommandText = proc;
                        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                        return true;

                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }


        public DataTable GetTableWithProc(List<SqlParameter> parames, string proc)
        {
            try
            {
                using (SqlConnection cnn = new SqlConnection(connectDatabase))
                {
                    using (SqlCommand cmd = cnn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        if (parames != null)
                        {
                            foreach (var item in parames)
                            {
                                cmd.Parameters.Add(item);
                            }
                        }
                        cmd.CommandText = proc;

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            return dt;
                        }

                    }
                }
            }
            catch (Exception e)
            {
                return null;
            }
        }
    }
}