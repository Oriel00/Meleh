<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="EventSelecting.aspx.cs"
    Inherits="EventSelecting" Title="Event Selecting (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="note"><b>Note:</b> Use Ctrl + click to select multiple events. Read more about <a href="http://doc.daypilot.org/calendar/event-selecting/">event selecting</a> [doc.daypilot.org].</div>
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataEndField="end"
        DataStartField="start" 
        DataTextField="name" 
        DataIdField="id" 
        DataAllDayField="allday" 
        Days="7" 
        OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected"
        TimeRangeSelectedHandling="CallBack" 
        ClientObjectName="dpc1"
        EventClickHandling="Select" 
        EventSelectHandling="JavaScript" 
        EventSelectJavaScript="" 
        OnEventSelect="DayPilotCalendar1_EventSelect"
        EventMoveHandling="CallBack" 
        OnEventMove="DayPilotCalendar1_EventMove"
        oncommand="DayPilotCalendar1_Command"
        EventDoubleClickHandling="JavaScript"
        EventDoubleClickJavaScript="alert('event:' + e.text())"
        >
    </DayPilot:DayPilotCalendar>
    <br />
        
</asp:Content>
