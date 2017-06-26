<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Export.aspx.cs" Inherits="Calendar_Export" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
<daypilot:daypilotcalendar id="DayPilotCalendar1" 
        runat="server" 
        dataendfield="end" 
        datastartfield="start" 
        datatextfield="name" 
        DataIdField="id" 
        datatagfields="name, id"
        DataAllDayField="allday"
        DataColumnField="column"
        Days="7" 
        HeightSpec="BusinessHours" 
        EventSelectColor="Blue"
        Showalldayevents="true"
         
        OnBeforeHeaderRender="DayPilotCalendar1_BeforeHeaderRender" 
        OnBeforeEventRender="DayPilotCalendar1_BeforeEventRender" 
        TimeFormat="Auto" 
        ViewType="Resources"
        HeaderLevels="2"
        
        

        ></daypilot:daypilotcalendar>
    </div>
    </form>
</body>
</html>
