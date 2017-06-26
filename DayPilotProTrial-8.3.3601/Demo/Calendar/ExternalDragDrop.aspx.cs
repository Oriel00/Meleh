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

public partial class Calendar_ExternalDragDrop : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["ExternalDragDrop"] == null)
        {
            Session["ExternalDragDrop"] = DataGeneratorCalendar.GetData();
        }
        table = (DataTable)Session["ExternalDragDrop"];
        DayPilotCalendar1.DataSource = Session["ExternalDragDrop"];
        #endregion

        
        if (!IsPostBack)
        {
            DayPilotCalendar1.StartDate = DayPilot.Utils.Week.FirstDayOfWeek(DateTime.Today);
            DataBind();
        }
    }
    protected void DayPilotCalendar1_EventMove(object sender, DayPilot.Web.Ui.Events.EventMoveEventArgs e)
    {
        #region Simulation of database update

        DataRow dr = table.Rows.Find(e.Id);
        if (dr != null)
        {
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            table.AcceptChanges();
        }
        else
        {
            dr = table.NewRow();
            dr["start"] = e.NewStart;
            dr["end"] = e.NewEnd;
            dr["id"] = e.Id;
            dr["name"] = e.Text;

            table.Rows.Add(dr);
            table.AcceptChanges();
        }


        #endregion

        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();
    }
}
