<%@ Page Title="" Language="C#" MasterPageFile="~/LayOut/LayOutHeader.Master" AutoEventWireup="true" CodeBehind="NewGroupWorkPage.aspx.cs" Inherits="BTL_LTWNC.NewGroupWorkPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/newGroupWork.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <form id="formNewGroupWork" runat="server">
        <h1>THÊM NHÓM VIỆC MỚI</h1>

        
        <label for="TextNameGroupWork"><i class="fas fa-file-signature icon" style="color: #0aea06;"></i>Tên nhóm việc</label>
        <asp:TextBox ID="TextNameGroupWork" runat="server" placeholder="Tên nhóm việc" CssClass="TextNameWork"></asp:TextBox>
        <asp:RequiredFieldValidator ID="NameGroupWorkValidator" runat="server" ControlToValidate="TextNameGroupWork" ValidationGroup="NewGroupWorkValidation" ForeColor="#FF3300" ErrorMessage="Tên nhóm việc là bắt buộc" />
        

 
        
        <label for="DropDownListNameEmployee"><i class="fas fa-user-shield icon" style="color: #0aea06;"></i>Leader</label>
        <asp:DropDownList ID="DropDownListNameEmployee" CssClass="DropDownListNameEmployee" runat="server"></asp:DropDownList>

        <div class="listBtn">
            <asp:Button ID="ButtonOk" CssClass="btn btnOk" runat="server" Text="Thêm mới" OnClick="ButtonOk_Click" ValidationGroup="NewGroupWorkValidation" />
            <asp:Button ID="ButtonCancel" CssClass="btn btnCancel" runat="server" Text="Hủy thêm mới" OnClick="ButtonCancel_Click" />
        </div>
    </form>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
