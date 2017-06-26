using System;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Text;
using ASP.App_Code.Data;
using DayPilot.Json;
using DayPilot.Utils;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;
using DayPilot.Web.Ui.Events.Scheduler;

public partial class Scheduler_EventMoveToPosition : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        initData();
        DayPilotScheduler1.StartDate = new DateTime(DateTime.Today.Year, 1, 1);
        DayPilotScheduler1.Days = Year.Days(DateTime.Today.Year);
        //DayPilotScheduler1.Separators.Add(DateTime.Today, ColorTranslator.FromHtml("#aaaaaa"), SeparatorLayer.BelowEvents, 60, 60);

        if (!IsPostBack)
        {
            DayPilotScheduler1.SetScrollX(DateTime.Today.AddDays(-1));
            //DayPilotScheduler1.ScrollY = 10;
            setDataSourceAndBind();
            DayPilotScheduler1.UpdateWithMessage("Welcome!");
        }
    }

    private void setDataSourceAndBind()
    {
        // ensure that filter is loaded
        string filter = (string)DayPilotScheduler1.ClientState["filter"];
        DayPilotScheduler1.DataSource = getData(DayPilotScheduler1.StartDate, DayPilotScheduler1.EndDate, filter);
        DayPilotScheduler1.DataBind();
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

        //DayPilotScheduler1.ScrollX = 2900;
        DayPilotScheduler1.UpdateWithMessage("Event moved to position: " + e.Position);
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
        DayPilotScheduler1.UpdateWithMessage("New event created.");
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

    protected void DayPilotScheduler1_BeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
        if (e.Id == "11")
        {
            e.CssClass = "scheduler_green_red";
        }
        //e.EventMoveVerticalEnabled = false;
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

    protected void DayPilotScheduler1_BeforeResHeaderRender(object sender, BeforeResHeaderRenderEventArgs e)
    {
            if (e.Id == "A")
            {
                e.ContextMenuClientName = "cmSpecial";
            }
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderResourceBubbleEventArgs)
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
                DayPilotScheduler1.ScrollY = 20;
                break;
            case "previous":
                DayPilotScheduler1.StartDate = DayPilotScheduler1.StartDate.AddYears(-1);
                DayPilotScheduler1.Days = Year.Days(DayPilotScheduler1.StartDate.Year);
                break;
            case "this":
                DayPilotScheduler1.StartDate = new DateTime(DateTime.Today.Year, 1, 1);
                DayPilotScheduler1.Days = Year.Days(DayPilotScheduler1.StartDate.Year);
                break;
            case "test":
                JsonData d = e.Data;
                break;
            case "refresh":
            case "filter":
                // refresh is always done, see setDataSourceAndBind()
                break;
            default:
                throw new Exception("Unknown command.");

        }

        setDataSourceAndBind();
        DayPilotScheduler1.Update();
    }

    protected void DayPilotScheduler1_EventClick(object sender, DayPilot.Web.Ui.Events.EventClickEventArgs e)
    {
        setDataSourceAndBind();
        DayPilotScheduler1.UpdateWithMessage(String.Format("Event {0} clicked.", e.Id));
        //throw new Exception("ScrollX: " + DayPilotScheduler1.ScrollX);
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

        if (Session[PageHash] == null)
        {
            Session[PageHash] = DataGeneratorScheduler.GetData();
        }
        table = (DataTable)Session[PageHash];
    }

    protected string PageHash
    {
        get
        {
            return Hash.ForPage(this);
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
            select = String.Format("NOT (([end] <= '{0:s}') OR ([start] >= '{1:s}'))", start, end);
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

    protected void DayPilotScheduler1_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.BeforeCellRenderEventArgs e)
    {
        if (e.Start.DayOfWeek == DayOfWeek.Saturday || e.Start.DayOfWeek == DayOfWeek.Sunday)
        {
            e.CssClass = "scheduler_green_cellweekend";
        }
    }

    protected void DayPilotScheduler1_Refresh(object sender, DayPilot.Web.Ui.Events.RefreshEventArgs e)
    {
        DayPilotScheduler1.StartDate = e.StartDate;
        setDataSourceAndBind();
        DayPilotScheduler1.Update(CallBackUpdateType.Full);
    }

    protected void DayPilotBubble1_RenderEventBubble(object sender, RenderEventBubbleEventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendFormat("<b>{0}</b><br />", e.Text);
        sb.AppendFormat("Start: {0}<br />", e.Start);
        sb.AppendFormat("End: {0}<br />", e.End);
        sb.AppendFormat("<br />");

        e.InnerHTML = sb.ToString();

    }
    protected void DayPilotScheduler1_ResourceHeaderMenuClick(object sender, DayPilot.Web.Ui.Events.Scheduler.ResourceHeaderMenuClickEventArgs e)
    {
        switch (e.Command)
        {
            case "Insert":
                e.Resource.Children.Add("Testing Child", Guid.NewGuid().ToString());
                e.Resource.Expanded = true;
                break;
            case "DeleteChildren":
                e.Resource.Children.Clear();
                break;
            case "Delete":
                DayPilotScheduler1.Resources.RemoveFromTree(e.Resource);
                break;
        }
        setDataSourceAndBind();
        DayPilotScheduler1.Update();
    }
    protected void DayPilotScheduler1_ResourceHeaderClick(object sender, DayPilot.Web.Ui.Events.Scheduler.ResourceHeaderClickEventArgs e)
    {
        DayPilotScheduler1.Resources.RemoveFromTree(e.Resource);
        setDataSourceAndBind();
        DayPilotScheduler1.Update();
    }
    protected void DayPilotScheduler1_BeforeTimeHeaderRender(object sender, DayPilot.Web.Ui.Events.BeforeTimeHeaderRenderEventArgs e)
    {

    }

    protected void DayPilotScheduler1_Notify(object sender, DayPilot.Web.Ui.Events.Scheduler.NotifyEventArgs e)
    {
        foreach(DayPilotEventArgs ea in e.Queue)
        {
            if (ea is EventMoveEventArgs)
            {
                EventMoveEventArgs em = (EventMoveEventArgs) ea;

                #region Simulation of database update

                DataRow dr = table.Rows.Find(em.Id);
                if (dr != null)
                {
                    dr["start"] = em.NewStart;
                    dr["end"] = em.NewEnd;
                    dr["column"] = em.NewResource;
                    table.AcceptChanges();
                }
                else
                {
                    throw new Exception("Event id not found.");
                }
                #endregion
            }
            else if (ea is EventUpdateEventArgs)
            {
                DayPilotScheduler1_EventUpdate(sender, (EventUpdateEventArgs) ea);
            }
        }
    }
    protected void DayPilotScheduler1_EventUpdate(object sender, EventUpdateEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Event.Value);
        if (dr != null)
        {
            dr["start"] = e.New.Start;
            dr["end"] = e.New.End;
            dr["column"] = e.New.Resource;
            dr["name"] = e.New.Text;
            table.AcceptChanges();
        }
        else
        {
            throw new Exception("Event id not found.");
        }
        #endregion


    }

    protected void DayPilotScheduler1_OnEventRightClick(object sender, EventRightClickEventArgs e)
    {
        
    }

    protected void DayPilotScheduler1_TimeHeaderClick(object sender, TimeHeaderClickEventArgs e)
    {
        
    }
}
