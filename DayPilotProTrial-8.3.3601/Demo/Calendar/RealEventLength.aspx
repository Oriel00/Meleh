<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="RealEventLength.aspx.cs" Inherits="Horizontal_RealEventLength" Title="Real Event Length (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note"><b>Note:</b> Events longer than a minimum size (30 minutes in this example) are rendered in real size (not inside a box aligned with time cells). Read more about <a href="http://doc.daypilot.org/calendar/exact-event-duration/">exact event duration</a> [doc.daypilot.org].</div>

    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        DataStartField="Start" 
        DataEndField="End" 
        Days="7" 
        Width="100%" 
        UseEventBoxes="ShortEventsOnly"
        ></daypilot:daypilotcalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
    <br />
    
</asp:Content>

