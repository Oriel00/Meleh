using System;
using System.Data;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Common;

public partial class EventSelecting : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["EventSelecting"] == null)
        {
            Session["EventSelecting"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["EventSelecting"];
        DayPilotCalendar1.DataSource = Session["EventSelecting"];
        #endregion


        if (!IsPostBack)
        {
            DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(DateTime.Today);
            DataBind();
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
        DayPilotCalendar1.Update();
    }

    protected void DayPilotCalendar1_EventSelect(object sender, DayPilotEventArgs e)
    {
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();
    }

    protected void DayPilotCalendar1_EventMove(object sender, DayPilot.Web.Ui.Events.EventMoveEventArgs e)
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
    protected void DayPilotCalendar1_Command(object sender, CommandEventArgs e)
    {
        if (DayPilotCalendar1.SelectedEvents.Count > 0)
        {
            EventInfo ei = DayPilotCalendar1.SelectedEvents[0];
            DayPilotCalendar1.SelectedEvents.RemoveAt(0);
            DayPilotCalendar1.DataBind();
            DayPilotCalendar1.UpdateWithMessage("Event removed from selection: " + ei.Text);
        }


        /*
        foreach(EventInfo ei in DayPilotCalendar1.SelectedEvents)
        {
            list += ei.Value + ":";
        }
         * */



        //throw new Exception(list);
    }
}
