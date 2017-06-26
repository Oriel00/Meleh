<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="EventMoveToPosition.aspx.cs"
    Inherits="Month_EventMoveToPosition" Title="Move Event to Position | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div class="note"><b>Note:</b> Read more about moving events to a <a href="http://doc.daypilot.org/month/event-position/">specific position inside a cell</a> [doc.daypilot.org].</div>
    
    <DayPilot:DayPilotMonth 
        ID="DayPilotMonth1" 
        runat="server" 
        DataEndField="end" 
        DataStartField="start"
        DataTextField="name" 
        DataIdField="id" 
        DataTagFields="name, id" 
        EventClickHandling="Bubble"
        EventClickJavaScript="alert(e.text());" 
        ContextMenuID="DayPilotMenu1" 
        OnEventMenuClick="DayPilotCalendar1_EventMenuClick"
        ClientObjectName="dpm" 
        EventMoveHandling="CallBack"
        OnEventMove="DayPilotMonth1_EventMove"
        Width="100%" 
        EventResizeHandling="CallBack" 
        OnEventResize="DayPilotMonth1_EventResize"
        OnTimeRangeSelected="DayPilotMonth1_TimeRangeSelected"
        TimeRangeSelectedHandling="JavaScript" 
        OnBeforeEventRender="DayPilotMonth1_BeforeEventRender" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false" 
        EventStartTime="false" 
        EventEndTime="false" 
        OnCommand="DayPilotMonth1_Command" 
                    
        OnBeforeCellRender="DayPilotMonth1_BeforeCellRender" 
        OnEventClick="DayPilotMonth1_EventClick" 
        HeaderClickHandling="JavaScript"
        ContextMenuSelectionID="DayPilotMenuSelection"
                    
        TimeRangeDoubleClickHandling="JavaScript"
        TimeRangeDoubleClickJavaScript="alert('doubleclick:' + start)"
        EventMoveToPosition="true"
        >
    </DayPilot:DayPilotMonth>

    <DayPilot:DayPilotMenu ID="DayPilotMenu1" runat="server" >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');"
            Text="NavigateUrl test" />
    </DayPilot:DayPilotMenu>

    <DayPilot:DayPilotMenu ID="DayPilotMenu2" runat="server" ClientObjectName="menu2"  >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');"
            Text="NavigateUrl test" />
    </DayPilot:DayPilotMenu>
    
    
    <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server" >
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dpm.timeRangeSelectedCallBack(e.start, e.end);"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
        <DayPilot:MenuItem Text="-" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Start: ' + e.start.toString() + '\nEnd: ' + e.end.toString())"
            Text="Show selection details" />
    </DayPilot:DayPilotMenu>
    
        <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble"

        Position="EventTop"
        
        

        >
    </DayPilot:DayPilotBubble>
    

</asp:Content>
