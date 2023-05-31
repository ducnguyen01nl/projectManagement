//Project.aspx/${item.PROJECT_ID}


function ProjectItem(item,role) {


    

    return ` <div class="project__card" ">
       ${role <= 1 ?`<button class="project__card__menu--btn">
        <i class="fas fa-ellipsis-h"></i>
      </button>`:""}
      
      ${item.BACKGROUND_URL ? `<img class="project__card__img" src="${item.BACKGROUND_URL}" alt="lỗi" />` : ''}
      <div class="project__card--info">
        <a class="project__card--info__name" href="DetailProjectPage.aspx?q=${item.PROJECT_ID}" >${item.NAME}</a>
        <hr class="project__card--info--hr" />
        <div class="project__card--info--detail">
          ${false ? `<p class="project__card--info__employees-number">
            <b>Số nhân sự: </b>${item.QUANTITY_EMPLOYEE}
          </p>`:""}
          <p class="project__card--info__des">
            ${item.DESCRIPTION
            ? `<b> Mô tả: </b> ${item.DESCRIPTION.trim().length > 70 ? item.DESCRIPTION.slice(0, 70) + '...' : item.DESCRIPTION}`
            : ''}
          </p>
          <p class="project__card--info__startAt">${item.START_AT ? `<b>Ngày bắt đầu: </b><span>${item.START_AT}</span>` : ''}</p>
          <p class="project__card--info__endAt">${item.END_AT ? `<b>Ngày bắt đầu: </b><span>${item.END_AT}</span>` : ''}</p>
        </div>
      </div>
      <div class="project__card__complete">
        <div class="project__card__complete--progress" style="width:${item.COMPLETION_PROGRESS * 100}%">
          <div class="project__card__complete--animation"></div>
        </div>
        <span class="project__card__complete--percent">Tiến độ: ${item.COMPLETION_PROGRESS * 100}%</span>
      </div>
      ${role<=1&& item.IS_DELETED ? `<div class="project__card__menu" data-item='${JSON.stringify(item)}'>
                  
                  <button class="project__card__menu--item project__card__menu__item__btn--restore" 
                    ><i class="far fa-clock"></i
                    ><span class="project__card__menu--item--text">
                      Khôi phục</span
                    ></button
                  >
                  <button class="project__card__menu--item project__card__menu__item__btn--delete__true"
                    ><i class="fas fa-trash-alt"></i
                    ><span class="project__card__menu--item--text"
                      >Xóa hoàn toàn</span
                    ></button
                  >
                </div>` : `<div class="project__card__menu" data-item='${JSON.stringify(item)}'>
                  <button  class="project__card__menu--item project__card__menu--item__btn--active"
                    ><i class="far fa-edit"></i>
                    <span class="project__card__menu--item--text">
                      Trạng thái</span
                    ></button
                  >
                  <button class="project__card__menu--item project__card__menu__item__btn--change__background" 
                    ><i class="far fa-image"></i
                    ><span class="project__card__menu--item--text">
                      Thay Ảnh Bìa</span
                    ></button
                  >
                  <button class="project__card__menu--item project__card__menu__item__btn--change__date" 
                    ><i class="far fa-clock"></i
                    ><span class="project__card__menu--item--text">
                      Chỉnh Sửa Ngày</span
                    ></button
                  >
                  <button class="project__card__menu--item project__card__menu__item__btn--delete"
                    ><i class="fas fa-trash-alt"></i
                    ><span class="project__card__menu--item--text"
                      >Xóa Dự Án</span
                    ></button
                  >
                </div>`

        }
    </div>`;
}

export default ProjectItem;