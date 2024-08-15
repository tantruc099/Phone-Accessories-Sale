
(function contentBlog () {
    const btnLeft = document.querySelector('#content__blog-btn-left')
    const btnRight = document.querySelector('#content__blog-btn-right')
    const itemBlog = document.querySelector('.content__blog--item')
    const blogContainer = document.querySelector('.content__blog-wrap')

    btnLeft.addEventListener('click' , () => {
        blogContainer.scrollLeft -= itemBlog.offsetWidth + 12
    })
    btnRight.addEventListener('click' , () => {
        blogContainer.scrollLeft += itemBlog.offsetWidth + 12
    })
})()

function responsiveMobile() {
    const bars = document.querySelector('.header__menu-phone')
    const headerMenu = document.querySelector('.header__menu-list')
    const itemsMenu = [...document.querySelectorAll('.header__menu-item')]

    bars.addEventListener('click', (e) => {
        headerMenu.classList.toggle('hide-menu')
    })
    itemsMenu.forEach(item => {
        item.addEventListener('click', (e) => {
            headerMenu.classList.toggle('hide-menu')
        })
    })

    const logo = document.querySelector('.header__logo')
    logo.addEventListener('click', (e) => {
        location.reload()
    })

    const storeMenu = document.querySelector('.store__menu')
    const storeBars = document.querySelector('.sidebar__wrap')
    storeMenu.addEventListener('click', (e) => {
        storeBars.classList.toggle('hide-sidebar')
    })
    storeBars.addEventListener('click', (e) => {
        if (e.target == e.currentTarget) {
            storeBars.classList.toggle('hide-sidebar')
        }
    })
    const storeProduct = document.querySelector('.sidebar__product')
    storeProduct.addEventListener('click', (e) => {
        storeBars.classList.toggle('hide-sidebar')
    })
}
responsiveMobile()

window.addEventListener('resize', (e) => reloadResponsiveProduct())
function reloadResponsiveProduct() {
    // để tạo lại số trang và sản phẩm trên mobile và ipad
    if (JSON.parse(localStorage.getItem('reloadResponsive')) == true) {
        if (window.innerWidth > 1024) {
            localStorage.setItem('reloadResponsive', false)
            location.reload()
        }
    } else if (JSON.parse(localStorage.getItem('reloadResponsive')) == false) {
        if (window.innerWidth < 1024) {
            localStorage.setItem('reloadResponsive', true)
            location.reload()
        }
    }
}
reloadResponsiveProduct()