using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_DienThoaiPhuKien.Models;

namespace Web_DienThoaiPhuKien.Controllers
{
    public class HomeController : Controller
    {
        QL_DTPKDataContext context = new QL_DTPKDataContext();
        // GET: Home
        public ActionResult Index()
        {
            if (Session["UserID"] != null)
            {
                int userID = (int)Session["UserID"];
                return View();
            }
            else
            {
                ViewBag.TB = "Người dùng chưa đăng nhập";
                return View();
            }
        }
    }
}