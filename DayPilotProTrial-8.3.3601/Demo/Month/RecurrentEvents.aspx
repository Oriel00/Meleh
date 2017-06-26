<%@ Page Language="C#" MasterPageFile="~/Demo.master" AutoEventWireup="true" CodeFile="RecurrentEvents.aspx.cs"
    Inherits="Month_RecurrentEvents" Title="Recurring Events (Month) | DayPilot Pro for ASP.NET WebForms Demo" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <script type="text/javascript">
    
    function ask(e) {
       
        // it's a normal event
        if (!e.recurrent()) {
            edit(e);
            return;
        } 
        
        // it's a recurrent event but it's an exception from the series
        if (e.value() !== null) {
            edit(e);
            return;
        }

        var modal = new DayPilot.Modal();
        modal.top = 150;
        modal.width = 300;
        modal.height = 150;
        //modal.opacity = 0;
        modal.border = "10px solid #d0d0d0";
        modal.closed = function() { 
            alert("result:" + this.result);
            if(this.result != "cancel") { 
                edit(e, this.result);
            }
        };

        modal.showUrl("RecurrentEditMode.html");
    }

    function edit(e, mode) {
        var modal = new DayPilot.Modal();
        modal.top = 60;
        modal.width = 600;
        modal.height = 330;
        //modal.opacity = 0;
        modal.border = "10px solid #d0d0d0";
        modal.closed = function() { 
            if (this.result === "OK") {
                dpm.commandCallBack('refresh');
            }
        };

        var url = "RecurrentEventEdit.aspx?q=1"
        if (e.recurrentMasterId() !== null) {
            url += "&master=" + e.recurrentMasterId();
        }
        if (e.value() !== null) {
            url += "&id=" + e.value();
        }
        if (mode == "this") {
            url += "&start=" + e.start().toStringSortable();
        }
        modal.showUrl(url);
    }
    
    
    </script>

    <div class="note"><b>Note:</b> Read more about <a href="http://doc.daypilot.org/month/recurring-events/">recurring events</a> [doc.daypilot.org].</div>
    
    <DayPilot:DayPilotMonth 
        ID="DayPilotMonth1" 
        runat="server" 
        DataEndField="end" 
        DataStartField="start"
        DataTextField="name" 
        DataIdField="id" 
        DataTagFields="name, id" 
        DataRecurrenceField="recurrence"
        EventClickHandling="JavaScript"
        EventClickJavaScript="ask(e);" 
        ContextMenuID="DayPilotMenu1" 
        OnEventMenuClick="DayPilotCalendar1_EventMenuClick"
        ClientObjectName="dpm" 
        EventMoveHandling="CallBack"
        OnEventMove="DayPilotMonth1_EventMove"
        Width="100%" 
        EventResizeHandling="CallBack" 
        OnEventResize="DayPilotMonth1_EventResize"
        OnTimeRangeSelected="DayPilotMonth1_TimeRangeSelected"
        TimeRangeSelectedHandling="CallBack" 
        OnBeforeEventRender="DayPilotMonth1_BeforeEventRender" 
        BubbleID="DayPilotBubble1" 
        ShowToolTip="false" 
        EventStartTime="false" 
        EventEndTime="false" 
        OnCommand="DayPilotMonth1_Command" 
                    
                     
        OnBeforeCellRender="DayPilotMonth1_BeforeCellRender" 
        OnEventClick="DayPilotMonth1_EventClick" 
        HeaderClickHandling="JavaScript"
        ContextMenuSelectionID="DayPilotMenuSelection"
                    
        TimeRangeDoubleClickHandling="JavaScript"
        TimeRangeDoubleClickJavaScript="alert('doubleclick:' + start)"
                    
        RecurrentEventImage="~/Media/linked/recur10x9.png"
        RecurrentEventExceptionImage="~/Media/linked/recurex10x9.png"

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
    
    
    <DayPilot:DayPilotMenu ID="DayPilotMenuSelection" runat="server">
        <DayPilot:MenuItem Action="JavaScript" JavaScript="dpm.timeRangeSelectedCallBack(e.start, e.end);"
            Text="Create new event (JavaScript)" />
        <DayPilot:MenuItem Action="PostBack" Command="Insert" Text="Create new event (PostBack)" />
        <DayPilot:MenuItem Action="CallBack" Command="Insert" Text="Create new event (CallBack)" />
        <DayPilot:MenuItem Text="-" ></DayPilot:MenuItem>
        <DayPilot:MenuItem Action="JavaScript" JavaScript="alert('Start: ' + e.start.toString() + '\nEnd: ' + e.end.toString())"
            Text="Show selection details" />
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
