<%@ Page Title="" Language="C#" MasterPageFile="~/LayOut/LayOutHeader.Master" AutoEventWireup="true" CodeBehind="NewTaskPage.aspx.cs" Inherits="BTL_LTWNC.NewTaskPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/newTask.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="formNewTask" runat="server" onsubmit="return validate();">
        <h1>THÊM VIỆC MỚI</h1>
        
        <label for="TextNameWork"><i class="fas fa-file-signature icon" style="color: #0aea06;"></i>Tên việc</label>
        <asp:TextBox ID="TextNameWork" runat="server" placeholder="Tên việc" CssClass="TextNameWork"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Tên việc không được để trống" ControlToValidate="TextNameWork" ForeColor="#FF3300" ValidationGroup="ValidateGroup"></asp:RequiredFieldValidator>
        
        <label for="TextDes"><i class="fas fa-audio-description icon" style="color: #0aea06  ;"></i>Mô tả</label>
        <asp:TextBox ID="TextDes" runat="server" placeholder="Mô tả" CssClass="TextNameWork"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Mô tả không được để trống" ControlToValidate="TextDes" ForeColor="#FF3300" ValidationGroup="ValidateGroup"></asp:RequiredFieldValidator>
        

        <div class="taskTime">
            <div>
                <label for="timeStart">Ngày bắt đầu</label>
                <input type="date" id="timeStart" name="start"  onchange= "changeTimeStart()">
                <asp:HiddenField ID="HiddenFieldTimeStart" runat="server" />

            </div>
            <div>
                <label for="timeEnd">Ngày kết thúc</label>
                <input type="date" id="timeEnd" name="end"  onchange= "changeTimeEnd()">
                <asp:HiddenField ID="HiddenFieldTimeEnd" runat="server" />

            </div>
        </div>

        <label for="DropDownListNameEmployee"><i class="fas fa-user-shield icon" style="color: #0aea06;"></i>Nhân viên đảm nhận</label>
        <asp:DropDownList  ID="DropDownListNameEmployee" CssClass="DropDownListNameEmployee" runat="server"></asp:DropDownList>

        <div class="listBtn">
            <asp:Button ID="ButtonOk" CssClass="btn btnOk" runat="server" Text="Thêm mới" OnClick="ButtonOk_Click" OnClientClick="validate()" ValidationGroup="ValidateGroup" />
            <asp:Button ID="ButtonCancel" CssClass="btn btnCancel" runat="server" Text="Hủy thêm mới" OnClick="ButtonCancel_Click"  />
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script>
        function validate() {
            if (!changeTimeStart() || !changeTimeEnd()) {
                return false; // nếu có lỗi, ngăn chặn form được gửi đi
            }
            return true;
        }

        function changeTimeStart() {
            var timeStartInput = document.getElementById("timeStart");
            var timeStartValue = timeStartInput.value;
            //được sử dụng để chuyển đổi một đối tượng Date sang chuỗi đại diện cho ngày giờ đó dưới định dạng chuẩn ISO 8601
            var currentTime = new Date().toISOString().slice(0, 10);
            if (timeStartValue === "") {
                alert("Ngày bắt đầu không được để trống");
                return false;
            }
            else {

                if (timeStartValue < currentTime) {
                    alert("Ngày bắt đầu phải lớn hơn ngày hiện tại");
                    timeStartInput.value = null;
                    return false;
                }
                else {
                    return true;
                    document.getElementById("<%= HiddenFieldTimeStart.ClientID %>").value = timeStartValue;
                }
            }
        }
        function changeTimeEnd() {

            var timeStartInput = document.getElementById("timeStart");
            var timeEndInput = document.getElementById("timeEnd");
            var timeEndValue = timeEndInput.value;
            if (timeEndValue === "") {
                alert("Ngày kết thúc không được để trống");
                return false;
            }
            else if (timeStartInput.value > timeEndValue) {
                alert("Ngày kết thúc phải lớn hơn ngày hiện tại");
                timeEndInput.value = null;
                return false;
            }
            else {

                document.getElementById("<%= HiddenFieldTimeEnd.ClientID %>").value = timeEndValue;
                return true;
            }
        }
        
    </script>
</asp:Content>
