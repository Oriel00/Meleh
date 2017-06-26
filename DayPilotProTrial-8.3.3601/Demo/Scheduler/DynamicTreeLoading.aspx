<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="DynamicTreeLoading.aspx.cs"
    Inherits="Scheduler_DynamicTreeLoading" Title="Dynamic Tree Loading (Scheduler) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="note">
        <b>Note:</b> The child tree nodes are loaded dynamically from the server (click the [+] icon).
        Read more about the <a href="http://doc.daypilot.org/scheduler/dynamic-tree-loading/">dynamic tree loading</a> [doc.daypilot.org].
    </div>

    <div class="note"><a href="javascript:dps1.commandCallBack('deletechildren');">Delete children</a></div>

    <DayPilot:DayPilotScheduler ID="DayPilotScheduler1" runat="server" 
        DataStartField="start" DataEndField="end" DataTextField="name" DataIdField="id" DataTagFields="id, name"
          DataResourceField="column" 
         Width="100%" RowHeaderWidth="120" CellDuration="1440" CellGroupBy="Month" TimeRangeSelectedHandling="Hold"
        ClientObjectName="dps1" 
        EventMoveHandling="CallBack" EventMoveJavaScript="alert(e.row())" EventResizeHandling="CallBack"
        OnEventMove="DayPilotScheduler1_EventMove" OnEventResize="DayPilotScheduler1_EventResize"
        OnTimeRangeSelected="DayPilotScheduler1_TimeRangeSelected" EventClickHandling="Edit"
        EventEditHandling="CallBack" OnEventEdit="DayPilotScheduler1_EventEdit" OnBeforeEventRender="DayPilotScheduler1_BeforeEventRender"
        OnEventMenuClick="DayPilotScheduler1_EventMenuClick" ContextMenuID="DayPilotMenu2" BusinessBeginsHour="5" 
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
         EnableViewState="false" ScrollLabelsVisible="false" 
        BubbleID="DayPilotBubble1" xCellBubbleID="DayPilotBubble1" ShowToolTip="false"
        HeightSpec="Max" Height="200" EventClickJavaScript="alert(e.start() + '\n' + e.end());"
        OnCommand="DayPilotScheduler1_Command" OnEventClick="DayPilotScheduler1_EventClick"
        ContextMenuSelectionID="DayPilotMenuSelection" OnTimeRangeMenuClick="DayPilotScheduler1_TimeRangeMenuClick" OnBeforeCellRender="DayPilotScheduler1_BeforeCellRender"
        TreeEnabled="true"
        TreeIndent="15" 
        OnLoadNode="DayPilotScheduler1_LoadNode"
        OnResourceHeaderClick="DayPilotScheduler1_OnResourceHeaderClick"

        >
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
