using BtlLtwnc.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;

namespace BTL_LTWNC.Model
{
    public class CustomAuthorizeAttribute : AuthorizeAttribute
    {
        DataContext dataContext = new DataContext();

        protected override bool IsAuthorized(HttpActionContext actionContext)
        {
            try
            {
                string[] roles = Roles.Split(',');
                string userId = HttpContext.Current.User.Identity.Name;

                var lisparam = new List<SqlParameter>();
                lisparam.Add(new SqlParameter("@USER_ID", userId));

                DataTable data = dataContext.GetTableWithProc(lisparam, "GetUser");

                foreach (var role in roles)
                {
                    if (role == data.Rows[0]["ROLE"].ToString() || role == data.Rows[0]["ROLE_NAME"].ToString())
                    {
                        return true;
                    }
                }
                // Thực hiện kiểm tra phân quyền của riêng mình
                return false; // hoặc false tùy vào điều kiện kiểm tra
            }
            catch
            {
                return false;
            }
        }
    }
}