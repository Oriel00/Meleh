using System;
using System.Data;

public partial class Resizing : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["EventResizing"] == null)
        {
            Session["EventResizing"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["EventResizing"];
        DayPilotCalendar1.DataSource = Session["EventResizing"];
        #endregion

        if (!IsPostBack)
        {
            DataBind();
        }
    }

    protected void DayPilotCalendar1_EventResize(object sender, DayPilot.Web.Ui.Events.EventResizeEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            table.AcceptChanges();

        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();

    }
}
