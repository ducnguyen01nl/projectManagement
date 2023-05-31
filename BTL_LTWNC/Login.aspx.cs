using BTL_LTWNC.Model;
using BtlLtwnc.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;

namespace BTL_LTWNC
{
    public partial class Login : System.Web.UI.Page
    {
        DataContext dataContext = new DataContext();
        En_Code en_code = new En_Code();

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["userLogin"] = null;
            FormsAuthentication.SignOut();
        }

        protected void LOGIN_Click(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(userName.Value) && !string.IsNullOrWhiteSpace(passWord.Value))
                {
                    DataTable Login = IsValidUser(userName.Value, passWord.Value);
                    if (Login != null && Login.Rows.Count > 0)
                    {
                        Session["userLogin"] = new UserCurrent
                        {
                            AVATAR = "",
                            USERNAME = userName.Value,
                            ROLE = (int)Login.Rows[0]["ROLE"]
                        };
                        Session["roleUserLogin"] = Login.Rows[0]["ROLE"];
                        FormsAuthentication.SetAuthCookie(Login.Rows[0]["USER_ID"].ToString(), false);
                        


                        Response.Redirect("~/Home.aspx");
                    }
                    else
                    {
                        textError.InnerText = "Tài khoản hoặc mật khẩu không đúng";
                    }
                }
            }catch(Exception er)
            {
                var a = er;
            }

        }

        private DataTable IsValidUser(string username, string password)
        {
            string passwordEnCode = en_code.ToEnCodeHashCode(password);
            List<SqlParameter> paramsSql = new List<SqlParameter>();
            paramsSql.Add(new SqlParameter("@UserName", username));

            paramsSql.Add(new SqlParameter("@PassWord", passwordEnCode));
            DataTable result = dataContext.getTableWithProc(paramsSql, "Login");
            return result;
        }

       
    }
}