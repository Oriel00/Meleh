using System;
using System.Data;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Scheduler;


public partial class Timesheet : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["DaysModeMonth"] == null)
        {
            Session["DaysModeMonth"] = DataGeneratorScheduler.GetDataDays();
        }
        table = (DataTable)Session["DaysModeMonth"];
        DayPilotScheduler1.DataSource = Session["DaysModeMonth"];
        #endregion
        
        if (!IsPostBack)
        {
            DateTime start = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            DateTime end = start.AddMonths(1);
            int days = (int)Math.Floor((end - start).TotalDays);

            DayPilotScheduler1.StartDate = start;
            DayPilotScheduler1.Days = days;

            DayPilotScheduler1.SetScrollX(DayPilotScheduler1.StartDate.Date.AddHours(8));

            DataBind();
        }

    }
    protected void DayPilotScheduler1_EventResize(object sender, DayPilot.Web.Ui.Events.EventResizeEventArgs e)
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

        DayPilotScheduler1.DataBind();
        DayPilotScheduler1.Update();
    }
    protected void DayPilotScheduler1_EventMove(object sender, DayPilot.Web.Ui.Events.EventMoveEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["column"] = e.NewResource;
            table.AcceptChanges();
        }

        #endregion

        DayPilotScheduler1.DataBind();
        DayPilotScheduler1.Update();

    }
    protected void DayPilotScheduler1_TimeRangeSelected(object sender, DayPilot.Web.Ui.Events.TimeRangeSelectedEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.NewRow();
        dr["start"] = e.Start;
        dr["end"] = e.End;
        dr["id"] = Guid.NewGuid().ToString();
        dr["name"] = "New event";

        table.Rows.Add(dr);
        table.AcceptChanges();
        #endregion

        DayPilotScheduler1.DataBind();
        DayPilotScheduler1.Update();
    }
    
    protected void DayPilotScheduler1_BeforeTimeHeaderRender(object sender, DayPilot.Web.Ui.Events.BeforeTimeHeaderRenderEventArgs e)
    {
    }

    protected void DayPilotScheduler1_BeforeCellRender(object sender, BeforeCellRenderEventArgs e)
    {
        if (!e.IsBusiness)
        {
            e.BackgroundColor = "#e3e3e3";
        }
    }

    protected void DayPilotScheduler1_BeforeResHeaderRender(object sender, BeforeResHeaderRenderEventArgs e)
    {
        e.Html = String.Format("<div style='text-align:right; margin-right:5px;'>{0}</div>", e.Html);
    }
}
