using System;
using System.Data;
using System.Web.UI;

public partial class Calendar_New : Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TextBoxStart.Text = Convert.ToDateTime(Request.QueryString["start"]).ToString();
            TextBoxEnd.Text = Convert.ToDateTime(Request.QueryString["end"]).ToString();

            //TextBoxName.Focus();
        }
    }
    protected void ButtonOK_Click(object sender, EventArgs e)
    {
        DateTime start = Convert.ToDateTime(TextBoxStart.Text);
        DateTime end = Convert.ToDateTime(TextBoxEnd.Text);
        string name = TextBoxName.Text;

        dbInsertEvent(start, end, name, null);
        Modal.Close(this, "OK");
    }

    private string dbInsertEvent(DateTime start, DateTime end, string name, string resource)
    {
        initData();

        string id = Guid.NewGuid().ToString();

        #region Simulation of database update

        DataRow dr = table.NewRow();
        dr["start"] = start;
        dr["end"] = end;
        dr["id"] = id;
        dr["name"] = name;
        dr["column"] = resource;

        table.Rows.Add(dr);
        table.AcceptChanges();
        #endregion

        return id;
    }

    protected void ButtonCancel_Click(object sender, EventArgs e)
    {
        Modal.Close(this);
    }

    private void initData()
    {
        if (Session["AllFeatures"] == null)
        {
            Session["AllFeatures"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["AllFeatures"];
    }

}
