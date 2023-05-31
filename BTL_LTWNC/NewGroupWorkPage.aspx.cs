using BTL_LTWNC.Model;
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


    public partial class NewGroupWorkPage : System.Web.UI.Page
    {
        string connnectionString = ConfigurationManager.ConnectionStrings["connectDatabase"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            using(SqlConnection cnn = new SqlConnection(connnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetEmployeeLeader", cnn);
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

        protected void ButtonOk_Click(object sender, EventArgs e)
        {
            int projectId = int.Parse(Request.QueryString["q"]);
            using (SqlConnection cnn = new SqlConnection(connnectionString))
            {
                SqlCommand cmd = new SqlCommand("AddNewGroupWork", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@nameGroupWork", TextNameGroupWork.Text);
                cmd.Parameters.AddWithValue("@projectId", projectId);
                cmd.Parameters.AddWithValue("@employeeIdLead", DropDownListNameEmployee.SelectedValue);
                cnn.Open();
                cmd.ExecuteNonQuery();
                cnn.Close();
            }

            Response.Redirect("DetailProjectPage.aspx?q=" + projectId);
        }

        protected void ButtonCancel_Click(object sender, EventArgs e)
        {
            int projectId = int.Parse(Request.QueryString["q"]);
            Response.Redirect("DetailProjectPage.aspx?q=" + projectId);
        }
    }
}