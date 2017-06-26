using System;
using DayPilot.Web.Ui.Events;

public partial class CustomBusinessHours : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DayPilotCalendar1_BeforeCellRender(object sender, BeforeCellRenderEventArgs e)
    {
        if (e.Start.Hour >= 9 && e.Start.Hour < 12)
            e.BackgroundColor = "#FFF2CC"; // shift #1 
        else if (e.Start.Hour >= 12 && e.Start.Hour < 15)
            e.BackgroundColor = "#FFD9CC"; // shift #2
        else if (e.Start.Hour >= 15 && e.Start.Hour < 18)
            e.BackgroundColor = "#F2FFCC"; // shift #3


        // Turning Saturday and Sunday into business days
        /*
        if ((e.Start.DayOfWeek == DayOfWeek.Saturday || e.Start.DayOfWeek == DayOfWeek.Sunday)
            || (e.Start.Hour >= 9 && e.Start.Hour < 18))
        {
            e.IsBusiness = true;
        }
         */

        // or you can change just IsBusiness and you will get the color automatically
        /*
        if (e.Start.Hour >= 10 && e.Start.Hour < 12)
            e.IsBusiness = true;
        else if (e.Start.Hour >= 14 && e.Start.Hour < 16)
            e.IsBusiness = true;
        else
            e.IsBusiness = false;
         */

    }
}
