<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="RecurrentEventsManual.aspx.cs"
Inherits="Calendar_RecurrentEventsManual" Title="All AJAX Features (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">

function afterRender(data) {
    if (data) {
        var text = data.message ? (data.message + " (id " + data.id + ")") : data;
        dpc.message(text, 1000, "#ffffff", "#dc143c", 5000); //#ff9525, #c00000
    }
}

function ask(e) {
   
    // it's a normal event
    if (!e.recurrent()) {
        edit(e);
        return;
    } 
    
    // it's a recurrent event but it's an exception from the series
    if (e.value() !== null) {
        edit(e);
        return;
    }

    var modal = new DayPilot.Modal();
    modal.top = 150;
    modal.width = 300;
    modal.height = 150;
    modal.opacity = 0;
    modal.border = "10px solid #d0d0d0";
    modal.closed = function() { 
        if(this.result != "cancel") { 
            edit(e, this.result);
        }
    };

    modal.showUrl("RecurrentEditMode.html");
}

function edit(e, mode) {
    var modal = new DayPilot.Modal();
    modal.top = 60;
    modal.width = 600;
    modal.height = 330;
    modal.opacity = 0;
    modal.border = "10px solid #d0d0d0";
    modal.closed = function() { 
        if (this.result === "OK") {
            dpc.commandCallBack('refresh');
        }
    };

    var url = "RecurrentEventEdit.aspx?q=1"
    if (e.recurrentMasterId() !== null) {
        url += "&master=" + e.recurrentMasterId();
    }
    if (e.value() !== null) {
        url += "&id=" + e.value();
    }
    if (mode == "this") {
        url += "&start=" + e.start().toStringSortable();
    }
    modal.showUrl(url);
    /*
    if (mode == "series") {
        modal.showUrl("RecurrentEventEdit.aspx?id=" + e.recurrentMasterId());
    }
    else if (e.value() !== null) {
        modal.showUrl("RecurrentEventEdit.aspx?id=" + e.value());
    }
    else {
        modal.showUrl("RecurrentEventEdit.aspx?id=" + e.recurrentMasterId() + "&occurrence=" + e.start().toStringSortable());
    }
    */
}

</script>

    <table style="width:100%">
        <tr>
            <td valign="top" style="width:150px">
                <DayPilot:DayPilotNavigator ID="DayPilotNavigator1" runat="server" 
                    BoundDayPilotClientObjectName="dpc" 
                    SelectMode="Week"
                    ShowMonths="3"
                    SkipMonths="3"
                    
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
                    OnEventMove="DayPilotCalendar1_EventMove" 
                    Days="7" 
                    OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected" 
                    TimeRangeSelectedHandling="CallBack" 
                    EventMoveHandling="CallBack"
                    EventMoveJavaScript="eventMove(e, newStart, newEnd, newResource)" 
                    ContextMenuID="DayPilotMenu1" 
                    OnEventMenuClick="DayPilotCalendar1_EventMenuClick" 
                    EventResizeHandling="CallBack" 
                    OnEventResize="DayPilotCalendar1_EventResize" 
                    EventClickHandling="JavaScript" 
                    EventClickJavaScript="ask(e)"
                    EventSelectHandling="JavaScript"
                    xHeightSpec="BusinessHours" 
                    OnEventClick="DayPilotCalendar1_EventClick" 
                    ClientObjectName="dpc" 
                    EventEditHandling="CallBack" 
                    OnEventEdit="DayPilotCalendar1_EventEdit" 
                    OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender" 
                    EventDeleteHandling="CallBack" 
                    OnEventDelete="DayPilotCalendar1_EventDelete" 
                    EventDeleteJavaScript="if (confirm('Do you really want to delete ' + e.text() + ' ?')) dpc.eventDeleteCallBack(e);" 
                    OnEventSelect="DayPilotCalendar1_EventSelect" 
                    OnRefresh="DayPilotCalendar1_Refresh" 
                    EventSelectColor="Blue"
                    xShowalldayevents="True"
                     
                    AfterRenderJavaScript="afterRender(data);" 
                    OnBeforeHeaderRender="DayPilotCalendar1_BeforeHeaderRender" 
                    ShowToolTip="true" 
                    EventDoubleClickHandling="Edit"
                    EventDoubleClickJavaScript="alert(e.value());"
                    EventHoverHandling="Bubble" 
                    TimeRangeDoubleClickHandling="CallBack"        
                    TimeFormat="Auto" OnTimeRangeDoubleClick="DayPilotCalendar1_TimeRangeDoubleClick"
                    ContextMenuSelectionID="DayPilotMenuSelection" 
                    OnTimeRangeMenuClick="DayPilotCalendar1_TimeRangeMenuClick" 
                    OnCommand="DayPilotCalendar1_Command" 
                    OnBeforeCellRender="DayPilotCalendar1_BeforeCellRender"
                    
                    
                    
                    

                    

                    
                    RecurrentEventImage="~/Media/linked/recur10x9.png"
                    RecurrentEventExceptionImage="~/Media/linked/recurex10x9.png" OnBeforeEventRecurrence="DayPilotCalendar1_BeforeEventRecurrence"

                    ></daypilot:daypilotcalendar>
                    <br />
                
            </td>
        </tr>
    </table>

    <daypilot:daypilotmenu id="DayPilotMenu1" runat="server" >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');" Text="NavigateUrl test" />
    </daypilot:daypilotmenu>
        <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server" >
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dpc.timeRangeSelectedCallBack(e.start, e.end, e.resource); dpc.clearSelection();"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
        <DayPilot:MenuItem Text="-" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Start: ' + e.start.toString() + '\nEnd: ' + e.end.toString() + '\nResource id: ' + e.resource);"
            Text="Show selection details" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dpc.clearSelection();"
            Text="Clean selection" />
    </DayPilot:DayPilotMenu>

    <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble"
        ShowLoadingLabel="true"
        HideAfter="500"
        >
    </DayPilot:DayPilotBubble>
    <br />
</asp:Content>

