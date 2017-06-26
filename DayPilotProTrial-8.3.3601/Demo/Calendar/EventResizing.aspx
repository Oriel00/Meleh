<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="EventResizing.aspx.cs" Inherits="Resizing" Title="Event Resizing (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-resizing/">event resizing</a> [doc.daypilot.org].</div>
    
    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        dataendfield="end"
        datastartfield="start" 
        datatextfield="name" 
        DataIdField="id" 
        DataAllDayField="allday"
        OnEventResize="DayPilotCalendar1_EventResize" 
        EventResizeHandling="CallBack"
        ShowAllDayEvents="true"
        ViewType="Week"
         ></daypilot:daypilotcalendar>
</asp:Content>

