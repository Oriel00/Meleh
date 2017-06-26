using System;
using System.Data;
using System.Drawing;
using ASP.App_Code.Data;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;
using DayPilot.Web.Ui.Events.Scheduler;

public partial class Scheduler_DynamicTreeLoading : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        initData();
        preloadTree();
        if (!IsPostBack)
        {
            // set the month view
            DayPilotScheduler1.StartDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            DayPilotScheduler1.Days = DateTime.DaysInMonth(DateTime.Today.Year, DateTime.Today.Month);
            //DayPilotScheduler1.Separators.Add(DateTime.Now, Color.Red);

            DayPilotScheduler1.SetScrollX(DateTime.Today);
            setDataSourceAndBind();
        }
    }

    private void preloadTree()
    {
        if (DayPilotScheduler1.Resources.Count == 0)
        {
            for(int i = 0; i < 5; i++)
            {
                char c = (char) ('A' + i);
                Resource r = new Resource(c + "", c + "");
                r.DynamicChildren = true;

                DayPilotScheduler1.Resources.Add(r);
            }
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
            re.InnerHTML = "<b>Event details</b><br />Here is the right place to show details about the event with ID: " + re.Value + ". This text is loaded dynamically from the server.";
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
            case "deletechildren":
                foreach (Resource resource in DayPilotScheduler1.Resources)
                {
                    resource.Children.Clear();
                    //resource.Children.Add("test", "test1");
                    //resource.DynamicChildren = true;
                    //resource.DynamicChildren = true;
                    //resource.Expanded = true;
                }
                DayPilotScheduler1.Update(CallBackUpdateType.Full);
                break;
        }
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
    }

    protected void DayPilotScheduler1_LoadNode(object sender, DayPilot.Web.Ui.Events.LoadNodeEventArgs e)
    {
        Resource r = e.Resource;
        Resource child = new Resource("Test", Guid.NewGuid().ToString());
        child.DynamicChildren = true;

        r.Children.Add(child);
        r.Expanded = true;

        DayPilotScheduler1.DataSource = getData(DayPilotScheduler1.ViewPort.Start, DayPilotScheduler1.ViewPort.End, null);
        DayPilotScheduler1.DataBind();

        DayPilotScheduler1.Update(CallBackUpdateType.Full);
    }


    protected void DayPilotScheduler1_OnResourceHeaderClick(object sender, ResourceHeaderClickEventArgs e)
    {
        //throw new Exception("resource clicked: " + e.Resource.Value);
    }

    protected void DayPilotScheduler1_Scroll(object sender, ScrollEventArgs e)
    {
        DayPilotScheduler1.DataSource = getData(DayPilotScheduler1.ViewPort.Start, DayPilotScheduler1.ViewPort.End, null);
        DayPilotScheduler1.DataBind();
        DayPilotScheduler1.Update();
    }
}
