using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Meleh_Start
{
    public partial class UserDetails : System.Web.UI.Page
    {
        SqlConnection con2 = new SqlConnection(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MLHDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            CertExistsError.Visible = false;
        }

        protected void InsButton_Click(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource3.InsertParameters["UserId"].DefaultValue = (AddUserName.SelectedValue);
                SqlDataSource3.InsertParameters["CertId"].DefaultValue = (AddCertName.SelectedValue);
                SqlDataSource3.InsertParameters["DateCert"].DefaultValue = AddDateCal.SelectedDate.ToString("yyyy-MM-dd");
                SqlDataSource3.Insert();

            }
            catch
            {
                CertExistsError.Visible = true;
            }
        }
        protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            GridView1.DataBind();
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}