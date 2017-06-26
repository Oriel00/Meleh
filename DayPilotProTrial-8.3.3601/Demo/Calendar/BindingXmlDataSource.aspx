<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="BindingXmlDataSource.aspx.cs" Inherits="BindingXmlDataSource" 
Title="XmlDataSource Binding (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-loading/">loading calendar events</a> [doc.daypilot.org].</div>
    
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        TimeFormat="Clock12Hours" 
        DataStartField="Start" 
        DataEndField="End"  
        >
        </DayPilot:DayPilotCalendar>
    &nbsp;<br />
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
</asp:Content>

