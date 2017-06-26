using System;
using System.Data;
using System.Web.UI;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;

public partial class ResourcesView : Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["ResourcesView"] == null)
        {
            Session["ResourcesView"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["ResourcesView"];
        DayPilotCalendar1.DataSource = Session["ResourcesView"];
        #endregion

        if (!IsPostBack)
        {
            DataBind();
        }
    }
    protected void DayPilotCalendar1_TimeRangeSelected(object sender, TimeRangeSelectedEventArgs e)
    {
        DayPilotCalendar1.Update();
    }

    protected void DayPilotCalendar1_EventResize(object sender, EventResizeEventArgs e)
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

    protected void DayPilotCalendar1_BeforeCellRender(object sender, BeforeCellRenderEventArgs e)
    {
    }

    protected void DayPilotCalendar1_EventMove(object sender, EventMoveEventArgs e)
    {

        #region Simulation of database update

        //throw new Exception("old resource: " + e.OldResource);

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["column"] = e.NewResource;
            table.AcceptChanges();

        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.UpdateWithMessage("Moved from " + e.OldResource + " to " + e.NewResource);

    }
}
