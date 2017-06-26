using System;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.IO;
using DayPilot.Web.Ui.Enums;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;

public partial class Month_ImageExport : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        initData();
        if (!IsPostBack)
        {
            DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
            DayPilotNavigator1.DataSource = getData(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, null);
            DataBind();
        }
    }

    protected void DayPilotCalendar1_EventMenuClick(object sender, EventMenuClickEventArgs e)
    {

        if (e.Command == "Delete")
        {
            #region Simulation of database update
            DataRow dr = table.Rows.Find(e.Id);

            if (dr != null)
            {
                table.Rows.Remove(dr);
                table.AcceptChanges();
            }
            #endregion

            DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
            DayPilotMonth1.DataBind();
            DayPilotMonth1.Update();
        }
    }
    protected void DayPilotMonth1_EventMove(object sender, EventMoveEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            //dr["column"] = e.NewResource;
            table.AcceptChanges();
        }
        else // moved from outside
        {
            dr = table.NewRow();
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["id"] = e.Id;
            dr["name"] = e.Text;
            //dr["column"] = e.NewResource;

            table.Rows.Add(dr);
            table.AcceptChanges();
        }

        #endregion

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update("Event moved.");

    }
    protected void DayPilotMonth1_EventResize(object sender, EventResizeEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            table.AcceptChanges();
        }

        #endregion

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update("Event resized");

    }

    protected void DayPilotMonth1_TimeRangeSelected(object sender, TimeRangeSelectedEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.NewRow();
        dr["start"] = e.Start;
        dr["end"] = e.End;
        dr["id"] = Guid.NewGuid().ToString();
        dr["name"] = "New event";

        table.Rows.Add(dr);
        table.AcceptChanges();
        #endregion

        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update();
    }
    protected void DayPilotMonth1_BeforeEventRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeEventRenderEventArgs e)
    {
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;
            re.InnerHTML = "<b>Event details</b><br />Here is the right place to show details about the event with ID: " + re.Value + ". This text is loaded dynamically from the server.";
        }
    }

    protected void DayPilotNavigator1_VisibleRangeChanged(object sender, EventArgs e)
    {
        DayPilotNavigator1.DataSource = getData(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotNavigator1.DataBind();
    }

    protected void DayPilotMonth1_Command(object sender, CommandEventArgs e)
    {

        switch (e.Command)
        {
            case "navigate":
                DayPilotMonth1.StartDate = (DateTime)e.Data["start"];
                DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
                DayPilotMonth1.DataBind();
                DayPilotMonth1.Update(CallBackUpdateType.Full);
                break;
            case "filter":
                DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
                DayPilotMonth1.DataBind();
                DayPilotMonth1.Update(CallBackUpdateType.EventsOnly);
                break;
        }

    }

    /// <summary>
    /// This method should normally load the data from the database.
    /// We will load our copy from a Session, just simulating a database.
    /// </summary>
    /// <param name="start"></param>
    /// <param name="end"></param>
    /// <param name="filter"></param>
    /// <returns></returns>
    private DataTable getData(DateTime start, DateTime end, string filter)
    {
        String select;
        if (String.IsNullOrEmpty(filter))
        {
            select = String.Format("NOT (([end] <= '{0:s}') OR ([start] >= '{1:s}'))", start, end, filter);
        }
        else
        {
            select = String.Format("NOT (([end] <= '{0:s}') OR ([start] >= '{1:s}')) and [name] like '%{2}%'", start, end, filter);
//            throw new Exception(select);
        }


        DataRow[] rows = table.Select(select);

        DataTable filtered = table.Clone();
        
        foreach (DataRow r in rows)
        {
            filtered.ImportRow(r);
        }

        return filtered;
    }

    /// <summary>
    /// Make sure a copy of the data is in the Session so users can try changes on their own copy.
    /// </summary>
    private void initData()
    {
        if (Session["MonthView"] == null)
        {
            Session["MonthView"] = DataGeneratorMonth.GetData();
        }

        table = (DataTable)Session["MonthView"];
    }

    protected void ButtonExport_Click(object sender, EventArgs e)
    {
        DayPilotMonth1.LoadStylesDefaultTheme();
        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();

        Response.Clear();
        Response.ContentType = "image/png";
        Response.AddHeader("Content-Disposition", "attachment;filename=print.png");
        DayPilotMonth1.Export(ImageFormat.Png).WriteTo(Response.OutputStream);
        Response.End();
    }

    protected void ButtonExportHeader_Click(object sender, EventArgs e)
    {
        DayPilotMonth1.DataSource = getData(DayPilotMonth1.VisibleStart, DayPilotMonth1.VisibleEnd, (string)DayPilotMonth1.ClientState["filter"]);
        DayPilotMonth1.DataBind();

        DayPilotMonth1.LoadStylesDefaultTheme();

        Response.Clear();
        Response.ContentType = "image/png";
        Response.AddHeader("content-disposition", "attachment;filename=print.png");

        int width = 1000;
        int height = 1000;

        Bitmap bmp = new Bitmap(width, height);
        Graphics g = Graphics.FromImage(bmp);
        g.SmoothingMode = SmoothingMode.AntiAlias;
        g.TextRenderingHint = TextRenderingHint.AntiAlias;

        Image cal = DayPilotMonth1.ExportBitmap();
        g.DrawImage(cal, 0, 50);

        string title = String.Format("{0:MMMM yyyy}", DayPilotMonth1.StartDate);
        Font font = new Font("Tahoma", 16, GraphicsUnit.Point);
        Brush brush = new SolidBrush(Color.Black);
        g.DrawString(title, font, brush, 0, 0);

        // PNG requires random access to the output stream
        using (MemoryStream mem = new MemoryStream())
        {
            bmp.Save(mem, ImageFormat.Png);
            mem.WriteTo(Response.OutputStream);
        }

        Response.End();
    }

    protected void DayPilotMonth1_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeCellRenderEventArgs e)
    {
    }
}