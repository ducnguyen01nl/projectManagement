import { callAPI } from "./ajax.js";



const actionProjectItem = (baseUrl, actions__select, search, page, limit, fetchApi) => {

    let project__card__menuBtns = document.querySelectorAll(
        ".project__card__menu--btn"
    );

    /*let project__card__menu = document.querySelectorAll(".project__card__menu");*/

    let project__card = document.querySelectorAll(".project__card");

    let overlay = document.getElementById("overlay");

    let urlGet = baseUrl + "project/getAll?" + actions__select.value + search + "&page=" + page + "&limit=" + limit;

    project__card.forEach((item) => {
        item.addEventListener("click", (e) => {
            e.stopPropagation();
        });
    });

    function hideMenu() {
        project__card.forEach((item) => {
            if (item.classList.contains("menu--show")) {
                item.classList.remove("menu--show");
            }
        });
    }

    function showHideOverlay() {
        let isShow = false;

        project__card.forEach((item) => {
            if (item.classList.contains("menu--show")) {
                isShow = true;
            }
        });
        overlay.classList.toggle("show", isShow);
    }

    document.body.addEventListener("click", () => {
        hideMenu();
        showHideOverlay();
    });

    project__card__menuBtns.forEach((btn) => {
        btn.addEventListener("click", (e) => {
            e.stopPropagation();
            e.preventDefault();
            let project = btn.parentElement;

            project.classList.toggle(
                "menu--show",
                !project.classList.contains("menu--show")
            );
            showHideOverlay();
        });
    });

    //xử lý xự kiện menu

    ////Hàm lấy dataItem
    function getdataItem(element, classNameDataItem) {
        let className = element.className;

        if (className == classNameDataItem) {
            return JSON.parse(element.getAttribute('data-item'));
        } else {
            return getdataItem(element.parentElement, classNameDataItem);
        }
    }
    let project__card__menu__item__btn__actives = document.querySelectorAll(".project__card__menu .project__card__menu--item__btn--active");

    //Thay đổi trạng thái của project
    project__card__menu__item__btn__actives.forEach(btn => {
        btn.addEventListener("click", (e) => {
            let item = getdataItem(e.target, "project__card__menu");

            const wrapper = document.createElement('div');
            wrapper.className = "wrapper"
            wrapper.addEventListener("click", (evt) => {
                evt.stopPropagation();
                wrapper.remove();

            })
            const formDiv = document.createElement('div');
            formDiv.addEventListener("click", event => {
                event.stopPropagation();
            })
            formDiv.className = "form";
            wrapper.appendChild(formDiv);

            const header = document.createElement("h3");
            header.innerText = "Trạng thái";
            formDiv.appendChild(header);

            const formItemDivActive = document.createElement("div");
            formItemDivActive.className = "form-group";

            const inputActive = document.createElement("input");
            inputActive.type = "radio";
            inputActive.name = "active";
            inputActive.id = "input--active";
            const labelActive = document.createElement("label");
            labelActive.innerText = "Hoạt dộng";
            labelActive.htmlFor = "input--active"

            formItemDivActive.appendChild(inputActive);
            formItemDivActive.appendChild(labelActive);


            const formItemDivUnActive = document.createElement("div");
            formItemDivUnActive.className = "form-group";

            const inputUnActive = document.createElement("input");
            inputUnActive.type = "radio";
            inputUnActive.name = "active";
            inputUnActive.id = "input--unactive";

            const labelUnActive = document.createElement("label");
            labelUnActive.innerText = "Không hoạt động";
            labelUnActive.htmlFor = "input--unactive"

            formItemDivUnActive.appendChild(inputUnActive);
            formItemDivUnActive.appendChild(labelUnActive);

            formDiv.appendChild(formItemDivActive);
            formDiv.appendChild(formItemDivUnActive);

            const button = document.createElement('button');
            button.addEventListener("click", () => {


                let url = baseUrl + "project/UpdateProject?ProjectID=" + item.PROJECT_ID;
                let data = {

                }
                if (inputActive.checked == true) {
                    data.IS_ACTIVE = true;
                }
                else {
                    data.IS_ACTIVE = false;

                }

                callAPI(url, "put", null, data, (err, res) => {
                    if (!!res) {
                        console.log(res);
                        fetchApi(urlGet);

                    }

                })
                overlay.classList.remove("show");
                hideMenu();
                wrapper.remove();

            })
            button.innerText = "Xác nhận"

            if (item.IS_ACTIVE) {
                inputActive.checked = true;
            } else {
                inputUnActive.checked = true;
            }
            formDiv.appendChild(button);

            document.body.appendChild(wrapper);


        })
    })

    //Thay đổi ảnh của project
    let project__card__menu__item__btn__change__background = document.querySelectorAll(".project__card__menu .project__card__menu__item__btn--change__background");

    project__card__menu__item__btn__change__background.forEach(btn => {
        btn.addEventListener("click", (e) => {
            let item = getdataItem(e.target, "project__card__menu");
            const wrapper = document.createElement('div');
            wrapper.className = "wrapper"
            wrapper.addEventListener("click", (evt) => {
                evt.stopPropagation();
                wrapper.remove();

            })
            const formDiv = document.createElement('div');
            formDiv.addEventListener("click", event => {
                event.stopPropagation();
            })
            formDiv.className = "form wrapper__modal";
            wrapper.appendChild(formDiv);

            formDiv.innerHTML = `<h3>Ảnh bìa</h3>`;
            const imgBackground = document.createElement('img');
            imgBackground.width = "256";
            if (!!item.BACKGROUND_URL) {
                imgBackground.src = item.BACKGROUND_URL;
            }
            formDiv.appendChild(imgBackground);

            const inputImg = document.createElement('input');
            inputImg.type = "file";
            inputImg.accept = "image/*";
            inputImg.style.padding = "8px 0"
            inputImg.addEventListener('change', (e) => {
                const file = e.target.files[0];

                console.log(file);
                const reader = new FileReader();
                reader.onload = (event) => {
                    imgBackground.src = event.target.result;
                };

                reader.readAsDataURL(file);
            })
            formDiv.appendChild(inputImg);

            const button = document.createElement('button');
            button.addEventListener("click", () => {


                let url = baseUrl + "project/UpdateProjectBackground?ProjectID=" + item.PROJECT_ID;
                let data = {

                }
                const formData = new FormData();

                var file = inputImg.files[0];
                if (!!file) {
                    formData.append("image", file);

                    callAPI(url, "put", null, formData, (err, res) => {
                        if (!!res) {
                            console.log(res);
                            fetchApi(urlGet);

                        }

                    })

                    overlay.classList.remove("show");
                    hideMenu();
                    wrapper.remove();
                }
                else {
                    alert("Vui lòng chọn ảnh!");
                }


            })
            button.innerText = "Cập nhật"

            formDiv.appendChild(button);

            document.body.appendChild(wrapper);


        })
    })


    //Chỉnh ngày
    let project__card__menu__item__btn__change__date = document.querySelectorAll(".project__card__menu .project__card__menu__item__btn--change__date");


    project__card__menu__item__btn__change__date.forEach(btn => {
        btn.addEventListener("click", (e) => {
            let item = getdataItem(e.target, "project__card__menu");
            const wrapper = document.createElement('div');
            wrapper.className = "wrapper"
            wrapper.addEventListener("click", (evt) => {
                evt.stopPropagation();
                wrapper.remove();

            })
            const formDiv = document.createElement('div');
            formDiv.addEventListener("click", event => {
                event.stopPropagation();
            })
            formDiv.className = "form wrapper__modal";
            wrapper.appendChild(formDiv);

            formDiv.innerHTML = `<h3>Ngày</h3>`;

            const divGroupStartAt = document.createElement("div");
            divGroupStartAt.className = "form-groupc";
            divGroupStartAt.innerHTML = `<p>Ngày bắt đàu dự án:</p>`;
            const inputStartAt = document.createElement("input");
            inputStartAt.type = "datetime-local";
            console.log(item.START_AT);
            inputStartAt.defaultValue = item.START_AT;
            divGroupStartAt.appendChild(inputStartAt);
            formDiv.appendChild(divGroupStartAt);


            const divGroupEndAt = document.createElement("div");
            divGroupEndAt.className = "form-groupc";

            divGroupEndAt.innerHTML = `<p>Ngày kết thúc dự án:</p>`;
            const inputEndAt = document.createElement("input");
            inputEndAt.type = "datetime-local";
            inputEndAt.defaultValue = item.END_AT;
            divGroupEndAt.appendChild(inputEndAt);
            formDiv.appendChild(divGroupEndAt);


            const button = document.createElement('button');
            button.addEventListener("click", () => {
                let url = baseUrl + "project/UpdateProject?ProjectID=" + item.PROJECT_ID +"&isStartAt=true&isEndAt=true";

                if (!!inputEndAt.value) {
                    if (inputStartAt.value < inputEndAt.value) {

                        let data = {
                            START_AT: inputStartAt.value,
                            END_AT: inputEndAt.value
                        }


                        callAPI(url, "put", null, data, (err, res) => {
                            if (!!res) {
                                console.log(res);
                                fetchApi(urlGet);

                            }

                        })

                        overlay.classList.remove("show");
                        hideMenu();
                        wrapper.remove();
                    } else {
                        alert("ngày bắt đầu phải nhỏ hơn ngày kết thúc!");
                    }
                }
                else {

                    let data = {
                        START_AT: inputStartAt.value,
                        END_AT: inputEndAt.value
                    }


                    callAPI(url, "put", null, data, (err, res) => {
                        if (!!res) {
                            console.log(res);
                            fetchApi(urlGet);

                        }

                    })

                    overlay.classList.remove("show");
                    hideMenu();
                    wrapper.remove();
                }

            })
            button.innerText = "Cập nhật"

            formDiv.appendChild(button);

            document.body.appendChild(wrapper);


        })
    })


    //Xóa dự án
    let project__card__menu__item__btn__delete = document.querySelectorAll(".project__card__menu .project__card__menu__item__btn--delete");

    project__card__menu__item__btn__delete.forEach(btn => {
        btn.addEventListener("click", (e) => {
            let item = getdataItem(e.target, "project__card__menu");
            const wrapper = document.createElement('div');
            wrapper.className = "wrapper"
            wrapper.addEventListener("click", (evt) => {
                evt.stopPropagation();
                wrapper.remove();

            })
            const formDiv = document.createElement('div');
            formDiv.addEventListener("click", event => {
                event.stopPropagation();
            })
            formDiv.className = "form";
            formDiv.style.textAlign = "center";
            wrapper.appendChild(formDiv);

            formDiv.innerHTML = `<p>Bạn có chắc muốn xóa dự án này?</p>`;

            const buttonCancel = document.createElement('button');
            buttonCancel.addEventListener("click", () => {                
                overlay.classList.remove("show");
                hideMenu();
                wrapper.remove();

            })
            buttonCancel.innerText = "Hủy";

            const button = document.createElement('button');
            button.addEventListener("click", () => {
                let url = baseUrl + "project/Delete/" + item.PROJECT_ID;

                callAPI(url, "delete", null, null, (err, res) => {
                    if (!!res) {
                        console.log(res);
                        fetchApi(urlGet);

                    }

                })

                overlay.classList.remove("show");
                hideMenu();
                wrapper.remove();

            })
            button.innerText = "Đúng";
            button.style.marginLeft = "8px";
            formDiv.appendChild(buttonCancel);
            formDiv.appendChild(button);

            document.body.appendChild(wrapper);


        })
    })

    //Khôi phục dự án
    let project__card__menu__item__btn__restore = document.querySelectorAll(".project__card__menu .project__card__menu__item__btn--restore");

    project__card__menu__item__btn__restore.forEach(btn => {
        btn.addEventListener("click", (e) => {
            let item = getdataItem(e.target, "project__card__menu");
            const wrapper = document.createElement('div');
            wrapper.className = "wrapper"
            wrapper.addEventListener("click", (evt) => {
                evt.stopPropagation();
                wrapper.remove();

            })
            const formDiv = document.createElement('div');
            formDiv.addEventListener("click", event => {
                event.stopPropagation();
            })
            formDiv.className = "form";
            formDiv.style.textAlign = "center";

            wrapper.appendChild(formDiv);

            formDiv.innerHTML = `<p>Bạn có chắc muốn khôi phục lại dự án này?</p>`;

            const buttonCancel = document.createElement('button');
            buttonCancel.addEventListener("click", () => {
                overlay.classList.remove("show");
                hideMenu();
                wrapper.remove();

            })
            buttonCancel.innerText = "Hủy";

            const button = document.createElement('button');
            button.addEventListener("click", () => {
                let url = baseUrl + "project/Restore/" + item.PROJECT_ID;

                callAPI(url, "put", null, null, (err, res) => {
                    if (!!res) {
                        console.log(res);
                        fetchApi(urlGet);

                    }

                })

                overlay.classList.remove("show");
                hideMenu();
                wrapper.remove();

            })
            button.innerText = "Đúng";
            button.style.marginLeft = "8px";

            formDiv.appendChild(buttonCancel);
            formDiv.appendChild(button);

            document.body.appendChild(wrapper);


        })
    })

    //Xóa thật dự án
    let project__card__menu__item__btn__delete__true = document.querySelectorAll(".project__card__menu .project__card__menu__item__btn--delete__true");

    project__card__menu__item__btn__delete__true.forEach(btn => {
        btn.addEventListener("click", (e) => {
            let item = getdataItem(e.target, "project__card__menu");
            const wrapper = document.createElement('div');
            wrapper.className = "wrapper"
            wrapper.addEventListener("click", (evt) => {
                evt.stopPropagation();
                wrapper.remove();

            })
            const formDiv = document.createElement('div');
            formDiv.addEventListener("click", event => {
                event.stopPropagation();
            })
            formDiv.className = "form";
            formDiv.style.textAlign = "center";

            wrapper.appendChild(formDiv);

            formDiv.innerHTML = `<p>Bạn có chắc chắn muốn xóa thật sự dự án này?</p>`;

            const buttonCancel = document.createElement('button');
            buttonCancel.addEventListener("click", () => {
                overlay.classList.remove("show");
                hideMenu();
                wrapper.remove();

            })
            buttonCancel.innerText = "Hủy";

            const button = document.createElement('button');
            button.addEventListener("click", () => {
                let url = baseUrl + "project/DeleteTrue/" + item.PROJECT_ID;

                callAPI(url, "delete", null, null, (err, res) => {
                    if (!!res) {
                        console.log(res);
                        fetchApi(urlGet);

                    }

                })

                overlay.classList.remove("show");
                hideMenu();
                wrapper.remove();

            })
            button.innerText = "Đúng";
            button.style.marginLeft = "8px";

            formDiv.appendChild(buttonCancel);
            formDiv.appendChild(button);

            document.body.appendChild(wrapper);


        })
    })
};


export default actionProjectItem;