<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" 
CodeFile="ShowHeader.aspx.cs" Inherits="ShowHeader" Title="Show Header (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" Culture="en-US" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Value="True">Show header</asp:ListItem>
        <asp:ListItem Selected="True" Value="False">Hide header</asp:ListItem>
    </asp:DropDownList><br />
    <br />
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataSourceID="XmlDataSource1" 
        DataTextField="name" 
        DataIdField="id" 
        StartDate="2010-01-01" 
        TimeFormat="Clock12Hours" 
        DataStartField="Start" 
        DataEndField="End"  
        ShowHeader="false"
            >
        </DayPilot:DayPilotCalendar>

    <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/App_Data/TestingData.xml">
    </asp:XmlDataSource>

</asp:Content>

