<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuaTaiKhoan.aspx.cs" Inherits="BTL_LTWNC.SuaTaiKhoan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <style>
        .lb {
          display: inline-block;
          width: 100px;
          margin-bottom: 10px;
        }

        input[type="text"], input[type="password"], input[type="email"], input[type="date"] {
          width: 250px;
          padding: 5px;
          border: 1px solid #ccc;
          border-radius: 4px;
          box-sizing: border-box;
          margin-bottom: 10px;
        }

        input[type="submit"] {
          background-color: #4CAF50;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
        }

        input[type="submit"]:hover {
          background-color: #45a049;
        }
        .form {
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          background-color: #f2f2f2;
          padding: 20px;
          border-radius: 5px;
        }
        .delete-button {
          background-color: #f44336; /* Red */
          border: none;
          color: white;
          padding: 10px 20px;
          text-align: center;
          text-decoration: none;
          display: inline-block;
          font-size: 16px;
          border-radius: 5px;
          cursor: pointer;
        }

        .delete-button:hover {
          background-color: #d32f2f; /* Darker red */
        }

        .delete-button:active {
          background-color: #b71c1c; /* Even darker red */
        }
        .edit-button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        .edit-button:hover {
            background-color: #3e8e41; /* Darker green */
        }

        .edit-button:active {
            background-color: #2980B9; /* Blue */
        }
        .form h1{
            text-align: center;
        }
        #slRole {
          width: 250px;
          height: 30px;
          font-size: 1em;
          color: #333;
          border: 1px solid #ccc;
          border-radius: 4px;
          padding: 5px;
        }

        #slRole option {
          font-size: 1em;
          color: #333;
          background-color: #fff;
        }
        .btn{
            text-align:center;
        }
    </style>
    <div class="form">
        <h1>Sửa tài khoản</h1>
        <div>
            <label class="lb">Họ tên</label>
            <input type="text" id="txtName" name="txtName" runat="server"/>
        </div>
        <div>
            <label  class="lb">Ngày sinh</label>
            <input type="date" id="txtNgaySinh" name="txtNgaySinh" runat="server"/>
        </div>
            <div>
            <label class="lb" >Chức vụ</label>
            <select id="slRole" runat="server">
                <option value ="0">Quản trị viên</option>
                <option value ="1">PM</option>
                <option value ="2">Leader</option>
                <option value ="3">Nhân viên</option>
            </select>
        </div>
        <div>
            <labe  class="lb">Giới tính</labe>
            <input type="radio" name="gioiTinh" value="1" runat="server" id="gtNam"/>Nam
            <input type="radio" name="gioiTinh" value="0" runat="server" id="gtNu"/>Nữ
        </div>
        <div>
            <label  class="lb">Phone</label>
            <input type="text" id="txtPhone" name="txtPhone" runat="server"/>
        </div>
        <div>
            <label  class="lb">CCCD</label>
            <input type="text" id="txtCCCD" name="txtCCCD" runat="server"/>
        </div>
        <div>
            <label  class="lb">Email</label>
            <input type="email" id="txtEmail" name="txtEmail" runat="server"/>
        </div>
        <div class="btn"> 
            <button onclick="TroVe()" class="delete-button">Trở về</button>
            <button onclick="Edit()" class="edit-button">Xác nhận</button>
        </div>
   </div>
    <script>
        function TroVe() {
            window.location.assign("Admin.aspx")
        }
        function Edit() {
            window.location.assign("SuaTaiKhoan.aspx?id=")
        }
    </script>
</body>
</html>

