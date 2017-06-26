<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="DateSwitching.aspx.cs" Inherits="Horizontal_DateSwitching" 
Title="Date Switching (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/manual-date-switching/">date switching</a> [doc.daypilot.org].</div>
    <div style="margin-bottom:5px">
        Go to:
        <a href="javascript:dpc1.commandCallBack('previous');">Previous</a> -
        <a href="javascript:dpc1.commandCallBack('next');">Next</a> -
        <a href="javascript:dpc1.commandCallBack('today');">Today</a>
        
        Switch view: <a href="javascript:dpc1.commandCallBack('day');">Day view</a> -
        <a href="javascript:dpc1.commandCallBack('week');">Week view</a>

    </div>


    
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1"
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2006-12-31" 
        DataStartField="Start"
        DataEndField="End" 
        Days="7" 
        Width="100%" 
        ClientObjectName="dpc1" 
        OnCommand="DayPilotCalendar1_Command"

        
        
        

        

        >
    </DayPilot:DayPilotCalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
</asp:Content>
