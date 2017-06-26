using System;
using System.Data;
using System.Web.UI;
using DayPilot.Utils;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;

public partial class DaysResourcesView : Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["ResourcesMultiDayView"] == null)
        {
            Session["ResourcesMultiDayView"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["ResourcesMultiDayView"];
        DayPilotCalendar1.DataSource = Session["ResourcesMultiDayView"];
        #endregion
        
        defineColumns();

        if (!IsPostBack)
        {
            DataBind();
        }
    }

    private void defineColumns()
    {
        DayPilotCalendar1.Columns.Clear();

        DateTime first = Week.FirstDayOfWeek(DayPilotCalendar1.StartDate);

        for (int i = 0; i < 7; i++)
        {
            DateTime day = first.AddDays(i);

            Column c = new Column(day.ToShortDateString(), day.ToString("s"));
            c.Date = day;
            DayPilotCalendar1.Columns.Add(c);

            Column c1 = new Column("A", "A");
            c1.Date = day;
            c.Children.Add(c1);

            Column c2 = new Column("B", "B");
            c2.Date = day;
            c.Children.Add(c2);

            if (day.Date == DateTime.Today)
            {
                Column c3 = new Column("C", "C");
                c3.Date = day;
                c.Children.Add(c3);
            }

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
    protected void DayPilotCalendar1_EventMove(object sender, EventMoveEventArgs e)
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

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderResourceBubbleEventArgs)
        {
            RenderResourceBubbleEventArgs re = e as RenderResourceBubbleEventArgs;
            e.InnerHTML = "<b>Resource header details</b><br />Value: " + re.ResourceId;
        }
    }

    protected void DayPilotCalendar1_Refresh(object sender, RefreshEventArgs e)
    {
        DayPilotCalendar1.StartDate = e.StartDate;
        defineColumns(); // required, the StartDate was changes
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update(CallBackUpdateType.Full);
    }
    protected void DayPilotCalendar1_Command(object sender, CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "previous":
                DayPilotCalendar1.StartDate = DayPilotCalendar1.StartDate.AddDays(-7);
                break;
            case "next":
                DayPilotCalendar1.StartDate = DayPilotCalendar1.StartDate.AddDays(7);
                break;
            case "today":
                DayPilotCalendar1.StartDate = Week.FirstDayOfWeek();
                break;
        }

        defineColumns(); // required, the StartDate was changes
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update(CallBackUpdateType.Full);

    }
}
