using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_DienThoaiPhuKien.Models;
using PagedList;

namespace Web_DienThoaiPhuKien.Controllers
{
    public class ProductController : Controller
    {
        QL_DTPKDataContext db = new QL_DTPKDataContext();
        // GET: Product
        public ActionResult AllProduct(int? page)
        {
            int pageSize = 8;
            int pageNumber = (page ?? 1);
            var lstProduct = db.SanPhams.OrderBy(s => s.TenSP).ToList();
            IPagedList<SanPham> pageList = lstProduct.ToPagedList(pageNumber, pageSize);
            return View(pageList);
        }
        public ActionResult DanhMucProduct(int MaDM, int? page)
        {
            int pageSize = 8;
            int pageNumber = (page ?? 1);
            var listProduct = db.SanPhams.Where(s => s.MaDM == MaDM).OrderBy(s => s.Gia).ToList();
            IPagedList<SanPham> pageList = listProduct.ToPagedList(pageNumber, pageSize);
            if (listProduct.Count == 0)
            {
                ViewBag.TB = "Không có sản phẩm nào thuộc danh mục này";
            }
            return View(pageList);
        }

        public ActionResult SearchProduct(string txt_search, int? page)
        {
            int pageSize = 8;
            int pageNumber = (page ?? 1);
            var listProduct = db.SanPhams.Where(s => s.TenSP.Contains(txt_search)).ToList();
            IPagedList<SanPham> pageList = listProduct.ToPagedList(pageNumber, pageSize);
            if (listProduct.Count == 0)
            {
                ViewBag.TB = "Không có sản phẩm bạn tìm"; 
            }
            return View(pageList);
        }
        public ActionResult DetailProduct(int MaSP)
        {
            SanPham sp = db.SanPhams.Single(s => s.MaSP == MaSP);
            if (sp == null)
            {
                return HttpNotFound();
            }
            return View(sp);
        }
        [HttpPost]
        public ActionResult SubmitRating(int MaSP, int rating, string txtNoiDungDanhGia)
        {
            if (Session["UserID"] != null)
            {
                var dbContext = new QL_DTPKDataContext();
                int masp = MaSP;
                int userID = (int)Session["UserID"];
                var user = dbContext.UserAccounts.FirstOrDefault(u => u.ID_user == userID);
                DanhGia danhGia = new DanhGia
                {
                    MaSP = masp,
                    NoiDung = txtNoiDungDanhGia,
                    DanhGiaSao = rating,
                    MaKH = user.MaKH
                };
                dbContext.DanhGias.InsertOnSubmit(danhGia);
                dbContext.SubmitChanges();
            }
            else
            {
                ViewBag.ErrorMessage = "Vui lòng đăng nhập để thực hiện thanh toán.";
                return RedirectToAction("Login", "Account");
            }

            return RedirectToAction("AllProduct", "Product");
        }

    }
}