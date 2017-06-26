<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="ExternalDragDrop.aspx.cs"
    Inherits="Calendar_ExternalDragDrop" Title="External Drag & Drop (Calendar) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/calendar/external-drag-and-drop/">external drag and drop</a> [doc.daypilot.org].</div>
    <DayPilot:DayPilotCalendar ID="DayPilotCalendar1" runat="server" 
        DataEndField="end"
        EventMoveJavaScript="dpc1.eventMoveCallBack(e, newStart, newEnd, oldColumn, newColumn);"
        ClientObjectName="dpc1" 
        DataStartField="start" 
        DataTextField="name" 
        DataIdField="id" 
        DataAllDayField="allday"
        OnEventMove="DayPilotCalendar1_EventMove" 
        Days="7" 
        EventMoveHandling="JavaScript"
        >
    </DayPilot:DayPilotCalendar>
    <p>Drag items from this list to the calendar:</p>
    <ul id="external">
        <li data-id="123" data-duration="1800"><span style="cursor:move">Item #123 (30 minutes)</span></li>
        <li data-id="124" data-duration="3600"><span style="cursor:move">Item #124 (60 minutes)</span></li>
    </ul>

    <script type="text/javascript">
        var parent = document.getElementById("external");
        var items = parent.getElementsByTagName("li");
        for (var i = 0; i < items.length; i++) {
            var e = items[i];
            var item = {
                element: e,
                id: e.getAttribute("data-id"),
                text: e.innerText,
                duration: e.getAttribute("data-duration")
            };
            DayPilot.Calendar.makeDraggable(item);
        }
    </script>
    
</asp:Content>
