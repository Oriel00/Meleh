<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Meleh_Start.Users" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="SqlDataSource1">
                <Columns>
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
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MLHDBUsersDB %>" SelectCommand="SELECT * FROM [Users]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
