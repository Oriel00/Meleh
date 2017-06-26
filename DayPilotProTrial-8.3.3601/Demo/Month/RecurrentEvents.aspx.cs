using System;
using System.Data;
using System.Drawing.Imaging;
using System.IO;
using DayPilot.Utils;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;
using DayPilot.Web.Ui.Recurrence;

public partial class Month_RecurrentEvents : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        initData();
        if (!IsPostBack)
        {
            DayPilotMonth1.UpdateWithMessage("Start: " + DayPilotMonth1.VisibleStart + " end: " + DayPilotMonth1.VisibleEnd);
            DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
            DataBind();
        }
    }

    protected void DayPilotCalendar1_EventMenuClick(object sender, EventMenuClickEventArgs e)
    {

        if (e.Command == "Delete")
        {
            #region Simulation of database update
            DataRow dr = table.Rows.Find(e.Id);

            if (dr != null)
            {
                table.Rows.Remove(dr);
                table.AcceptChanges();
            }
            #endregion

            DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
            DayPilotMonth1.DataBind();
            DayPilotMonth1.Update();
        }
    }
    protected void DayPilotMonth1_EventMove(object sender, EventMoveEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);

        // recurrent event but no exception
        if (e.Recurrent && !e.RecurrentException)
        {
            DataRow master = table.Rows.Find(e.RecurrentMasterId);

            dr = table.NewRow();
            dr["id"] = Guid.NewGuid().ToString();
            dr["name"] = master["name"];
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["recurrence"] = RecurrenceRule.EncodeExceptionModified(e.RecurrentMasterId, e.OldStart);
            table.Rows.Add(dr);
            table.AcceptChanges();

            DayPilotMonth1.UpdateWithMessage("Recurrent event exception added.");
        }
        // recurrent exception or regular event
        else if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            table.AcceptChanges();

            DayPilotMonth1.UpdateWithMessage("Event moved.");
        }
        else
        {
            DayPilotMonth1.UpdateWithMessage("No update.");
        }

        #endregion

        DayPilotMonth1.UpdateWithMessage("Update. Start: " + DayPilotMonth1.VisibleStart + " end: " + DayPilotMonth1.VisibleEnd);
        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();
        

    }
    protected void DayPilotMonth1_EventResize(object sender, EventResizeEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        /*
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            table.AcceptChanges();
        }
        */

        if (e.Recurrent && !e.RecurrentException)
        {
            DataRow master = table.Rows.Find(e.RecurrentMasterId);

            dr = table.NewRow();
            dr["id"] = Guid.NewGuid().ToString();
            dr["recurrence"] = RecurrenceRule.EncodeExceptionModified(e.RecurrentMasterId, e.OldStart);
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["name"] = master["name"];
            table.Rows.Add(dr);
            table.AcceptChanges();
        }
        else if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            table.AcceptChanges();
        }
        #endregion

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.UpdateWithMessage("Event resized");

    }

    protected void DayPilotMonth1_TimeRangeSelected(object sender, TimeRangeSelectedEventArgs e)
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

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update();
    }
    protected void DayPilotMonth1_BeforeEventRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeEventRenderEventArgs e)
    {
        if (e.Id == "12")
        {
            e.ContextMenuClientName = "menu2";
        }
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;
            re.InnerHTML = "<b>Event details</b><br />Here is the right place to show details about the event with ID: " + re.Value + ". This text is loaded dynamically from the server.";
        }
    }

    protected void DayPilotMonth1_Command(object sender, CommandEventArgs e)
    {

        switch (e.Command)
        {
            case "navigate":
                DayPilotMonth1.StartDate = (DateTime)e.Data["start"];
                DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
                DayPilotMonth1.DataBind();
                DayPilotMonth1.Update();
                break;
            case "filter":
                DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
                DayPilotMonth1.DataBind();
                DayPilotMonth1.Update();
                break;
            case "refresh":
                DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
                DayPilotMonth1.DataBind();
                DayPilotMonth1.Update();
                break;

        }

    }

    /// <summary>
    /// This method should normally load the data from the database.
    /// We will load our copy from a Session, just simulating a database.
    /// </summary>
    /// <param name="start"></param>
    /// <param name="end"></param>
    /// <param name="filter"></param>
    /// <returns></returns>
    private DataTable getData(DateTime start, DateTime end, string filter)
    {
        String select;
        if (String.IsNullOrEmpty(filter))
        {
            select = String.Format("NOT (([end] <= '{0:s}') OR ([start] >= '{1:s}'))", start, end, filter);
        }
        else
        {
            select = String.Format("NOT (([end] <= '{0:s}') OR ([start] >= '{1:s}')) and [name] like '%{2}%'", start, end, filter);
//            throw new Exception(select);
        }


        DataRow[] rows = table.Select(select);

        DataTable filtered = table.Clone();
        
        foreach (DataRow r in rows)
        {
            filtered.ImportRow(r);
        }

        return filtered;
    }

    /// <summary>
    /// Make sure a copy of the data is in the Session so users can try changes on their own copy.
    /// </summary>
    private void initData()
    {
        if (Session["MonthRecurrence"] == null)
        {
            Session["MonthRecurrence"] = GetData();
        }

        table = (DataTable)Session["MonthRecurrence"];
    }

    protected void DayPilotMonth1_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeCellRenderEventArgs e)
    {
        e.CssClass = Week.WeekNrISO8601(e.Start)%2 == 0 ? "even" : "odd";
    }

    protected void DayPilotMonth1_EventClick(object sender, EventClickEventArgs e)
    {
    }

    private DataTable GetData()
    {

        DataTable dt;
        dt = new DataTable();
        dt.Columns.Add("start", typeof(DateTime));
        dt.Columns.Add("end", typeof(DateTime));
        dt.Columns.Add("name", typeof(string));
        dt.Columns.Add("id", typeof(string));
        dt.Columns.Add("recurrence", typeof(string));

        DataRow dr;

        DateTime start = Week.FirstDayOfWeek().AddHours(15);
        // starting on the first day of this week today at 15:00, repeated every week, five times
        RecurrenceRule rule = RecurrenceRule.FromDateTime("1", start).Weekly().Times(5);

        dr = dt.NewRow();
        dr["id"] = 1;
        dr["start"] = start;
        dr["end"] = start.AddHours(1);
        dr["name"] = "Every week";
        dr["recurrence"] = rule.Encode();
        dt.Rows.Add(dr);

        DateTime start2 = Week.FirstDayOfWeek().AddHours(10);
        // starting on the first day of this week at 10:00, repeated every day for one month
        RecurrenceRule rule2 = RecurrenceRule.FromDateTime("2", start2).Daily().Until(start2.AddDays(31));

        dr = dt.NewRow();
        dr["id"] = 2;
        dr["start"] = start2;
        dr["end"] = start2.AddHours(1);
        dr["name"] = "Every day";
        dr["recurrence"] = rule2.Encode();
        dt.Rows.Add(dr);

        dt.PrimaryKey = new DataColumn[] { dt.Columns["id"] };

        return dt;
    }

}
