using System;
using System.Data;
using DayPilot.Web.Ui.Events.Calendar;


public partial class EventDeleting : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["EventDeleting"] == null)
        {
            Session["EventDeleting"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["EventDeleting"];
        DayPilotCalendar1.DataSource = Session["EventDeleting"];
        #endregion


        if (!IsPostBack)
        {
            DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(DateTime.Today);
            DataBind();
        }

    }
    protected void DayPilotCalendar1_EventDelete(object sender, DayPilot.Web.Ui.Events.Calendar.EventDeleteEventArgs e)
    {
        deleteAndBind(e.Id);
    }

    private void deleteAndBind(string id)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(id);
        if (dr != null)
        {
            table.Rows.Remove(dr);
            table.AcceptChanges();
        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();

    }

    protected void DayPilotCalendar1_OnBeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
    }
}
