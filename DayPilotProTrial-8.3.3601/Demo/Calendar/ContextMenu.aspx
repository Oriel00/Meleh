<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="ContextMenu.aspx.cs" Inherits="ContextMenu" 
Title="Context Menu (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-context-menu/">event context menu</a> [doc.daypilot.org].</div>

    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataTextField="name" 
        DataIdField="id" 
        DataAllDayField="allday"
        DataStartField="start" 
        DataEndField="end" 
        ContextMenuID="DayPilotMenu1" 
        OnEventMenuClick="DayPilotCalendar1_EventMenuClick" 
        OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender"
        ViewType="Week"
        ></DayPilot:DayPilotCalendar>
    &nbsp;&nbsp;<br />
    <daypilot:daypilotmenu id="DayPilotMenu1" runat="server" ClientObjectName="menu">
        <DayPilot:MenuItem Text="Open" Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');" ></DayPilot:MenuItem>
        
        <DayPilot:MenuItem Text="-" Action="NavigateUrl" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Text="Delete (CallBack)" Action="CallBack" Command="Delete"></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="PostBack" Command="Delete" Text="Delete (PostBack)" />
        <DayPilot:MenuItem Text="Delete (JavaScript using callback)" Action="JavaScript" Command='Delete' JavaScript="if (confirm('Do you really want to delete event ' + e.text() + ' ?')) ctl00_ContentPlaceHolder1_DayPilotCalendar1.eventMenuClickCallBack(e, command);"></DayPilot:MenuItem>
    </daypilot:daypilotmenu>
    <daypilot:daypilotmenu id="Daypilotmenu2" runat="server" ClientObjectName="specialmenu">
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Opening event (id ' + e.value() + ')');"
            Text="Open" />
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Sending event (id ' + e.value() + ')');"
            Text="Send" />
        <DayPilot:MenuItem Action="NavigateUrl" Text="-" />
        <DayPilot:MenuItem Action="JavaScript" Command='Delete' JavaScript="if (confirm('Do you really want to delete event ' + e.text() + ' ?')) ctl00_ContentPlaceHolder1_DayPilotCalendar1.eventMenuClickCallBack(e, command);"
            Text="Delete (JavaScript using callback)" />
        <DayPilot:MenuItem Action="JavaScript" Command='Switch' JavaScript="e.client.contextMenu(menu);"
            Text="Switch to normal menu" />
    </daypilot:daypilotmenu>
    <br />
</asp:Content>