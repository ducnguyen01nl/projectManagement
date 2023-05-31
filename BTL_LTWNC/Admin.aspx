<%@ Page Title="" Language="C#" MasterPageFile="~/LayOut/LayOutHeader.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="BTL_LTWNC.Admin2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link href="Styles/thang_css.css" rel="stylesheet" />
    <link href="Styles/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="form-input">
        <h1>Quản lý tài khoản</h1>
        <div class="btn-header">
            <button onclick="ThemTaiKhoan()" class="view-button" id="btnTaoMoi">+ Thêm tài khoản</button>
            <button onclick="DanhSachNhanVien()" class="view-button" id="btnNhanVien">Danh sách nhân viên</button>
        </div>
        <table class="auto-style1">
            <thead>
                <tr>
                    <td>Tên tài khoản
                    </td>
                    <td>Quyền
                    </td>
                    <td>Ngày tạo
                    </td>
                    <td>Người sử dụng
                    </td>
                    <td>Trạng thái
                    </td>
                    <td>Chức năng
                    </td>
                </tr>
            </thead>
            <tbody>
                <!--<tr>
                    <td>thang123</td>
                    <td>Nhân viên</td>
                    <td>15/03/2023</td>
                    <td>Thắng</td>
                    <td>Đang hoạt động</td>
                    <td style="text-align:center"> 
                        <button class="view-button" id="view-button" onclick="ChiTiet(10)">Chi Tiết</button>
                        <button class="edit-button" onclick="Sua(10,'thang','1','1','0')">Sửa</button>
                        <button class="off-button" onclick="GanTaiKhoan(10,'thang123',1)">Gắn tài khoản</button>
                        <button class="off-button" onclick="ISACTIVE(10)">Trạng thái</button>
                        <button class="delete-button" onclick="Xoa(10)">Xóa</button>
                    </td>
                </tr>-->
                <asp:ListView ID="ListView1" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("USER_NAME") %></td>
                            <td><%# Eval("ROLE_NAME") %></td>
                            <td><%# XuLyDate(Eval("CREATED_AT")) %></td>
                            <td><%# Eval("NAME") %></td>
                            <td><%# InsertActive(Eval("IS_ACTIVE")) %></td>
                            <td style="text-align: center">
                                <button class="view-button" id="view-button" onclick="ChiTiet(<%# Eval("USER_ID") %>)">Chi Tiết</button>
                                <button class="edit-button" onclick="Sua(<%# Eval("USER_ID") %>,'<%# Eval("USER_NAME") %>',1,<%# Eval("ROLE") %>,<%# XuLyNhanVien(Eval("EMPLOYEE_ID")) %>)">Sửa</button>
                                <button class="off-button" onclick="ISACTIVE(<%# Eval("USER_ID") %>,'<%#(Eval("IS_ACTIVE"))%>')"><%# XuLyIsActive(Eval("IS_ACTIVE"))%></button>
                                <button class="delete-button" onclick="Xoa(<%# Eval("USER_ID") %>)">Xóa</button>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </tbody>
        </table>
    </div>

    <div class="form form-show" id="themMoi">
        <h1>Thêm tài khoản</h1>
        <div class="form-add">
            <label class="lb">Username</label>
            <input type="text" id="txtUserName" name="txtUserName" />
            <label class="error" id="ErrorUserName"></label>
        </div>
        <div class="form-add">
            <label class="lb">Password</label>
            <input type="password" id="txtPassWord" name="txtPassWord" />
            <label class="error" id="ErrorPassWord"></label>
        </div>
        <div class="form-add">
            <label class="lb">Retype-Password</label>
            <input type="password" id="txtRetypePassWord" name="txtRetypePassWord" />
            <label class="error" id="ErrorRetypePassWord"></label>
        </div>
        <div class="form-add">
            <label class="lb">Quyền hạn</label>
            <select id="slRole">
                <option value="-1">Mời bạn chọn quyền</option>
                <option value="1">PM</option>
                <option value="2">Leader</option>
                <option value="3">Nhân viên</option>
            </select>
            <label class="error" id="ErrorRole"></label>
        </div>
        <div class="btn">
            <button onclick="TroVe()" class="delete-button" id="delete-button-themMoi">Trở về</button>
            <button onclick="TaoMoi()" class="edit-button">Tạo mới</button>
        </div>
    </div>

    <div class="form-view form-show" id="chiTiet">
        <input type="hidden" id="txtIdUser" />
        <h1>Chi Tiết tài khoản</h1>
        <div class="form-add">
            <label class="lb">Username</label>
            <input type="text" id="txtUserName2" name="txtUserName" class="disabled-input" disabled />
            <label class="error" id="ErrorUserName2"></label>
        </div>
        <div class="form-add">
            <label class="lb">Trạng thái</label>
            <select id="isActive" class="disabled-input" disabled>
                <option value="1">Đang hoạt động</option>
                <option value="0">Đừng hoạt động</option>
            </select>
        </div>
        <div class="form-add">
            <label class="lb">Quyền hạn</label>
            <select id="slRole2" class="disabled-input" disabled>
                <option value="0">Quản trị viên</option>
                <option value="1">PM</option>
                <option value="2">Leader</option>
                <option value="3">Nhân viên</option>
            </select>
            <label class="error" id="ErrorRole2"></label>
        </div>
        <input type="hidden" id="txtEmployeeId" />
        <div class="form-add">
            <label class="lb">Đã gán cho nhân viên</label>
            <input type="text" id="txtEmployee" name="txtEmployee" class="disabled-input" disabled />
        </div>
        <div class="form-add">
            <label class="lb">Ngày tạo</label>
            <input type="date" id="txtNgayTao" name="txtNgayTao" class="disabled-input" disabled />
        </div>
        <div class="form-add">
            <label class="lb">Ngày sửa</label>
            <input type="date" id="txtNgaySua" name="txtNgaySua" class="disabled-input" disabled />
        </div>
        <div class="btn">
            <button onclick="DoiMatKhau()" class="view-button" id="DoiMatKhau">Đổi mật khẩu</button>
            <button onclick="Edit()" class="edit-button" id="edit-taiKhoan">Sửa</button>
        </div>
        <div class="btn">
            <button onclick="TroVe()" class="delete-button" id="delete-button-chiTiet">Đóng</button>
        </div>
    </div>

    <div class="form form-show" id="doiMatKhau">
        <h1>Đổi mật khẩu</h1>
        <div class="form-add">
            <label class="lb">Username</label>
            <input type="text" id="txtUserName-doiMatKhau" name="txtUserName" disabled />
            <label class="error" id="ErrorUserName-doiMatKhau"></label>
        </div>
        <div class="form-add">
            <label class="lb">Password</label>
            <input type="password" id="txtPassWord-doiMatKhau" name="txtPassWord" />
            <label class="error" id="ErrorPassWord-doiMatKhau"></label>
        </div>
        <div class="form-add">
            <label class="lb">Retype-Password</label>
            <input type="password" id="txtRetypePassWord-doiMatKhau" name="txtRetypePassWord" />
            <label class="error" id="ErrorRetypePassWord-doiMatKhau"></label>
        </div>
        <div class="btn">
            <button onclick="TroVe()" class="delete-button" id="delete-button-doiMatKhau">Trở về</button>
            <button onclick="XacNhanDoiMatKhau()" class="edit-button">Xác nhận</button>
        </div>
    </div>

    <div class="form form-show" id="editTaiKhoan">

        <h1>Edit tài khoản</h1>
        <input type="hidden" id="txtIdUser-editTaiKhoan" />
        <div class="form-add">
            <label class="lb">Username</label>
            <input type="text" id="txtUserName-editTaiKhoan" name="txtUserName" disabled />
        </div>
        <div class="form-add">
            <label class="lb">Trạng thái</label>
            <select id="isActive-editTaiKhoan" class="disabled-input">
                <option value="1">Đang hoạt động</option>
                <option value="0">Đừng hoạt động</option>
            </select>
        </div>
        <div class="form-add">
            <label class="lb">Quyền hạn</label>
            <select id="slRole-editTaiKhoan" class="disabled-input">
                <option value="0">Quản trị viên</option>
                <option value="1">PM</option>
                <option value="2">Leader</option>
                <option value="3">Nhân viên</option>
            </select>
        </div>
        <div class="form-add">
            <label class="lb">Gán nhân viên</label>
            <select id="nhanVien-editTaiKhoan" class="disabled-input">
                <option value="-1">Mời chọn nhân viên</option>
            </select>
        </div>
        <div class="btn">
            <button onclick="TroVe()" class="delete-button" id="delete-button-editTaiKhoan">Đóng</button>
            <button onclick="XacNhanEdit()" class="edit-button">Thay đổi</button>
        </div>
    </div>

    <div class="form-ganTaiKhoan form-show" id="ganTaiKhoan">
        <h1>Gán tài khoản</h1>
        <input type="hidden" id="UserId-ganTaiKhoan" />
        <div class="form-add">
            <label class="lb">Username</label>
            <input type="text" id="txtUserName-ganTaiKhoan" name="txtUserName" disabled />
        </div>
        <div class="form-add">
            <label class="lb">Gán nhân viên</label>
            <select id="nhanVien-ganTaiKhoan" class="disabled-input">
                <option value="-1">Mời chọn nhân viên</option>
                <option value="1">Thắng</option>
            </select>
        </div>
        <div class="btn">
            <button onclick="TroVe()" class="delete-button" id="delete-button-ganTaiKhoan">Đóng</button>
            <button onclick="Gan()" class="edit-button">Gắn</button>
        </div>
    </div>

    <div class="overlay"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
      <script>

        let overlay = document.querySelector(".overlay");

        overlay.addEventListener("click", () => {

        });
        function resetFormThemTaiKhoan() {
            overlay.classList.add("show");

            let txtUserName = document.getElementById("txtUserName").value = "";
            let txtPassWord = document.getElementById("txtPassWord").value = "";
            let txtRetypePassWord = document.getElementById("txtRetypePassWord").value = "";
            let slRole = document.getElementById("slRole").value = "-1";
            let ErrorUserName = document.getElementById("ErrorUserName").innerHTML = "";
            let ErrorPassWord = document.getElementById("ErrorPassWord").innerHTML = "";
            let ErrorRetypePassWord = document.getElementById("ErrorRetypePassWord").innerHTML = "";
            let ErrorRole = document.getElementById("ErrorRole").innerHTML = "";
        }

        document.getElementById("delete-button-ganTaiKhoan").onclick = function () {
            document.getElementById("ganTaiKhoan").style.display = 'none';
            overlay.classList.remove("show")
        };

        document.getElementById("btnTaoMoi").onclick = function () {
            resetFormThemTaiKhoan();
            document.getElementById("themMoi").style.display = 'block';
        };

        document.getElementById("delete-button-themMoi").onclick = function () {
            document.getElementById("themMoi").style.display = 'none';
            overlay.classList.remove("show")
        };

        document.getElementById("delete-button-chiTiet").onclick = function () {
            document.getElementById("chiTiet").style.display = 'none';
            overlay.classList.remove("show");

        };

        document.getElementById("edit-taiKhoan").onclick = function () {
            let txtUserName = document.getElementById("txtUserName2").value;
            let isActive = document.getElementById("isActive").value;
            let slRole2 = document.getElementById("slRole2").value;
            let txtEmployeeId = document.getElementById("txtEmployeeId").value;
            let txtUserName_editTaiKhoan = document.getElementById("txtUserName-editTaiKhoan").value = txtUserName;
            GetNhanVien(txtEmployeeId);
            let isActive_editTaiKhoan = document.getElementById("isActive-editTaiKhoan").value = isActive;
            let slRole_editTaiKhoan = document.getElementById("slRole-editTaiKhoan").value = slRole2;
            document.getElementById("chiTiet").style.display = 'none';
            overlay.classList.remove("show");

            document.getElementById("editTaiKhoan").style.display = 'block';
        };

        document.getElementById("delete-button-editTaiKhoan").onclick = function () {
            var selectElement = document.getElementById("nhanVien-editTaiKhoan");
            selectElement.options.length = 1;
            document.getElementById("editTaiKhoan").style.display = 'none';
            overlay.classList.remove("show");
        };

        document.getElementById("delete-button-doiMatKhau").onclick = function () {
            let txtIdUser = document.getElementById("txtIdUser").value = "";
            let txtPassWord_doiMatKhau = document.getElementById("txtPassWord-doiMatKhau").value = "";
            let slRole_editTaiKhoan = document.getElementById("slRole-editTaiKhoan").value = "";
            let ErrorRetypePassWord_doiMatKhau = document.getElementById("ErrorRetypePassWord-doiMatKhau").innerHTML = "";
            document.getElementById("doiMatKhau").style.display = 'none';
            overlay.classList.remove("show");

            document.getElementById("chiTiet").style.display = 'block';
        };
        document.getElementById("DoiMatKhau").onclick = function () {
            let txtUserName = document.getElementById("txtUserName2").value;
            let txtUserName_doiMatKhau = document.getElementById("txtUserName-doiMatKhau").value = txtUserName;
            document.getElementById("doiMatKhau").style.display = 'block';
            document.getElementById("chiTiet").style.display = 'none';
            overlay.classList.remove("show")
        };

        function Sua(id, name, trangThai, quyenHan, idNhanVien) {
            GetNhanVien(idNhanVien);
            let txtIdUser_editTaiKhoan = document.getElementById("txtIdUser-editTaiKhoan").value = id;
            let txtUserName_editTaiKhoan = document.getElementById("txtUserName-editTaiKhoan").value = name;
            let isActive_editTaiKhoan = document.getElementById("isActive-editTaiKhoan").value = trangThai;
            let slRole_editTaiKhoan = document.getElementById("slRole-editTaiKhoan").value = quyenHan;

            document.getElementById("editTaiKhoan").style.display = 'block';
            overlay.classList.add("show");
        }

        function GanTaiKhoan(idUser, userName, idUse) {
            document.getElementById("ganTaiKhoan").style.display = 'block';
            let UserId_ganTaiKhoan = document.getElementById("UserId-ganTaiKhoan").value = idUser;
            let txtUserName_ganTaiKhoan = document.getElementById("txtUserName-ganTaiKhoan").value = userName;
            let nhanVien_ganTaiKhoan = document.getElementById("nhanVien-ganTaiKhoan").value = idUse;
        }

        function XacNhanDoiMatKhau() {
            let txtIdUser = document.getElementById("txtIdUser").value;
            let txtPassWord_doiMatKhau = document.getElementById("txtPassWord-doiMatKhau").value;
            let txtRetypePassWord_doiMatKhau = document.getElementById("txtRetypePassWord-doiMatKhau").value;
            let ErrorRetypePassWord_doiMatKhau = document.getElementById("ErrorRetypePassWord-doiMatKhau");
            if (txtPassWord_doiMatKhau != txtRetypePassWord_doiMatKhau) {
                ErrorRetypePassWord_doiMatKhau.innerHTML = "Nhập lại không chính xác";
            }
            else {
                ErrorRetypePassWord_doiMatKhau.innerHTML = "Đổi thành công";
            }
        }

        function ChiTiet(id) {
            overlay.classList.add("show");

            let txtIdUser = document.getElementById("txtIdUser");
            let txtUserName2 = document.getElementById("txtUserName2");
            let slRole2 = document.getElementById("slRole2");
            let isActive = document.getElementById("isActive");
            let txtNgayTao = document.getElementById("txtNgayTao");
            let txtNgaySua = document.getElementById("txtNgaySua");
            let txtEmployee = document.getElementById("txtEmployee");
            let txtEmployeeId = document.getElementById("txtEmployeeId");
            /*txtIdUser.value = "thang123";
            txtEmployee.value = "Chưa gán cho nhân viên";
            txtUserName2.value = "thang";
            slRole2.value = "3";
            isActive.value = "1";
            txtNgayTao.value = "04/12/2023"
            txtNgaySua.value = "";
            document.getElementById("chiTiet").style.display = 'block';*/
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    var obj = JSON.parse(xhttp.responseText);
                    txtIdUser.value = obj[0]["USER_ID"];
                    txtEmployee.value = obj[0]["NAME"] != null ? obj[0]["NAME"] : "Chưa gán cho nhân viên";
                    txtUserName2.value = obj[0]["USER_NAME"];
                    slRole2.value = obj[0]["ROLE"];
                    isActive.value = obj[0]["IS_ACTIVE"] ? 1 : 0;
                    txtNgayTao.value = new Date(obj[0]["CREATED_AT"]).toISOString().slice(0, 10)
                    txtNgaySua.value = obj[0]["UPDATED_AT"] != null ? new Date(obj[0]["UPDATED_AT"]).toISOString().slice(0, 10) : "";
                    txtEmployeeId.value = obj[0]["EMPLOYEE_ID"] != null ? obj[0]["EMPLOYEE_ID"] : "-1"
                    document.getElementById("chiTiet").style.display = 'block';
                }
            };
            xhttp.open("GET", "ChiTietTaiKhoan.aspx?id=" + id, true);
            xhttp.send();
        }

        function ISACTIVE(id, isActive) {
            let boolIsActive = isActive == "True";
            let trangThai;
            let isTrangThai = boolIsActive ? 1 : 0;
            boolIsActive ? trangThai = "Tắt trạng thái" : trangThai = "Bật trạng thái"
            if (confirm("Bạn có chắc chắn muốn " + trangThai + " của user không?")) {
                //xuLy = 2 : Tat trang thai
                const data = { UserId: id, TrangThai: isTrangThai, XuLy: 2 };
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        alert(xhttp.responseText);
                        location.reload();
                    }
                };
                xhttp.open("POST", "XuLyTaiKhoan.aspx", true);
                xhttp.setRequestHeader('Content-Type', 'application/json');
                xhttp.send(JSON.stringify(data));
            }
        }

        function Xoa(id) {
            //xuLy = 3 : Xoa
            if (confirm("Bạn có chắc chắn muốn xóa user không?")) {
                const data = { UserId: id, XuLy: 3 };
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        alert(xhttp.responseText);
                        location.reload();
                    }
                };
                xhttp.open("POST", "XuLyTaiKhoan.aspx", true);
                xhttp.setRequestHeader('Content-Type', 'application/json');
                xhttp.send(JSON.stringify(data));
            }
        }

        function DanhSachNhanVien() {
            window.location.assign("/NhanVien2.aspx")
        }

        function GetNhanVien(id) {
            let nhanVien = document.getElementById("nhanVien-editTaiKhoan");
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    var obj = JSON.parse(xhttp.responseText);
                    console.log("obj", obj);
                    obj.forEach(item => {
                        nhanVien.innerHTML += `<option value="${item.EMPLOYEE_ID}">${item.NAME}</option>`
                    });
                    nhanVien.value = id;
                }
            };
            xhttp.open("Get", "XuLyTaiKhoan.aspx?employeeId=" + id, true);
            xhttp.send();
        }

        function TaoMoi() {
            let txtUserName = document.getElementById("txtUserName").value;
            let txtPassWord = document.getElementById("txtPassWord").value;
            let txtRetypePassWord = document.getElementById("txtRetypePassWord").value;
            let slRole = document.getElementById("slRole").value;
            if (ValidateThemMoi(txtUserName, txtPassWord, txtRetypePassWord, slRole)) {
                //xuLy = 1 : Thêm
                const data = { UserName: txtUserName, PassWord: txtPassWord, Role: slRole, XuLy: 1 };
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (xhttp.readyState == 4 && xhttp.status == 200) {
                        document.getElementById("themMoi").style.display = 'none';
                        overlay.classList.remove("show")
                        location.reload();
                    }
                };
                xhttp.open("POST", "XuLyTaiKhoan.aspx", true);
                xhttp.setRequestHeader('Content-Type', 'application/json');
                xhttp.send(JSON.stringify(data));
            }
        }

        function XacNhanEdit() {
            //debugger
            let txtIdUser_editTaiKhoan = document.getElementById("txtIdUser-editTaiKhoan").value;
            let txtUserName_editTaiKhoan = document.getElementById("txtUserName-editTaiKhoan").value;
            let isActive_editTaiKhoan = document.getElementById("isActive-editTaiKhoan").value;
            let slRole_editTaiKhoan = document.getElementById("slRole-editTaiKhoan").value;
            let nhanVien_editTaiKhoan = document.getElementById("nhanVien-editTaiKhoan").value;
            //xuLy = 4 : Gan sua user
            const data = { UserId: txtIdUser_editTaiKhoan, isAcite: isActive_editTaiKhoan, Role: slRole_editTaiKhoan, employeeId : nhanVien_editTaiKhoan, XuLy: 4 };
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (xhttp.readyState == 4 && xhttp.status == 200) {
                    document.getElementById("editTaiKhoan").style.display = 'none';
                    alert(this.responseText);
                    location.reload();
                }
            };
            xhttp.open("POST", "XuLyTaiKhoan.aspx", true);
            xhttp.setRequestHeader('Content-Type', 'application/json');
            xhttp.send(JSON.stringify(data));
        }

        function ValidateThemMoi(txtUserName, txtPassWord, txtRetypePassWord, slRole) {
            let valid1 = ValidateUserName(txtUserName);
            let valid2 = ValidatePassWord(txtPassWord);
            let valid3 = ValidateRetypePassWord(txtPassWord, txtRetypePassWord);
            let valid4 = validateRole(slRole);
            if (valid1 && valid2 && valid3 && valid4) return true;
            return false;
        }

        function ValidateUserName(txtUserName) {
            /*let txtUserName = document.getElementById("txtUserName").value;*/
            let ErrorUserName = document.getElementById("ErrorUserName");
            if (txtUserName.trim().length == 0) {
                ErrorUserName.innerHTML = "Bạn chưa nhập UserName";
                return false;
            } else if (txtUserName.trim().length < 6) {
                ErrorUserName.innerHTML = "UserName quá ngắn. Mời nhập lại!";
                return false;
            } else {
                ErrorUserName.innerHTML = "";
                return true;
            }
        }

        function ValidatePassWord(txtPassWord) {
            let ErrorPassWord = document.getElementById("ErrorPassWord");
            if (txtPassWord.trim().length == 0) {
                ErrorPassWord.innerHTML = "Bạn chưa nhập Password";
                return false;
            } else if (txtPassWord.trim().length < 6) {
                ErrorPassWord.innerHTML = "Password quá ngắn. Mời nhập lại!";
                return false;
            } else {
                ErrorPassWord.innerHTML = "";
                return true;
            }
        }

        function validateRole(slRole) {
            if (slRole == -1) {
                ErrorRole.innerHTML = "Bạn chưa chọn quyền hạn";
                return false;
            } else {
                ErrorRole.innerHTML = "";
                return true;

            }
        }

        function ValidateRetypePassWord(txtPassWord, txtRetypePassWord) {
            let ErrorRetypePassWord = document.getElementById("ErrorRetypePassWord");
            if (txtPassWord != txtRetypePassWord) {
                ErrorRetypePassWord.innerHTML = "Nhập lại chưa chính xác";
                return false;
            } else {
                ErrorRetypePassWord.innerHTML = "";
                return true;
            }
        }

        

      </script>
</asp:Content>
