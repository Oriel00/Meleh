<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="RecurrentEvents.aspx.cs"
Inherits="Calendar_RecurrentEvents" Title="Recurrent Events (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">

function afterRender(data, isCallBack) {
    if (data) {
        var text = data.message ? (data.message + " (id " + data.id + ")") : data;
        dpc.message(text, 1000, "#ffffff", "#dc143c", 5000); //#ff9525, #c00000
    }
    if (isCallBack) {  // refresh the navigator
        dpn.visibleRangeChangedCallBack();
    }
}

function askDelete(e) {
   
    // it's a normal event
    if (!e.recurrent()) {
        dpc.eventDeleteCallBack(e);
        return;
    } 
    
    // it's a recurrent event but it's an exception from the series
    if (e.value() !== null) {
        dpc.eventDeleteCallBack(e);
        return;
    }

    var modal = new DayPilot.Modal();
    modal.top = 150;
    modal.width = 300;
    modal.height = 150;
    modal.border = "10px solid #d0d0d0";
    modal.closed = function() { 
        if(this.result != "cancel") { 
            dpc.eventDeleteCallBack(e, { which: this.result }); // this.result = "this" or "series"
        }
    };

    modal.showUrl("RecurrentDeleteMode.html");
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
    //modal.opacity = 0;
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
    //modal.opacity = 0;
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
}

</script>

    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/recurring-events/">recurring events</a> [doc.daypilot.org].</div>

    <table style="width:100%">
        <tr>
            <td valign="top" style="width:150px">
                <DayPilot:DayPilotNavigator ID="DayPilotNavigator1" runat="server" 
                    ClientObjectName="dpn"
                    BoundDayPilotClientObjectName="dpc" 
                    SelectMode="Week"
                    ShowMonths="3"
                    SkipMonths="3"
                    
                    DataStartField="start"
                    DataEndField="end" 
                    DataIdField="id"
                    DataRecurrenceField="recurrence"
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
                    DataRecurrenceField="recurrence"
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
                    OnEventClick="DayPilotCalendar1_EventClick" 
                    ClientObjectName="dpc" 
                    EventEditHandling="CallBack" 
                    OnEventEdit="DayPilotCalendar1_EventEdit" 
                    OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender" 
                    OnEventDelete="DayPilotCalendar1_EventDelete" 
                    OnEventSelect="DayPilotCalendar1_EventSelect" 
                    EventSelectColor="Blue"
                     
                    AfterRenderJavaScript="afterRender(data, isCallBack);" 
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
                    RecurrentEventExceptionImage="~/Media/linked/recurex10x9.png"
                    
                    OnBeforeEventRecurrence="DayPilotCalendar1_OnBeforeEventRecurrence"

                    ></daypilot:daypilotcalendar>
                    <br />
                
            </td>
        </tr>
    </table>

    <daypilot:daypilotmenu id="DayPilotMenu1" runat="server" >
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete" Action="JavaScript" JavaScript="askDelete(e);"></DayPilot:MenuItem>
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
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Expand" /><br />
    <br />
    <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <br />
    <asp:GridView ID="GridView2" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    <br />
    <br />
</asp:Content>

