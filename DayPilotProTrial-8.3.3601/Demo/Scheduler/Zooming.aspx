<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="Zooming.aspx.cs"
    Inherits="Scheduler_Zooming" Title="Zooming (Scheduler) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <strong>Tip:</strong> Click the first row of the header (e.g. "<%= DateTime.Today.ToString("MMMM yyyy") %>") to
    zoom into that time period.
    <span id="message" style="padding:2px; background-color: #dc143c; color: White; display: none;"></span>
    <br /><br />
    
    <DayPilot:DayPilotScheduler ID="DayPilotScheduler1" runat="server" 
        DataStartField="start" DataEndField="end" DataTextField="name" DataIdField="id" DataTagFields="id, name"
          DataResourceField="column" 
         Width="100%" CellDuration="1440" CellGroupBy="Month" TimeRangeSelectedHandling="Hold"
        ClientObjectName="dps1" OnBeforeTimeHeaderRender="DayPilotScheduler1_BeforeTimeHeaderRender"
        EventMoveHandling="CallBack" EventMoveJavaScript="alert(e.row())" EventResizeHandling="CallBack"
        OnEventMove="DayPilotScheduler1_EventMove" OnEventResize="DayPilotScheduler1_EventResize"
        OnTimeRangeSelected="DayPilotScheduler1_TimeRangeSelected" EventClickHandling="Edit"
        EventEditHandling="CallBack" OnEventEdit="DayPilotScheduler1_EventEdit" OnBeforeEventRender="DayPilotScheduler1_BeforeEventRender"
        OnEventMenuClick="DayPilotScheduler1_EventMenuClick" ContextMenuID="DayPilotMenu2" BusinessBeginsHour="5" 
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
         EnableViewState="false" ScrollLabelsVisible="false" 
        BubbleID="DayPilotBubble1" xCellBubbleID="DayPilotBubble1" ResourceBubbleID="DayPilotBubble1" ShowToolTip="false"
        HeightSpec="Fixed" Height="350" EventClickJavaScript="alert(e.start() + '\n' + e.end());"
        OnCommand="DayPilotScheduler1_Command" OnEventClick="DayPilotScheduler1_EventClick"
        ContextMenuSelectionID="DayPilotMenuSelection" OnTimeRangeMenuClick="DayPilotScheduler1_TimeRangeMenuClick"
        
        
        
        TimeRangeDoubleClickHandling="JavaScript"
        
        >
        <Resources>
            <DayPilot:Resource Name="Room A" Id="A" />
            <DayPilot:Resource Name="Room B" Id="B" />
            <DayPilot:Resource Name="Room C" Id="C" ToolTip="Test" />
            <DayPilot:Resource Name="Room D" Id="D" />
            <DayPilot:Resource Name="Room E" Id="E" />
            <DayPilot:Resource Name="Room F" Id="F" />
            <DayPilot:Resource Name="Room G" Id="G" />
            <DayPilot:Resource Name="Room H" Id="H" />
            <DayPilot:Resource Name="Room I" Id="I" />
            <DayPilot:Resource Name="Room J" Id="J" />
            <DayPilot:Resource Name="Room K" Id="K" />
            <DayPilot:Resource Name="Room L" Id="L" />
            <DayPilot:Resource Name="Room M" Id="M" />
            <DayPilot:Resource Name="Room N" Id="N" />
            <DayPilot:Resource Name="Room O" Id="O" />
            <DayPilot:Resource Name="Room P" Id="P" />
            <DayPilot:Resource Name="Room Q" Id="Q" />
            <DayPilot:Resource Name="Room R" Id="R" />
            <DayPilot:Resource Name="Room S" Id="S" />
            <DayPilot:Resource Name="Room T" Id="T" />
            <DayPilot:Resource Name="Room U" Id="U" />
            <DayPilot:Resource Name="Room V" Id="V" />
            <DayPilot:Resource Name="Room W" Id="W" />
            <DayPilot:Resource Name="Room X" Id="X" />
            <DayPilot:Resource Name="Room Y" Id="Y" />
            <DayPilot:Resource Name="Room Z" Id="Z" />
        </Resources>
        <Separators>
            <DayPilot:Separator Color="green" Location="02/01/2008 12:00:00" />
            <DayPilot:Separator Color="green" Location="02/03/2008 12:00:00" />
            <DayPilot:Separator Color="red" Location="02/02/2008 00:00:00" />
        </Separators>
    </DayPilot:DayPilotScheduler>
    
    <DayPilot:DayPilotMenu ID="DayPilotMenu2" runat="server" >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Refresh" Action="JavaScript" JavaScript="dps1.commandCallBack('refresh');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');"
            Text="NavigateUrl test" />
    </DayPilot:DayPilotMenu>
    
    <DayPilot:DayPilotMenu ID="DayPilotMenuSpecial" runat="server" ClientObjectName="cmSpecial" 
        >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (JavaScript using callback)" Action="JavaScript"
            Command='Delete' JavaScript="if (confirm('Do you really want to delete event ' + e.text() + ' ?')) dps1.eventMenuClickCallBack(e, command);">
        </DayPilot:MenuItem>
    </DayPilot:DayPilotMenu>
    
    
    <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server" >
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dps1.timeRangeSelectedCallBack(e.start, e.end, e.resource);"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
        <DayPilot:MenuItem Text="-"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Start: ' + e.start.toString() + '\nEnd: ' + e.end.toString() + '\nResource id: ' + e.resource);"
            Text="Show selection details" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dps1.clearSelection();" Text="Clean selection" />
    </DayPilot:DayPilotMenu>

    
    <DayPilot:DayPilotBubble ID="DayPilotBubble1" runat="server" OnRenderContent="DayPilotBubble1_RenderContent" ClientObjectName="bubble">
    </DayPilot:DayPilotBubble>

    <br />
    <br />
</asp:Content>
