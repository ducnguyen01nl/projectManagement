using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.SessionState;

namespace BTL_LTWNC.Model
{
    public class Authorize
    {
        

        

        public static bool RoleWithWebForms(HttpSessionState session, int role)
        {
            try
            {
                UserCurrent userCurrent = (UserCurrent)session["userLogin"];

                if (userCurrent != null)
                {
                    if (userCurrent.ROLE <= role)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;

                }
            }
            catch
            {

                return false;

            }
        }

        private static void ResultUnAuthorize()
        {            
                var message = new HttpResponseMessage(HttpStatusCode.Unauthorized)
                {
                    ReasonPhrase = "UnAuthorize",
                    Content = new StringContent("Chưa đăng nhập hoặc không có quyền hạn!")
                };

                throw new HttpResponseException(message);
            
        }


    }
}