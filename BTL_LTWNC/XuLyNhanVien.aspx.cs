using BTL_LTWNC.Model;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BtlLtwnc.Data;
using Newtonsoft.Json;
using System.Net;

namespace BTL_LTWNC
{
    public partial class XuLyNhanVien : System.Web.UI.Page
    {
        DataContext context = new DataContext();
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
                if (obj.GetValue("XuLy").ToString() == "1")
                {
                    AddTaiKhoan(obj);
                }
                else if (obj.GetValue("XuLy").ToString() == "2")
                {
                    EditTaiKhoan(obj);
                }
                else if (obj.GetValue("XuLy").ToString() == "3")
                {
                    DeleteTaiKhoan(obj);
                }

            }
        }

        protected void AddTaiKhoan(JObject obj)
        {
            try
            {
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("NAME", obj.GetValue("Name").ToString()));
                sqlParameters.Add(new SqlParameter("BIRTHDAY", obj.GetValue("NgaySinh").ToString()));
                sqlParameters.Add(new SqlParameter("GENDER", obj.GetValue("Gender").ToString()));
                sqlParameters.Add(new SqlParameter("ROLE", obj.GetValue("Role").ToString()));
                sqlParameters.Add(new SqlParameter("CCCD", obj.GetValue("CCCD").ToString()));
                sqlParameters.Add(new SqlParameter("EMAIL", obj.GetValue("Email").ToString()));
                sqlParameters.Add(new SqlParameter("PHONE", obj.GetValue("Phone").ToString()));

                DataTable kiemTra = context.getTableWithProc(sqlParameters, "CREATE_EMPLOYEE");
                if (kiemTra.Rows.Count == 0)
                {
                    Response.Write("Thêm thành công");
                    Response.Flush();
                    Response.Close();
                }
                else
                {
                    Response.Write("Thêm thất bại");
                    Response.Flush();
                    Response.Close();
                }
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
                sqlParameters.Add(new SqlParameter("EMPLOYEE_ID", obj.GetValue("EmployeeId").ToString()));
                sqlParameters.Add(new SqlParameter("NAME", obj.GetValue("Name").ToString()));
                sqlParameters.Add(new SqlParameter("BIRTHDAY", obj.GetValue("NgaySinh").ToString()));
                sqlParameters.Add(new SqlParameter("GENDER", obj.GetValue("Gender").ToString()));
                sqlParameters.Add(new SqlParameter("ROLE", obj.GetValue("Role").ToString()));
                sqlParameters.Add(new SqlParameter("CCCD", obj.GetValue("CCCD").ToString()));
                sqlParameters.Add(new SqlParameter("EMAIL", obj.GetValue("Email").ToString()));
                sqlParameters.Add(new SqlParameter("PHONE", obj.GetValue("Phone").ToString()));

                DataTable kiemTra = context.getTableWithProc(sqlParameters, "EDIT_EMPLOYEE");
                if (kiemTra.Rows.Count == 0)
                {
                    Response.Write("Sửa thành công");
                    Response.Flush();
                    Response.Close();
                }
                else
                {
                    Response.Write("Sửa thất bại");
                    Response.Flush();
                    Response.Close();
                }
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
                sqlParameters.Add(new SqlParameter("EMPLOYEE_ID", obj.GetValue("EmployeeId").ToString()));

                DataTable kiemTra = context.getTableWithProc(sqlParameters, "DELETE_EMPLOYEE");
                Response.Write("Xóa thành công");
                Response.Flush();
                Response.Close();
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
                List<SqlParameter> sqlParameters = new List<SqlParameter>();
                sqlParameters.Add(new SqlParameter("EMPLOYEE_ID", employeeId));
                DataTable kiemTra = context.getTableWithProc(sqlParameters, "GET_THONG_TIN_EMPLOYEE");
                Response.Write(JsonConvert.SerializeObject(kiemTra));
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