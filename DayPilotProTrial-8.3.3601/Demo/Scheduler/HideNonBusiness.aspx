<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="HideNonBusiness.aspx.cs"
    Inherits="Scheduler_HideNonBusiness" Title="Hide Non-Business Hours (Scheduler) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">

/* Fast filter helpers */

function clear() {
    var filterBox = document.getElementById("TextBoxFilter");
    filterBox.value = '';
    filter();
}
function filter() {
    var filterBox = document.getElementById("TextBoxFilter");
    var filterText = filterBox.value;
    
    dps1.clientState = {"filter": filterText};
    dps1.commandCallBack("filter");
}

function key(e) {
    var keynum  = (window.event) ? event.keyCode : e.keyCode;

    if (keynum === 13) {
        filter();
        return false;
    }

    return true;     
}

/* Event editing helpers - modal dialog */
	function createEvent(start, end, resource) {
	    var modal = new DayPilot.Modal();
	    modal.top = 60;
        modal.width = 300;
        modal.opacity = 60;
        modal.border = "1px solid black";
        modal.closed = function() { 
            if(this.result == "OK") { 
                dps1.commandCallBack('refresh'); 
            }
        };
	
        modal.height = 250;
	    modal.showUrl("New.aspx?start=" + start.toStringSortable() + "&end=" + end.toStringSortable() + "&r=" + resource + "&hash=<%= PageHash %>");
	}
</script>

<div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/scheduler/hiding-non-business-hours/">hiding non-business hours</a> in the scheduler [doc.daypilot.org].</div>

    <DayPilot:DayPilotScheduler 
        ID="DayPilotScheduler1" 
        runat="server" 
        DataStartField="start" 
        DataEndField="end" 
        DataTextField="name" 
        DataIdField="id" 
        DataResourceField="column" 
        DataTagFields="id, name"
        
        CellGroupBy="Month"
         
        Width="100%" 
        RowHeaderWidth="120" 
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="createEvent(start, end, resource)"
        ClientObjectName="dps1" 
        EventMoveHandling="CallBack" 
        OnEventMove="DayPilotScheduler1_EventMove" 
        EventResizeHandling="CallBack"
        OnEventResize="DayPilotScheduler1_EventResize"
        OnTimeRangeSelected="DayPilotScheduler1_TimeRangeSelected" 
        EventClickHandling="JavaScript"
        EventEditHandling="CallBack" 
        OnEventEdit="DayPilotScheduler1_EventEdit" 
        OnBeforeEventRender="DayPilotScheduler1_BeforeEventRender"
        OnEventMenuClick="DayPilotScheduler1_EventMenuClick" 
        ContextMenuID="DayPilotMenu2" 
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
         
        EnableViewState="false" 
        ScrollLabelsVisible="false" 
        BubbleID="DayPilotBubble1" 
        xCellBubbleID="DayPilotBubble1" 
        ShowToolTip="false"
        HeightSpec="Fixed" 
        Height="300" 
        OnCommand="DayPilotScheduler1_Command" 
        OnEventClick="DayPilotScheduler1_EventClick"
        ContextMenuSelectionID="DayPilotMenuSelection" 
        OnTimeRangeMenuClick="DayPilotScheduler1_TimeRangeMenuClick" 
        OnBeforeCellRender="DayPilotScheduler1_BeforeCellRender"
        EventDoubleClickHandling="Edit"
        OnBeforeTimeHeaderRender="DayPilotScheduler1_BeforeTimeHeaderRender"
        
        Scale="Hour"
        BusinessBeginsHour="9" 
        BusinessEndsHour="18"
        ShowNonBusiness="false" 
        OnIncludeCell="DayPilotScheduler1_IncludeCell"
        CellWidth="40"                    
        
        >
        <TimeHeaders>
            <DayPilot:TimeHeader GroupBy="Month"/>
            <DayPilot:TimeHeader GroupBy="Day" Format="d"/>
            <DayPilot:TimeHeader GroupBy="Cell"/>
        </TimeHeaders>
        <Resources>
            <DayPilot:Resource Name="Room A" Id="A" Expanded="True" />
            <DayPilot:Resource Name="Room B" Id="B" Expanded="False" />
            <DayPilot:Resource Name="Room C" Id="C" ToolTip="Test" Expanded="False" />
            <DayPilot:Resource Name="Room D" Id="D" Expanded="False" />
            <DayPilot:Resource Name="Room E" Id="E" Expanded="False" />
            <DayPilot:Resource Name="Room F" Id="F" Expanded="False" />
            <DayPilot:Resource Name="Room G" Id="G" Expanded="False" />
            <DayPilot:Resource Name="Room H" Id="H" Expanded="False" />
            <DayPilot:Resource Name="Room I" Id="I" Expanded="False" />
            <DayPilot:Resource Name="Room J" Id="J" Expanded="False" />
            <DayPilot:Resource Name="Room K" Id="K" Expanded="False" />
            <DayPilot:Resource Name="Room L" Id="L" Expanded="False" />
            <DayPilot:Resource Name="Room M" Id="M" Expanded="False" />
            <DayPilot:Resource Name="Room N" Id="N" Expanded="False" />
            <DayPilot:Resource Name="Room O" Id="O" Expanded="False" />
            <DayPilot:Resource Name="Room P" Id="P" Expanded="False" />
            <DayPilot:Resource Name="Room Q" Id="Q" Expanded="False" />
            <DayPilot:Resource Name="Room R" Id="R" Expanded="False" />
            <DayPilot:Resource Name="Room S" Id="S" Expanded="False" />
            <DayPilot:Resource Name="Room T" Id="T" Expanded="False" />
            <DayPilot:Resource Name="Room U" Id="U" Expanded="False" />
            <DayPilot:Resource Name="Room V" Id="V" Expanded="False" />
            <DayPilot:Resource Name="Room W" Id="W" Expanded="False" />
            <DayPilot:Resource Name="Room X" Id="X" Expanded="False" />
            <DayPilot:Resource Name="Room Y" Id="Y" Expanded="False" />
            <DayPilot:Resource Name="Room Z" Id="Z" Expanded="False" />
       </Resources>
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
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('x:' + dps1.eventOffset.x + ' y:' + dps1.eventOffset.y + ' resource:' + e.row());" Text="Mouse offset (relative to event)" />
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

    
    <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble" OnRenderEventBubble="DayPilotBubble1_RenderEventBubble"
        >
    </DayPilot:DayPilotBubble>

    <br />
    <br />
</asp:Content>
