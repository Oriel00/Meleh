using System;
using System.Data;
using System.Drawing;
using DayPilot.Web.Ui.Events;

public partial class EventLeftBar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("DurationBar.aspx");
    }
}
