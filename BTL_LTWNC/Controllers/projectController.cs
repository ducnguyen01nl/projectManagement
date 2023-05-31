using BTL_LTWNC.Model;
using BtlLtwnc.Data;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebTruyenApi.Models;
using System.Data.SqlClient;
using BTL_LTWNC.Data;
using System.Web;
using System.IO;
using System.Web.Hosting;
using System.Web.SessionState;

namespace BTL_LTWNC.Controllers
{
    public class projectController : ApiController
    {
        DataContext dataContext = new DataContext();


        [Authorize]
        [HttpGet]
        public IHttpActionResult getAll(string name = "", int page = 1, int limit = 10, string typeSort = "PROJECT_ID", Boolean sort = true, Boolean all = false, Boolean isActive = true, Boolean isDeleted = false)
        {


            try
            {
                var litsParams = new List<SqlParameter>();

                int userId = int.Parse(HttpContext.Current.User.Identity.Name);
                var listParam1 = new List<SqlParameter>();
                listParam1.Add(new SqlParameter("@USER_ID", userId));
                DataTable user = dataContext.getTableWithProc(listParam1, "GetUser");

                if (user.Rows.Count > 0 && (int)user.Rows[0]["ROLE"] > 1)
                {
                    var listParam2 = new List<SqlParameter>();
                    listParam2.Add(new SqlParameter("@USER_ID", userId));

                    DataTable userInfo = dataContext.getTableWithProc(listParam2, "GetChiTietTaiKhoan");
                    if (userInfo.Rows.Count > 0 && userInfo != null)
                    {
                        litsParams.Add(new SqlParameter("@EMPLOYEE_ID",(int)userInfo.Rows[0]["EMPLOYEE_ID"]));
                    }
                    else
                    {
                        litsParams.Add(new SqlParameter("@EMPLOYEE_ID", -1));

                    }

                }

                if (!string.IsNullOrWhiteSpace(name))
                {
                    litsParams.Add(new SqlParameter("@searchName", name));
                }

                if (!all)
                {
                    litsParams.Add(new SqlParameter("@isDeleted", isDeleted));

                    if (!isDeleted)
                    {
                        litsParams.Add(new SqlParameter("@isActive", isActive));
                    }

                }
                litsParams.Add(new SqlParameter("@limit", limit));
                litsParams.Add(new SqlParameter("@page", page));
                string[] strings = new string[] {"PROJECT_ID", "NAME", "DESCRIPTION", "START_AT", "END_AT", "DELAY_DATE", "IS_ACTIVE", "IS_SUCCESS", "CREATED_AT", "UPDATED_AT", "IS_DELETED" };

                if (strings.Contains(typeSort))
                {
                    litsParams.Add(new SqlParameter("@SortColumn", typeSort));

                }
                else
                {
                    litsParams.Add(new SqlParameter("@SortColumn", "PROJECT_ID"));

                }


                if (sort)
                {
                    litsParams.Add(new SqlParameter("@SortOrder", "ASC"));

                }
                else
                {
                    litsParams.Add(new SqlParameter("@SortOrder", "DESC"));


                }




                DataSet ds = dataContext.getTableDataSetWithProc(litsParams, "getProjects");


                var data = ds.Tables[0];
                int totalPage = Convert.ToInt32(ds.Tables[1].Rows[0]["TotalPage"]);
                int pageIndex = Convert.ToInt32(ds.Tables[1].Rows[0]["PageIndex"]);

                var eData = TableToList<Project>.ConvertDataTableToList(data);

                var result = new List<ProjectResponse>();
                //var pathImg = HostingEnvironment.MapPath("~/Assets/Img/");

                foreach (var item in eData)
                {
                    var listParamItem = new List<SqlParameter>();
                    listParamItem.Add(new SqlParameter("@PROJECT_ID", item.PROJECT_ID));
                    var resCompletionProgress = dataContext.getTableWithProc(listParamItem, "tinh_tien_do_hoan_thanh_cua_project");
                    var resQuantityEmployee = dataContext.getTableWithProc(listParamItem, "tinh_so_nv_cua_project");
                    double completionProgress = 0;
                    int quantityEmployee = 0;

                    if (resCompletionProgress != null)
                    {
                        var a = resCompletionProgress.Rows[0]["complete_progress"];
                        completionProgress = (double)a;
                    }
                    if (resQuantityEmployee != null)
                    {
                        var a = resQuantityEmployee.Rows[0]["TotalCountEmployee"];
                        quantityEmployee = Convert.ToInt32(a);
                    }


                    result.Add(new ProjectResponse
                    {
                        PROJECT_ID = item.PROJECT_ID,
                        CREATED_AT = item.CREATED_AT,
                        DELAY_DATE = item.DELAY_DATE,
                        DESCRIPTION = item.DESCRIPTION,
                        END_AT = item.END_AT,
                        IS_ACTIVE = item.IS_ACTIVE,
                        IS_DELETED = item.IS_DELETED,
                        IS_SUCCESS = item.IS_SUCCESS,
                        NAME = item.NAME,
                        START_AT = item.START_AT,
                        UPDATED_AT = item.UPDATED_AT,
                        BACKGROUND_URL = string.IsNullOrEmpty(item.BACKGROUND_URL) ? "" : "./Assets/Img/" + item.BACKGROUND_URL,
                        COMPLETION_PROGRESS = (float)completionProgress,
                        QUANTITY_EMPLOYEE = (int)quantityEmployee
                    });
                }




                return Ok(new
                {
                    data = result,
                    pageindex = pageIndex,
                    totalpage = totalPage,

                });
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [CustomAuthorize(Roles = "0,1")]
        [HttpPost]
        public IHttpActionResult CreateProject(ProjectVM projectVM)
        {

            try
            {
                var listParams = new List<SqlParameter>();
                listParams.Add(new SqlParameter("@name", projectVM.NAME));
                listParams.Add(new SqlParameter("@description", projectVM.DES));

                var result = dataContext.getTableWithProc(listParams, "create_project");
                return Ok("Tạo thành công");

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [CustomAuthorize(Roles = "0,1")]
        [HttpPut]
        public IHttpActionResult UpdateProject(int ProjectID, [FromBody] ProjectUpdate projectUpdate, bool isStartAt = false, bool isEndAt = false)
        {
            try
            {

                var listParams = new List<SqlParameter>();
                listParams.Add(new SqlParameter("@PROJECT_ID", ProjectID));

                if (projectUpdate != null)
                {
                    if (!string.IsNullOrEmpty(projectUpdate.NAME))
                    {
                        listParams.Add(new SqlParameter("@NAME", projectUpdate.NAME));
                    }
                    if (!string.IsNullOrEmpty(projectUpdate.DESCRIPTION))
                    {
                        listParams.Add(new SqlParameter("@DESCRIPTION", projectUpdate.DESCRIPTION));

                    }
                    if (isStartAt)
                    {
                        listParams.Add(new SqlParameter("@isStartAt", 1));

                        listParams.Add(new SqlParameter("@start_at", projectUpdate.START_AT));

                    }
                    if (isEndAt)
                    {
                        listParams.Add(new SqlParameter("@isEndAt", 1));

                        listParams.Add(new SqlParameter("@end_at", projectUpdate.END_AT));

                    }
                    if (projectUpdate.DELAY_DATE != null)
                    {
                        listParams.Add(new SqlParameter("@delay_date", projectUpdate.DELAY_DATE));

                    }
                    if (projectUpdate.IS_ACTIVE != null)
                    {
                        listParams.Add(new SqlParameter("@is_active", projectUpdate.IS_ACTIVE));

                    }
                    if (projectUpdate.IS_SUCCESS != null)
                    {
                        listParams.Add(new SqlParameter("@is_success", projectUpdate.IS_SUCCESS));

                    }
                    if (projectUpdate.IS_DELETED != null)
                    {
                        listParams.Add(new SqlParameter("@is_deleted", projectUpdate.IS_DELETED));

                    }
                }

                HttpPostedFile image = HttpContext.Current.Request.Files["image"];
                if (image != null && image.ContentLength != 0)
                {

                }
                listParams.Add(new SqlParameter("@updated_at", DateTime.Now));
                var result = dataContext.getTableWithProc(listParams, "update_tblProject");


                return Ok("Sửa thành công!");
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        
        [CustomAuthorize(Roles = "0,1")]
        [HttpPut]
        public IHttpActionResult UpdateProjectBackground(int ProjectID)
        {


            try
            {

                var listParams = new List<SqlParameter>();
                listParams.Add(new SqlParameter("@PROJECT_ID", ProjectID));

                HttpPostedFile image = HttpContext.Current.Request.Files["image"];
                if (image != null && image.ContentLength != 0)
                {
                    var path = HostingEnvironment.MapPath("~/Assets/Img/");
                    var fileName = "imgProject" + ProjectID + "." + image.FileName.Split('.')[1];
                    listParams.Add(new SqlParameter("@BACKGROUND_URL", fileName));

                    image.SaveAs(path + fileName);
                }
                listParams.Add(new SqlParameter("@updated_at", DateTime.Now));
                var result = dataContext.getTableWithProc(listParams, "update_tblProject");


                return Ok("Sửa thành công!");
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [CustomAuthorize(Roles = "0,1")]
        [HttpPut]
        public IHttpActionResult Restore(int id)
        {


            try
            {
                var listParams = new List<SqlParameter>();
                listParams.Add(new SqlParameter("@PROJECT_ID", id));
                listParams.Add(new SqlParameter("@is_deleted", false));

                var result = dataContext.getTableWithProc(listParams, "update_tblProject");


                return Ok("Khoio phục thành công!");

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [CustomAuthorize(Roles = "0,1")]
        [HttpDelete]
        public IHttpActionResult Delete(int id)
        {


            try
            {
                var listParams = new List<SqlParameter>();
                listParams.Add(new SqlParameter("@PROJECT_ID", id));
                listParams.Add(new SqlParameter("@is_deleted", true));

                var result = dataContext.getTableWithProc(listParams, "update_tblProject");


                return Ok("Xóa thành công!");

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [CustomAuthorize(Roles = "0,1")]
        [HttpDelete]
        public IHttpActionResult DeleteTrue(int id)
        {


            try
            {
                var listParams = new List<SqlParameter>();
                listParams.Add(new SqlParameter("@PROJECT_ID", id));

                var result = dataContext.getTableWithProc(listParams, "deleteProject");


                return Ok("Xóa thành công!");

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
