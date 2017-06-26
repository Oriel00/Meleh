<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="CustomBusinessHours.aspx.cs" Inherits="CustomBusinessHours" 
Title="Custom Business Hours (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note">
    <b>Note:</b> You can customize the calendar business hours by handling the BeforeCellRender event. This event is called for each calendar cell and you can set Business/NonBusiness status or BackgroundColor for each cell separately.
    Read more about <a href="http://doc.daypilot.org/calendar/business-hours/">business hours</a> customization [doc.daypilot.org].
    </div>


    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        DataStartField="Start" 
        DataEndField="End" 
        OnBeforeCellRender="DayPilotCalendar1_BeforeCellRender" 
        ></daypilot:daypilotcalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
    
</asp:Content>

