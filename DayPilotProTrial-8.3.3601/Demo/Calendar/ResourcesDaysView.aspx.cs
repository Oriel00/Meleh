using System;
using System.Data;
using System.IO;
using System.Web.UI;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;

public partial class ResourcesDaysView : Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["ResourcesDaysView"] == null)
        {
            Session["ResourcesDaysView"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["ResourcesDaysView"];
        DayPilotCalendar1.DataSource = Session["ResourcesDaysView"];
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

        DateTime first = DayPilotCalendar1.StartDate;

        string[] resources = new string[] {"A", "B", "C"};

        foreach (string res in resources)
        {

            Column c = new Column(res, res); // using the same Name and Value
            DayPilotCalendar1.Columns.Add(c);

            for (int j = 0; j < 2; j++)
            {
                DateTime day = first.AddDays(j);

                Column subC = new Column(day.ToShortDateString(), res);
                subC.Date = day;
                c.Children.Add(subC);
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
            //dr["name"] = e.Resource;
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
        defineColumns();
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update(CallBackUpdateType.Full);
    }

    protected void DayPilotCalendar1_Command(object sender, CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "previous":
                DayPilotCalendar1.StartDate = DayPilotCalendar1.StartDate.AddDays(-3);
                break;
            case "next":
                DayPilotCalendar1.StartDate = DayPilotCalendar1.StartDate.AddDays(3);
                break;
            case "today":
                DayPilotCalendar1.StartDate = DateTime.Today;
                break;
        }

        defineColumns(); // required, the StartDate was changes
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update(CallBackUpdateType.Full);

    }

    protected void DayPilotCalendar1_BeforeCellRender(object sender, BeforeCellRenderEventArgs e)
    {
    }
}
