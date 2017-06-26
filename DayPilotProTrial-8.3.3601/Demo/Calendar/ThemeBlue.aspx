<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="ThemeBlue.aspx.cs"
Inherits="Calendar_ThemeBlue" Title="Blue Theme (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">

// required for copy'n'paste functionality
var copied = null;

/* Event editing helpers - modal dialog */
    function dialog() {
	    var modal = new DayPilot.Modal();
	    modal.top = 60;
        modal.width = 300;
        modal.opacity = 70;
        modal.border = "10px solid #d0d0d0";
        modal.closed = function() { 
            if(this.result == "OK") { 
                dpc1.commandCallBack('refresh'); 
            }
            dpc1.clearSelection();
        };
	
        modal.height = 250;
        modal.zIndex = 100;
        return modal;
    }

	function create(start, end, resource) {
	    var modal = dialog();
	    modal.showUrl("New.aspx?start=" + start.toStringSortable() + "&end=" + end.toStringSortable() + "&r=" + resource);
	}
	
	function edit(e) {
	    var modal = dialog();
	    modal.showUrl("Edit.aspx?id=" + e.value());
	}
	
	function afterRender(isCallBack) {
	    dpn.visibleRangeChangedCallBack();
	}

</script>

    <div class="note"><b>Note:</b> You can create a theme using the online <strong>DayPilot Theme Designer</strong>: <a href="http://themes.daypilot.org/">http://themes.daypilot.org/</a></div>

    <div class="calendar_blue_wrap"><div class="calendar_blue_wrap_inner">
    <table style="width:100%;">
        <tr>
            <td valign="top" style="width:160px; background-color: #fff;">
                <DayPilot:DayPilotNavigator ID="DayPilotNavigator1" runat="server" 
                    ClientObjectName="dpn"
                    BoundDayPilotClientObjectName="dpc1" 
                    SelectMode="Week"
                    ShowMonths="3"
                    SkipMonths="3"
                    Theme="navigator_blue"
                    DataStartField="start"
                    DataEndField="end" 
                    VisibleRangeChangedHandling="CallBack"
                    OnVisibleRangeChanged="DayPilotNavigator1_VisibleRangeChanged"
                    ShowWeekNumbers="true" 
                    OnTimeRangeSelected="DayPilotNavigator1_TimeRangeSelected"
                    OnBeforeCellRender="DayPilotNavigator1_BeforeCellRender"
                    ></DayPilot:DayPilotNavigator>
            </td>
            <td valign="top" style="width:10px;">
            </td>
            <td valign="top" style="background-color: #fff;">
                <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
                    datastartfield="start" dataendfield="end" datatextfield="name" DataIdField="id" 
                    dataservertagfields="color"
                    DataAllDayField="allday"
                    OnEventMove="DayPilotCalendar1_EventMove" 
                    ViewType="Week" 
                    OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected" 
                    TimeRangeSelectedHandling="JavaScript" 
                    TimeRangeSelectedJavaScript="alert(start.toStringSortable() + '-' + end.toStringSortable())"
                    EventMoveHandling="CallBack" 
                    ContextMenuID="DayPilotMenu1" 
                    OnEventMenuClick="DayPilotCalendar1_EventMenuClick" 
                    EventResizeHandling="CallBack" 
                    OnEventResize="DayPilotCalendar1_EventResize" 
                    EventClickHandling="JavaScript" 
                    EventClickJavaScript="edit(e);"
                    EventSelectHandling="JavaScript"
                    xHeightSpec="BusinessHours" 
                    OnEventClick="DayPilotCalendar1_EventClick" 
                    ClientObjectName="dpc1" 
                    EventEditHandling="CallBack" 
                    OnEventEdit="DayPilotCalendar1_EventEdit" 
                    OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender" 
                    EventDeleteHandling="JavaScript" 
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
                    AfterRenderJavaScript="afterRender(isCallBack);"
                    
                    Theme="calendar_blue"
                    
                    CellHeight="25"
                    HourWidth="60"
                    

                    ></daypilot:daypilotcalendar>
                
            </td>
        </tr>
    </table>
    </div></div>
    
    <daypilot:daypilotmenu id="DayPilotMenu1" runat="server"  ShowMenuTitle="true">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="edit(e);" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() +')');" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Copy" Action="JavaScript" JavaScript="copied = e.value();" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete" Image='../Media/linked/menu_delete.png' />
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
        Position="EventTop"
        
        
        >
    </DayPilot:DayPilotBubble>
    <br />
    
</asp:Content>

