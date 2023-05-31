(() => {
    let dropDownList = document.querySelector(".header__user__dropDown");
    let headerUser = document.querySelector(".header__user");

    dropDownList.addEventListener("click", (e) => {
        e.stopPropagation();
    });

    document.body.addEventListener("click", () => {
        if (dropDownList.classList.contains("show")) {
            dropDownList.classList.remove("show");
        }
    });

    headerUser.addEventListener("click", (e) => {
        e.stopPropagation();
        dropDownList.classList.toggle(
            "show",
            !dropDownList.classList.contains("show")
        );
    });

    
})();
