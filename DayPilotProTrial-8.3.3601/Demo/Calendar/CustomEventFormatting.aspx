<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="CustomEventFormatting.aspx.cs" Inherits="CustomEventFormatting" 
Title="Custom Event Formatting (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-customization/">event customization</a> [doc.daypilot.org].</div>
    
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1"
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        DataStartField="Start"
        DataEndField="End" 
        DataTagFields="id, name" 
        OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender"
        >
    </DayPilot:DayPilotCalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
</asp:Content>
