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
    public partial class NewTaskPage : System.Web.UI.Page
    {

            string connnectionString = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            using(SqlConnection cnn = new SqlConnection(connnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetEmployeeStaff", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cnn.Open();
                SqlDataReader dataReader = cmd.ExecuteReader();
                while (dataReader.Read())
                {
                    ListItem item = new ListItem();
                    item.Value = dataReader["EMPLOYEE_ID"].ToString();
                    item.Text = dataReader["NAME"].ToString();
                    DropDownListNameEmployee.Items.Add(item);
                }
                dataReader.Close();
                cnn.Close();
            }

            
        }

        protected void ButtonCancel_Click(object sender, EventArgs e)
        {
            int projectId = int.Parse(Request.QueryString["idProject"]);
            Response.Redirect("DetailProjectPage.aspx?q=" + projectId);
        }

        protected void ButtonOk_Click(object sender, EventArgs e)
        {
            int projectId = int.Parse(Request.QueryString["idProject"]);
            int groupId = int.Parse(Request.QueryString["idGroup"]);

            using (SqlConnection cnn = new SqlConnection(connnectionString))
            {
                
                SqlCommand cmd = new SqlCommand("AddNewTask", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@groupWorkId", groupId);
                cmd.Parameters.AddWithValue("@nameTask", TextNameWork.Text);
                cmd.Parameters.AddWithValue("@DesTask", TextDes.Text);
                cmd.Parameters.AddWithValue("@startTime", HiddenFieldTimeStart.Value);
                cmd.Parameters.AddWithValue("@endTime", HiddenFieldTimeEnd.Value);
                cmd.Parameters.AddWithValue("@employeeId", DropDownListNameEmployee.SelectedValue);
                cnn.Open();
                cmd.ExecuteNonQuery();
                cnn.Close();

            }
            Response.Redirect("DetailProjectPage.aspx?q=" + projectId);
        }
    }
}