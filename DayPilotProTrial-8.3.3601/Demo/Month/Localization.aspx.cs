using System;
using System.Data;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Bubble;

public partial class Month_Localization : System.Web.UI.Page
{
    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region Data loading initialization
        if (Session["MonthView"] == null)
        {
            Session["MonthView"] = DataGeneratorMonth.GetData();
        }
        table = (DataTable)Session["MonthView"];
        DayPilotMonth1.DataSource = Session["MonthView"];
        #endregion
        
        if (!IsPostBack)
        {
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

        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update("Event resized");

    }
    protected void DayPilotMonth1_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeCellRenderEventArgs e)
    {
        
        if (e.Start == DateTime.Today)
        {
            e.HeaderBackColor = "#FFD9CC";
        }
          
    }

    protected void DayPilotMonth1_BeforeHeaderRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeHeaderRenderEventArgs e)
    {
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

        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update();
    }
    protected void DayPilotMonth1_BeforeEventRender(object sender, DayPilot.Web.Ui.Events.Month.BeforeEventRenderEventArgs e)
    {
        if (e.Id == "7")
        {
            e.ContextMenuClientName = "test";
        }
    }

    protected void DayPilotBubble1_RenderContent(object sender, RenderEventArgs e)
    {
        if (e is RenderEventBubbleEventArgs)
        {
            RenderEventBubbleEventArgs re = e as RenderEventBubbleEventArgs;
            re.InnerHTML = "<b>Event details</b><br />Here is the right place to show details about the event with ID: " + re.Value + ". This text is loaded dynamically from the server.";
        }
    }

    protected void DayPilotMonth1_Refresh(object sender, RefreshEventArgs e)
    {
        DayPilotMonth1.StartDate = e.StartDate; 
        DayPilotMonth1.DataBind();
        DayPilotMonth1.Update();

    }
    protected void ButtonChange_Click(object sender, EventArgs e)
    {
        Culture = DropDownList1.SelectedValue;
        DataBind();
    }
}
