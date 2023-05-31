using BTL_LTWNC.Model;
using BtlLtwnc.Data;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_LTWNC
{
    public partial class ThemTaiKhoan : System.Web.UI.Page
    {
        DataContext context = new DataContext();
        En_Code en_code = new En_Code();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Authorize.RoleWithWebForms(Session, 0))
            {
                Response.StatusCode = Convert.ToInt32(HttpStatusCode.Unauthorized);
                Response.Write("Chưa đăng nhập hoặc không có quyền hạn!");
                Response.Flush();
                Response.Close();
            }

            var inputStream = Request.InputStream;
            var streamReader = new StreamReader(inputStream);
            var requestBody = streamReader.ReadToEnd();
            if (string.IsNullOrEmpty(requestBody))
            {
                GetEmployee();
            }
            else
            {
                // Chuyển đổi dữ liệu JSON thành đối tượng C#
                JObject obj = JObject.Parse(requestBody);
                var value = obj.GetValue("XuLy").ToString();
                if (value == "1")
                {
                    AddTaiKhoan(obj);
                }
                else if (value == "2")
                {
                    TatTrangThai(obj);
                }
                else if(value == "3")
                {
                    DeleteTaiKhoan(obj);
                }
                else if (value == "4")
                {
                    EditTaiKhoan(obj);
                }

            }
        }

        protected void AddTaiKhoan(JObject obj)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                string userName = obj.GetValue("UserName").ToString();
                sqlParameters.Add(new SqlParameter("USER_NAME", userName));
                DataTable kiemTra = context.getTableWithProc(sqlParameters, "KIEM_TRA_USER");
                if (kiemTra.Rows.Count == 0)
                {
                    string passWord = en_code.ToEnCodeHashCode(obj.GetValue("PassWord").ToString());
                    sqlParameters.Add(new SqlParameter("PASSWORD", passWord));
                    sqlParameters.Add(new SqlParameter("ROLE", obj.GetValue("Role").ToString()));
                    var result = context.getTableWithProc(sqlParameters, "CREATE_USER");
                    Response.Write("Thêm thành công");
                    Response.Flush();
                    Response.Close();
                }
                else
                {
                    Response.Write("UserName đã tồn tại");
                    Response.Flush();
                    Response.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        protected void GetEmployee()
        {
            try
            {
                var employeeId = Request.QueryString["employeeId"];
                List<SqlParameter> sqlParameters= new List<SqlParameter>(); 
                sqlParameters.Add(new SqlParameter("EMPLOYEE_ID", employeeId));
                DataTable kiemTra = context.getTableWithProc(sqlParameters, "GET_EMPLOYEE");
                Response.Write(JsonConvert.SerializeObject(kiemTra));
                Response.Flush(); 
                Response.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        protected void DeleteTaiKhoan(JObject obj)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("USER_ID", obj.GetValue("UserId").ToString()));
                DataTable kiemTra = context.getTableWithProc(sqlParameters, "DELETE_USER");
                Response.Write("Xóa thành công");
                Response.Flush();
                Response.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        protected void EditTaiKhoan(JObject obj)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("USER_ID", obj.GetValue("UserId").ToString()));
                sqlParameters.Add(new SqlParameter("IS_ACTIVE", obj.GetValue("isAcite").ToString()));
                sqlParameters.Add(new SqlParameter("ROLE", obj.GetValue("Role").ToString()));
                sqlParameters.Add(new SqlParameter("EMPLOYEE_ID", obj.GetValue("employeeId").ToString()));
                DataTable kiemTra = context.getTableWithProc(sqlParameters, "EDIT_USER");
                Response.Write("Sửa thành công");
                Response.Flush();
                Response.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        protected void TatTrangThai(JObject obj)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("USER_ID", obj.GetValue("UserId").ToString()));
                sqlParameters.Add(new SqlParameter("IS_ACTIVE", obj.GetValue("TrangThai").ToString()));
                DataTable kiemTra = context.getTableWithProc(sqlParameters, "CLOSE_USER");
                Response.Write("Thành công");
                Response.Flush();
                Response.Close();
               
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
    }
}