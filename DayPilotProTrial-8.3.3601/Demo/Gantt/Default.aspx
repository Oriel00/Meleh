<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="Gantt_Default" Title="ASP.NET Gantt | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="note"><b>Note:</b> Read more about the <a href="http://www.daypilot.org/gantt/">ASP.NET Gantt Chart</a> control.</div>
    
    <DayPilot:DayPilotGantt
        ID="DayPilotGantt1" 
        runat="server" 
        ClientObjectName="dp"
        
        ContextMenuTaskID="DayPilotMenu1"
        ContextMenuRowID="DayPilotMenu1"
        ContextMenuLinkID="DayPilotMenuLink"
        BubbleTaskID="DayPilotBubble1"
        BubbleRowID="DayPilotBubble1"
                
        TaskClickHandling="CallBack"               
        
        >
        <TimeHeaders>
            <DayPilot:TimeHeader GroupBy="Month" Format="MMMM yyyy" />
            <DayPilot:TimeHeader GroupBy="Day" Format="%d" />
        </TimeHeaders>
        <Columns>
            <DayPilot:TaskColumn Title="Name" Property="text" Width="100" />
            <DayPilot:TaskColumn Title="Info" Property="info" Width="100" />
        </Columns>
    </DayPilot:DayPilotGantt>
    
    <DayPilot:DayPilotMenu ID="DayPilotMenu1" runat="server">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.id() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.id() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
    </DayPilot:DayPilotMenu>

    <DayPilot:DayPilotMenu ID="DayPilotMenuLink" runat="server">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening link (from ' + this.source.from() + ' to ' + this.source.to() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
    </DayPilot:DayPilotMenu>
    
    <DayPilot:DayPilotBubble runat="server" ID="DayPilotBubble1"></DayPilot:DayPilotBubble>
       
</asp:Content>

