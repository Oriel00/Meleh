using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using DayPilot.Utils;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;
using DayPilot.Web.Ui.Events.Calendar;
using DayPilot.Web.Ui.Recurrence;

public partial class Calendar_RecurrentEvents : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["Recurrence"] == null)
        {
            Session["Recurrence"] = GetData();
        }
        table = (DataTable)Session["Recurrence"];
        DayPilotCalendar1.DataSource = Session["Recurrence"];
        DayPilotNavigator1.DataSource = Session["Recurrence"];
        #endregion

        if (!IsPostBack)
        {
            DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek();
            DataBind();
        }
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
        //RecurrenceRule rule2 = RecurrenceRule.FromDateTime("2", start2).Daily().Until(start2.AddDays(31));
        RecurrenceRule rule2 = RecurrenceRule.FromDateTime("2", start2).Daily(2).Times(2);

        dr = dt.NewRow();
        dr["id"] = 2;
        dr["start"] = start2;
        dr["end"] = start2.AddHours(1);
        dr["name"] = "Every day";
        dr["recurrence"] = rule2.Encode();
        dt.Rows.Add(dr);

        DateTime start3 = Week.FirstDayOfWeek().AddDays(1).AddHours(13);
        dr = dt.NewRow();
        dr["id"] = 3;
        dr["start"] = start3;
        dr["end"] = start3.AddHours(1);
        dr["name"] = "By hour (custom)";
        dt.Rows.Add(dr);

        dt.PrimaryKey = new DataColumn[] { dt.Columns["id"] };

        return dt;
    }

    protected void DayPilotCalendar1_EventMove(object sender, EventMoveEventArgs e)
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
        }
        // recurrent exception or regular event
        else if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            table.AcceptChanges();
        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.UpdateWithMessage("Event moved.");
    }

    protected void DayPilotCalendar1_EventMenuClick(object sender, EventMenuClickEventArgs e)
    {
        if (e.Command == "Delete")
        {
            #region Simulation of database update

            DataRow dr = table.Rows.Find(e.Id);

            if (e.Recurrent && !e.RecurrentException)
            {
                dr = table.NewRow();
                dr["id"] = Guid.NewGuid().ToString();
                dr["start"] = e.Start;
                dr["end"] = e.End;
                dr["recurrence"] = RecurrenceRule.EncodeExceptionDeleted(e.RecurrentMasterId, e.Start);
                table.Rows.Add(dr);
                table.AcceptChanges();
            }
            else if (e.Recurrent && e.RecurrentException && dr != null)
            {
                table.Rows.Remove(dr);
                table.AcceptChanges();
            }
            else if (dr != null)
            {
                table.Rows.Remove(dr);
                table.AcceptChanges();
            }

            #endregion

            DayPilotCalendar1.DataBind();
            DayPilotCalendar1.Update();
        }
    }
    protected void DayPilotCalendar1_TimeRangeSelected(object sender, TimeRangeSelectedEventArgs e)
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

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update("New event created.");
    }

    protected void DayPilotCalendar1_EventResize(object sender, EventResizeEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);

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

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update("Event resized");
    }

    protected void DayPilotCalendar1_EventClick(object sender, EventClickEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["name"] = "Event clicked at " + DateTime.Now;
            table.AcceptChanges();
        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();
    }
    protected void DayPilotCalendar1_EventEdit(object sender, EventEditEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["name"] = e.NewText;
            table.AcceptChanges();
        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update("Event text changed.");
    }
    protected void DayPilotCalendar1_BeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
    }


    protected void DayPilotCalendar1_EventDelete(object sender, EventDeleteEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);

        if (e.Recurrent)
        {
            if (e.RecurrentException)  // replace this exception with a deleted exception
            {
                if (dr != null)
                {
                    // save the original start
                    DateTime start = RecurrenceRule.DecodeStart((string)dr["recurrence"]);

                    // delete the "modified" exception
                    table.Rows.Remove(dr);
                    table.AcceptChanges();

                    // add "deleted" exception
                    dr = table.NewRow();
                    dr["id"] = Guid.NewGuid().ToString();
                    dr["start"] = start;
                    dr["end"] = start;
                    dr["recurrence"] = RecurrenceRule.EncodeExceptionDeleted(e.RecurrentMasterId, start);
                    table.Rows.Add(dr);
                    table.AcceptChanges();
                }
                
            }
            else 
            {
                // not an exception, look for the request
                string which = (string) e.Data["which"];
                switch (which)
                {
                    case "this":
                        // add "deleted" exception
                        dr = table.NewRow();
                        dr["id"] = Guid.NewGuid().ToString();
                        dr["start"] = e.Start;
                        dr["end"] = e.End;
                        dr["recurrence"] = RecurrenceRule.EncodeExceptionDeleted(e.RecurrentMasterId, e.Start);
                        table.Rows.Add(dr);
                        table.AcceptChanges();
                        
                        break;
                    case "series":
                        // delete the master
                        DataRow master = table.Rows.Find(e.RecurrentMasterId);
                        table.Rows.Remove(master);

                        // delete all exceptions
                        string prefix = RecurrenceRule.Prefix(e.RecurrentMasterId);
                        DataRow[] rows = table.Select(String.Format("recurrence like '{0}%'", prefix));
                        foreach(DataRow r in rows)
                        {
                            table.Rows.Remove(r);
                        }
                        table.AcceptChanges();
                        break;
                }

            }
        }
        else
        {
            if (dr != null)
            {
                table.Rows.Remove(dr);
                table.AcceptChanges();
            }
        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update("Event deleted.");
    }

    protected void DayPilotCalendar1_EventSelect(object sender, DayPilotEventArgs e)
    {
        DayPilotCalendar1.Update();
    }


    protected void DayPilotCalendar1_BeforeHeaderRender(object sender, BeforeHeaderRenderEventArgs e)
    {
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;

            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("<b>{0}</b><br />", re.Text);
            sb.AppendFormat("Start: {0}<br />", re.Start);
            sb.AppendFormat("End: {0}<br />", re.End);

            //re.InnerHTML = "<b>Event details</b><br />Here is the right place to show details about the event with ID: " + re.Value + ". This text is loaded dynamically from the server.<br/>";
            re.InnerHTML = sb.ToString();
        }
        else if (e is RenderTimeBubbleEventArgs)
        {
            RenderTimeBubbleEventArgs re = e as RenderTimeBubbleEventArgs;
            e.InnerHTML = "<b>Time header details</b><br />From:" + re.Start + "<br />To: " + re.End;
        }
        else if (e is RenderCellBubbleEventArgs)
        {
            RenderCellBubbleEventArgs re = e as RenderCellBubbleEventArgs;
            e.InnerHTML = "<b>Cell details</b><br />Column:" + re.ResourceId + "<br />From:" + re.Start + "<br />To: " + re.End;
        }
    }

    protected void DayPilotCalendar1_TimeRangeDoubleClick(object sender, TimeRangeDoubleClickEventArgs e)
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

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update("New event created.");
    }

    protected void DayPilotCalendar1_TimeRangeMenuClick(object sender, TimeRangeMenuClickEventArgs e)
    {
        if (e.Command == "Insert")
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

            DayPilotCalendar1.DataBind();
            DayPilotCalendar1.Update();
        }

    }
    protected void DayPilotCalendar1_Command(object sender, CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "previous":
                DayPilotCalendar1.StartDate = DayPilotCalendar1.StartDate.AddDays(-7);
                DayPilotCalendar1.DataBind();
                DayPilotCalendar1.Update(CallBackUpdateType.Full);
                break;
            case "navigate":
                DateTime start = (DateTime) e.Data["start"];
                DateTime end = (DateTime) e.Data["end"];

                DayPilotCalendar1.StartDate = start;
                //DayPilotCalendar1.Days = (int) (end - start).TotalDays;

                DayPilotCalendar1.DataBind();
                DayPilotCalendar1.Update(CallBackUpdateType.Full);
                break;
            case "refresh":
                DayPilotCalendar1.DataBind();
                DayPilotCalendar1.Update();
                break;
        }


    }
    protected void DayPilotNavigator1_VisibleRangeChanged(object sender, EventArgs e)
    {
        DayPilotNavigator1.DataBind();
    }

    protected void DayPilotCalendar1_BeforeCellRender(object sender, BeforeCellRenderEventArgs e)
    {
        //e.BackgroundColor = "#a2a2a2";
    }

    protected void DayPilotCalendar1_HeaderClick(object sender, HeaderClickEventArgs e)
    {
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.DataSource = RecurrenceExpander.Expand(table, "recurrence", "start", "end", "id", "master", DayPilotCalendar1.StartDate, DayPilotCalendar1.EndDate);
        GridView2.DataSource = table;
        DataBind();

    }

    protected void DayPilotCalendar1_OnBeforeEventRecurrence(BeforeEventRecurrenceEventArgs ea)
    {
        List<DateTime> list = new List<DateTime>();
        for (int i = 1; i < 5; i++)
        {
            list.Add(ea.Start.AddHours(i));
        }
        ea.Rule = RecurrenceRule.FromList(list);
    }
}
