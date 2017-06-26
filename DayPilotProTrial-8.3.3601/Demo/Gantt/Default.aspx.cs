using System;
using System.Collections;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums.Gantt;
using DayPilot.Web.Ui.Events.Gantt;

public partial class Gantt_Default : System.Web.UI.Page
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
        DayPilotGantt1.LinkMenuClick += new LinkMenuClickEventHandler(DayPilotGantt1_LinkMenuClick);

        if (!IsPostBack)
        {
            DayPilotGantt1.StartDate = DateTime.Today.AddDays(-10);
            DayPilotGantt1.ScrollTo(DateTime.Today);
            DayPilotGantt1.Days = 30;
            LoadTasksAndLinks();            
        }
    }

    void DayPilotGantt1_LinkMenuClick(object sender, LinkMenuClickEventArgs e)
    {
        DayPilotGantt1.Message("Command: " + e.Command + ", link from " + e.From + " to " + e.To);
    }

    void DayPilotGantt1_TaskMenuClick(object sender, TaskMenuClickEventArgs e)
    {
        DayPilotGantt1.Message("Command: " + e.Command + ", task: " + e.Id);
    }

    void DayPilotGantt1_TaskClick(object sender, TaskClickEventArgs e)
    {
//        DayPilotGantt1.Message("Clicked: " + e.Id);
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
        e.Box.BubbleHtml = "Complete: " + e.Complete + "%";
        e.Row.BubbleHtml = "Task Name: " + e.Text;
    }

    void DayPilotGantt1_BeforeLinkRender(object sender, BeforeLinkRenderEventArgs e)
    {
        //e.Color = "blue";
        //e.Style = LinkStyle.Dotted;
        //e.CssClass = "mylink";
    }

    private void LoadTasksAndLinks()
    {
        DayPilotGantt1.Tasks.Clear();
        DayPilotGantt1.Links.Clear();

        DateTime start = DateTime.Today.AddDays(1);

        Task group1 = new Task("Group 1", "G1", start, start.AddDays(1));
        group1.Tags["info"] = "info";
        group1.Complete = 30;
        group1.Children.Add(CreateTask("Task 1", "1", start, start.AddDays(1), 50));
        group1.Children.Add("Task 2", "2", start.AddDays(1), start.AddDays(2));
        group1.Children.Add(new Milestone("Milestone 1", "M1", start.AddDays(2)));
        DayPilotGantt1.Tasks.Add(group1);
        DayPilotGantt1.Links.Add("1", "2");

        start = start.AddDays(2);
        Task group2 = new Task("Group 2", "G2", start, start.AddDays(1));
        group2.Tags["info"] = "info";
        group2.Complete = 30;
        group2.Children.Add(CreateTask("Task 1", "3", start, start.AddDays(1), 50));
        group2.Children.Add("Task 2", "4", start.AddDays(1), start.AddDays(2));
        group2.Children.Add(new Milestone("Milestone 2", "M2", start.AddDays(2)));
        DayPilotGantt1.Tasks.Add(group2);
        DayPilotGantt1.Links.Add("3", "4");

        DayPilotGantt1.Links.Add("G1", "G2");

    }

    private Task CreateTask(string text, string id, DateTime start, DateTime end, int complete)
    {
        Task task = new Task(text, id, start, end);
        task.Complete = complete;
        return task;
    }

    void DayPilotGantt1_Command(object sender, DayPilot.Web.Ui.Events.Gantt.CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "goto":
                DayPilotGantt1.StartDate = Convert.ToDateTime((string)e.Data);
                DayPilotGantt1.Days = DateTime.DaysInMonth(DayPilotGantt1.StartDate.Year, DayPilotGantt1.StartDate.Month);
                LoadTasksAndLinks();
                DayPilotGantt1.UpdateWithMessage("Command received: " + e.Command);
                break;
            case "clientstate":
                DayPilotGantt1.UpdateWithMessage("filter: " + DayPilotGantt1.ClientState["filter"]);
                break;

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
