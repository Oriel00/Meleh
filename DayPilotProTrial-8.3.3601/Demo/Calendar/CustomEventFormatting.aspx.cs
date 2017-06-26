using System;
using System.Data;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Calendar;

public partial class CustomEventFormatting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DayPilotCalendar1_BeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
        if (e.Tag[0] == "2")
        {
            e.DurationBarColor = "red";
            e.DurationBarBackColor = "#eee";
            e.BackgroundColor = "lightyellow";
            e.Html = "<i>WARNING: This is an unusual event.</i><br>" + e.Html + "<br/>" + e.Tag["name"];
        }

        if (e.Id == "1")
        {
            e.Html = "test";
            e.Visible = false;
        }
    }
}
