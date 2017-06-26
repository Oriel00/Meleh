<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Certs.aspx.cs" Inherits="Meleh_Start.Certs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head runat="server">
    <title></title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%--        <div class="container-fluid">
           <div class="jumbotron" style="border:1px solid #888; box-shadow:0px 2px 5px #ccc;">
                <h1>מל"כ - מערכת לניהול כוח אדם</h1>
            </div>--%>
            <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Meleh</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="#">Home</a></li>
      <li><a href="#">People</a></li>
      <li><a href="#">Weekly Arrangment</a></li>
      <li><a href="#">War</a></li>
    </ul>
  </div>
</nav>
        <form id="form1" runat="server">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MLHDBConnectionString2 %>" SelectCommand="SELECT * FROM [Certification] WHERE ([CertName] LIKE '%' + @CertName + '%')" DeleteCommand="DELETE FROM [Certification] WHERE [CertId] = @CertId" InsertCommand="INSERT INTO [Certification] ([CertName], [ConditionId], [DateCert]) VALUES (@CertName, @ConditionId, @DateCert)" UpdateCommand="UPDATE [Certification] SET [CertName] = @CertName, [ConditionId] = @ConditionId, [DateCert] = @DateCert WHERE [CertId] = @CertId">

                <DeleteParameters>
                    <asp:Parameter Name="CertId" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CertName" Type="String" />
                    <asp:Parameter Name="ConditionId" Type="Int32" />
                    <asp:Parameter Name="DateCert" DbType="Date" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchBox1" Name="CertName" PropertyName="Text" Type="String" DefaultValue="%" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CertName" Type="String" />
                    <asp:Parameter Name="ConditionId" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="DateCert" />
                    <asp:Parameter Name="CertId" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        
        <asp:TextBox ID="SearchBox1" runat="server" AutoPostBack="True" ></asp:TextBox>
        <asp:Button ID="SearchButt" runat="server" Text="Search" />
            <asp:DropDownList ID="DropDownList1" runat="server">
        </asp:DropDownList>
            <asp:GridView ID="CertGridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="CertId" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="CertId" HeaderText="CertId" InsertVisible="False" ReadOnly="True" SortExpression="CertId" />
                    <asp:BoundField DataField="CertName" HeaderText="הסמכה" SortExpression="CertName" />
                    <asp:BoundField DataField="ConditionId" HeaderText="כשיר?" SortExpression="ConditionId" />
                    <asp:BoundField DataField="DateCert" HeaderText="תאריך הסמכה" SortExpression="DateCert" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
        <asp:TextBox ID="AddName" runat="server"></asp:TextBox>
        <p>
            <asp:TextBox ID="AddCond" runat="server"></asp:TextBox>
        </p>
        <asp:DropDownList ID="openCal" runat="server" AutoPostBack="True" OnSelectedIndexChanged="openCal_SelectedIndexChanged">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem Selected="True">תאריך הסמכה</asp:ListItem>
        </asp:DropDownList>
        <asp:Calendar ID="AddDateCal" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px">
            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
            <NextPrevStyle VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#808080" />
            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
            <SelectorStyle BackColor="#CCCCCC" />
            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
            <WeekendDayStyle BackColor="#FFFFCC" />
        </asp:Calendar>
        <p>
            <asp:Button ID="InsButton" runat="server" OnClick="InsButton_Click" Text="Insert" />
        </p>
            
    </form>

</body>
</html>
