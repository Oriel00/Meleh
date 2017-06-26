using System;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Enums.Calendar;

public partial class ScrollingArea : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (DropDownList1.SelectedValue)
        {
            case "fixed":
                DayPilotCalendar1.HeightSpec = HeightSpecEnum.Fixed;
                DayPilotCalendar1.Height = 200;
                break;
            case "full":
                DayPilotCalendar1.HeightSpec = HeightSpecEnum.Full;
                break;
            case "businesshours":
                DayPilotCalendar1.HeightSpec = HeightSpecEnum.BusinessHours;
                break;
            case "businesshoursnoscrolling":
                DayPilotCalendar1.HeightSpec = HeightSpecEnum.BusinessHoursNoScroll;
                break;
        }
        DayPilotCalendar1.DataBind();
        
    }

    protected void DropDownListColWidth_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        switch (DropDownListColWidth.SelectedValue)
        {
            case "fixed":
                DayPilotCalendar1.ColumnWidthSpec = ColWidthSpec.Fixed;
                DayPilotCalendar1.ColumnWidth = 300;
                break;
            case "auto":
                DayPilotCalendar1.ColumnWidthSpec = ColWidthSpec.Auto;
                break;
        }
        DayPilotCalendar1.DataBind();
    }

}
