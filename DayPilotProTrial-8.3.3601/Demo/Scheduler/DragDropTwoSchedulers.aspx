﻿<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="DragDropTwoSchedulers.aspx.cs"
    Inherits="Scheduler_DragDropTwoSchedulers" Title="Tree & Filter (Scheduler) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-nz" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">

/* DayPilotScheduler.AfterRenderJavaScript handler */

function afterRender(data, isCallBack) {
}

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
    function dialog() {
	    var modal = new DayPilot.Modal();
	    modal.top = 60;
        modal.width = 300;
        modal.opacity = 70;
        modal.border = "10px solid #d0d0d0";
        modal.closed = function() { 
            if(this.result == "OK") { 
                dps1.commandCallBack('refresh'); 
            }
            dps1.clearSelection();
        };
	
        modal.height = 250;
        modal.zIndex = 100;
        return modal;
    }

	function timeRangeSelected(start, end, resource) {
	    var modal = dialog();
	    modal.showUrl("New.aspx?start=" + start.toStringSortable() + "&end=" + end.toStringSortable() + "&r=" + resource + "&hash=<%= PageHash %>");
	}
	
	function eventClick(e) {
	    var modal = dialog();
	    modal.showUrl("Edit.aspx?id=" + e.value() + "&hash=<%= PageHash %>");
	}
	
	function eventMove(e, newStart, newEnd, newResource) {
	    if (e.calendar === dps2) {  // event source
	        dps2.eventMoveCallBack(e, newStart, newEnd, newResource);
	    }
	    else {
	        dps1.events.remove(e); // don't commit, just a client-side change
	        dps2.eventMoveCallBack(e, newStart, newEnd, newResource);
	    }
	}
	
</script>

    <div>
        
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td></td>
                <td><div style="margin-bottom: 4px;"><span id="message" style="padding:2px; background-color: #dc143c; color: White; display: none;"></span>&nbsp;</div></td>
                <td align="right"><span style="color:Gray">Try "sales" and click <b>Apply</b> or hit <b>&lt;enter&gt;</b></span></td>
            </tr>
        </table>
    </div>

    <div id="toolbar">
        <a href="javascript:dps1.commandCallBack('previous');">&#x25c4;</a>
        <a href="javascript:dps1.commandCallBack('next');">&#x25ba;</a>
        <a href="javascript:dps1.commandCallBack('this');">This Year</a>
        <div class="right">
            Fast filter: <input type="text" id="TextBoxFilter" onkeypress="return key(event);" />&nbsp;<a href="javascript:filter();" style="font-weight:bold">Apply</a>&nbsp;<a href="javascript:clear();">Clear</a>
        </div>
    </div>

    <DayPilot:DayPilotScheduler 
        ID="DayPilotScheduler1" 
        runat="server" 
        DataStartField="start" 
        DataEndField="end" 
        DataTextField="name" 
        DataIdField="id" 
        DataResourceField="column" 
        DataTagFields="id, name"
         
         
        
         
        Width="100%" 
        RowHeaderWidth="120"
        CellDuration="1440" 
        CellGroupBy="Month" 
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="timeRangeSelected(start, end, resource)"
        ClientObjectName="dps1" 
        EventMoveHandling="Notify" 
        OnEventMove="DayPilotScheduler1_EventMove" 
        EventMoveJavaScript="dps1.eventMoveCallBack(e, newStart, newEnd, newResource);"
        EventResizeHandling="Notify"
        OnEventResize="DayPilotScheduler1_EventResize"
        OnTimeRangeSelected="DayPilotScheduler1_TimeRangeSelected" 
        EventClickHandling="JavaScript"
        EventClickJavaScript="eventClick(e);"
        EventHoverHandling="Disabled"
        EventEditHandling="CallBack" 
        OnEventEdit="DayPilotScheduler1_EventEdit" 
        OnBeforeEventRender="DayPilotScheduler1_BeforeEventRender"
        OnEventMenuClick="DayPilotScheduler1_EventMenuClick" 
        ContextMenuID="DayPilotMenu2" 
        ContextMenuResourceID="DayPilotMenuRes"
        BusinessBeginsHour="5" 
        BusinessEndsHour="24"
        AfterRenderJavaScript="afterRender(data, isCallBack);" 
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
         
        EnableViewState="false" 
        ScrollLabelsVisible="false" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false"
        HeightSpec="Fixed" 
        Height="300" 
        OnCommand="DayPilotScheduler1_Command" 
        OnEventClick="DayPilotScheduler1_EventClick"
        OnTimeRangeMenuClick="DayPilotScheduler1_TimeRangeMenuClick" 
        OnBeforeCellRender="DayPilotScheduler1_BeforeCellRender"
        TreeEnabled="true"
        TreeIndent="15"
        EventDoubleClickHandling="Edit"
        
        ResourceBubbleID="DayPilotBubble1"
        
        
         
        OnResourceHeaderMenuClick="DayPilotScheduler1_ResourceHeaderMenuClick"
         
         
        OnBeforeTimeHeaderRender="DayPilotScheduler1_BeforeTimeHeaderRender"
        ContextMenuSelectionID="DayPilotMenuSelection"
        
        SyncResourceTree="true" 
        DragOutAllowed="true"
        >
        <Resources>
            <DayPilot:Resource Name="Room A" Id="A" Expanded="True">
                <Children>
                    <DayPilot:Resource Name="Room A.1" Id="A1" Expanded="False" >
                        <Children>
                            <DayPilot:Resource Name="Room A.1.1" Id="A11" Expanded="False" />
                            <DayPilot:Resource Name="Room A.1.2" Id="A12" Expanded="False" />
                        </Children>
                    </DayPilot:Resource>
                    <DayPilot:Resource Name="Room A.2" Id="A2" Expanded="False" />
                </Children>
            </DayPilot:Resource>
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
 
    <div style="margin-top:20px;"></div>
     <DayPilot:DayPilotScheduler 
        ID="DayPilotScheduler2" 
        runat="server" 
        DataStartField="start" 
        DataEndField="end" 
        DataTextField="name" 
        DataIdField="id" 
        DataResourceField="column" 
        DataTagFields="id, name"
         
         
        
         
        Width="100%" 
        RowHeaderWidth="120"
        CellDuration="1440" 
        CellGroupBy="Month" 
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="timeRangeSelected(start, end, resource)"
        ClientObjectName="dps2" 
        EventMoveHandling="JavaScript" 
        OnEventMove="DayPilotScheduler2_EventMove" 
        EventMoveJavaScript="eventMove(e, newStart, newEnd, newResource);"
        EventResizeHandling="Notify"
        OnEventResize="DayPilotScheduler1_EventResize"
        OnTimeRangeSelected="DayPilotScheduler1_TimeRangeSelected" 
        EventClickHandling="JavaScript"
        EventClickJavaScript="eventClick(e);"
        EventHoverHandling="Disabled"
        EventEditHandling="CallBack" 
        OnEventEdit="DayPilotScheduler1_EventEdit" 
        OnBeforeEventRender="DayPilotScheduler1_BeforeEventRender"
        OnEventMenuClick="DayPilotScheduler1_EventMenuClick" 
        ContextMenuID="DayPilotMenu2" 
        ContextMenuResourceID="DayPilotMenuRes"
        BusinessBeginsHour="5" 
        BusinessEndsHour="24"
        AfterRenderJavaScript="afterRender(data, isCallBack);" 
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
         
        EnableViewState="false" 
        ScrollLabelsVisible="false" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false"
        HeightSpec="Fixed" 
        Height="300" 
        OnCommand="DayPilotScheduler1_Command" 
        OnEventClick="DayPilotScheduler1_EventClick"
        OnTimeRangeMenuClick="DayPilotScheduler1_TimeRangeMenuClick" 
        OnBeforeCellRender="DayPilotScheduler1_BeforeCellRender"
        TreeEnabled="true"
        TreeIndent="15"
        EventDoubleClickHandling="Edit"
        
        ResourceBubbleID="DayPilotBubble1"
        
        
         
        OnResourceHeaderMenuClick="DayPilotScheduler1_ResourceHeaderMenuClick"
         
         
        OnBeforeTimeHeaderRender="DayPilotScheduler1_BeforeTimeHeaderRender"
        ContextMenuSelectionID="DayPilotMenuSelection"
        
        SyncResourceTree="true" 
        DragOutAllowed="true"
        >
        <Resources>
            <DayPilot:Resource Name="Room A" Value="A" Expanded="True"></DayPilot:Resource>
            <DayPilot:Resource Name="Room B" Value="B" Expanded="False" />
            <DayPilot:Resource Name="Room C" Value="C" ToolTip="Test" Expanded="False" />
       </Resources>
    </DayPilot:DayPilotScheduler>
    
    <p>Drag items from this list to the calendar:</p>
    <ul style="font-weight:bold;">
        <li><span onmousedown='return DayPilotScheduler.dragStart(this.parentNode, 60*30, "123", this.innerHTML);' style="cursor:move;" unselectable='on'>Item #123 (30 minutes)</span></li>
        <li><span onmousedown='return DayPilotScheduler.dragStart(this.parentNode, 24*60*60, "124", this.innerHTML);' style="cursor:move;" unselectable='on'>Item #124 (1 day)</span></li>
    </ul>

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
    
    <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server"  >
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dps1.timeRangeSelectedCallBack(e.start, e.end, e.resource);"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
        <DayPilot:MenuItem Text="-" Action="JavaScript"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Start: ' + e.start + '\nEnd: ' + e.end + '\nResource id: ' + e.resource);"
            Text="Show selection details" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dps1.clearSelection();" Text="Clean selection" />
    </DayPilot:DayPilotMenu>

    <DayPilot:DayPilotMenu ID="DayPilotMenuRes" runat="server"  >
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Add child" />
        <DayPilot:MenuItem Text="-" Action="JavaScript"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="CallBack" Command="Delete" Text="Delete" />
        <DayPilot:MenuItem Action="CallBack" Command="DeleteChildren" Text="Delete children" />
        <DayPilot:MenuItem Text="-" Action="JavaScript"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert(e.name + '\n' + e.value);"
            Text="Show resource details" />
    </DayPilot:DayPilotMenu>

    
    <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble" 
        OnRenderEventBubble="DayPilotBubble1_RenderEventBubble"
        Width="250"
        
        Corners="Rounded"
        >
    </DayPilot:DayPilotBubble>

    <br />
    <br />
</asp:Content>
