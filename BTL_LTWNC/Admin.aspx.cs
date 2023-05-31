using BTL_LTWNC.Model;
using BtlLtwnc.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_LTWNC
{
    public partial class Admin2 : System.Web.UI.Page
    {
        DataContext _context = new DataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            //UserCurrent userCurrent = (UserCurrent)Session["userLogin"];

            //if (userCurrent == null)
            //{
            //    Response.Redirect("Login.aspx");
            //}
            if (Session==null||(int)Session["roleUserLogin"] != 0)
            {
                Response.Redirect("Home.aspx");
            }
            var reuslt = GetUser();
            ListView1.DataSource = reuslt;
            ListView1.DataBind();
        }

        protected DataTable GetUser()
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("USER_ID", DBNull.Value));
            return _context.getTableWithProc(sqlParameters, "GetUser");

        }

        protected string XuLyNhanVien(object idNhanVien)
        {
            var value = idNhanVien.ToString();
            if (!string.IsNullOrEmpty(value))
            {
                return value;
            }
            return "-1";
        }

        private bool IsNullOrEmpty()
        {
            throw new NotImplementedException();
        }

        protected string InsertActive(object active)
        {
            var value = (bool)active;
            if (value) return "Đang hoạt động";
            return "Dừng hoạt động";
        }

        protected string XuLyIsActive(object active)
        {
            var value = (bool)active;
            if (value) return "Tắt trạng thái";
            return "Bật trạng thái";
        }

        protected string XuLyDate(object date)
        {
            string dateStr = date.ToString();
            DateTime birthday;
            DateTime.TryParse(dateStr, out birthday);
            return birthday.ToString("dd/MM/yyyy");
        }

        protected void add_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThemTaiKhoan.aspx");
        }

        
    }
}