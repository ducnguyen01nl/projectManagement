using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace BTL_LTWNC
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

            // Web API routes
            GlobalConfiguration.Configure(config =>
            {
                config.MapHttpAttributeRoutes();

                config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{action}/{id}",
                defaults: new { id = RouteParameter.Optional }
    );
                config.Formatters.Remove(config.Formatters.XmlFormatter);
                config.Formatters.Clear();
                config.Formatters.Add(new JsonMediaTypeFormatter());
                // JSON formatting
                //config.Formatters.JsonFormatter.SupportedMediaTypes
                //    .Add(new MediaTypeHeaderValue("application/json"));
            });

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["userLogin"] = null;
            Session["roleUserLogin"] = null;
            Session["test"] = "test";

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {



        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            string currentPage = Request.Url.AbsolutePath;


            if (User != null)
            {
                if (!User.Identity.IsAuthenticated)
                {
                    if (!currentPage.ToLower().EndsWith("login.aspx"))
                    {
                        // Nếu không phải trang Login, chuyển hướng người dùng đến trang Login
                        Response.Redirect("~/Login.aspx");
                    }
                }
            }
            else
            {
                if (!currentPage.ToLower().EndsWith("login.aspx"))
                {
                    // Nếu không phải trang Login, chuyển hướng người dùng đến trang Login
                    Response.Redirect("~/Login.aspx");
                }

            }

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Session["userLogin"] = null;
            Session["roleUserLogin"] = null;
            FormsAuthentication.SignOut();
            Session.Abandon();

        }

        protected void Application_End(object sender, EventArgs e)
        {
            Session["userLogin"] = null;
            Session["roleUserLogin"] = null;
            FormsAuthentication.SignOut();
            Session.Abandon();
        }
    }
}