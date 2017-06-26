<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="EventDeleting.aspx.cs" Inherits="EventDeleting" Title="Event Deleting (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-deleting/">event deleting</a> [doc.daypilot.org].</div>

    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        dataendfield="end"
        datastartfield="start" 
        datatextfield="name" 
        DataIdField="id" 
        DataAllDayField="allday" 
        Days="7" 
        ClientObjectName="dpc"
        EventDeleteHandling="JavaScript"
        EventDeleteJavaScript="if (confirm('Delete?')) { dpc.eventDeleteCallBack(e); }" 
        OnEventDelete="DayPilotCalendar1_EventDelete" 
        
        OnBeforeEventRender="DayPilotCalendar1_OnBeforeEventRender"
        ></daypilot:daypilotcalendar>
    <br />

</asp:Content>

