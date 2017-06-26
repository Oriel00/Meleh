using System;
using System.Collections;
using DayPilot.Web.Ui;
using DayPilot.Web.Ui.Enums.Gantt;
using DayPilot.Web.Ui.Events.Gantt;

public partial class Gantt_TaskSyncing : System.Web.UI.Page
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
            DayPilotGantt1.StartDate = DateTime.Today.AddDays(-1);
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
        DayPilotGantt1.Message("Clicked: " + e.Id);
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
        if (e.Tags.ContainsKey("color"))
        {
            e.Box.BarBackColor = "#ddd";
            e.Box.BarColor = e.Tags["color"];
        }
    }

    void DayPilotGantt1_BeforeLinkRender(object sender, BeforeLinkRenderEventArgs e)
    {
        if (e.Tags.ContainsKey("color"))
        {
            e.Color = e.Tags["color"];
        }

    }

    private void LoadTasksAndLinks()
    {
        DayPilotGantt1.Tasks.Clear();
        DayPilotGantt1.Links.Clear();

        Task group = new Task("Group 1", "G1", DateTime.Now, DateTime.Now.AddDays(1));
        group.Tags["info"] = "info";
        group.Complete = 30;

        group.Children.Add(CreateTask("Task 1", "1", DateTime.Now, DateTime.Now.AddDays(1), 50));
        group.Children.Add("Task 2", "2", DateTime.Now, DateTime.Now.AddDays(1));
        group.Children.Add(new Milestone("Milestone 1", "M1", DateTime.Now.AddHours(1)));

        DayPilotGantt1.Tasks.Add(group);

        DayPilotGantt1.Links.Add(CreateLink("1", "2", "green"));
    }

    private Link CreateLink(string from, string to, string color)
    {
        Link link = new Link();
        link.From = from;
        link.To = to;
        link.Tags["color"] = color;
        return link;
    }

    private Task CreateTask(string text, string id, DateTime start, DateTime end, int complete)
    {
        Task task = new Task(text, id, start, end);
        task.Complete = complete;
        task.Tags["color"] = "red";
        return task;
    }

    void DayPilotGantt1_Command(object sender, DayPilot.Web.Ui.Events.Gantt.CommandEventArgs e)
    {
        if (e.Command == "goto")
        {
            DayPilotGantt1.StartDate = Convert.ToDateTime((string)e.Data);
            DayPilotGantt1.Days = DateTime.DaysInMonth(DayPilotGantt1.StartDate.Year, DayPilotGantt1.StartDate.Month);
            //LoadTasksAndLinks();
            DayPilotGantt1.UpdateWithMessage("Command received: " + e.Command);
        }
    }

    void DayPilotGantt1_BeforeCellRender(object sender, DayPilot.Web.Ui.Events.Gantt.BeforeCellRenderEventArgs e)
    {
    }

    protected void DayPilotGantt1_OnTaskMove(object sender, TaskMoveEventArgs e)
    {
        DayPilotGantt1.UpdateWithMessage("Moved to " + e.NewStart);
    }
}
