<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Meleh_Start.Default" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<DayPilot:DayPilotScheduler 
  ID="DayPilotScheduler1" 
  runat="server" 
  
  DataStartField="eventstart" 
  DataEndField="eventend" 
  DataTextField="name" 
  DataIdField="id" 
  DataResourceField="resource_id" 
  
  CellGroupBy="Month"
  Scale="Day"
  
  EventMoveHandling="CallBack" 
  OnEventMove="DayPilotScheduler1_EventMove" 
  >
</DayPilot:DayPilotScheduler>
    </form>
</body>
</html>
