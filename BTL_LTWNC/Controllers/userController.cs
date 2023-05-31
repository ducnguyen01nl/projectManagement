using BtlLtwnc.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BTL_LTWNC.Controllers
{
    public class userController : ApiController
    {
        DataContext dataContext = new DataContext();

        // GET api/<controller>
        public IHttpActionResult Get()
        {
            return Ok();
        }

        
    }
}