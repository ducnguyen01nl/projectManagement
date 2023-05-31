using BtlLtwnc.Data;
using Newtonsoft.Json;
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
    public partial class ChiTietTaiKhoan : System.Web.UI.Page
    {
        DataContext context = new DataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session == null || (int)Session["roleUserLogin"] != 0)
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
                DataTable data = context.getTableWithProc(sqlParameter, "GetUser");
                Response.Write(JsonConvert.SerializeObject(data));
                Response.Flush();
                Response.Close();
            }
                /*txtUSER_ID.Value = data.Rows[0]["USER_ID"].ToString();
                string birthdayString = data.Rows[0]["BIRTHDAY"] == null ? "" : data.Rows[0]["BIRTHDAY"].ToString();
                if (!string.IsNullOrEmpty(birthdayString))
                {
                    DateTime birthday;
                    if (DateTime.TryParse(birthdayString, out birthday))
                    {
                        txtDate.Value = birthday.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        // handle invalid date format
                    }
                }
                else
                {
                    // handle null or empty value
                }
                txtName.Value = data.Rows[0]["NAME"].ToString();
                if (int.Parse(data.Rows[0]["ROLE"].ToString()) == 0)
                {
                    txtRole.Value = "Quản trị viên";
                }else if (int.Parse(data.Rows[0]["ROLE"].ToString()) == 1)
                {
                    txtRole.Value = "PM";
                }else if (int.Parse(data.Rows[0]["ROLE"].ToString()) == 2){
                    txtRole.Value = "Leader";
                }else
                {
                    txtRole.Value = "Nhân viên";
                }

                if((bool)data.Rows[0]["GENDER"] == true)
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
            }*/
        }
    }
}