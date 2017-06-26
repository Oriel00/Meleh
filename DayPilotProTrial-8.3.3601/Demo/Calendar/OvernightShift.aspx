<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="OvernightShift.aspx.cs"
Inherits="Calendar_OvernightShift" Title="Overnight Shift (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">

// required for copy'n'paste functionality
var copied = null;

</script>

<div class="note">
    <b>Note: </b> Each calendar column displays time from 4 pm to 7 am the following day. Read more about the <a href="http://doc.daypilot.org/calendar/overnight-scheduling/">overnight scheduling</a> [doc.daypilot.org].
</div>

    <table style="width:100%; text-align:center;">
        <tr>
            <td valign="top" style="width:150px">
                <DayPilot:DayPilotNavigator ID="DayPilotNavigator1" runat="server" 
                    ClientObjectName="dpn"
                    BoundDayPilotClientObjectName="dpc1" 
                    SelectMode="Week"
                    ShowMonths="3"
                    SkipMonths="3"
                    
                    DataStartField="start"
                    DataEndField="end" 
                    VisibleRangeChangedHandling="CallBack"
                    OnVisibleRangeChanged="DayPilotNavigator1_VisibleRangeChanged"
                    ShowWeekNumbers="true" 
                    OnTimeRangeSelected="DayPilotNavigator1_TimeRangeSelected"
                    ></DayPilot:DayPilotNavigator>
                <br />
                <br />
                <div style="height:20px"></div>        
            </td>
            <td valign="top">
                <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
                    datastartfield="start" dataendfield="end" datatextfield="name" DataIdField="id" 
                    dataservertagfields="color"
                    DataAllDayField="allday"
                    OnEventMove="DayPilotCalendar1_EventMove" 
                    ViewType="Week" 
                    OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected" 
                    TimeRangeSelectedHandling="JavaScript" 
                    TimeRangeSelectedJavaScript="alert(start.toStringSortable())"
                    EventMoveHandling="CallBack" 
                    ContextMenuID="DayPilotMenu1" 
                    OnEventMenuClick="DayPilotCalendar1_EventMenuClick" 
                    EventResizeHandling="CallBack" 
                    OnEventResize="DayPilotCalendar1_EventResize" 
                    EventClickHandling="JavaScript" 
                    EventSelectHandling="JavaScript"
                    xHeightSpec="BusinessHours" 
                    OnEventClick="DayPilotCalendar1_EventClick" 
                    ClientObjectName="dpc1" 
                    EventEditHandling="CallBack" 
                    OnEventEdit="DayPilotCalendar1_EventEdit" 
                    OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender" 
                    EventDeleteHandling="CallBack" 
                    OnEventDelete="DayPilotCalendar1_EventDelete" 
                    EventDeleteJavaScript="if (confirm('Do you really want to delete ' + e.text() + ' ?')) dpc1.eventDeleteCallBack(e);" 
                    OnEventSelect="DayPilotCalendar1_EventSelect" 
                    EventSelectColor="red"
                    Showalldayevents="True"
                     
                    OnBeforeHeaderRender="DayPilotCalendar1_BeforeHeaderRender" 
                    ShowToolTip="false" 
                    EventDoubleClickHandling="Edit"
                    EventDoubleClickJavaScript="alert(e.value());"
                    EventHoverHandling="Bubble" 
                    TimeRangeDoubleClickHandling="CallBack"        
                    TimeFormat="Auto" OnTimeRangeDoubleClick="DayPilotCalendar1_TimeRangeDoubleClick"
                    ContextMenuSelectionID="DayPilotMenuSelection" 
                    OnTimeRangeMenuClick="DayPilotCalendar1_TimeRangeMenuClick" 
                    OnCommand="DayPilotCalendar1_Command" 
                    OnBeforeCellRender="DayPilotCalendar1_BeforeCellRender"
                    
                    EventArrangement="Full"
                    
                    BubbleID="DayPilotBubble1"
                    ColumnBubbleID="DayPilotBubble1"
                    
                    OnBeforeTimeHeaderRender="DayPilotCalendar1_BeforeTimeHeaderRender"
                    DayBeginsHour="16"
                    DayEndsHour="8"
                    
                    BusinessBeginsHour="20"
                    BusinessEndsHour="5"
                    
                    HideFreeCells="true"
                    ></daypilot:daypilotcalendar>
                    <br />
                
            </td>
        </tr>
    </table>
    
    <daypilot:daypilotmenu id="DayPilotMenu1" runat="server"  ShowMenuTitle="true">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() +')');" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() +')');" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Copy" Action="JavaScript" JavaScript="copied = e.value();" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete" Image='../Media/linked/menu_delete.png' ></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" Image='../Media/linked/menu_delete.png' />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');" Text="NavigateUrl test" />
    </daypilot:daypilotmenu>
    <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server" >
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dpc1.timeRangeSelectedCallBack(e.start, e.end, e.resource); dpc1.clearSelection();"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
        <DayPilot:MenuItem Text="-" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="if (!copied) { alert('You need to copy an event first.'); return; } dpc1.commandCallBack('paste', {id:copied, start: e.start});" Text="Paste" />
        <DayPilot:MenuItem Text="-" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Start: ' + e.start.toString() + '\nEnd: ' + e.end.toString() + '\nResource id: ' + e.resource);"
            Text="Show selection details" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dpc1.clearSelection();"
            Text="Clean selection" />
    </DayPilot:DayPilotMenu>

    <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble"
        ShowLoadingLabel="true"
        HideAfter="500"
        Corners="Rounded"
        >
    </DayPilot:DayPilotBubble>
    <br />
    
</asp:Content>

