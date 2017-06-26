using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DayPilot.Web.Ui.Enums;

public partial class Horizontal_DateSwitching : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DayPilotCalendar1_Refresh(object sender, DayPilot.Web.Ui.Events.RefreshEventArgs e)
    {
        DayPilotCalendar1.Days = e.Days;
        if (e.Days == 7)
        {
            DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(e.StartDate);
        }
        else
        {
            DayPilotCalendar1.StartDate = e.StartDate;
        }

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update(CallBackUpdateType.Full);
    }
    protected void DayPilotCalendar1_Command(object sender, DayPilot.Web.Ui.Events.CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "previous":
                DayPilotCalendar1.StartDate = DayPilotCalendar1.StartDate.AddDays(-DayPilotCalendar1.Days);
                break;
            case "next":
                DayPilotCalendar1.StartDate = DayPilotCalendar1.StartDate.AddDays(DayPilotCalendar1.Days);
                break;
            case "today":
                DayPilotCalendar1.StartDate = (DayPilotCalendar1.Days == 7) ? DayPilot.Utils.Week.FirstDayOfWeek(DateTime.Today) : DateTime.Today;
                break;
            case "week":
                DayPilotCalendar1.Days = 7;
                DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(DayPilotCalendar1.StartDate);
                break;
            case "day":
                DayPilotCalendar1.Days = 1;
                break;
        }

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update(CallBackUpdateType.Full);
    }
}
