using System;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Text;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events.Bubble;

public partial class Scheduler_Large : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("DynamicEventRendering.aspx");
    }

}
