<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="CellStacking.aspx.cs"
    Inherits="Month_CellStacking" Title="Cell Stacking Mode (Month) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="note"><b>Note:</b> Events are stacked inside day cells (a vertical scrollbar is added when needed). Read more about the <a href="http://doc.daypilot.org/month/cell-stacking-mode/">cell stacking mode</a> [doc.daypilot.org].</div>
                
    <DayPilot:DayPilotMonth ID="DayPilotMonth1" runat="server" 
        DataEndField="end" 
        DataStartField="start"
        DataTextField="name" 
        DataIdField="id" 
        DataTagFields="name, id" 
        EventClickHandling="JavaScript"
        EventClickJavaScript="alert(e.text());" 
        ContextMenuID="DayPilotMenu1" 
        OnEventMenuClick="DayPilotCalendar1_EventMenuClick"
        ClientObjectName="dpm" 
        EventMoveHandling="CallBack" 
        OnEventMove="DayPilotMonth1_EventMove"
        Width="100%" 
        EventResizeHandling="CallBack" 
        OnEventResize="DayPilotMonth1_EventResize"
        OnTimeRangeSelected="DayPilotMonth1_TimeRangeSelected"
        TimeRangeSelectedHandling="CallBack" 
        OnBeforeEventRender="DayPilotMonth1_BeforeEventRender" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false" 
        OnCommand="DayPilotMonth1_Command" 

                     

        EventStackingMode="Cell"
        EventStartTime="false"
        EventEndTime="false"
        EventTextAlignment="Left"
        EventSortExpression="name asc"
                    
        OnBeforeCellRender="DayPilotMonth1_BeforeCellRender"
        >
    </DayPilot:DayPilotMonth>

    <DayPilot:DayPilotMenu ID="DayPilotMenu1" runat="server">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');"
            Text="NavigateUrl test" />
    </DayPilot:DayPilotMenu>

    <DayPilot:DayPilotMenu ID="DayPilotMenu2" runat="server" ClientObjectName="menu2">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Send" Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');">
        </DayPilot:MenuItem>
        <DayPilot:MenuItem Text="-" Action="NavigateUrl"></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="Callback" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Action="NavigateUrl" NavigateUrl="javascript:alert('Going somewhere else (id {0})');"
            Text="NavigateUrl test" />
    </DayPilot:DayPilotMenu>
    
        <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble"
        UseShadow="True"
        >
    </DayPilot:DayPilotBubble>
    

</asp:Content>
