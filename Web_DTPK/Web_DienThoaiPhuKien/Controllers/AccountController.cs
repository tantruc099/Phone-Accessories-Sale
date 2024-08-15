using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_DienThoaiPhuKien.Models;

namespace Web_DienThoaiPhuKien.Controllers
{
    public class AccountController : Controller
    {
        QL_DTPKDataContext context = new QL_DTPKDataContext();
        // GET: Account
        string HoTenForLogin = "";
        [HttpGet]
        public ActionResult Register()
        {
            var model = new Register();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(Register model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    KhachHang khachHang = new KhachHang
                    {
                        HoTen = model.HoTen,
                        DiaChi = model.DiaChi,
                        Email = model.Email,
                        DienThoai = model.DienThoai,
                    };
                    HoTenForLogin = model.HoTen;
                    context.KhachHangs.InsertOnSubmit(khachHang);
                    context.SubmitChanges();
                    UserAccount userAccount = new UserAccount
                    {
                        username = model.Username,
                        password_user = model.Password,
                        MaKH = khachHang.MaKH
                    };
                    context.UserAccounts.InsertOnSubmit(userAccount);
                    context.SubmitChanges();
                    return RedirectToAction("Login", "Account");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "Đã có lỗi xảy ra khi đăng ký");
                }
            }
            return View(model);
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(Login model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var user = context.UserAccounts.SingleOrDefault(u => u.username == model.Username && u.password_user == model.Password);
                    var HoTen = HoTenForLogin;
                    var model1 = new Login
                    {
                        HoTen = HoTen
                    };
                    if (user != null)
                    {
                        Session["UserID"] = user.ID_user;
                        if (user.vaitro == 1)
                        {
                            return RedirectToAction("Index", "Admin");
                        }
                        else
                        {
                            return RedirectToAction("AllProduct", "Product");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không đúng.");
                    }
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", "Đã xảy lỗi khi đăng nhập.");
                }
            }
            return View(model);
        }
        public JsonResult GetHoTen()
        {
            var hoTen = HoTenForLogin;

            return Json(new { HoTen = hoTen }, JsonRequestBehavior.AllowGet);
        }

    }
}