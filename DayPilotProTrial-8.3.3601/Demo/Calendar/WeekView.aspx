<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="WeekView.aspx.cs" 
Inherits="WeekView" Title="Week View (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note"><b>Note:</b> Read more about the calendar <a href="http://doc.daypilot.org/calendar/week-view/">week view</a> [doc.daypilot.org].</div>

    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        DataStartField="Start" 
        DataEndField="End" 
        ViewType="Week" 
        Width="100%"
        ></daypilot:daypilotcalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
    
</asp:Content>

