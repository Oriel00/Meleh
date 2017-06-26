<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="DaysResourcesView.aspx.cs"
    Inherits="DaysResourcesView" Title="Days-Resources View (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="note"><b>Note:</b> Read more about the calendar <a href="http://doc.daypilot.org/calendar/column-header-hierarchy/">column header hierarchy</a> [doc.daypilot.org].</div>


    <div style="margin-bottom:5px">
        Go to:
        <a href="javascript:dpc1.commandCallBack('previous');">Previous</a> -
        <a href="javascript:dpc1.commandCallBack('next');">Next</a> -
        <a href="javascript:dpc1.commandCallBack('today');">Today</a>
    </div>

    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        ViewType="Resources"
        DataColumnField="Column" 
        DataEndField="End" 
        DataStartField="Start" 
        DataTextField="Name"
        DataIdField="id" 
        DataAllDayField="allday" 
        TimeRangeSelectedHandling="JavaScript"
        TimeRangeSelectedJavaScript="alert(start + ' ' + end + ' ' + resource); dpc.clearSelection();"
        OnTimeRangeSelected="DayPilotCalendar1_TimeRangeSelected"
        EventResizeHandling="CallBack" 
        OnEventResize="DayPilotCalendar1_EventResize"
        HeaderLevels="2" 
        ClientObjectName="dpc1" 
        EventMoveHandling="CallBack" 
        OnEventMove="DayPilotCalendar1_EventMove"
        ShowAllDayEvents="true"
        ColumnBubbleID="DayPilotBubble1" 
        OnCommand="DayPilotCalendar1_Command" 
        
        AllDayEnd="Date"
        
        >
    </DayPilot:DayPilotCalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
        <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble"
        UseShadow="True"
        HideAfter="500"
        >
    </DayPilot:DayPilotBubble>

</asp:Content>
