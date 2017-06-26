using System;
using System.Data;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Calendar;

public partial class ContextMenu : System.Web.UI.Page
{
    private DataTable table;
    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["ContextMenuData"] == null)
        {
            Session["ContextMenuData"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["ContextMenuData"];
        DayPilotCalendar1.DataSource = Session["ContextMenuData"];
        #endregion

        if (!IsPostBack)
        {
            DataBind();
        }

    }


    protected void DayPilotCalendar1_EventMenuClick(object sender, DayPilot.Web.Ui.Events.EventMenuClickEventArgs e)
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

            DayPilotCalendar1.DataBind();
            DayPilotCalendar1.Update();
        }

    }
    protected void DayPilotCalendar1_BeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
        if (e.Id ==  "4")
        {
            e.Html = "This event has a special context menu";
            e.DurationBarColor = "red";
            e.ContextMenuClientName = "specialmenu";
        }
    }


}
