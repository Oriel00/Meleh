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
    public partial class Certs : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MLHDB;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            AddDateCal.Visible = false;
        }

        protected void InsButton_Click(object sender, EventArgs e)
        {
            
            con.Open();
            SqlCommand cmd = con.CreateCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "CONVERT(VARCHAR(10),GETDATE(),131)";
            cmd.CommandText = "INSERT INTO Certification (CertName, ConditionID, DateCert) VALUES ('"+AddName.Text+"' , '"+AddCond.Text+"' , '"+AddDateCal.SelectedDate+"')";
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("Certs.aspx");
        }

        protected void openCal_SelectedIndexChanged(object sender, EventArgs e)
        {
            AddDateCal.Visible = true;
        }
    }
}