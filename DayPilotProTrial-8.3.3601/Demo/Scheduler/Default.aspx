﻿<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="Scheduler_Default" Title="ASP.NET Scheduler | DayPilot Pro for ASP.NET WebForms Demo"  Culture="en-us" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">

    /* Event editing helpers - modal dialog */
    function dialog() {
	    var modal = new DayPilot.Modal();
	    modal.onClosed = function (args) {
	        window.console && console.log(args);
            if(args.result == "OK") { 
                dps1.commandCallBack('refresh'); 
            }
            dps1.clearSelection();
        };
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

	function onEventMoving(args) {
	    var dp = dps1;
        if (args.resource === "C") {
            var except = args.e.data;
            var events = dp.rows.find(args.resource).events.all();

            var start = args.start;
            var end = args.end;
            var overlaps = events.some(function (item) {
                return item.data !== except && DayPilot.Util.overlaps(item.start(), item.end(), start, end);
            });

            while (overlaps) {
                start = start.addDays(1);
                end = end.addDays(1);

                overlaps = events.some(function (item) {
                    return item.data !== except && DayPilot.Util.overlaps(item.start(), item.end(), start, end);
                });
            }

            if (args.start !== start) {
                args.start = start;
                args.end = end;

                args.left.enabled = false;
                args.right.html = "Start automatically moved to " + args.start.toString("d MMMM, yyyy");
            }

        }

    }

</script>

	<div class="note"><b>Note:</b> Read more about DayPilot <a href="http://www.daypilot.org/scheduler/">ASP.NET scheduler control</a>.</div>
        
    <DayPilot:DayPilotScheduler 
        ID="DayPilotScheduler1" 
        runat="server" 
        DataStartField="start" 
        DataEndField="end" 
        DataTextField="name" 
        DataIdField="id" 
        DataResourceField="column" 
        DataTagFields="id, name"
        RowHeaderWidth="120"
        Scale="Day"
        CellWidth="60"
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="timeRangeSelected(start, end, resource)"        
        ClientObjectName="dps1" 
        EventMoveHandling="Notify" 
        OnEventMove="DayPilotScheduler1_EventMove" 
        EventMoveJavaScript="dps1.eventMoveCallBack(e, newStart, newEnd, newResource);"
        EventResizeHandling="Notify"
        OnEventResize="DayPilotScheduler1_EventResize"
        OnTimeRangeSelected="DayPilotScheduler1_TimeRangeSelected" 
        EventClickHandling="Edit"        
        EventClickJavaScript="eventClick(e);"
        EventEditHandling="Notify" 
        OnEventEdit="DayPilotScheduler1_EventEdit" 
        OnBeforeEventRender="DayPilotScheduler1_BeforeEventRender"
        OnEventMenuClick="DayPilotScheduler1_EventMenuClick" 
        ContextMenuID="DayPilotMenu2" 
        ContextMenuResourceID="DayPilotMenuRes"
        BusinessBeginsHour="5" 
        BusinessEndsHour="24"
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
         
        EnableViewState="false" 
        ScrollLabelsVisible="false" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false"
        HeightSpec="Max" 
        Height="500" 
        OnCommand="DayPilotScheduler1_Command" 
        OnEventClick="DayPilotScheduler1_EventClick"
        OnTimeRangeMenuClick="DayPilotScheduler1_TimeRangeMenuClick" 
        OnBeforeCellRender="DayPilotScheduler1_BeforeCellRender"
        TreeEnabled="true"
        TreeIndent="15"
        EventDoubleClickHandling="Edit"
        
        xResourceBubbleID="DayPilotBubble1"
        
        OnResourceHeaderMenuClick="DayPilotScheduler1_ResourceHeaderMenuClick"
        OnBeforeTimeHeaderRender="DayPilotScheduler1_BeforeTimeHeaderRender"
        ContextMenuSelectionID="DayPilotMenuSelection"
        
        SyncResourceTree="true" 
        DragOutAllowed="true"
        
        TimeRangeDoubleClickHandling="JavaScript"
        TimeRangeDoubleClickJavaScript="alert('double click');"
        DurationBarVisible="true"
        TimeHeaderClickHandling="Disabled"
        OnTimeHeaderClick="DayPilotScheduler1_TimeHeaderClick"
        
        TreePreventParentUsage="true"
        TreeImageMarginLeft="3"
        TreeImageMarginTop="6"
        CellGroupBy="Month"
        
        EventMovingStartEndEnabled="true"
        EventResizingStartEndEnabled="true"
        TimeRangeSelectingStartEndEnabled="true"
        EventTapAndHoldHandling="ContextMenu"
        EventMovingJavaScript="onEventMoving(args);"
        
        >
        <Resources>
            <DayPilot:Resource Name="Locations" Id="GroupLocations" Expanded="true" >
                <Children>
                    <DayPilot:Resource Name="Room 1" Id="A" Expanded="False" />
                    <DayPilot:Resource Name="Room 2" Id="B" Expanded="False" />
                    <DayPilot:Resource Name="Room 3" Id="C" Expanded="False" />
                    <DayPilot:Resource Name="Room 4" Id="D" Expanded="False" />
                </Children>
            </DayPilot:Resource>
            <DayPilot:Resource Name="People" Id="GroupPeople" Expanded="True">
                <Children>
                <DayPilot:Resource Name="Person 1" Id="E" Expanded="False" />
                <DayPilot:Resource Name="Person 2" Id="F" ToolTip="Test" Expanded="False" />
                <DayPilot:Resource Name="Person 3" Id="G" ToolTip="Test" Expanded="False" />
                <DayPilot:Resource Name="Person 4" Id="H" ToolTip="Test" Expanded="False" />
                </Children>
            </DayPilot:Resource>
            <DayPilot:Resource Name="Tools" Id="GroupTools" Expanded="True">
                <Children>
                <DayPilot:Resource Name="Tool 1" Id="I" Expanded="False" />
                <DayPilot:Resource Name="Tool 2" Id="J" ToolTip="Test" Expanded="False" />
                <DayPilot:Resource Name="Tool 3" Id="K" ToolTip="Test" Expanded="False" />
                <DayPilot:Resource Name="Tool 4" Id="L" ToolTip="Test" Expanded="False" />
                </Children>
            </DayPilot:Resource>
       </Resources>
    </DayPilot:DayPilotScheduler>
       
    <DayPilot:DayPilotMenu ID="DayPilotMenu2" runat="server">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Refresh" Action="JavaScript" JavaScript="dps1.commandCallBack('refresh');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="More">
            <DayPilot:MenuItem Text="Export" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');"></DayPilot:MenuItem>
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('x:' + dps1.eventOffset.x + ' y:' + dps1.eventOffset.y + ' resource:' + e.row());" Text="Mouse offset (relative to event)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');" Text="NavigateUrl test" />
    </DayPilot:DayPilotMenu>
    
    <DayPilot:DayPilotMenu ID="DayPilotMenuSpecial" runat="server" ClientObjectName="cmSpecial" >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (JavaScript using callback)" Action="JavaScript"
            Command='Delete' JavaScript="if (confirm('Do you really want to delete event ' + e.text() + ' ?')) dps1.eventMenuClickCallBack(e, command);">
        </DayPilot:MenuItem>
    </DayPilot:DayPilotMenu>
    
    <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server" ClientObjectName="cmSelection">
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dps1.timeRangeSelectedCallBack(e.start, e.end, e.resource);"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
        <DayPilot:MenuItem Text="-" Action="JavaScript"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Start: ' + e.start + '\nEnd: ' + e.end + '\nResource id: ' + e.resource);"
            Text="Show selection details" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dps1.clearSelection();" Text="Clean selection" />
    </DayPilot:DayPilotMenu>

    <DayPilot:DayPilotMenu ID="DayPilotMenuRes" runat="server" >
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
        
        Position="EventTop"
        >
    </DayPilot:DayPilotBubble>

    <br />
    <br />
    

</asp:Content>

