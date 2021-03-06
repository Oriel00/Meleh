<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="WeeksView.aspx.cs"
    Inherits="Month_WeeksView" Title="Weeks View (Month) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    
    <div class="note"><b>Note:</b> Showing previous and next weeks in addition to the current week. Read more about the <a href="http://doc.daypilot.org/month/weeks-view/">weeks view</a> [doc.daypilot.org].</div>

    <table style="width:100%">
        <tr>
            <td valign="top" style="width:150px">
                <DayPilot:DayPilotNavigator ID="DayPilotNavigator1" runat="server" 
                    BoundDayPilotID="DayPilotMonth1" 
                    SelectMode="Week"
                    ShowMonths="3"
                    DataStartField="start"
                    DataEndField="end" 
                    VisibleRangeChangedHandling="CallBack"
                    OnVisibleRangeChanged="DayPilotNavigator1_VisibleRangeChanged"
                    
                    ></DayPilot:DayPilotNavigator>
                <br />
                <br />
                <div style="height:20px"></div>        
            </td>
            <td valign="top">
            
                <DayPilot:DayPilotMonth 
                    ID="DayPilotMonth1" 
                    runat="server" 
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
                    EventResizeHandling="CallBack" 
                    OnEventResize="DayPilotMonth1_EventResize"
                    OnTimeRangeSelected="DayPilotMonth1_TimeRangeSelected"
                    TimeRangeSelectedHandling="CallBack" 
                    OnBeforeEventRender="DayPilotMonth1_BeforeEventRender" 
                    BubbleID="DayPilotBubble1" 
                    ShowToolTip="false" 
                    OnCommand="DayPilotMonth1_Command" 
                    
                    
                    EventStartTime="false"
                    EventEndTime="false"
                    
                    ViewType="Weeks"
                    Weeks="3" 
                    onbeforecellrender="DayPilotMonth1_BeforeCellRender"
                    
                    >
                </DayPilot:DayPilotMonth>
        </tr>
    </table>

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
