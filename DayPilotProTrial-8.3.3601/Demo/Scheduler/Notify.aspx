<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="Notify.aspx.cs"
    Inherits="Scheduler_Notify" Title="Notify Model (Scheduler) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-nz" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">

/* DayPilotScheduler.AfterRenderJavaScript handler */

function afterRender(data, isCallBack) {
}

/* Event editing helpers - modal dialog */
	function timeRangeSelected(start, end, resource) {
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
	    modal.showUrl("New.aspx?start=" + start.toStringSortable() + "&end=" + end.toStringSortable() + "&r=" + resource + "&hash=<%= PageHash %>");
	}
	
	function changeText(e, text) {
	    //var e = dps1.events.find(ev.value());
	    e.text(text);
	    //e.client.innerHTML(text);
	    dps1.events.update(e).queue();
	}
	
	function createEvent(name) {
	    var e = new DayPilot.Event({start:new DayPilot.Date(), end:(new DayPilot.Date()).addHours(5), value: DayPilot.guid(), text: name, resource:'E'});
	    dps1.events.add(e).queue();
	}
	
	function deleteEvent(e) {
	    //var e = dps1.events.find(ev.value());
	    dps1.events.remove(e).queue();	    
	}
	
    function save() {
	    dps1.queue.notify();
	}

</script>

    <div class="note">
    <b>Note:</b> In the <a href="http://doc.daypilot.org/scheduler/notify-event-model/">Notify event model</a> the changes (event moving, resizing, updating or creating) are applied on the client side immediately. The events are not refreshed after receiving the response from the server.
    This demo shows a lot of events (365 * 26 = 9,490). Events are loaded from the server all at once (compare with <a href="DynamicEventLoading.aspx">dynamic event loading</a>) but are rendered progressively (DynamicEventRendering="Progressive") as you scroll.
    In the traditional <i>Refresh</i> mode it would take at least a few seconds to update the event set after adding or moving an event.
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
        EventClickJavaScript="deleteEvent(e);"
        EventHoverHandling="Disabled"
        EventEditHandling="CallBack" 
        OnEventEdit="DayPilotScheduler1_EventEdit" 
        OnBeforeEventRender="DayPilotScheduler1_BeforeEventRender"
        OnEventMenuClick="DayPilotScheduler1_EventMenuClick" 
        ContextMenuID="DayPilotMenu2" 
        ContextMenuResourceID="DayPilotMenuRes"
        BusinessBeginsHour="5" 
        AfterRenderJavaScript="afterRender(data, isCallBack);" 
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
         
        EnableViewState="false" 
        ScrollLabelsVisible="false" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false"
        HeightSpec="Auto" 
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
        onnotify="DayPilotScheduler1_Notify" 
        oneventupdate="DayPilotScheduler1_EventUpdate"
        NotifyCommit="Queue" 
        oneventadd="DayPilotScheduler1_EventAdd" 
        oneventremove="DayPilotScheduler1_EventRemove"
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
    
    <div style="margin-top: 20px;">
        <div style="font-weight:bold">1. Perform fast client-side operations</div>
        <div><a href="javascript:createEvent('Test');">Create new event</a> (Resource E)</div>
        <div>Move any event using drag&amp;drop</div>
        <div>Resize any event using drag&amp;drop</div>
        <div>Delete any event using context menu (right click)</div>
        <div>Set text using context menu (right click)</div>
    </div>
    <div style="margin-top: 20px;">
        <div style="font-weight:bold">2. Send changes to the server</div>
        <div><a href="javascript:save()">Save queue</a></div>
    </div>
    <div style="margin-top: 20px;">
        <div>Debugging</div>
        <div><a href="javascript:dps1.debuggingEnabled = true;">Turn on</a> | <a href="javascript:dps1.debuggingEnabled = false;">Turn off</a></div>
        <div><a href="javascript:dps1.showDebugMessages();">Show debug messages</a></div>
    </div>

    <DayPilot:DayPilotMenu ID="DayPilotMenu2" runat="server" >
        <DayPilot:MenuItem Text="Delete" Action="JavaScript" JavaScript="deleteEvent(e);"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Set text to 'Clear'" Action="JavaScript" JavaScript="changeText(e, 'Clear');"></DayPilot:MenuItem>
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
