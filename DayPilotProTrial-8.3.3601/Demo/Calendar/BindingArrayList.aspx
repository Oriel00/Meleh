<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="BindingArrayList.aspx.cs" Inherits="BindingArrayList" 
Title="ArrayList Binding (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-loading/">loading calendar events</a> [doc.daypilot.org].</div>

    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        DataStartField="Start"
        dataendfield="End" 
        datatextfield="Name" 
        DataIdField="id"
        DataAllDayField="AllDay"
        ShowAllDayEvents="true"
        onload="DayPilotCalendar1_Load"        
        ></daypilot:daypilotcalendar>
    <br />
</asp:Content>

