using System;
using System.Collections;
using System.Data;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;
using DayPilot.Web.Ui.Events.Calendar;

public partial class Calendar_GoogleLike : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["AllFeatures"] == null)
        {
            Session["AllFeatures"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["AllFeatures"];
        DayPilotCalendar1.DataSource = Session["AllFeatures"];
        DayPilotNavigator1.DataSource = Session["AllFeatures"];
        #endregion

        if (!IsPostBack)
        {
            DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek();
            DataBind();
        }
    }

    protected void DayPilotCalendar1_EventMove(object sender, EventMoveEventArgs e)
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

        Hashtable ht = new Hashtable();
        ht["message"] = "Event moved.";
        ht["id"] = e.Id;

        DayPilotCalendar1.Update(ht);
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
        if (dr != null)
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
        if (e.Id == "6")
        {
            e.BorderColor = "#1AAFE0";
            e.BackgroundColor = "#90D8F2";
        }
        if (e.Id == "8")
        {
            e.BorderColor = "#068c14";
            e.BackgroundColor = "#08b81b";
        }
        if (e.Id == "2")
        {
            e.BorderColor = "#FAD165";
            e.BackgroundColor = "#FEF2D3";
        }
    }


    protected void DayPilotCalendar1_EventDelete(object sender, EventDeleteEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            table.Rows.Remove(dr);
            table.AcceptChanges();
        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update("Event deleted.");
    }

    protected void DayPilotCalendar1_EventSelect(object sender, DayPilotEventArgs e)
    {
        DayPilotCalendar1.Update();
    }

    protected void DayPilotCalendar1_Refresh(object sender, RefreshEventArgs e)
    {
        DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(e.StartDate);
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update(CallBackUpdateType.Full);
    }


    protected void DayPilotCalendar1_BeforeHeaderRender(object sender, BeforeHeaderRenderEventArgs e)
    {
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;
            re.InnerHTML = "<b>Event details</b><br />Here is the right place to show details about the event with ID: " + re.Value + ". This text is loaded dynamically from the server.<br/>";
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
        if (e.Start >= DateTime.Today && e.End <= DateTime.Today.AddDays(1))
        {
            e.BackgroundColor = "#f1f1f1";
        }
    }
}
