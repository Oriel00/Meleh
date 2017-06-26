<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="Meleh_Start.UserDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/script.js"></script>
    <script type="text/javascript" src="js/bootstrap-multiselect.js"></script>
    <link rel="stylesheet" href="css/bootstrap-multiselect.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css" />
    <script type="text/javascript" src="DataTables/datatables.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>מל"כ - ניהול כוח אדם</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav class="navbar navbar-inverse navbar-static-top">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">Balance Web Development</a>
                    </div>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#">About</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Services<span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Design</a></li>
                                    <li><a href="#">Development</a></li>
                                    <li><a href="#">Consulting</a></li>
                                </ul>
                            </li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>

        <asp:TextBox ID="SearchUserDet" runat="server" AutoPostBack="True"></asp:TextBox>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MLHDBConnectionString %>" SelectCommand="SELECT * FROM [Users] WHERE ([FirstName] LIKE '%' + @FirstName + '%')" DeleteCommand="DELETE FROM [Users] WHERE [UserId] = @UserId" InsertCommand="INSERT INTO [Users] ([FirstName], [LastName], [NameENG], [Rank], [Type], [LastUpdate], [DivisionId], [SquadronId], [UnitId], [PhoNum], [MISC]) VALUES (@FirstName, @LastName, @NameENG, @Rank, @Type, @LastUpdate, @DivisionId, @SquadronId, @UnitId, @PhoNum, @MISC)" UpdateCommand="UPDATE [Users] SET [FirstName] = @FirstName, [LastName] = @LastName, [NameENG] = @NameENG, [Rank] = @Rank, [Type] = @Type, [LastUpdate] = @LastUpdate, [DivisionId] = @DivisionId, [SquadronId] = @SquadronId, [UnitId] = @UnitId, [PhoNum] = @PhoNum, [MISC] = @MISC WHERE [UserId] = @UserId" OnDeleted="SqlDataSource1_Deleted" OnUpdated="SqlDataSource1_Updated">
            <DeleteParameters>
                <asp:Parameter Name="UserId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="NameENG" Type="String" />
                <asp:Parameter Name="Rank" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
                <asp:Parameter Name="LastUpdate" Type="DateTime" />
                <asp:Parameter Name="DivisionId" Type="Int32" />
                <asp:Parameter Name="SquadronId" Type="Int32" />
                <asp:Parameter Name="UnitId" Type="Int32" />
                <asp:Parameter Name="PhoNum" Type="String" />
                <asp:Parameter Name="MISC" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SearchUserDet" DefaultValue="%" Name="FirstName" PropertyName="Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="NameENG" Type="String" />
                <asp:Parameter Name="Rank" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
                <asp:Parameter Name="LastUpdate" Type="DateTime" />
                <asp:Parameter Name="DivisionId" Type="Int32" />
                <asp:Parameter Name="SquadronId" Type="Int32" />
                <asp:Parameter Name="UnitId" Type="Int32" />
                <asp:Parameter Name="PhoNum" Type="String" />
                <asp:Parameter Name="MISC" Type="String" />
                <asp:Parameter Name="UserId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
        <h1>פרטים אישיים:</h1>
        <asp:ListBox ID="HideColumns" runat="server" DataSourceID="SqlDataSource4" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" Height="96px" Width="312px"></asp:ListBox>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:MLHDBConnectionString %>" SelectCommand="select COLUMN_NAME from MLHDB.INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users'"></asp:SqlDataSource>
        <br />
        <br/>

        <asp:GridView ID="UserGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="SqlDataSource1" AllowPaging="True" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" InsertVisible="False" />
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
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <br />
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="UserId" DataSourceID="SqlDataSource1">
            <EditItemTemplate>
                UserId:
                <asp:Label ID="UserIdLabel1" runat="server" Text='<%# Eval("UserId") %>' />
                <br />
                FirstName:
                <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
                <br />
                LastName:
                <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
                <br />
                NameENG:
                <asp:TextBox ID="NameENGTextBox" runat="server" Text='<%# Bind("NameENG") %>' />
                <br />
                Rank:
                <asp:TextBox ID="RankTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Rank") %>' />
                <br />
                Type:
                <asp:TextBox ID="TypeTextBox" runat="server" Text='<%# Bind("Type") %>' />
                <br />
                LastUpdate:
                <asp:TextBox ID="LastUpdateTextBox" runat="server" Text='<%# Bind("LastUpdate") %>' />
                <br />
                DivisionId:
                <asp:TextBox ID="DivisionIdTextBox" runat="server" Text='<%# Bind("DivisionId") %>' />
                <br />
                SquadronId:
                <asp:TextBox ID="SquadronIdTextBox" runat="server" Text='<%# Bind("SquadronId") %>' />
                <br />
                UnitId:
                <asp:TextBox ID="UnitIdTextBox" runat="server" Text='<%# Bind("UnitId") %>' />
                <br />
                PhoNum:
                <asp:TextBox ID="PhoNumTextBox" runat="server" Text='<%# Bind("PhoNum") %>' />
                <br />
                MISC:
                <asp:TextBox ID="MISCTextBox" runat="server" Text='<%# Bind("MISC") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>
                FirstName:
                <asp:TextBox ID="FirstNameTextBox" runat="server" Text='<%# Bind("FirstName") %>' />
                <br />
                LastName:
                <asp:TextBox ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>' />
                <br />
                NameENG:
                <asp:TextBox ID="NameENGTextBox" runat="server" Text='<%# Bind("NameENG") %>' />
                <br />
                Rank:
                <asp:TextBox ID="RankTextBox" runat="server" Text='<%# Bind("Rank") %>' />
                <br />
                Type:
                <asp:TextBox ID="TypeTextBox" runat="server" Text='<%# Bind("Type") %>' />
                <br />
                LastUpdate:
                <asp:TextBox ID="LastUpdateTextBox" runat="server" Text='<%# Bind("LastUpdate") %>' />
                <br />
                DivisionId:
                <asp:TextBox ID="DivisionIdTextBox" runat="server" Text='<%# Bind("DivisionId") %>' />
                <br />
                SquadronId:
                <asp:TextBox ID="SquadronIdTextBox" runat="server" Text='<%# Bind("SquadronId") %>' />
                <br />
                UnitId:
                <asp:TextBox ID="UnitIdTextBox" runat="server" Text='<%# Bind("UnitId") %>' />
                <br />
                PhoNum:
                <asp:TextBox ID="PhoNumTextBox" runat="server" Text='<%# Bind("PhoNum") %>' />
                <br />
                MISC:
                <asp:TextBox ID="MISCTextBox" runat="server" Text='<%# Bind("MISC") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                UserId:
                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                <br />
                FirstName:
                <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>' />
                <br />
                LastName:
                <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>' />
                <br />
                NameENG:
                <asp:Label ID="NameENGLabel" runat="server" Text='<%# Bind("NameENG") %>' />
                <br />
                Rank:
                <asp:Label ID="RankLabel" runat="server" Text='<%# Bind("Rank") %>' />
                <br />
                Type:
                <asp:Label ID="TypeLabel" runat="server" Text='<%# Bind("Type") %>' />
                <br />
                LastUpdate:
                <asp:Label ID="LastUpdateLabel" runat="server" Text='<%# Bind("LastUpdate") %>' />
                <br />
                DivisionId:
                <asp:Label ID="DivisionIdLabel" runat="server" Text='<%# Bind("DivisionId") %>' />
                <br />
                SquadronId:
                <asp:Label ID="SquadronIdLabel" runat="server" Text='<%# Bind("SquadronId") %>' />
                <br />
                UnitId:
                <asp:Label ID="UnitIdLabel" runat="server" Text='<%# Bind("UnitId") %>' />
                <br />
                PhoNum:
                <asp:Label ID="PhoNumLabel" runat="server" Text='<%# Bind("PhoNum") %>' />
                <br />
                MISC:
                <asp:Label ID="MISCLabel" runat="server" Text='<%# Bind("MISC") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>
        <br />
        <h1>הסמכות:</h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="FullName" HeaderText="FullName" ReadOnly="True" SortExpression="FullName" />
                <asp:BoundField DataField="CertName" HeaderText="CertName" SortExpression="CertName" />
                <asp:BoundField DataField="DateCert" HeaderText="DateCert" SortExpression="DateCert" />
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
        <br />
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MLHDBConnectionString %>" SelectCommand="SELECT Users.FirstName, Users.LastName, Certification.CertName, UserCertifications.DateCert, CONCAT(Users.FirstName, ' ',Users.LastName) AS  FullName FROM UserCertifications INNER JOIN Certification ON UserCertifications.CertId = Certification.CertId INNER JOIN Users ON UserCertifications.UserId = Users.UserId WHERE (Users.FirstName LIKE '%' + @FirstName + '%')" InsertCommand="INSERT INTO UserCertifications(CertId, UserId, DateCert) VALUES (@CertId, @UserId, @DateCert)">
            <InsertParameters>
                <asp:Parameter Name="CertId" />
                <asp:Parameter Name="UserId" />
                <asp:Parameter Name="DateCert" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SearchUserDet" DefaultValue="%" Name="FirstName" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MLHDBConnectionString %>" SelectCommand="SELECT [CertName], [CertId] FROM [Certification]"></asp:SqlDataSource>
        <br />
        <asp:Label ID="CertExistsError" runat="server" Text="Label">ההסמכה הזאת כבר קיימת למשתמש</asp:Label>
        <br />
        <asp:DropDownList ID="AddUserName" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="FirstName" DataValueField="UserId">
        </asp:DropDownList>
        <asp:DropDownList ID="AddCertName" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="CertName" DataValueField="CertId">
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

        <asp:Button ID="InsButton" runat="server" Text="Insert" OnClick="InsButton_Click" />

    </form>
</body>
</html>
