<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="Meleh_Start.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged1"></asp:TextBox>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="mainUSER" Height="214px" Width="362px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged1">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" />
                    <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                    <asp:BoundField DataField="NameENG" HeaderText="NameENG" SortExpression="NameENG" />
                    <asp:BoundField DataField="Rank" HeaderText="Rank" SortExpression="Rank" />
                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                    <asp:BoundField DataField="LastUpdate" HeaderText="עדכון אחרון" SortExpression="LastUpdate" />
                    <asp:BoundField DataField="DivisionId" HeaderText="DivisionId" SortExpression="DivisionId" />
                    <asp:BoundField DataField="SquadronId" HeaderText="SquadronId" SortExpression="SquadronId" />
                    <asp:BoundField DataField="UnitId" HeaderText="UnitId" SortExpression="UnitId" />
                    <asp:BoundField DataField="PhoNum" HeaderText="PhoNum" SortExpression="PhoNum" />
                    <asp:BoundField DataField="MISC" HeaderText="MISC" SortExpression="MISC" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="mainUSER" runat="server" ConnectionString="<%$ ConnectionStrings:MLHDBConnectionString %>" SelectCommand="SELECT * FROM [Users]"></asp:SqlDataSource>
        </div>
        <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="UserId" DataSourceID="mainUSER" Height="133px" Width="220px">
            <Fields>
                <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="NameENG" HeaderText="NameENG" SortExpression="NameENG" />
                <asp:BoundField DataField="Rank" HeaderText="Rank" SortExpression="Rank" />
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                <asp:BoundField DataField="LastUpdate" HeaderText="LastUpdate" SortExpression="LastUpdate" />
                <asp:BoundField DataField="DivisionId" HeaderText="DivisionId" SortExpression="DivisionId" />
                <asp:BoundField DataField="SquadronId" HeaderText="SquadronId" SortExpression="SquadronId" />
                <asp:BoundField DataField="UnitId" HeaderText="UnitId" SortExpression="UnitId" />
                <asp:BoundField DataField="PhoNum" HeaderText="PhoNum" SortExpression="PhoNum" />
                <asp:BoundField DataField="MISC" HeaderText="MISC" SortExpression="MISC" />
            </Fields>
        </asp:DetailsView>
    </form>
</body>
</html>
