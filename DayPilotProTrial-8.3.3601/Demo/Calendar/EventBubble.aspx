<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="EventBubble.aspx.cs"
    Inherits="EventBubble" Title="Event Bubble (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-bubble/">event bubble</a> [doc.daypilot.org].</div>

    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataEndField="end"
        DataStartField="start" 
        DataTextField="name" 
        DataIdField="id" 
        DataAllDayField="allday" 
        Days="7" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false" 
        ShowAllDayEvents="false"
        EventMoveHandling="Notify"
        >
    </DayPilot:DayPilotCalendar>
    <DayPilot:DayPilotBubble ID="DayPilotBubble1" runat="server" 
        OnRenderEventBubble="DayPilotBubble1_RenderEventBubble"
        ClientObjectName="bubble" 
        Width="300">
    </DayPilot:DayPilotBubble>
</asp:Content>
