using System;

public partial class TimeFormat : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (DropDownList1.SelectedValue)
        {
            case "12": 
                DayPilotCalendar1.TimeFormat = DayPilot.Web.Ui.Enums.TimeFormat.Clock12Hours;
                break;
            case "24":
                DayPilotCalendar1.TimeFormat = DayPilot.Web.Ui.Enums.TimeFormat.Clock24Hours;
                break;
        }
        
    }
}
