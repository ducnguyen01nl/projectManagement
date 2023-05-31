<%@ Page Title="" Language="C#" MasterPageFile="~/LayOut/LayOutHeader.Master" AutoEventWireup="true" CodeBehind="DeleteTaskPage.aspx.cs" Inherits="BTL_LTWNC.DeleteTaskPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/DeleteTaskPage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form id="formDelete" runat="server">
        <h1>XÓA VIỆC</h1>

        <label for="DropDownListTask"><i class="fas fa-file-signature icon" style="color: #0aea06;"></i>Chọn việc cần xóa</label>
        <asp:DropDownList ID="DropDownListTask" CssClass="DropDownListTask" runat="server" >
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <div class="listBtn">
            <asp:Button ID="ButtonOk" CssClass="btn btnOk" runat="server" Text="Cập nhật" OnClick="ButtonOk_Click" />
            <asp:Button ID="ButtonCancel" CssClass="btn btnCancel" runat="server" Text="Hủy chỉnh sửa" OnClick="ButtonCancel_Click"  />
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
