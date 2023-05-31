using BtlLtwnc.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_LTWNC
{
    public partial class NhanVien2 : System.Web.UI.Page
    {
        DataContext _context = new DataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session == null || (int)Session["roleUserLogin"] != 0)
            {
                Response.Redirect("Home.aspx");
            }
            var reuslt = GetEmployee();
            ListView1.DataSource = reuslt;
            ListView1.DataBind();
        }

        protected DataTable GetEmployee()
        {
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            sqlParameters.Add(new SqlParameter("EMPLOYEE_ID", DBNull.Value));
            return _context.getTableWithProc(sqlParameters, "GET_THONG_TIN_EMPLOYEE");

        }

        protected string XuLyDate(object date)
        {
            string dateStr = date.ToString();
            DateTime birthday;
            DateTime.TryParse(dateStr, out birthday);
            return birthday.ToString("dd/MM/yyyy");
        }

        protected string XuLyGioiTinh(object gender)
        {
            var gt = (bool)gender;
            return gt ? "Nam" : "Nữ";
        }
    }
}