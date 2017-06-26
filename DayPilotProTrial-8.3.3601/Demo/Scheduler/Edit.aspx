<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Edit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>New event</title>
    <link href='../Media/empty.css' type="text/css" rel="stylesheet" /> 
</head>
<body style="background-color:white; margin:10px;">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellspacing="4" cellpadding="0">
            <tr>
                <td align="right"></td>
                <td>
                    <h2>Edit Event</h2>
                </td>
            </tr>
            <tr>
                <td align="right">Start:</td>
                <td><asp:TextBox ID="TextBoxStart" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">End:</td>
                <td><asp:TextBox ID="TextBoxEnd" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right">Resource:</td>
                <td><asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Value="A">Room A</asp:ListItem>
                    <asp:ListItem Value="A.1">Room A.1</asp:ListItem>
                    <asp:ListItem Value="A.1.1">Room A.1.1</asp:ListItem>
                    <asp:ListItem Value="A.1.2">Room A.1.2</asp:ListItem>
                    <asp:ListItem Value="A.2">Room A.2</asp:ListItem>
                    <asp:ListItem Value="B">Room B</asp:ListItem>
                    <asp:ListItem Value="C">Room C</asp:ListItem>
                    <asp:ListItem Value="D">Room D</asp:ListItem>
                    <asp:ListItem Value="E">Room E</asp:ListItem>
                    <asp:ListItem Value="F">Room F</asp:ListItem>
                    <asp:ListItem Value="G">Room G</asp:ListItem>
                    <asp:ListItem Value="H">Room H</asp:ListItem>
                    <asp:ListItem Value="I">Room I</asp:ListItem>
                    <asp:ListItem Value="J">Room J</asp:ListItem>
                    <asp:ListItem Value="K">Room K</asp:ListItem>
                    <asp:ListItem Value="L">Room L</asp:ListItem>
                    <asp:ListItem Value="M">Room M</asp:ListItem>
                    <asp:ListItem Value="N">Room N</asp:ListItem>
                    <asp:ListItem Value="O">Room O</asp:ListItem>
                    <asp:ListItem Value="P">Room P</asp:ListItem>
                    <asp:ListItem Value="Q">Room Q</asp:ListItem>
                    <asp:ListItem Value="R">Room R</asp:ListItem>
                    <asp:ListItem Value="S">Room S</asp:ListItem>
                    <asp:ListItem Value="T">Room T</asp:ListItem>
                    <asp:ListItem Value="U">Room U</asp:ListItem>
                    <asp:ListItem Value="V">Room V</asp:ListItem>
                    <asp:ListItem Value="W">Room W</asp:ListItem>
                    <asp:ListItem Value="X">Room X</asp:ListItem>
                    <asp:ListItem Value="Y">Room Y</asp:ListItem>
                    <asp:ListItem Value="Z">Room Z</asp:ListItem>
                </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right">Name:</td>
                <td><asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right"></td>
                <td>
                    <asp:Button ID="ButtonOK" runat="server" OnClick="ButtonOK_Click" Text="OK" />
                    <asp:Button ID="ButtonCancel" runat="server" Text="Cancel" OnClick="ButtonCancel_Click" />
                </td>
            </tr>
        </table>
        
        <a href="javascript:alert(modal.stretch)">Modal</a>
        </div>
    </form>
    <script type="text/javascript">
        document.getElementById("TextBoxName").focus();
    </script>

</body>
</html>
