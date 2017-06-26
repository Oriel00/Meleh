using System;
using System.Data;
using DayPilot.Web.Ui.Events;

public partial class Editing : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["EventDeleting"] == null)
        {
            Session["EventDeleting"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["EventDeleting"];
        DayPilotCalendar1.DataSource = Session["EventDeleting"];
        #endregion

        if (!IsPostBack)
        {
            DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(DateTime.Today);
            DataBind();
        }
    }

    protected void DayPilotCalendar1_EventEdit(object sender, EventEditEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);

        if (dr != null)
        {
            dr["name"] = e.NewText;
            table.AcceptChanges();
        }

        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();
    }
}
