<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="GoogleLike.aspx.cs" Inherits="Calendar_GoogleLike" Title="Google-Like Style (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">

function afterRender(data) {
    if (data) {
        var text = data.message ? (data.message + " (id " + data.id + ")") : data;
        var img = "<img src='../media/ajax-loader-black.gif' />";
        dpc1.message(text, 1000, "#333333", "#fabd54", 5000); //#ff9525, #c00000
    }
}

	function createEvent(start, end, resource) {
	    var modal = new DayPilot.Modal();
	    modal.top = 60;
        modal.width = 300;
        modal.opacity = 0;
        modal.border = "1px solid #d0d0d0";
        modal.closed = function() { 
            if(this.result == "OK") { 
                dpc1.commandCallBack('refresh'); 
            }
            dpc1.clearSelection();
        };
	
        modal.height = 250;
	    modal.showUrl("New.aspx?start=" + start.toStringSortable() + "&end=" + end.toStringSortable());
	}

</script>

<div class="note"><b>Note:</b> You can create a theme using the online <strong>DayPilot Theme Designer</strong>: <a href="http://themes.daypilot.org/">http://themes.daypilot.org/</a></div>

    <table style="width:100%">
        <tr>
            <td valign="top" style="width:150px">
                <DayPilot:DayPilotNavigator ID="DayPilotNavigator1" runat="server" 
                    BoundDayPilotID="DayPilotCalendar1" 
                    SelectMode="Week"
                    ShowMonths="3"
                    Theme="navigator_g"
                    DataStartField="start"
                    DataEndField="end" 
                    VisibleRangeChangedHandling="CallBack"
                    OnVisibleRangeChanged="DayPilotNavigator1_VisibleRangeChanged"
                    ></DayPilot:DayPilotNavigator>
                <br />
                <br />
                <div style="height:20px"></div>        
            </td>
            <td valign="top">
                <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
                    datastartfield="start" dataendfield="end" datatextfield="name" DataIdField="id" 
                    datatagfields="name, id"
                    DataAllDayField="allday"
                    OnEventMove="DayPilotCalendar1_EventMove" 
                    Days="7" 
                    OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected" 
                    TimeRangeSelectedHandling="JavaScript"
                    TimeRangeSelectedJavaScript="createEvent(start, end)" 
                    EventMoveHandling="CallBack" 
                    ContextMenuID="DayPilotMenu1" 
                    OnEventMenuClick="DayPilotCalendar1_EventMenuClick" 
                    EventResizeHandling="CallBack" 
                    OnEventResize="DayPilotCalendar1_EventResize" 
                    EventClickHandling="Bubble" 
                    EventClickJavaScript="alert('This is a custom click handler. Double-click the event to edit its name inline.');"
                    EventSelectHandling="CallBack"
                    HeightSpec="BusinessHours" 
                    OnEventClick="DayPilotCalendar1_EventClick" 
                    ClientObjectName="dpc1" 
                    EventEditHandling="CallBack" 
                    OnEventEdit="DayPilotCalendar1_EventEdit" 
                    OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender" 
                    EventDeleteHandling="Disabled" 
                    OnEventDelete="DayPilotCalendar1_EventDelete" 
                    EventDeleteJavaScript="if (confirm('Do you really want to delete ' + e.text() + ' ?')) dpc1.eventDeleteCallBack(e);" 
                    OnEventSelect="DayPilotCalendar1_EventSelect" 
                    EventSelectColor="Blue"
                    Showalldayevents="True"
                     
                    AfterRenderJavaScript="afterRender(data);" 
                    OnBeforeHeaderRender="DayPilotCalendar1_BeforeHeaderRender" 
                    BubbleID="DayPilotBubble1" 
                    ShowToolTip="False" 
                    EventDoubleClickHandling="Edit"
                    EventHoverHandling="Disabled" 
                    TimeRangeDoubleClickHandling="CallBack"        
                    TimeFormat="Auto" OnTimeRangeDoubleClick="DayPilotCalendar1_TimeRangeDoubleClick"
                    ContextMenuSelectionID="DayPilotMenuSelection" 
                    OnTimeRangeMenuClick="DayPilotCalendar1_TimeRangeMenuClick" 
                    OnCommand="DayPilotCalendar1_Command" 
                    
                    ScrollLabelsVisible="false"
                    DurationBarVisible="false"
                    OnBeforeCellRender="DayPilotCalendar1_BeforeCellRender"

                    Theme="calendar_g"                    
                    EventCorners="Rounded"
                    
                    ShowAllDayEventStartEnd="false"
                    LoadingLabelText="<img src='../Media/linked/ajax-loader-round.gif' />"
                    LoadingLabelBackColor=""
                    EventArrangement="Cascade"
                    EventHeaderVisible="true"
                    ShowEventStartEnd="false"
                    ></daypilot:daypilotcalendar>
                    <br />
            
            </td>
        </tr>
    </table>

        <div>
            <br />
            <br />
            <br />
        </div>

    <daypilot:daypilotmenu id="DayPilotMenu1" runat="server" >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');" ></DayPilot:MenuItem>
        
        <DayPilot:MenuItem Text="-" Action="NavigateUrl" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');" Text="NavigateUrl test" />
    </daypilot:daypilotmenu>
        <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server" >
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dpc1.timeRangeSelectedCallBack(e.start, e.end, e.resource); dpc1.clearSelection();"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
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
        HideAfter="0"
        >
    </DayPilot:DayPilotBubble>
    <br />
</asp:Content>

