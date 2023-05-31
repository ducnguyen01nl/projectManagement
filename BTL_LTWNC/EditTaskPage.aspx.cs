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
    public partial class EditTaskPage : System.Web.UI.Page
    {
            string connectionString = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
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

                        ListItem item1 = new ListItem();
                        item1.Value = dataReader["EMPLOYEE_ID"].ToString();
                        item1.Text = dataReader["NAMEEPLOYEE"].ToString();
                        DropDownListNameEmployee.Items.Add(item1);
                    }
                    dataReader.Close();
                    cnn.Close();
                }

            }
        }

        protected void DropDownListTask_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection cnn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetTaskByIdTask", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@IdTask", DropDownListTask.SelectedValue);
                cnn.Open();
                SqlDataReader dataReader = cmd.ExecuteReader();
                while (dataReader.Read())
                {
                    TextNameWork.Text = dataReader["NAME"].ToString();
                    TextDes.Text = dataReader["DES"].ToString();
                    HiddenFieldTimeStart.Value = dataReader["START_AT"].ToString();
                    HiddenFieldTimeEnd.Value = dataReader["END_AT"].ToString();
                    DropDownListNameEmployee.SelectedValue = dataReader["EMPLOYEE_ID"].ToString();
                }
                dataReader.Close();
                cnn.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "changeTimeStartDefault", "changeTimeStartDefault();", true);

            }
        }

        protected void ButtonOk_Click(object sender, EventArgs e)
        {
            using(SqlConnection cnn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("EditTask", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@idTask",DropDownListTask.SelectedValue);
                cmd.Parameters.AddWithValue("@nameTask", TextNameWork.Text);
                cmd.Parameters.AddWithValue("@desTask",TextDes.Text);
                cmd.Parameters.AddWithValue("@startTime",HiddenFieldTimeStart.Value);
                cmd.Parameters.AddWithValue("@endTime",HiddenFieldTimeEnd.Value);
                cmd.Parameters.AddWithValue("@employeeId",DropDownListNameEmployee.SelectedValue);
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