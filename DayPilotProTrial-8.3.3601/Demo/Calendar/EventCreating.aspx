<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="EventCreating.aspx.cs"
    Inherits="EventCreating" Title="Event Creating (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-creating/">event creating</a> [doc.daypilot.org].</div>

    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataEndField="end"
        DataStartField="start" 
        DataTextField="name" 
        DataIdField="id" 
        DataAllDayField="allday" 
        Days="7" 
        OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected"
        TimeRangeSelectedHandling="CallBack" 
        ContextMenuSelectionID="DayPilotMenu1" 
        ClientObjectName="dpc1" 
        OnTimeRangeMenuClick="DayPilotCalendar1_TimeRangeMenuClick"
        
        
        

        

        
        >
    </DayPilot:DayPilotCalendar>
    <br />
    Click and drag mouse over a free time cell to create a new event on the server.
    <DayPilot:DayPilotMenu ID="DayPilotMenu1" runat="server" >
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
</asp:Content>
