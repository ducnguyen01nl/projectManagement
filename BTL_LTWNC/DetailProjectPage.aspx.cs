using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_LTWNC
{
    public partial class DetailProjectPage : System.Web.UI.Page
    {
            string connnectionString = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["GroupId"] = 0;
            using (SqlConnection cnn = new SqlConnection(connnectionString))
            {
                if(Request.QueryString["q"] != null)
                {
                    int projectId = int.Parse(Request.QueryString["q"]);
                    SqlCommand cmd = new SqlCommand("GetProjectByID", cnn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ProjectID", projectId);
                    cnn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ImageProject.ImageUrl = "Assets/Img/" + reader["BACKGROUND_URL"].ToString();
                        LabelProject.Text = reader["NAME"].ToString();
                        TextDes.Text = reader["DESCRIPTION"].ToString();
                        LabelEnd.Text = reader["END_AT"].ToString();
                        LabelStart.Text = reader["START_AT"].ToString();
                    }
                    reader.Close();
                    cnn.Close();
                    GetGroupWork(projectId);
                    
                }

            }

            //int idProject = int.Parse(Request.QueryString["q"]);
            //using (SqlConnection cnn = new SqlConnection(connnectionString))
            //{
            //    SqlCommand cmd = new SqlCommand("GetGroupWorkById", cnn);
            //    cmd.CommandType = CommandType.StoredProcedure;
            //    cmd.Parameters.AddWithValue("@ProjectID", idProject);
            //    cnn.Open();
            //    SqlDataReader dataReader = cmd.ExecuteReader();
            //    while (dataReader.Read())
            //    {
            //        ListItem listItem = new ListItem();
            //        listItem.Value = dataReader["GROUP_ID"].ToString();
            //        listItem.Text = dataReader["NAME"].ToString();
            //        DropDownListWorkGroup.Items.Add(listItem);
            //    }
            //    cnn.Close();
            //}

        }

        //protected void DropDownListWorkGroup_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    using(SqlConnection cnn = new SqlConnection(connnectionString))
        //    {
        //        SqlCommand cmd = new SqlCommand("GetInfoListTaskByGroupId", cnn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@GroupID", DropDownListWorkGroup.SelectedValue);
        //        cnn.Open();
        //        SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
        //        DataTable dataTable = new DataTable();
        //        dataAdapter.Fill(dataTable);
        //        GridViewGroupWork.DataSource = dataTable;
        //        GridViewGroupWork.DataBind();
        //        cnn.Close();
        //    }
        //}

        protected void GetGroupWork(int projectId)
        {
            using (SqlConnection cnn = new SqlConnection(connnectionString))
            {

                SqlCommand cmd = new SqlCommand("GetGroupWorkByID", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProjectID", projectId);
            cnn.Open();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
                //DataRow[] dateRow = dt.Select("", "NAME ASC").OrderBy(x => x["NAME"]).ToArray();
                //DataTable sortDt = dt.Clone();
                //foreach(DataRow data in dateRow)
                //{
                //    sortDt.ImportRow(data);
                //}
            RepeaterWorkGroup.DataSource = dt;
            RepeaterWorkGroup.DataBind();
            cnn.Close();
            }
        }

        protected DropDownList DropDownListTaskDelete;
        protected HiddenField HiddenField2;
        protected void RepeaterWorkGroup_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                using (SqlConnection cnn = new SqlConnection(connnectionString))
                {
                Label LabelLeader = (Label)e.Item.FindControl("LabelLeader");
                Label LabelIssue = (Label)e.Item.FindControl("LabelIssue");
                Repeater repeaterTask = (Repeater)e.Item.FindControl("RepeaterTask");
                CheckBoxList checkBoxListTask = (CheckBoxList)e.Item.FindControl("CheckBoxList1");
                HiddenField HiddenField = (HiddenField)e.Item.FindControl("HiddenField1");
                HiddenField2 = (HiddenField)e.Item.FindControl("HiddenField2");
                DropDownListTaskDelete = (DropDownList)e.Item.FindControl("DropDownListTaskDelete");
                DataRowView dataRowView = (DataRowView)e.Item.DataItem;

                SqlCommand cmd = new SqlCommand("GetNameLeaderById", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmployeeId", dataRowView["EMPLOYEE_ID_LEAD"]);
                cnn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                      LabelLeader.Text  = reader["NAME"].ToString();
                }
                reader.Close(); 
                cnn.Close();

                    Session["TaskTotal"] = 0;
                    Session["TaskSuccess"] = 0;

                SqlCommand cmd2 = new SqlCommand("GetTaskWorkByID", cnn);
                cmd2.CommandType = System.Data.CommandType.StoredProcedure;
                cmd2.Parameters.AddWithValue("@GroupId", dataRowView["GROUP_ID"]);
                cnn.Open();
                SqlDataReader dataReader = cmd2.ExecuteReader();
                while (dataReader.Read())
                {
                    if ((bool)dataReader["IS_SUCCESS"])
                    {
                        Session["TaskTotal"] = (int)Session["TaskTotal"] + 1;
                        Session["TaskSuccess"] = (int)Session["TaskSuccess"] + 1;
                    }
                    else
                    {
                        Session["TaskTotal"] = (int)Session["TaskTotal"] + 1;
                    }

                    ListItem item = new ListItem();
                    item.Text = dataReader["NAME"].ToString() + " <label class='issue__user' name='issue__user'><i class='fas fa-angle-double-right fa-lg' style='color: #ff0000;'></i>" + dataReader["NAMEEPLOYEE"].ToString() + "</label>";
                    item.Value = dataReader["TASK_ID"].ToString();
                    item.Selected = (bool)dataReader["IS_SUCCESS"];
                    checkBoxListTask.Items.Add(item);
                }
                dataReader.Close();
                //if((int)Session["TaskSuccess"] != 0)
                //    {
                //        HiddenField.Value = (((int)Session["TaskSuccess"] / (int)Session["TaskTotal"]) * 100).ToString();
                //    }
                //    else
                //    {
                //        HiddenField.Value = "0";
                //    }
                cnn.Close();

                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string UpdateTask(int taskId, bool isSuccess)
        {
            string connnectionString = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;
            using (SqlConnection cnn = new SqlConnection(connnectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateTask", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TaskId", taskId);
                cmd.Parameters.AddWithValue("@IsSuccess", isSuccess);
                cnn.Open();
                cmd.ExecuteNonQuery();
                cnn.Close();
            }
            return "success";
        }


            protected void AddWorkGroup_Click(object sender, EventArgs e)
            {
                int projectId = int.Parse(Request.QueryString["q"]);
                Response.Redirect("NewGroupWorkPage.aspx?q=" + projectId);
            }

        



        //[System.Web.Services.WebMethod]
        //public static void GetTaskDelete()
        //{
        //    if(DropDownListTaskDelete != null)
        //    {

        //        string connnectionString = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;
        //        using (SqlConnection cnn = new SqlConnection(connnectionString))
        //        {

        //            SqlCommand cmd3 = new SqlCommand("GetTaskWorkByID", cnn);
        //            cmd3.CommandType = CommandType.StoredProcedure;
        //            cmd3.Parameters.AddWithValue("@GroupId", Convert.ToInt32(HiddenField2.Value));
        //            cnn.Open();
        //            SqlDataReader dataReader3 = cmd3.ExecuteReader();
        //            while (dataReader3.Read())
        //            {
        //                ListItem itemTask = new ListItem();
        //                itemTask.Value = dataReader3["TASK_ID"].ToString();
        //                itemTask.Text = dataReader3["NAME"].ToString();
        //                DropDownListTaskDelete.Items.Add(itemTask);
        //            }
        //            dataReader3.Close();
        //            cnn.Close();
        //        }
        //    }
        //}



    }
}



//var sortedData = data.OrderBy(x => x.NAME);
//var sortedData = data.OrderByDescending(x => x.NAME);