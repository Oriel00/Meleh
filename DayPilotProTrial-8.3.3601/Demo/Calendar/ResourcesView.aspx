<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="ResourcesView.aspx.cs"
    Inherits="ResourcesView" Title="Resources View (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="note"><b>Note:</b> Read more about the calendar <a href="http://doc.daypilot.org/calendar/resources-view/">resources view</a> [doc.daypilot.org].</div>


    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        ViewType="Resources"
        DataColumnField="Column" 
        DataEndField="End" 
        DataStartField="Start" 
        DataTextField="Name"
        DataIdField="id" 
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="alert(start + ' ' + end + ' ' + resource); dpc.clearSelection();"
        OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected"
        EventResizeHandling="CallBack" 
        EventMoveHandling="CallBack"
        EventMoveJavaScript="alert('resource: ' + e.resource());"
        OnEventResize="DayPilotCalendar1_EventResize"
        ClientObjectName="dpc" 
        OnBeforeCellRender="DayPilotCalendar1_BeforeCellRender"
        OnEventMove="DayPilotCalendar1_EventMove" 
        
        >
        <Columns>
            <DayPilot:Column Name="Meeting Room A" Id="A" Date="" />
            <DayPilot:Column Name="Meeting Room B" Id="B" Date="" />
            <DayPilot:Column Name="Meeting Room C" Id="C" Date="" />
        </Columns>
    </DayPilot:DayPilotCalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
    
</asp:Content>
