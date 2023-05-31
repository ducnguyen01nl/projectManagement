using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_LTWNC
{
    public partial class DeleteTaskPage : System.Web.UI.Page
    {
            string connectionString = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int groupId = Convert.ToInt32(Request.QueryString["idGroup"]);
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetTaskWorkByID", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@GroupId", groupId);
                cnn.Open();
                SqlDataReader dataReader = cmd.ExecuteReader();
                while (dataReader.Read())
                {
                    ListItem item = new ListItem();
                    item.Value = dataReader["TASK_ID"].ToString();
                    item.Text = dataReader["NAME"].ToString();
                    DropDownListTask.Items.Add(item);

                }
                dataReader.Close();
                cnn.Close();
            }
        }

        protected void ButtonOk_Click(object sender, EventArgs e)
        {
            using( SqlConnection cnn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteTask",cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TaskId", DropDownListTask.SelectedValue);
                cnn.Open();
                cmd.ExecuteNonQuery();
                cnn.Close();
            }
            int projectId = int.Parse(Request.QueryString["idProject"]);
            Response.Redirect("DetailProjectPage.aspx?q=" + projectId);
        }

        protected void ButtonCancel_Click(object sender, EventArgs e)
        {
            int projectId = int.Parse(Request.QueryString["idProject"]);
            Response.Redirect("DetailProjectPage.aspx?q=" + projectId);
        }
    }
}