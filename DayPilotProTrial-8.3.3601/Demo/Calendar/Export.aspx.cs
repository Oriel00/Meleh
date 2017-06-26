using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Enums.Calendar;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Calendar;

public partial class Calendar_Export : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        defineColumns();

        DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek();

        if (Session["AllFeatures"] == null)
        {
            Session["AllFeatures"] = DataGeneratorCalendar.GetData();
        }




        DayPilotCalendar1.DataSource = Session["AllFeatures"];
        DataBind();

        // override the output
        Response.Clear();
        Response.ContentType = "image/png";
        MemoryStream img = DayPilotCalendar1.Export(ImageFormat.Png);
        img.WriteTo(Response.OutputStream);
        Response.End();
    }

    private void defineColumns()
    {
        DayPilotCalendar1.Columns.Clear();

        DateTime first = DayPilotCalendar1.StartDate;

        string[] resources = new string[] { "A", "B", "C" };

        for (int i = 0; i < 3; i++)
        {

            Column c = new Column(resources[i], resources[i]);
            DayPilotCalendar1.Columns.Add(c);

            for (int j = 0; j < 2; j++)
            {
                DateTime day = first.AddDays(j);

                Column subC = new Column(day.ToShortDateString(), resources[i]);
                subC.Date = day;
                c.Children.Add(subC);
            }
        }
    }


    protected void DayPilotCalendar1_BeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
        if (e.Id == "3")
        {
            //e.InnerHTML = "User actions (\"move\", \"resize\", \"click\", and 'delete') disabled for this specific event.";
            //e.InnerHTML = "User actions (move, resize, click, and delete) disabled for this specific event.";
            e.Html = "User actions";
            e.DurationBarColor = "red";
            e.EventClickEnabled = false;
            e.EventMoveEnabled = false;
            e.EventResizeEnabled = false;
            e.EventDeleteEnabled = false;
            e.ToolTip = "One\ntwo\nthree.";
        }

        if (e.Id == "7")
        {
            e.DurationBarImageUrl = "../Media/linked/tentative5x8.gif";
        }
    }

    protected void DayPilotCalendar1_BeforeHeaderRender(object sender, BeforeHeaderRenderEventArgs e)
    {
        if (DayPilotCalendar1.ViewType == ViewTypeEnum.Days)
        {
            e.Html = e.Date.ToString("d MMMM yyyy");
        }
    }


}
