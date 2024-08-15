using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Web_DienThoaiPhuKien.Models
{
    public class Register
    {
        [Required(ErrorMessage = "Vui lòng nhập lại Họ và Tên.")]
        public string HoTen { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Địa chỉ.")]
        public string DiaChi { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Email.")]
        [EmailAddress(ErrorMessage = "Địa chỉ Email không hợp lệ.")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Số điện thoại.")]
        public string DienThoai { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập Tên đăng nhập.")]
        public string Username { get; set; }
        [Required(ErrorMessage = "Vui lòng nhập mật khẩu.")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        [Required(ErrorMessage = "Vui lòng xác nhận mật khẩu.")]
        [Compare("Password", ErrorMessage = "Mật khẩu và xác nhận mật khẩu không khớp")]
        [DataType(DataType.Password)]
        public string ConfirmPassword { get; set; }
    }
}