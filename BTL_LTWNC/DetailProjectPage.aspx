<%@ Page Title="" Language="C#" MasterPageFile="~/LayOut/LayOutHeader.Master" AutoEventWireup="true" CodeBehind="DetailProjectPage.aspx.cs" Inherits="BTL_LTWNC.DetailProjectPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link rel="stylesheet" href="Styles/detailProject.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">

        <div class="project__container">
            <div class="project__info">
                <asp:Image CssClass="imgProject" ID="ImageProject" runat="server" />
                <asp:Label ID="LabelProject" CssClass="LabelProject" runat="server"></asp:Label>
                <asp:Label ID="TextDes" CssClass="TextDes" runat="server" Text="Label"></asp:Label>
                <div class="project__time">
                    <span><i class="fas fa-hourglass-start fa-lg" style="color: #12ce51;"></i>
                        <asp:Label ID="LabelStart" runat="server"></asp:Label>
                    </span>
                    <span><i class="fas fa-hourglass-end fa-lg" style="color: #ff0000;"></i>
                        <asp:Label ID="LabelEnd" runat="server"></asp:Label>

                    </span>
                </div>
            </div>
            <div class="project__staff">
                <div class="project__workGroup">
                    <h2>Các nhóm công việc</h2>
                    <%if (Session["roleUserLogin"] != null && Convert.ToInt32(Session["roleUserLogin"]) <= 1)
                        { %>
                    <asp:Button ID="AddWorkGroup" CssClass="btn--addWorkGroup" runat="server" Text="Thêm nhóm việc" OnClick="AddWorkGroup_Click" />
                    <%} %>
                </div>

                <%--<div class="workGroup--content">
                    <asp:Label ID="Label1" runat="server" Text="Chọn nhóm việc:"></asp:Label>
                    <asp:DropDownList ID="DropDownListWorkGroup" OnSelectedIndexChanged="DropDownListWorkGroup_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>

                    <asp:Label ID="Label2" runat="server" Text="Thông tin việc:"></asp:Label>
                    <asp:GridView ID="GridViewGroupWork" runat="server"></asp:GridView>
                </div>--%>
                <div class="workGroup--container">
                    <asp:Repeater ID="RepeaterWorkGroup" runat="server" OnItemDataBound="RepeaterWorkGroup_ItemDataBound">
                        <ItemTemplate>
                            <div class="workGroup__item">
                                <div class="item--name">
                                    <span style="color: blue"><%# Eval("NAME") %></span>
                                    <div>
                                        <i class="fas fa-user-shield" style="color: #ff0000;"></i>
                                        <span style="color: #ff0000">(Leader)</span>
                                        <asp:Label ID="LabelLeader" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <%--<div class="progress__item">
                                    <span>Tiến độ: 0%</span>
                                    <progress id="myProgressBar" class="task-progress" groupid="<%# Eval("GROUP_ID") %>" max="100" value="0"></progress>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value="0" />
                                </div>--%>
                                <%--<asp:Button ID="AddTask" CssClass="btn--addWork" Text="Thêm việc +" OnClick="AddTask_Click" />--%>
                                <%--<button class="btn--addWork" onclick="AddTask_Click">Thêm việc +</button>--%>
                                <%if (Session["roleUserLogin"] != null && Convert.ToInt32(Session["roleUserLogin"]) <= 2)
                                    { %>
                                <div class="listBtn">
                                    <a class="btn--addWork" href="NewTaskPage.aspx?idGroup=<%# Eval("GROUP_ID") %>&idProject=<%=Request.QueryString["q"] %>">Thêm việc +</a>
                                    <a class="btn--editWork" href="EditTaskPage.aspx?idGroup=<%# Eval("GROUP_ID") %>&idProject=<%=Request.QueryString["q"] %>">Sửa việc</a>
                                    <a class="btn--deleteWork" href="DeleteTaskPage.aspx?idGroup=<%# Eval("GROUP_ID") %>&idProject=<%=Request.QueryString["q"] %>">Xóa việc</a>
                                    <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("GROUP_ID") %>' />
                                </div>
                                <%} %>

                                <%--<div id="deletePopup" class="popup">
                                  <div class="popup-content">
                                    <div class="popup-header">
                                      <span class="close" onclick="hideDeletePopup()">&times;</span>
                                      <h2>Xóa Task</h2>
                                    </div>
                                    <div class="popup-body">
                                      <p>Chọn việc bạn muốn xóa</p>
                                        <asp:DropDownList ID="DropDownListTaskDelete" runat="server"></asp:DropDownList>
                                    </div>
                                    <div class="popup-footer">
                                      <button type="button" onclick="hideDeletePopup()">Hủy</button>
                                      <button type="button" onclick="deleteTask()">Xóa</button>
                                    </div>
                                  </div>
                                </div>--%>
                                
                                <div class="listWork__item">
                                    <asp:CheckBoxList ID="CheckBoxList1" runat="server"></asp:CheckBoxList>
                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>

                </div>
            </div>
        </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>

        var checkBoxLists = document.querySelectorAll('[id*=RepeaterWorkGroup] [id*=CheckBoxList1]');
        var DropDownListTaskDelete = document.querySelectorAll('[id*=RepeaterWorkGroup] [id*=DropDownListTaskDelete]');
        var HiddenField2 = document.querySelectorAll('[id*=RepeaterWorkGroup] [id*=HiddenField2]');
        var deletePopup = document.getElementById("deletePopup");
        console.log(checkBoxLists);
        for (var i = 0; i < checkBoxLists.length; i++) {
            var checkBoxList = checkBoxLists[i];
            checkBoxList.addEventListener('change', function () {
                checkboxChanged(this);
            });
        }
        function checkboxChanged(sender) {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log(JSON.parse(xhr.responseText));
                }
            };
            xhr.open("Post", "DetailProjectPage.aspx/UpdateTask", true);
            xhr.setRequestHeader("Content-type", "application/json");
            var data = JSON.stringify({ "taskId": parseInt(sender.value), "isSuccess": sender.checked });
            xhr.send(data);
        }
        function UpdateProgess() {
            var progessBar = document.querySelector("progress");
            var hiddenField = document.querySelector("input[type='hidden']");
            progessBar.value = hiddenField.value;
            
        }



        var progressList = document.querySelectorAll('.task-progress');
        var hiddenFields = document.querySelectorAll('#myRepeater [id*=myHiddenField]');

        // Lấy giá trị của từng HiddenField
        for (var i = 0; i < hiddenFields.length; i++) {
            (function () { // tạo scope riêng cho biến hiddenField
                var hiddenField = hiddenFields[i];
                hiddenField.addEventListener("change", function () {
                    console.log("change");
                    var value = parseInt(hiddenField.value);
                    var progress = document.querySelector('.task-progress[groupid="' + this.getAttribute('groupid') + '"]');

                    progress.value = value;
                    progress.nextSibling.textContent = "Tiến độ: " + value + "%";
                });
            })();
        }


        //function openModelDelete(groupId) {
        //    deletePopup.style.display = "block";
        //    GetTaskDelete(groupId);
        //}

        //function GetTaskDelete (groupId) {
        //    var xhr = new XMLHttpRequest();
        //    xhr.onreadystatechange = function () {
        //        if (xhr.readyState == 4 && xhr.status == 200) {
        //            console.log(JSON.parse(xhr.responseText))
        //        }
        //    };
        //    xhr.open("Post", "DeleteTaskPage.aspx?groupId=" + groupId, true);
        //    xhr.send();
        //}

        //function hideDeletePopup() {
        //    deletePopup.style.display = "none";
        //}


    </script>
</asp:Content>
