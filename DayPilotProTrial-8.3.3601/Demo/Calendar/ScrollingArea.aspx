<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="ScrollingArea.aspx.cs" Inherits="ScrollingArea" Title="Scrolling Area (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note">
        <b>Note:</b> Setting the calendar <a href="http://doc.daypilot.org/calendar/height/">height</a> and <a href="http://doc.daypilot.org/calendar/fixed-column-width/">column width</a> will influence the scrollbars.
    </div>

    <div class="note">
    Height:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Value="businesshours" Selected="True">Business hours</asp:ListItem>
        <asp:ListItem Value="fixed">Fixed (200 pixels)</asp:ListItem>
        <asp:ListItem Value="businesshoursnoscrolling">Business hours (no scrolling)</asp:ListItem>
        <asp:ListItem Value="full">Full (no scrolling)</asp:ListItem>
    </asp:DropDownList>

    Column width:
    <asp:DropDownList ID="DropDownListColWidth" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownListColWidth_OnSelectedIndexChanged">
        <asp:ListItem Value="auto">Auto</asp:ListItem>
        <asp:ListItem Value="fixed">Fixed (300 pixels)</asp:ListItem>
    </asp:DropDownList>
    
   </div>
    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        DataColumnField="Column" 
        DataEndField="End" 
        DataSourceID="XmlDataSource1" 
        DataStartField="Start" 
        DataTextField="Name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        
        HeightSpec="BusinessHours"
        ColumnWidthSpec="Auto"
        ColumnWidth="300"
        
        ViewType="Week"
        ></daypilot:daypilotcalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
</asp:Content>

