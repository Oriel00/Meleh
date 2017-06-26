<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="MultipleCalendars.aspx.cs" 
Inherits="MultipleControls" Title="Multiple Calendars (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        TimeFormat="Clock12Hours" 
        DataStartField="Start" 
        DataEndField="End" 
        Theme="calendar_green"
        >
        </DayPilot:DayPilotCalendar>
    &nbsp;<br />
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar2" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        TimeFormat="Clock12Hours" 
        DataStartField="Start" 
        DataEndField="End" 
        
        Theme="calendar_white"
        >
        </DayPilot:DayPilotCalendar>
    &nbsp;<br />
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar3" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        TimeFormat="Clock12Hours" 
        DataStartField="Start" 
        DataEndField="End" 
        
        Theme="calendar_transparent"
        >
        </DayPilot:DayPilotCalendar>
    &nbsp;<br />
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>

</asp:Content>

