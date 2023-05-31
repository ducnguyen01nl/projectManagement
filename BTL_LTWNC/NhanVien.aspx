<%@ Page Title="" Language="C#" MasterPageFile="~/LayOut/LayOutHeader.Master" AutoEventWireup="true" CodeBehind="NhanVien.aspx.cs" Inherits="BTL_LTWNC.NhanVien2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Quan ly nhan vien</title>
    <link href="Styles/thang_css.css" rel="stylesheet" /> 
    <%--<link href="LayOut/style.css" rel="stylesheet" />--%>
    <link href="Styles/index.css" rel="stylesheet" />

    <style>
        .form2{
            height: 90%;
        }


        label {
          margin-bottom: 5px;
        }

        input, select {
          padding: 5px;
          border: 1px solid #ccc;
          border-radius: 4px;
          font-size: 16px;
        }

        #themMoi {
            display: none;
        }
        #suaNhanVien{
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-input">
        <h1>Quản lý nhân viên</h1>
        <div class="btn-header">
            <button onclick="ThemTaiKhoan()" class="view-button" id="btnTaoMoi"> + Thêm nhân viên</button>
            <button onclick="DanhSachTaiKhoan()" class="view-button" id="btnNhanVien">Danh sách tài khoản</button>
        </div>
        <table class="auto-style1">
            <thead>
                <tr>
                    <td>
                        Tên nhân viên
                    </td>
                    <td>
                        Ngày sinh
                    </td>
                    <td>
                        Giới tính
                    </td>
                    <td>
                        Chức vụ
                    </td>
                    <td>
                        CCCD
                    </td>
                    <td>
                        Email
                    </td>
                    <td>
                        Số điện thoại
                    </td>
                    <td>
                        Chức năng
                    </td>
                </tr>
            </thead>
            <tbody>
                <!--<tr>
                    <td>Thắng</td>
                    <td>11/10/2001</td>
                    <td>Nam</td>
                    <td>Nhân viên</td>
                    <td>Email</td>
                    <td>0328080499</td> 
                    <td>Hà Nội</td>
                    <td style="text-align:center"> 
                        <button class="edit-button" onclick="Sua()">Sửa</button>
                        <button class="delete-button" onclick="Xoa(1)">Xóa</button>
                    </td>
                </tr>-->
                <asp:ListView ID="ListView1" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("NAME") %></td>
                            <td><%# XuLyDate(Eval("BIRTHDAY")) %></td>
                            <td><%# XuLyGioiTinh(Eval("GENDER")) %></td>
                            <td><%# Eval("ROLE_NAME") %></td>
                            <td><%# Eval("CCCD") %></td>
                            <td><%# Eval("EMAIL") %></td>
                            <td><%# Eval("PHONE") %></td>
                            <td style="text-align:center"> 
                                <button class="edit-button" onclick="Sua(<%# Eval("EMPLOYEE_ID") %>)">Sửa</button>
                                <button class="delete-button" onclick="Xoa(<%# Eval("EMPLOYEE_ID") %>)">Xóa</button>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </tbody>
        </table>
    </div>

    <div class="form2 form-show" id="themMoi">
        <h1>THÊM NHÂN VIÊN</h1>
        <div class="form-add">
            <div class="form-row row">
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Tên nhân viên</label>
                        <input type="text" id="txtName" name="txtName"/>
                        <label class="error" id="ErrorName"></label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Ngày sinh</label>
                        <input type="date" id="txtNgaySinh" name="txtngaySinh"/>
                        <label class="error" id="ErrorDate"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="col-md-6">
                    <div class="form-add" >
                        <label class="lb">Giới tính</label>
                        <select id="gender" class="slect-input">
                            <option value ="1">Nam</option>
                            <option value ="0">Nữ</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Chức vụ</label>
                        <select id="slRole" class="slect-input">
                            <option value ="-1">Mời bạn chọn chức vụ</option>
                            <option value ="1">PM</option>
                            <option value ="2">Leader</option>
                            <option value ="3">Nhân viên</option>
                        </select>
                        <label class="error" id="ErrorRole"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Số CCCD</label>
                        <input type="number" id="txtCCCD" name="txtCCCD" max="999999999999"/>
                        <label class="error" id="ErrorCCCD"></label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Email</label>
                        <input type="text" id="txtEmail" name="txtEmail"/>
                        <label class="error" id="ErrorEmail"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="col-md-6">
                        <div class="form-add">
                        <label class="lb">Phone</label>
                        <input type="number" id="txtPhone" name="txtPhone" max="9999999999"/>
                        <label class="error" id="ErrorPhone"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="btn"> 
                    <button onclick="TroVe()" class="delete-button" id="delete-button-themMoi">Trở về</button>
                    <button onclick="TaoMoi()" class="edit-button">Tạo mới</button>
                </div>
            </div>
        </div>
    </div>

    <div class="form2 form-show" id="suaNhanVien">
        <h1>SỬA NHÂN VIÊN</h1>
        <input type="hidden" id="txtEmployeeId"/>
        <div class="form-add">
            <div class="form-row row">
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Tên nhân viên</label>
                        <input type="text" id="txtName-edit" name="txtName" maxlength="50"/>
                        <label class="error" id="ErrorName-edit"></label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Ngày sinh</label>
                        <input type="date" id="txtNgaySinh-edit" name="txtNgaySinh"/>
                        <label class="error" id="ErrorDate-edit"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="col-md-6">
                    <div class="form-add" >
                        <label class="lb">Giới tính</label>
                        <select id="gender-edit" class="slect-input">
                            <option value ="1">Nam</option>
                            <option value ="0">Nữ</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Chức vụ</label>
                        <select id="slRole-edit" class="slect-input">
                            <option value ="-1">Mời bạn chọn chức vụ</option>
                            <option value ="1">PM</option>
                            <option value ="2">Leader</option>
                            <option value ="3">Nhân viên</option>
                        </select>
                        <label class="error" id="ErrorRole-edit"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Số CCCD</label>
                        <input type="number" id="txtCCCD-edit" name="txtCCCD" max ="999999999999"/>
                        <label class="error" id="ErrorCCCD-edit"></label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-add">
                        <label class="lb">Email</label>
                        <input type="text" id="txtEmail-edit" name="txtEmail"/>
                        <label class="error" id="ErrorEmail-edit"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="col-md-6">
                        <div class="form-add">
                        <label class="lb">Phone</label>
                        <input type="number" id="txtPhone-edit" name="txtPhone" max ="9999999999"/>
                        <label class="error" id="ErrorPhone-edit"></label>
                    </div>
                </div>
            </div>
            <div class="form-row row">
                <div class="btn"> 
                    <button onclick="TroVe()" class="delete-button" id="delete-button-edit">Trở về</button>
                    <button onclick="Edit()" class="edit-button">Sửa</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        document.getElementById("btnTaoMoi").onclick = function () {
            document.getElementById("themMoi").style.display = 'block';
        };

        document.getElementById("delete-button-themMoi").onclick = function () {
            resetFormThemNhanVien();
            document.getElementById("themMoi").style.display = 'none';
        };

        document.getElementById("delete-button-edit").onclick = function () {
            resetFormThemNhanVien_edit();
            document.getElementById("suaNhanVien").style.display = 'none';
        };

        function DanhSachTaiKhoan() {
            window.location.assign("/Admin.aspx")
        }

        function Sua(id) {
            let txtName = document.getElementById("txtName-edit");
            let txtngaySinh = document.getElementById("txtNgaySinh-edit");
            let gender = document.getElementById("gender-edit");
            let slRole = document.getElementById("slRole-edit");
            let txtCCCD = document.getElementById("txtCCCD-edit");
            let txtEmail = document.getElementById("txtEmail-edit");
            let txtPhone = document.getElementById("txtPhone-edit");
            let txtEmployeeId = document.getElementById("txtEmployeeId");
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    var obj = JSON.parse(xhttp.responseText);
                    txtEmployeeId.value = obj[0]["EMPLOYEE_ID"]
                    txtName.value = obj[0]["NAME"];
                    const birthday = obj[0]["BIRTHDAY"] != null ? new Date(obj[0]["BIRTHDAY"]) : null;
                    const localDate = new Date(birthday.getTime() - (birthday.getTimezoneOffset() * 60000));
                    txtngaySinh.value = localDate.toISOString().slice(0, 10);
                    slRole.value = obj[0]["ROLE"];
                    gender.value = obj[0]["GENDER"] ? "1" : "0";
                    txtCCCD.value = obj[0]["CCCD"];
                    txtEmail.value = obj[0]["EMAIL"];
                    txtPhone.value = obj[0]["PHONE"];
                    document.getElementById("suaNhanVien").style.display = 'block';  
                }
            };
            xhttp.open("GET", "XuLyNhanVien.aspx?employeeId="+id, true);
            xhttp.send();
        }

        function resetFormThemNhanVien() {
            let txtName = document.getElementById("txtName").value = "";
            let txtngaySinh = document.getElementById("txtNgaySinh").value = "";
            let slRole = document.getElementById("slRole").value = "-1";
            let txtCCCD = document.getElementById("txtCCCD").value = "";
            let txtEmail = document.getElementById("txtEmail").value = "";
            let txtPhone = document.getElementById("txtPhone").value = "";
            let ErrorName = document.getElementById("ErrorName").innerHTML = "";
            let ErrorRole = document.getElementById("ErrorRole").innerHTML = "";
            let ErrorDate = document.getElementById("ErrorDate").innerHTML = "";
        }

        function resetFormThemNhanVien_edit() {
            let txtName = document.getElementById("txtName-edit").value = "";
            let txtngaySinh = document.getElementById("txtNgaySinh-edit").value = "";
            let slRole = document.getElementById("slRole-edit").value = "-1";
            let txtCCCD = document.getElementById("txtCCCD-edit").value = "";
            let txtEmail = document.getElementById("txtEmail-edit").value = "";
            let txtPhone = document.getElementById("txtPhone-edit").value = "";
            let ErrorName = document.getElementById("ErrorName-edit").innerHTML = "";
            let ErrorRole = document.getElementById("ErrorRole-edit").innerHTML = "";
            let ErrorDate = document.getElementById("ErrorDate-edit").innerHTML = "";
        }

        function validateTaoMoi() {
            let validateName1 = validateName();
            let validateNgaySinh1 = validateNgaySinh();
            let validateRole1 = validateRole();
            let vatidateCCCD1 = validateCCCD();
            let vatidatePhone1 = validatePhone();
            return validateName1 && validateNgaySinh1 && validateRole1 && vatidateCCCD1 && vatidatePhone1
        }

        function validateCCCD() {
            let txtCCCD = document.getElementById("txtCCCD").value;
            let ErrorCCCD = document.getElementById("ErrorCCCD");
            if (txtCCCD.trim().length == 0) {
                ErrorCCCD.innerHTML = "";
                return true;
            } else if (txtCCCD.trim().length == 12) {
                ErrorCCCD.innerHTML = "";
                return true;
            } else {
                ErrorCCCD.innerHTML = "CCCD không hợp lệ";
                return false;
            }
        }

        function validatePhone() {
            let txtPhone = document.getElementById("txtPhone").value;
            let ErrorPhone = document.getElementById("ErrorPhone");
            if (txtPhone.trim().length == 0) {
                ErrorPhone.innerHTML = "";
                return true;
            } else if (txtPhone.trim().length == 10) {
                ErrorPhone.innerHTML = "";
                return true;
            } else {
                ErrorPhone.innerHTML = "Phone không hợp lệ";
                return false;
            }
        }

        function validateNgaySinh() {
            let txtngaySinh = document.getElementById("txtNgaySinh").value;
            let ErrorDate = document.getElementById("ErrorDate");
            let bool = validateDate(txtngaySinh);
            if (bool) {
                ErrorDate.innerHTML = "";
                return true;
            }
            ErrorDate.innerHTML = "Ngày sinh không hợp lệ";
            return false;
        }

        function validateRole() {
            let slRole = document.getElementById("slRole").value;
            let ErrorRole = document.getElementById("ErrorRole");
            if (slRole == "-1") {
                ErrorRole.innerHTML = "Mời bạn nhập chức vụ"
                return false;
            }
            ErrorRole.innerHTML = ""
            return true;
        }

        function validateName() {
            let txtName = document.getElementById("txtName").value;
            let bool = isFullName(txtName);
            let ErrorName = document.getElementById("ErrorName");
            if (txtName.trim().length === 0) {
                ErrorName.innerHTML = "Mời bạn nhập tên";
                return false;
            } else if (!bool) {
                ErrorName.innerHTML = "Nhập tên không hợp lệ";
                return false;
            } else {
                ErrorName.innerHTML = "";
                return true;
            }
        }

        function isFullName(input) {
            const nameRegex = /^[\p{L}\s'-]+$/u; // Biểu thức chính quy để kiểm tra họ tên
            return nameRegex.test(input);
        }

        function validateDate(inputDate) {
            // Kiểm tra định dạng ngày tháng bằng biểu thức chính quy
            const dateFormat = /^\d{4}-\d{2}-\d{2}$/;
            if (!inputDate.match(dateFormat)) {
                return false; // Nếu không phù hợp với định dạng, trả về false
            }

            // Kiểm tra tính hợp lệ của ngày tháng
            const date = new Date(inputDate);
            if (isNaN(date.getTime())) {
                return false; // Nếu không hợp lệ, trả về false
            }

            // Kiểm tra xem đối tượng Date được tạo có đúng là ngày tháng đã nhập
            const year = date.getFullYear();
            const month = date.getMonth() + 1;
            const day = date.getDate();
            const inputDateParts = inputDate.split("-");
            const inputYear = parseInt(inputDateParts[0], 10);
            const inputMonth = parseInt(inputDateParts[1], 10);
            const inputDay = parseInt(inputDateParts[2], 10);
            if (year !== inputYear || month !== inputMonth || day !== inputDay) {
                return false; // Nếu không hợp lệ, trả về false
            }

            return true; // Nếu hợp lệ, trả về true
        }

        function TaoMoi() {
            if (validateTaoMoi()) {
                let txtName = document.getElementById("txtName").value;
                let txtNgaySinh = document.getElementById("txtNgaySinh").value;
                let gender = document.getElementById("gender").value;
                let slRole = document.getElementById("slRole").value;
                let txtCCCD = document.getElementById("txtCCCD").value;
                let txtEmail = document.getElementById("txtEmail").value;
                let txtPhone = document.getElementById("txtPhone").value;
                //xuLy = 1 : Thêm
                const data = { EmployeeId: txtEmployeeId, Name: txtName, NgaySinh: txtNgaySinh, Gender: gender, Role: slRole, CCCD: txtCCCD, Email: txtEmail, Phone: txtPhone, XuLy: 1 };
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        alert(xhttp.responseText);
                        document.getElementById("themMoi").style.display = 'none';
                        location.reload();
                    }
                };
                xhttp.open("POST", "XuLyNhanVien.aspx", true);
                xhttp.setRequestHeader('Content-Type', 'application/json');
                xhttp.send(JSON.stringify(data));
            }
            
        }

        function Edit() {
            if (validateEdit()) {
                let txtEmployeeId = document.getElementById("txtEmployeeId").value;
                let txtName = document.getElementById("txtName-edit").value;
                let txtNgaySinh = document.getElementById("txtNgaySinh-edit").value;
                let gender= document.getElementById("gender-edit").value;
                let slRole = document.getElementById("slRole-edit").value;
                let txtCCCD = document.getElementById("txtCCCD-edit").value;
                let txtEmail = document.getElementById("txtEmail-edit").value;
                let txtPhone = document.getElementById("txtPhone-edit").value;
                //xuLy = 2 : Sửa
                const data = { EmployeeId: txtEmployeeId, Name: txtName, NgaySinh: txtNgaySinh, Gender: gender, Role: slRole, CCCD: txtCCCD, Email: txtEmail, Phone: txtPhone, XuLy: 2 };
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        alert(xhttp.responseText);
                        document.getElementById("suaNhanVien").style.display = 'none';
                        location.reload();
                    }
                };
                xhttp.open("POST", "XuLyNhanVien.aspx", true);
                xhttp.setRequestHeader('Content-Type', 'application/json');
                xhttp.send(JSON.stringify(data));
            }
            
        }

        function validateEdit() {
            let validateName = validateName_edit();
            let validateNgaySinh = validateNgaySinh_edit();
            let validateRole = validateRole_edit();
            let vatidateCCCD = validateCCCD_edit();
            let vatidatePhone = validatePhone_edit();
            return validateName && validateNgaySinh && validateRole && vatidateCCCD && vatidatePhone
        }

        function validateName_edit() {
            let txtName = document.getElementById("txtName-edit").value;
            let bool = isFullName(txtName);
            let ErrorName = document.getElementById("ErrorName-edit");
            if (txtName.trim().length === 0) {
                ErrorName.innerHTML = "Mời bạn nhập tên";
                return false;
            } else if (!bool) {
                ErrorName.innerHTML = "Nhập tên không hợp lệ";
                return false;
            } else {
                ErrorName.innerHTML = "";
                return true;
            }
        }

        function validateNgaySinh_edit() {
            let txtngaySinh = document.getElementById("txtNgaySinh-edit").value;
            let ErrorDate = document.getElementById("ErrorDate-edit");
            let bool = validateDate(txtngaySinh);
            if (bool) {
                ErrorDate.innerHTML = "";
                return true;
            }
            ErrorDate.innerHTML = "Ngày sinh không hợp lệ";
            return false;
        }

        function validateRole_edit() {
            let slRole = document.getElementById("slRole-edit").value;
            let ErrorRole = document.getElementById("ErrorRole-edit");
            if (slRole == "-1") {
                ErrorRole.innerHTML = "Mời bạn nhập chức vụ"
                return false;
            }
            ErrorRole.innerHTML = ""
            return true;

        }

        function validateCCCD_edit() {
            let txtCCCD = document.getElementById("txtCCCD-edit").value;
            let ErrorCCCD = document.getElementById("ErrorCCCD-edit");
            if (txtCCCD.trim().length == 0) {
                ErrorCCCD.innerHTML = "";
                return true;
            } else if (txtCCCD.trim().length == 12) {
                ErrorCCCD.innerHTML = "";
                return true;
            } else {
                ErrorCCCD.innerHTML = "CCCD không hợp lệ";
                return false;
            }
        }

        function validatePhone_edit() {
            let txtPhone = document.getElementById("txtPhone-edit").value;
            let ErrorPhone = document.getElementById("ErrorPhone-edit");
            if (txtPhone.trim().length == 0) {
                ErrorPhone.innerHTML = "";
                return true;
            } else if (txtPhone.trim().length == 10) {
                ErrorPhone.innerHTML = "";
                return true;
            } else {
                ErrorPhone.innerHTML = "Phone không hợp lệ";
                return false;
            }
        }

        function Xoa(id) {
            if (confirm("Bạn có chắc chắn muốn xóa nhân viên không ?")) {
                //xuLy = 3 : Xóa
                const data = { EmployeeId: id, XuLy: 3 };
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        alert(xhttp.responseText);
                        location.reload();
                    }
                };
                xhttp.open("POST", "XuLyNhanVien.aspx", true);
                xhttp.setRequestHeader('Content-Type', 'application/json');
                xhttp.send(JSON.stringify(data));
            }
        }
    </script>
</asp:Content>
