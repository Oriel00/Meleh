<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="Timesheet.aspx.cs"
    Inherits="Timesheet" Title="Timesheet View (Scheduler) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="note"><b>Note:</b> Read more about the <a href="http://doc.daypilot.org/scheduler/timesheet/">timesheet</a> [doc.daypilot.org]. See also the <a href="http://code.daypilot.org/60174/timesheet-for-asp-net-c-vb-net-sql-server">Timesheet Tutorial for ASP.NET</a> (with C# and VB.NET source code; sample SQL Server database)</div>

    <DayPilot:DayPilotScheduler ID="DayPilotScheduler1" runat="server" Days="31" StartDate="2010-01-01"
        DataStartField="start" DataEndField="end" DataTextField="name" DataIdField="id"
        EventResizeHandling="CallBack" OnEventResize="DayPilotScheduler1_EventResize"
        EventMoveHandling="CallBack" OnEventMove="DayPilotScheduler1_EventMove" ClientObjectName="dps1"
        OnTimeRangeSelected="DayPilotScheduler1_TimeRangeSelected" 
        TimeRangeSelectedHandling="CallBack" 
        ViewType="Days" 
        CellGroupBy="Hour"
        CellDuration="15" 
        CellWidth="30" 
        OnBeforeTimeHeaderRender="DayPilotScheduler1_BeforeTimeHeaderRender" 
        OnBeforeCellRender="DayPilotScheduler1_BeforeCellRender"
        OnBeforeResHeaderRender="DayPilotScheduler1_BeforeResHeaderRender"
        
        ShowNonBusiness="false"
        BusinessBeginsHour="1"
        BusinessEndsHour="24"
        >
    </DayPilot:DayPilotScheduler>
</asp:Content>
