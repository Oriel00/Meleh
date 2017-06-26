using System;
using System.Data;
using System.Drawing;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;

public partial class Month_HideWeekend : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        initData();
        if (!IsPostBack)
        {
            DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, null);
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

            DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, null);
            DayPilotMonth1.DataBind();
            DayPilotMonth1.Update();
        }
    }
    protected void DayPilotMonth1_EventMove(object sender, EventMoveEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            //dr["column"] = e.NewResource;
            table.AcceptChanges();
        }
        else // moved from outside
        {
            dr = table.NewRow();
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["id"] = e.Id;
            dr["name"] = e.Text;
            //dr["column"] = e.NewResource;

            table.Rows.Add(dr);
            table.AcceptChanges();
        }

        #endregion

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, null);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update("Event moved.");

    }
    protected void DayPilotMonth1_EventResize(object sender, EventResizeEventArgs e)
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

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, null);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update("Event resized");

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

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, null);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update();
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
            case "next":
                DayPilotMonth1.StartDate = DayPilotMonth1.StartDate.AddMonths(1);
                break;
            case "previous":
                DayPilotMonth1.StartDate = DayPilotMonth1.StartDate.AddMonths(-1);
                break;
            case "today":
                DayPilotMonth1.StartDate = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                break;
        }

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, null);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update(CallBackUpdateType.Full);
    }

    /// <summary>
    /// Make sure a copy of the data is in the Session so users can try changes on their own copy.
    /// </summary>
    private void initData()
    {
        if (Session["MonthHideWeekend"] == null)
        {
            Session["MonthHideWeekend"] = DataGeneratorMonth.GetData();
        }

        table = (DataTable)Session["MonthHideWeekend"];
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


    protected void DayPilotMonth1_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeCellRenderEventArgs e)
    {

    }
}
