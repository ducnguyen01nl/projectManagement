function createItem(paginationElement, index, currentPage, func = () => { }) {
    const button = document.createElement('button');
    button.innerText = index;
    if (index === currentPage) {
        button.classList.add('active');
    }
    button.addEventListener('click', func);
    paginationElement.appendChild(button);
}

function createItemDotDotDot(paginationElement) {
    const button = document.createElement('button');
    button.innerHTML = '...';
    paginationElement.appendChild(button);
}

function Pagination(paginationElement, pageCount, currentPage, fucItem = () => { }, funcNext = () => { }, funcPre = () => { }) {
    if (paginationElement instanceof HTMLElement) {
        paginationElement.innerHTML = '';

        if (pageCount > 1) {
            if (pageCount < 9) {
                for (var i = 1; i <= pageCount; i++) {
                    createItem(paginationElement, i, currentPage, fucItem);
                }
            } else {
                for (var i = 1; i <= pageCount; i++) {
                    if (currentPage < 3) {
                        if (i < 4) {
                            createItem(paginationElement, i, currentPage, fucItem);
                        }
                        if (i > pageCount - 3) {
                            createItem(paginationElement, i, currentPage, fucItem);
                        }
                        if (i === Math.floor(pageCount / 2)) {
                            createItemDotDotDot(paginationElement);
                        }
                    } else {
                        if (currentPage > 2 && currentPage < 5) {
                            if (i === currentPage + 2) {
                                createItemDotDotDot(paginationElement);
                            }
                            if (i < currentPage + 2) {
                                createItem(paginationElement, i, currentPage, fucItem);
                            }
                            if (i > pageCount - 3) {
                                createItem(paginationElement, i, currentPage, fucItem);
                            }
                        } else {
                            if (currentPage > 4 && currentPage < pageCount - 3) {
                                if (i < 3) {
                                    createItem(paginationElement, i, currentPage, fucItem);
                                }
                                if (i === 3 || i === pageCount - 3) {
                                    createItemDotDotDot(paginationElement);
                                }
                                if (i > currentPage - 2 && i < currentPage + 1) {
                                    createItem(paginationElement, i, currentPage, fucItem);
                                }
                                if (i > pageCount - 3) {
                                    createItem(paginationElement, i, currentPage, fucItem);
                                }
                            } else {
                                if (i == 3) {
                                    createItemDotDotDot(paginationElement);
                                }

                                if (i < 3) {
                                    createItem(paginationElement, i, currentPage, fucItem);
                                }
                                if (i > pageCount - 6) {
                                    createItem(paginationElement, i, currentPage, fucItem);
                                }
                            }
                        }
                    }
                }
            }

            const buttonPre = document.createElement('button');
            buttonPre.innerHTML = '&laquo;';
            buttonPre.addEventListener('click', funcPre);
            if (currentPage === 1) {
                buttonPre.disabled = true;
                buttonPre.classList.add('disable');
            }
            paginationElement.insertBefore(buttonPre, paginationElement.firstChild);

            const buttonNext = document.createElement('button');
            buttonNext.innerHTML = '&raquo;';
            buttonNext.addEventListener('click', funcNext);
            if (currentPage == pageCount) {
                buttonNext.disabled = true;
                buttonNext.classList.add('disable');
            }
            paginationElement.appendChild(buttonNext);
        }
    }
}

export default Pagination;
