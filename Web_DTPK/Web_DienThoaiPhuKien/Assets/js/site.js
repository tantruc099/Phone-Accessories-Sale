$(document).ready(function () {
    $("#lay5SanPhamLink").click(function (e) {
        e.preventDefault();
        $.ajax({
            url: "/Admin/Lay5SanPham",
            type: "GET",
            success: function (result) {
                console.log("Action đã được gọi thành công.");
            },
            error: function (error) {
                console.log("Đã xảy ra lỗi: " + error);
            }
        });
    });
});