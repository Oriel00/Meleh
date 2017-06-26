using System;
using System.Data;
using System.Threading;
using DayPilot.Utils;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;

public partial class EventBubble : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(DateTime.Today);
        DayPilotCalendar1.DataSource = DataGeneratorCalendar.GetData();
        DataBind();

    }

    protected void DayPilotBubble1_RenderEventBubble(object sender, RenderEventBubbleEventArgs e)
    {
        e.InnerHTML = string.Format("<b>{0}</b><br />Start: {1} <br/>End: {2}<br/>Event description.", 
            e.Text,
            TimeFormatter.GetHourMinutes(e.Start, DayPilotCalendar1.TimeFormat),
            TimeFormatter.GetHourMinutes(e.End, DayPilotCalendar1.TimeFormat));
    }
}
