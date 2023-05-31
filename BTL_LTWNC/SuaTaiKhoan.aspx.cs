using BtlLtwnc.Data;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BTL_LTWNC.Model;
using System.Net;

namespace BTL_LTWNC
{
    public partial class SuaTaiKhoan : System.Web.UI.Page
    {
        DataContext context = new DataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((int)Session["roleUserLogin"] != 0)
            {
                Response.Redirect("Home.aspx");
            }
           
            if (Request["id"] != null)
            {
                List<SqlParameter> sqlParameter = new List<SqlParameter>();
                SqlParameter sql = new SqlParameter();
                sql.Value = Request["id"];
                sql.ParameterName = "USER_ID";
                sqlParameter.Add(sql);
                DataTable data = context.getTableWithProc(sqlParameter, "GetChiTietTaiKhoan");
                string birthdayString = data.Rows[0]["BIRTHDAY"] == null ? "" : data.Rows[0]["BIRTHDAY"].ToString();
                if (!string.IsNullOrEmpty(birthdayString))
                {
                    DateTime birthday;
                    if (DateTime.TryParse(birthdayString, out birthday))
                    {
                        txtNgaySinh.Value = birthday.ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        // handle invalid date format
                    }
                }
                txtName.Value = data.Rows[0]["NAME"].ToString();
                if ((bool)data.Rows[0]["GENDER"] == true)
                {
                    gtNam.Checked = true;
                }
                else
                {
                    gtNu.Checked = true;
                }
                txtPhone.Value = data.Rows[0]["PHONE"].ToString() == null ? "" : data.Rows[0]["PHONE"].ToString();
                txtCCCD.Value = data.Rows[0]["CCCD"].ToString() == null ? "" : data.Rows[0]["CCCD"].ToString();
                txtEmail.Value = data.Rows[0]["EMAIL"].ToString() == null ? "" : data.Rows[0]["EMAIL"].ToString();
            }
        }
    }
}