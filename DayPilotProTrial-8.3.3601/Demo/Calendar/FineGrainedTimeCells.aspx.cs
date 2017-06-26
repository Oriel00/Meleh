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

public partial class FineGrainedTimeCells : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int hourHeight = Convert.ToInt32(DropDownList1.SelectedValue);
        DayPilotCalendar1.CellHeight = hourHeight;
        checkReadability();
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        int cellDuration = Convert.ToInt32(DropDownList2.SelectedValue);
        DayPilotCalendar1.CellDuration = cellDuration;
        checkReadability();
    }

    private void checkReadability()
    {
        if (DayPilotCalendar1.CellDuration == 60)
        {
            DayPilotCalendar1.CellHeight = 25;
            DropDownList1.SelectedValue = "25";
            DropDownList1.Enabled = false;
        }
        else
        {
            DropDownList1.Enabled = true;
        }

    }
}
