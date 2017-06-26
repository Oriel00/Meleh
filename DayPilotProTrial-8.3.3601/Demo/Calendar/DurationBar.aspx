<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true"
 CodeFile="DurationBar.aspx.cs" Inherits="DurationBar" Title="Duration Bar (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/event-duration-bar/">event duration bar</a> [doc.daypilot.org].</div>
    Duration bar color:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Value="default">Defined by Theme</asp:ListItem>
        <asp:ListItem Value="hidden">Hidden</asp:ListItem>
    </asp:DropDownList><br />
    <br />
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataTextField="name" 
        DataIdField="id" 
        DataStartField="start" 
        DataEndField="end" 
        DurationBarVisible="true"
        
        ViewType="Week"
        ></DayPilot:DayPilotCalendar>
    &nbsp;&nbsp;<br />
    <br />
</asp:Content>

