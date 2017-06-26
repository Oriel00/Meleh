<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="Localization.aspx.cs"
    Inherits="Month_Localization" Title="Localization (Month) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="note"><b>Note:</b> Read more about the <a href="http://doc.daypilot.org/month/localization/">localization</a> [doc.daypilot.org].</div>

    <asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem Value="">Default (inherited)</asp:ListItem>
        <asp:ListItem Value="zh-CN">Chinese (zh-CN)</asp:ListItem>
        <asp:ListItem Value="cs-CZ">Czech (cs-CZ)</asp:ListItem>
        <asp:ListItem Value="nl-NL">Dutch (nl-NL)</asp:ListItem>
        <asp:ListItem Value="en-US">English (en-US)</asp:ListItem>
        <asp:ListItem Value="fr-FR">French (fr-FR)</asp:ListItem>
        <asp:ListItem Value="de-DE">German (de-DE)</asp:ListItem>
        <asp:ListItem Value="ja-JP">Japanese (ja-JP)</asp:ListItem>
        <asp:ListItem Value="ru-RU">Russian (ru-RU)</asp:ListItem>
        <asp:ListItem Value="es-ES">Spanish (es-ES)</asp:ListItem>
    </asp:DropDownList>
    <asp:Button ID="ButtonChange" runat="server" OnClick="ButtonChange_Click" Text="Change" /><br />

    <p>The current culture determines the behavior:</p>
    <ul>
        <li>First day of week (Sunday/Monday)</li>
        <li>Language of the day and month names</li>
        <li>Time format (12/24 hours)</li>
    </ul>

    <br />
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
        OnBeforeHeaderRender="DayPilotMonth1_BeforeHeaderRender" 
        OnTimeRangeSelected="DayPilotMonth1_TimeRangeSelected"
        TimeRangeSelectedHandling="CallBack" 
        OnBeforeEventRender="DayPilotMonth1_BeforeEventRender" 
        BubbleID="DayPilotBubble1" 
        OnRefresh="DayPilotMonth1_Refresh" 
        OnBeforeCellRender="DayPilotMonth1_BeforeCellRender"
        ShowToolTip="false" 
        
         
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
    
        <DayPilot:DayPilotBubble 
        ID="DayPilotBubble1" 
        runat="server" 
        OnRenderContent="DayPilotBubble1_RenderContent" 
        ClientObjectName="bubble"
        UseShadow="True"
        >
    </DayPilot:DayPilotBubble>
    

</asp:Content>
