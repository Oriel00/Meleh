using System;
using System.Data;
using System.Drawing;
using DayPilot.Web.Ui.Events;

public partial class DurationBar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["EventLeftBar"] == null)
                Session["EventLeftBar"] = DataGeneratorCalendar.GetData();

            DayPilotCalendar1.DataSource = Session["EventLeftBar"];
            DataBind();
        }

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (DropDownList1.SelectedValue)
        {
            case "hidden":
                DayPilotCalendar1.DurationBarVisible = false;
                break;
            case "default":
                DayPilotCalendar1.DurationBarVisible = true;
                break;
        }

        DayPilotCalendar1.DataSource = Session["EventLeftBar"];
        DataBind();


    }
}
