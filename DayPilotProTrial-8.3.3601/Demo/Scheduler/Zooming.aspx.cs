using System;
using System.Data;
using DayPilot.Utils;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events.Bubble;

public partial class Scheduler_Zooming : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        initData();
        if (!IsPostBack)
        {
            DateTime firstDay = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            DayPilotScheduler1.StartDate = new DateTime(DateTime.Today.Year, 1, 1);
            DayPilotScheduler1.Days = Year.Days(firstDay.Year);

            adjustCellLayout();

            DayPilotScheduler1.SetScrollX(firstDay);
            setDataSourceAndBind();
        }
    }

    private void setDataSourceAndBind()
    {
        // ensure that filter is loaded
        string filter = (string)DayPilotScheduler1.ClientState["filter"];
        DayPilotScheduler1.DataSource = getData(DayPilotScheduler1.StartDate, DayPilotScheduler1.EndDate, filter);
        DayPilotScheduler1.DataBind();

    }

    protected void DayPilotScheduler1_BeforeTimeHeaderRender(object sender, DayPilot.Web.Ui.Events.BeforeTimeHeaderRenderEventArgs e)
    {
        if (e.Level == 0)
        {
            int days = (int) Math.Floor((e.End - e.Start).TotalDays);

            DateTime outStart = DateTime.MinValue;
            int outDays;

            switch (DayPilotScheduler1.CellGroupBy)
            {
                case GroupByEnum.Hour: // day, switch to week
                    outStart = Week.FirstDayOfWeek(e.Start, DayOfWeek.Monday);
                    outDays = 7;
                    break;
                case GroupByEnum.Day: // week, switch to month
                    outStart = new DateTime(e.Start.Year, e.Start.Month, 1);
                    outDays = DateTime.DaysInMonth(e.Start.Year, e.Start.Month);
                    break;
                case GroupByEnum.Week: // month, switch to year
                    outStart = new DateTime(e.Start.Year, 1, 1);
                    outDays = DateTime.IsLeapYear(e.Start.Year) ? 366 : 365;
                    break;
                case GroupByEnum.Month: // year, dont switch
                    outDays = 0;
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            if (days >= 1) // do not zoom into greater detail than one day
            {
                e.InnerHTML = String.Format("<a href='javascript:dps1.commandCallBack(\"goto\", {{ start:\"{0}\", days:{1} }})' style='color:black' title='Zoom in'>{2}</a>", e.Start.ToString("s"), days, e.InnerHTML);
            }

            if (outDays > 0) // do not zoom out if we see the whole year
            {
                e.InnerHTML += String.Format(" (<a href='javascript:dps1.commandCallBack(\"goto\", {{ start: \"{0}\", days: {1} }})' style='color:black' title='Zoom out'>up</a>)", outStart.ToString("s"), outDays);
            }
        }
    }

    private void adjustCellLayout()
    {
        int days = DayPilotScheduler1.Days;

        if (days > 31) // year
        {
            DayPilotScheduler1.CellGroupBy = GroupByEnum.Month;
            DayPilotScheduler1.CellDuration = 1440;
            DayPilotScheduler1.CellWidth = 20;
        }
        else if (days >= 28) // month
        {
            DayPilotScheduler1.CellGroupBy = GroupByEnum.Week;
            DayPilotScheduler1.CellDuration = 1440;
            DayPilotScheduler1.CellWidth = 60;
        }
        else if (days > 1) // week
        {
            DayPilotScheduler1.CellGroupBy = GroupByEnum.Day;
            DayPilotScheduler1.CellDuration = 60;
            DayPilotScheduler1.CellWidth = 60;
        }
        else // day
        {
            DayPilotScheduler1.CellGroupBy = GroupByEnum.Hour;
            DayPilotScheduler1.CellDuration = 15;
            DayPilotScheduler1.CellWidth = 60;
        }
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
        else // moved from outside
        {
            dr = table.NewRow();
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["id"] = e.Id;
            dr["name"] = e.Text;
            dr["column"] = e.NewResource;

            table.Rows.Add(dr);
            table.AcceptChanges();
        }

        #endregion

        setDataSourceAndBind();
        DayPilotScheduler1.Update("Event moved.");
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

        setDataSourceAndBind();
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
        dr["column"] = e.Resource;

        table.Rows.Add(dr);
        table.AcceptChanges();
        #endregion

        setDataSourceAndBind();
        DayPilotScheduler1.Update(String.Format("New event created."));
    }
    protected void DayPilotScheduler1_EventEdit(object sender, DayPilot.Web.Ui.Events.EventEditEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["name"] = e.NewText;
            table.AcceptChanges();
        }

        #endregion

        setDataSourceAndBind();
        DayPilotScheduler1.Update();
    }

    protected void DayPilotScheduler1_BeforeEventRender(object sender, DayPilot.Web.Ui.Events.Scheduler.BeforeEventRenderEventArgs e)
    {
        if (e.Id == "11")
        {
            e.ContextMenuClientName = "cmSpecial";
            e.EventMoveEnabled = false;
            e.EventResizeEnabled = false;
            e.EventClickEnabled = false;
            e.DurationBarColor = "red";
            e.BackgroundColor = "lightyellow";
        }
    }

    protected void DayPilotScheduler1_EventMenuClick(object sender, DayPilot.Web.Ui.Events.EventMenuClickEventArgs e)
    {
        switch (e.Command)
        {
            case "Delete":
                #region Simulation of database update
                DataRow dr = table.Rows.Find(e.Id);

                if (dr != null)
                {
                    table.Rows.Remove(dr);
                    table.AcceptChanges();
                }
                #endregion
                break;
        }

        setDataSourceAndBind();
        DayPilotScheduler1.Update();
    }

    protected void DayPilotScheduler1_BeforeResHeaderRender(object sender, DayPilot.Web.Ui.Events.Scheduler.BeforeResHeaderRenderEventArgs e)
    {
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;
            re.InnerHTML = "<b>Event details</b><br />Here is the right place to show details about the event with ID: " + re.Value + ". This text is loaded dynamically from the server.<br/><a href='http://www.google.com'>Google</a>";
        }
        else if (e is RenderResourceBubbleEventArgs)
        {
            RenderResourceBubbleEventArgs re = e as RenderResourceBubbleEventArgs;
            e.InnerHTML = "<b>Resource header details</b><br />Value: " + re.ResourceId;
        }
        else if (e is RenderCellBubbleEventArgs)
        {
            RenderCellBubbleEventArgs re = e as RenderCellBubbleEventArgs;
            e.InnerHTML = "<b>Cell details</b><br />Resource:" + re.ResourceId + "<br />From:" + re.Start + "<br />To: " + re.End;
        }
    }

    protected void DayPilotScheduler1_Command(object sender, DayPilot.Web.Ui.Events.CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "next":
                DayPilotScheduler1.StartDate = DayPilotScheduler1.StartDate.AddYears(1);
                DayPilotScheduler1.Days = Year.Days(DayPilotScheduler1.StartDate.Year);
                DayPilotScheduler1.ScrollX = 0;
                adjustCellLayout();
                break;
            case "previous":
                DayPilotScheduler1.StartDate = DayPilotScheduler1.StartDate.AddYears(-1);
                DayPilotScheduler1.Days = Year.Days(DayPilotScheduler1.StartDate.Year);
                DayPilotScheduler1.ScrollX = 0;
                adjustCellLayout();
                break;
            case "this":
                DayPilotScheduler1.StartDate = new DateTime(DateTime.Today.Year, 1, 1);
                DayPilotScheduler1.Days = Year.Days(DayPilotScheduler1.StartDate.Year);
                DayPilotScheduler1.ScrollX = 0;
                adjustCellLayout();
                break;
            case "year":
                int year = (int) e.Data;
                DayPilotScheduler1.StartDate = new DateTime(year, 1, 1);
                DayPilotScheduler1.Days = Year.Days(DayPilotScheduler1.StartDate.Year);
                DayPilotScheduler1.ScrollX = 0;
                adjustCellLayout();
                break;
            case "goto":
                DayPilotScheduler1.StartDate = (DateTime) e.Data["start"];
                DayPilotScheduler1.Days = (int) e.Data["days"];
                DayPilotScheduler1.ScrollX = 0;
                if (IsTodayInRange())
                {
                    DayPilotScheduler1.SetScrollX(DateTime.Today);
                }
                else
                {
                    DayPilotScheduler1.ScrollX = 0;
                }
                adjustCellLayout();
                break;
            case "refresh":
                // just rebind
                break;
            case "filter":
                //string filter = (string)e.Data;
                //DayPilotScheduler1.DataSource = getData(DayPilotScheduler1.StartDate, DayPilotScheduler1.EndDate.AddDays(1), filter);
                setDataSourceAndBind();
                DayPilotScheduler1.DataBind();
                DayPilotScheduler1.Update(CallBackUpdateType.EventsOnly);
                return; // note that the binding done inside the case section here
            default:
                throw new Exception("Unknown command.");

        }

        setDataSourceAndBind();
        DayPilotScheduler1.Update();
    }

    private bool IsTodayInRange()
    {
        if (DateTime.Today >= DayPilotScheduler1.StartDate && DateTime.Today < DayPilotScheduler1.EndDate)
        {
            return true;
        }
        return false;
    }

    protected void DayPilotScheduler1_EventClick(object sender, DayPilot.Web.Ui.Events.EventClickEventArgs e)
    {
        setDataSourceAndBind();
        DayPilotScheduler1.Update(String.Format("Event {0} clicked.", e.Id));

    }
    protected void DayPilotScheduler1_TimeRangeMenuClick(object sender, DayPilot.Web.Ui.Events.TimeRangeMenuClickEventArgs e)
    {
        if (e.Command == "Insert")
        {
            #region Simulation of database update

            DataRow dr = table.NewRow();
            dr["start"] = e.Start;
            dr["end"] = e.End;
            dr["id"] = Guid.NewGuid().ToString();
            dr["name"] = "New event";
            dr["column"] = e.ResourceId;

            table.Rows.Add(dr);
            table.AcceptChanges();
            #endregion

            setDataSourceAndBind();
            DayPilotScheduler1.Update();
        }
    }


    /// <summary>
    /// Make sure a copy of the data is in the Session so users can try changes on their own copy.
    /// </summary>
    private void initData()
    {
        if (Session["Scheduler"] == null)
        {
            Session["Scheduler"] = DataGeneratorScheduler.GetData();
        }
        table = (DataTable)Session["Scheduler"];
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
        }
        //throw new Exception(select);

        DataRow[] rows = table.Select(select);
        DataTable filtered = table.Clone();
        foreach (DataRow r in rows)
        {
            filtered.ImportRow(r);
        }
        return filtered;
    }

}
