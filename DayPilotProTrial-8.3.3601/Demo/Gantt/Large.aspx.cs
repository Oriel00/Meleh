using System;
using System.Collections;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums.Gantt;
using DayPilot.Web.Ui.Events.Gantt;

public partial class Gantt_Large : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DayPilotGantt1.BeforeCellRender += DayPilotGantt1_BeforeCellRender;
        DayPilotGantt1.TaskMove += DayPilotGantt1_OnTaskMove;
        DayPilotGantt1.Command += DayPilotGantt1_Command;
        DayPilotGantt1.BeforeLinkRender += DayPilotGantt1_BeforeLinkRender;
        DayPilotGantt1.BeforeTaskRender += DayPilotGantt1_BeforeTaskRender;
        DayPilotGantt1.BeforeTimeHeaderRender += DayPilotGantt1_BeforeTimeHeaderRender;
        DayPilotGantt1.TaskClick += DayPilotGantt1_TaskClick;
        DayPilotGantt1.TaskMenuClick += new TaskMenuClickEventHandler(DayPilotGantt1_TaskMenuClick);

        if (!IsPostBack)
        {
            DayPilotGantt1.StartDate = DateTime.Today.AddDays(-1);
            DayPilotGantt1.Days = 30;
            LoadTasksAndLinks();
        }
    }

    void DayPilotGantt1_TaskMenuClick(object sender, TaskMenuClickEventArgs e)
    {
        DayPilotGantt1.UpdateWithMessage("Command: " + e.Command + ", task: " + e.Id);
    }

    void DayPilotGantt1_TaskClick(object sender, TaskClickEventArgs e)
    {
        DayPilotGantt1.UpdateWithMessage("Clicked: " + e.Id);
    }

    void DayPilotGantt1_BeforeTimeHeaderRender(object sender, DayPilot.Web.Ui.Events.BeforeTimeHeaderRenderEventArgs e)
    {
        /*
        if (e.Level == 0)
        {
            e.BackgroundColor = "#aaffaa";
        }
         */
    }

    void DayPilotGantt1_BeforeTaskRender(object sender, BeforeTaskRenderEventArgs e)
    {
        /*
        e.Box.Html = "test";
        e.Box.HtmlRight = "right";
         * */
    }

    void DayPilotGantt1_BeforeLinkRender(object sender, BeforeLinkRenderEventArgs e)
    {
        //e.Color = "blue";
        //e.Style = LinkStyle.Dotted;
        //e.CssClass = "mylink";
    }

    private void LoadTasksAndLinks()
    {
        DayPilotGantt1.DataSource = DataGeneratorGantt.GetDataLarge();
        DayPilotGantt1.DataIdField = "id";
        DayPilotGantt1.DataTextField = "text";
        DayPilotGantt1.DataStartField = "start";
        DayPilotGantt1.DataEndField = "end";
        DayPilotGantt1.DataParentField = "parent";
        DayPilotGantt1.DataBind();

        DayPilotGantt1.Links.Clear();
        DayPilotGantt1.Links.Add("1", "2");
    }

    private Task CreateTask(string text, string id, DateTime start, DateTime end, int complete)
    {
        Task task = new Task(text, id, start, end);
        task.Complete = complete;
        return task;
    }

    void DayPilotGantt1_Command(object sender, DayPilot.Web.Ui.Events.Gantt.CommandEventArgs e)
    {
        if (e.Command == "goto")
        {
            DayPilotGantt1.StartDate = Convert.ToDateTime((string)e.Data);
            DayPilotGantt1.Days = DateTime.DaysInMonth(DayPilotGantt1.StartDate.Year, DayPilotGantt1.StartDate.Month);
            LoadTasksAndLinks();
            DayPilotGantt1.UpdateWithMessage("Command received: " + e.Command);
        }
    }

    void DayPilotGantt1_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.Gantt.BeforeCellRenderEventArgs e)
    {
        /*
        if (e.Start.DayOfWeek == DayOfWeek.Sunday)
        {
            e.BackgroundColor = "#ffaaaa";
        }
         */
    }

    protected void DayPilotGantt1_OnTaskMove(object sender, TaskMoveEventArgs e)
    {
        DayPilotGantt1.UpdateWithMessage("Moved to " + e.NewStart);
    }
}
