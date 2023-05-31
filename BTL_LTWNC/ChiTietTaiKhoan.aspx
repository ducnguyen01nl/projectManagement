<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChiTietTaiKhoan.aspx.cs" Inherits="BTL_LTWNC.ChiTietTaiKhoan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
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
        .btn{
            text-align:center;
        }
    </style>
    <input type="hidden" id="txtUSER_ID" runat="server"/>
    <div class="form">
        <h1>Chi Tiết tài khoản</h1>
        <div>
            <label class="lb">Họ tên</label>
            <input type="text" id="txtName" name="txtName" runat="server" disabled/>
        </div>
        <div>
            <label class="lb">Ngày sinh</label>
            <input type="text" placeholder="__/__/____" data-date-format='dd/mm/yyyy' class="date date-picker" ata-date-end-date="+0d" id="txtDate" runat="server" disabled/>
        </div>
            <div>
            <label class="lb" >Chức vụ</label>
            <input type="text" id="txtRole" name="txtRole" runat="server" disabled/>
        </div>
            
        <div>
            <labe  class="lb"l>Giới tính</labe>
            <input type="radio" name="gioiTinh" value="1" runat="server" id="gtNam" disabled/>Nam
            <input type="radio" name="gioiTinh" value="0" runat="server" id="gtNu" disabled/>Nữ
        </div>
        <div>
            <label  class="lb">Phone</label>
            <input type="text" id="txtPhone" name="txtPhone" runat="server" disabled/>
        </div>
        <div>
            <label  class="lb">CCCD</label>
            <input type="text" id="txtCCCD" name="txtCCCD" runat="server" disabled/>
        </div>
        <div>
            <label  class="lb">Email</label>
            <input type="email" id="txtEmail" name="txtEmail" runat="server" disabled/>
        </div>
        <div class="btn"> 
            <button onclick="TroVe()" class="delete-button">Trở về</button>
            <button onclick="Edit()" class="edit-button">Sửa</button>
        </div>
   </div>
    <script>
        function TroVe() {
            window.location.assign("Admin.aspx")
        }
        function Edit() {
            let userId = document.getElementById("txtUSER_ID").value;
            window.location.assign("SuaTaiKhoan.aspx?id=" + userId)
        }
    </script>
</body>
</html>
