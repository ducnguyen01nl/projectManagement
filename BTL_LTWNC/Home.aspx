<%@ Page Title="" Language="C#" MasterPageFile="~/LayOut/LayOutHeader.Master"
    AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="BtlLtwnc.Home" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Styles/home.css" rel="stylesheet" />
</asp:Content>
<asp:Content
    ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">
    <div class="actions">
        <header>
            <h3>Dự án</h3>
        </header>

        <%if (Session["roleUserLogin"] != null && Convert.ToInt32(Session["roleUserLogin"]) <= 1)
            { %>
        <div class="actions__select">
            <select id="actions__select">
                <option value="isActive=true">Đang hoạt động</option>
                <option value="isActive=false">Chưa hoạt dộng</option>
                <option value="isDeleted=true">Đã xóa</option>
                <option value="all=true">Tất cả</option>
            </select>

        </div>
        <%--<div>
            <select id="actions__select__type__sort">
                <option value="typeSort=PROJECT_ID">PROJECT_ID</option>
                <option value="typeSort=NAME">NAME</option>
                <option value="typeSort=DESCRIPTION">DESCRIPTION</option>
                <option value="typeSort=START_AT">START_AT</option>
                <option value="typeSort=END_AT">END_AT</option>
                <option value="typeSort=DELAY_DATE">DELAY_DATE</option>
                <option value="typeSort=IS_ACTIVE">IS_ACTIVE</option>
                <option value="typeSort=IS_SUCCESS">IS_SUCCESS</option>
                <option value="typeSort=CREATED_AT">CREATED_AT</option>
                <option value="typeSort=UPDATED_AT">UPDATED_AT</option>
                <option value="typeSort=IS_DELETED">IS_DELETED</option>
            </select>

            <button id="actions__select__type__sort--btn">Tăng dần</button>
        </div>--%>

        <%} %>
    </div>
    <div id="search-text"></div>
    <div class="list-project">
        <div class="grid">
            <div id="litsProjectId" class="row">
            </div>
            <div id="listProjectPagination"></div>
        </div>
        <%if (Session["roleUserLogin"] != null && Convert.ToInt32(Session["roleUserLogin"]) <= 1)
            { %>
        <div class="add-project">
            <button id="actions__btn--add" class="actions__btn--add">
                <i class="fas fa-plus"></i>Thêm mới
            </button>
        </div>

        <%} %>
    </div>


    <div id="add__project__form__overlay" class="overlay">
        <div class="add__project--wrapper">
            <div id="add__project__form" class="add__project__form">
                <h2 class="add__project__form--title">Dự án mới:</h2>

                <input id="add__project__form__input__name" class="add__project__form--item form-control" type="text" placeholder="Tên dự án mới" />
                <textarea id="add__project__form__input__des" cols="50" rows="10" class="add__project__form--item form-control" placeholder="Mô tả"></textarea>
                <p class="add__project__form--item add__project__form__text--error"></p>
                <button id="add__project__form__btn__submit" class="add__project__form--item update">Thêm mới</button>
            </div>
        </div>
    </div>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        function handlebtnActiveOnclick(event) {
            console.log("item: ", event);
        }
    </script>
    <script type="module">
        import { callAPI } from "./Script/ajax.js";
        import ProjectItem from "./Component/ProjectItem.js";
        import actionProjectItem from './Script/actionProjectItem.js';
        import Pagination from './Component/Pagination.js'
        (() => {
            let page = 1;
            let limit = 10000;
            let baseUrl = "<%: ConfigurationManager.AppSettings["BaseURl"]%>";
            let actions__select = document.querySelector("#actions__select");
            let actions__select__type__sort = document.getElementById("actions__select__type__sort");
            let actions__select__type__sort__btn = document.getElementById("actions__select__type__sort--btn");
            let typeSortDefaul = "typeSort=PROJECT_ID";
            let getDefaul = "isActive=true";


            let listProjectPagination = document.getElementById("listProjectPagination");
            //gọi api để render
            function fetchApi() {
                let get = actions__select?.value || getDefaul;
                let sortString = !!actions__select__type__sort__btn ? actions__select__type__sort__btn.innerText == "Tăng dần" ? "sort=true" : "sort=false" : "sort=false";
                let typeSortString =  actions__select__type__sort?.value || typeSortDefaul;
                let typeSort = "&" + typeSortString;
                let sort = "&" + sortString;
                let url = baseUrl + "project/getAll?" + get + search + "&page=" + page + "&limit=" + limit + typeSort + sort;
                callAPI(url, "Get", null, null, (e, res) => {
                    if (!!res) {
                        let role = Number(<%= Session["roleUserLogin"]%>);
                        console.log("role: ", role);
                        localStorage.setItem('Role', role);
                        let litsProject = "";
                        let eLitsProject = document.getElementById("litsProjectId");

                        litsProject = res.data.map((item) => {

                            return `<div  class="col c-2-4">
                                            ${ProjectItem(item, role)}
                                        </div>`;
                        }).join("");

                        eLitsProject.innerHTML = litsProject;
                        if (!!actions__select) {
                            actionProjectItem(baseUrl, actions__select, search, page, limit, fetchApi);
                        }
                        Pagination(listProjectPagination, res.totalpage, page, handleSelectPage, handleNextPage, handlePrePage);
                    } else {
                    }
                });
            }

            

           

            //Tìm khiếm
            const urlParams = new URLSearchParams(window.location.search);
            const searchValue = urlParams.get('q');

            const search = !!searchValue ? "&name=" + searchValue : "";
            if (!!searchValue) {
                document.getElementById("search-text").innerHTML = `<b>Tìm kiếm: </b> ${searchValue}`;
            }

            //Phân trang


            function handleNextPage() {
                page++;
                // let get = actions__select?.value || getDefaul;
                // let url = baseUrl + "project/getAll?" + get+ search + "&page=" + page + "&limit=" + limit;
                fetchApi();
            }

            function handlePrePage() {
                page--;
                // let get = actions__select?.value || getDefaul;

                // let url = baseUrl + "project/getAll?" + get + search + "&page=" + page + "&limit=" + limit;
                fetchApi();
            }

            function handleSelectPage(e) {
                let index = Number(e.target.innerText);
                // let get = actions__select?.value || getDefaul;
                page = Number(index);
                // let url = baseUrl + "project/getAll?" + get + search + "&page=" + page + "&limit=" + limit;
                fetchApi();
            }



            // let url = baseUrl + "project/getAll?" + get  + search + "&page=" + page + "&limit=" + limit;
            fetchApi();

            //sắp xếp
            //if (!!actions__select__type__sort__btn && !!actions__select__type__sort) {
            //    actions__select__type__sort__btn.addEventListener("click", () => {
            //        if (actions__select__type__sort__btn.innerText == "Tăng dần") {
            //            actions__select__type__sort__btn.innerText = "Giảm dần"
            //        } else {
            //            actions__select__type__sort__btn.innerText = "Tăng dần"
            //        }
            //        fetchApi();
            //    })
            //    actions__select__type__sort.addEventListener("change", () => {
            //        fetchApi();
            //    })
            //}
            

            //lọc dữ liệu
            if (!!actions__select) {
                actions__select.onchange = () => {
                    page = 1;
                    let value = actions__select.value;
                    // let url = baseUrl + "project/getAll?" + value + search + "&page=" + page + "&limit=" + limit;
                    fetchApi();
                }
            }






            //action thêm project

            let add__project__form__overlay = document.getElementById("add__project__form__overlay");
            let actions__btn__add = document.getElementById("actions__btn--add");
            let add__project__form = document.getElementById("add__project__form");
            let add__project__form__btn__submit = document.getElementById("add__project__form__btn__submit");


            if (!!actions__btn__add) {
                actions__btn__add.onclick = () => {


                    add__project__form__overlay.classList.add("show");
                }
            }

            add__project__form__overlay.onclick = () => {
                add__project__form__overlay.classList.remove("show");
            }

            add__project__form.onclick = e => {
                e.stopPropagation();
            }

            add__project__form__btn__submit.onclick = () => {
                let add__project__form__input__nameValue = document.getElementById("add__project__form__input__name").value;
                let add__project__form__input__desValue = document.getElementById("add__project__form__input__des").value;
                if (!add__project__form__input__nameValue) {
                    alert("Không thể để trống tên project!");
                }
                else {
                    const data = {
                        NAME: add__project__form__input__nameValue,
                        DES: add__project__form__input__desValue
                    }
                    let urlAddProject = baseUrl + "project/CreateProject";

                    callAPI(urlAddProject, "Post", null, data, (e, res) => {
                        console.log("chạy")

                        // let url = baseUrl + "project/getAll?" + actions__select.value + search+ "&page=" + page + "&limit=" + limit;
                        fetchApi();

                    });
                    add__project__form__overlay.classList.remove("show");

                }
            }
        })();
    </script>

</asp:Content>
