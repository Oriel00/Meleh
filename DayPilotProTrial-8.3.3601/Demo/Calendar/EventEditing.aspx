<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="EventEditing.aspx.cs" Inherits="Editing" Title="Event Editing (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-editing/">event editing</a> [doc.daypilot.org].</div>
    
    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        dataendfield="end"
        datastartfield="start" 
        datatextfield="name" 
        DataIdField="id"  
        DataAllDayField="allday"
        Days="7" 
        EventClickHandling="Edit"
         
        EventEditHandling="CallBack" 
        OnEventEdit="DayPilotCalendar1_EventEdit"
        ShowAllDayEvents="true"
        

        ></daypilot:daypilotcalendar>
</asp:Content>

