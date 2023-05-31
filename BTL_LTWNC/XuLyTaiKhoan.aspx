<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="XuLyTaiKhoan.aspx.cs" Inherits="BTL_LTWNC.ThemTaiKhoan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!--
    <style>
        .form h1{
            text-align:center;
        }
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
        .btn{
          
        }
        .add-button {
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

        .add-button:hover {
            background-color: #3e8e41; /* Darker green */
        }

        .add-button:active {
            background-color: #2980B9; /* Blue */
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
            <h1>Thêm tài khoản</h1>
            <div>
                <label class="lb">Username</label>
                <input type="text" id="txtUserName" name="txtUserName"/>
                <label class="error" id="ErrorUserName"></label>
            </div>
             <div>
                <label class="lb">Password</label>
                <input type="password" id="txtPassWorde" name="txtPassWord"/>
            </div>
            <div>
                <label class="lb">Quyền hạn</label>
                <select id="slRole">
                    <option value ="-1">Mời bạn chọn quyền</option>
                    <option value ="1">PM</option>
                    <option value ="2">Leader</option>
                    <option value ="3">Nhân viên</option>
                </select>
            </div>
            <div class="btn"> 
                <button onclick="TroVe()" class="delete-button">Trở về</button>
                <button onclick="TaoMoi()" class="add-button">Tạo mới</button>
            </div>
        </div>
    <script>
        function TroVe() {
            window.location.assign("Admin.aspx");
        }
        function TaoMoi() {
            console.log("hello");
            let txtUserName = document.getElementById("txtUserName").value;
            let txtPassWorde = document.getElementById("txtPassWorde").value;
            let slRole = document.getElementById("slRole").value;
            let errorUserName = document.getElementById("ErrorUserName");
            validate();
            function validate() {
                let isValidate = true;
                if (txtUserName.trim().length == 0) {
                    errorUserName.value = 'Mời bạn nhập UserName';
                }
                else if (txtUserName.trim().length > 6) {
                    errorUserName.value = 'Nhập UserName phải > 6 ký tự';
                } else {
                    errorUserName.value = "";
                }
                console.log(errorUserName.value);
            }
        }
    </script>-->
</body>
</html>
