using BTL_LTWNC.Model;
using BtlLtwnc.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BtlLtwnc
{
    public partial class Home : System.Web.UI.Page
    {
        public DataTable dataTable { get; set; }

        DataContext dataContext = new DataContext();


        protected void Page_Load(object sender, EventArgs e)
        {
            UserCurrent userCurrent = (UserCurrent)Session["userLogin"];

            if(userCurrent == null)
            {
                Response.Redirect("Login.aspx");
            }




        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            
        }

        protected void LogOut_Click(object sender, EventArgs e)
        {
            Session["userLogin"] = null;
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");

        }
    }
}