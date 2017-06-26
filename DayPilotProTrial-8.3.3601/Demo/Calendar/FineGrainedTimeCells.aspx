<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="FineGrainedTimeCells.aspx.cs" Inherits="FineGrainedTimeCells" 
Title="Fine Grained Time Cells (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="note">
        <b>Note: </b> Read more about <a href="http://doc.daypilot.org/calendar/time-cell-duration/">cell duration</a> and <a href="http://doc.daypilot.org/calendar/cell-height/">cell height</a> [doc.daypilot.org].
    </div>

    Cell duration:
    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
        <asp:ListItem Value="120">120 minutes</asp:ListItem>
        <asp:ListItem Value="60">60 minutes</asp:ListItem>
        <asp:ListItem Value="30">30 minutes</asp:ListItem>
        <asp:ListItem Value="20">20 minutes</asp:ListItem>
        <asp:ListItem Selected="True" Value="15">15 minutes</asp:ListItem>
        <asp:ListItem Value="10">10 minutes</asp:ListItem>
        <asp:ListItem Value="5">5 minutes</asp:ListItem>
    </asp:DropDownList>
    cell height:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Selected="True" Value="15">15</asp:ListItem>
        <asp:ListItem Value="17">17</asp:ListItem>
        <asp:ListItem Value="20">20</asp:ListItem>
        <asp:ListItem Value="25">25</asp:ListItem>
        <asp:ListItem Value="50">50</asp:ListItem>
    </asp:DropDownList> pixels<br />
    <br />
    <daypilot:daypilotcalendar id="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        DataTagFields="name, id"
        StartDate="2010-01-01" 
        DataStartField="Start" 
        DataEndField="End" 
        CellDuration="15" 
        CellHeight="15"
        StoreEventsInViewState="true"     
        ></daypilot:daypilotcalendar>
    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>
</asp:Content>

