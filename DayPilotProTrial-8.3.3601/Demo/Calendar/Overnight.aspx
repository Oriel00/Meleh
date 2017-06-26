<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="Overnight.aspx.cs" 
Inherits="Calendar_Overnight" Title="Overnight business hours (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">

function afterRender(data) {
    if (data) {
        if (data.message) {
            showMessage(data.message + " (id " + data.id + ")");
        }
        else {
            showMessage(data);
        }
    }
}

/* message helpers */

var timeout = null;

function showMessage(text) {
    var messageDiv = document.getElementById("message");
    messageDiv.innerHTML = text;
    messageDiv.style.display = '';
    
    if (timeout) {
        window.clearTimeout(timeout);
    }
    timeout = window.setTimeout('clearMessage()', 4000);
}

function clearMessage() {
    var messageDiv = document.getElementById("message");
    messageDiv.innerHTML = '';
    messageDiv.style.display = 'none';
}

</script>

    <table style="width:100%">
        <tr>
            <td valign="top" style="width:150px">
                <DayPilot:DayPilotNavigator ID="DayPilotNavigator1" runat="server" 
                    BoundDayPilotClientObjectName="dpc1" 
                    SelectMode="Week"
                    ShowMonths="3"
                    
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
                    DataColumnField="allday"
                    OnEventMove="DayPilotCalendar1_EventMove" 
                    Days="7" 
                    OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected" 
                    TimeRangeSelectedHandling="Hold" 
                    EventMoveHandling="CallBack" 
                    ContextMenuID="DayPilotMenu1" 
                    OnEventMenuClick="DayPilotCalendar1_EventMenuClick" 
                    EventResizeHandling="CallBack" 
                    OnEventResize="DayPilotCalendar1_EventResize" 
                    EventClickHandling="JavaScript" 
                    EventClickJavaScript="alert('This is a custom click handler. Double-click the event to edit its name inline.');"
                    EventSelectHandling="JavaScript"
                    HeightSpec="BusinessHours" 
                    OnEventClick="DayPilotCalendar1_EventClick" 
                    ClientObjectName="dpc1" 
                    EventEditHandling="CallBack" 
                    OnEventEdit="DayPilotCalendar1_EventEdit" 
                    OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender" 
                    EventDeleteHandling="CallBack" 
                    OnEventDelete="DayPilotCalendar1_EventDelete" 
                    EventDeleteJavaScript="if (confirm('Do you really want to delete ' + e.text() + ' ?')) dpc1.eventDeleteCallBack(e);" 
                    OnEventSelect="DayPilotCalendar1_EventSelect" 
                    OnRefresh="DayPilotCalendar1_Refresh" 
                    EventSelectColor="Blue"
                    Showalldayevents="True"
                     
                    AfterRenderJavaScript="afterRender(data);" 
                    OnBeforeHeaderRender="DayPilotCalendar1_BeforeHeaderRender" 
                    BubbleID="DayPilotBubble1" 
                    ShowToolTip="False" 
                    EventDoubleClickHandling="Edit"
                    EventDoubleClickJavaScript="alert(e.value());"
                    EventHoverHandling="Bubble" 
                    TimeRangeDoubleClickHandling="CallBack"        
                    TimeFormat="Auto" OnTimeRangeDoubleClick="DayPilotCalendar1_TimeRangeDoubleClick"
                    ContextMenuSelectionID="DayPilotMenuSelection" 
                    OnTimeRangeMenuClick="DayPilotCalendar1_TimeRangeMenuClick" 
                    OnCommand="DayPilotCalendar1_Command" 
                    
                    
                    
                    

                    

                    BusinessBeginsHour="18"
                    BusinessEndsHour="9"                    
                    
                    >
                    <Columns>
                        <daypilot:Column Name="First" Date="2009-01-01T18:00:00"></daypilot:Column>
                    </Columns>
                    </daypilot:daypilotcalendar>
                    <br />
                <asp:Button ID="ButtonExport" runat="server" OnClick="ButtonExport_Click" Text="Print/export" />
                <span id="message" style="padding:2px; background-color: #dc143c; color: White; display: none;"></span>
            
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
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');" ></DayPilot:MenuItem>
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
        HideAfter="500"
        >
    </DayPilot:DayPilotBubble>
    <br />
</asp:Content>

