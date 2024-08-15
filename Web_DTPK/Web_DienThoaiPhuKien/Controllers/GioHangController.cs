using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_DienThoaiPhuKien.Models;
using System.Configuration;

namespace Web_DienThoaiPhuKien.Controllers
{
    public class GioHangController : Controller
    {
        private readonly string connectionString;
        QL_DTPKDataContext context = new QL_DTPKDataContext();
        private List<GioHang> cartItems = new List<GioHang>();
        public GioHangController()
        {
            connectionString = ConfigurationManager.AppSettings["connectionString"];
        }
        public int tmaHD {  get; set; }
        // GET: GioHang
        public List<GioHang> GetProduct()
        {
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang == null)
            {
                lstGioHang = new List<GioHang>();
                Session["GioHang"] = lstGioHang;
            }
            return lstGioHang;
        }
        //Them gio hang
        public ActionResult AddProduct(int MaSP, string strURL)
        {
            List<GioHang> lstGioHang = GetProduct();
            GioHang sp = lstGioHang.Find(s => s.iMaSP == MaSP);
            if (sp == null)
            {
                sp = new GioHang(MaSP);
                lstGioHang.Add(sp);
                return Redirect(strURL);
            }
            else
            {
                sp.iSoLuong++;
                return Redirect(strURL);
            }
        }
        //Tong so luong
        private int TongSoLuong()
        {
            int sum = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang != null)
            {
                sum += lstGioHang.Sum(sp => sp.iSoLuong);
            }
            return sum;
        }
        //Tong thanh tien
        private double TongThanhTien()
        {
            double sum = 0;
            List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
            if (lstGioHang != null)
            {
                sum += lstGioHang.Sum(sp => sp.dTongTien);
            }
            return sum;
        }
        //Xay dung trang gio hang
        public ActionResult GioHang()
        {
            List<GioHang> lstGioHang = GetProduct();

            if (lstGioHang == null || lstGioHang.Count == 0)
            {
                ViewBag.ErrorMessage = "Giỏ hàng của bạn đang trống.";
                return View("GioHang");
            }

            ViewBag.TongSoLuong = TongSoLuong();
            ViewBag.TongThanhTien = TongThanhTien();
            return View(lstGioHang);
        }
        //Hien thi so luong gio hang tren layout
        public ActionResult GioHangPartial()
        {
            ViewBag.TongSoLuong = TongSoLuong();
            return PartialView();
        }
        //Xoa gio hang
        public ActionResult RemoveProduct(int MaSP)
        {
            List<GioHang> lstGioHang = GetProduct();
            GioHang sp = lstGioHang.Single(s => s.iMaSP == MaSP);
            if (sp != null)
            {
                lstGioHang.RemoveAll(s => s.iMaSP == MaSP);
                return RedirectToAction("GioHang", "GioHang");
            }
            if (lstGioHang.Count == 0)
            {
                return RedirectToAction("AllProduct", "Product");
            }
            return RedirectToAction("GioHang", "GioHang");
        }
        public ActionResult RemoveAll()
        {
            List<GioHang> lstGioHang = GetProduct();
            lstGioHang.Clear();
            return RedirectToAction("AllProduct", "Product");
        }
        [HttpPost]
        public ActionResult UpdateQuantity(int MaSP, string action, FormCollection f)
        {
            List<GioHang> lstGioHang = GetProduct();
            GioHang sp = lstGioHang.SingleOrDefault(s => s.iMaSP == MaSP);

            if (sp != null)
            {
                if (action == "increment")
                {
                    sp.iSoLuong = sp.iSoLuong + 1;
                }
                else if (action == "decrement" && sp.iSoLuong > 1)
                {
                    sp.iSoLuong = sp.iSoLuong - 1;
                }
            }
            UpdateCartTotals(lstGioHang);
            return RedirectToAction("GioHang");
        }
        private void UpdateCartTotals(List<GioHang> lstGioHang)
        {
            if (lstGioHang != null)
            {
                ViewBag.TongSoLuong = lstGioHang.Sum(sp => sp.iSoLuong);
                ViewBag.TongThanhTien = lstGioHang.Sum(sp => sp.dTongTien);
            }
            else
            {
                ViewBag.TongSoLuong = 0;
                ViewBag.TongThanhTien = 0;
            }
        }
        public ActionResult ChiTietHoaDon(int maHD)
        {
            if (Session["UserID"] != null)
            {
                List<GioHang> lstGioHang = GetProduct();
                ViewBag.TongSoLuong = TongSoLuong();
                ViewBag.TongThanhTien = TongThanhTien();
                Session["GioHang"] = null;
                return View(lstGioHang);
            }

            return RedirectToAction("Login", "Account");
        }
        public List<ChiTietHD> GetChiTietHoaDonByMaHD(int maHD)
        {
            using (var dbContext = new QL_DTPKDataContext(connectionString))
            {
                var chiTietHoaDon = dbContext.ChiTietHDs.Where(chiTiet => chiTiet.MaHD == maHD).ToList();
                return chiTietHoaDon;
            }
        }

        [HttpPost]
        public ActionResult ThanhToan()
        {
            if (Session["UserID"] != null)
            {
                int userID = (int)Session["UserID"];

                try
                {
                    using (var context = new QL_DTPKDataContext(connectionString))
                    {
                        List<GioHang> lstGioHang = Session["GioHang"] as List<GioHang>;
                        int MAHD = 0;
                        if (lstGioHang != null && lstGioHang.Any())
                        {
                            var user = context.UserAccounts.FirstOrDefault(u => u.ID_user == userID);
                            double totalPrice = CalculateTotalPrice(lstGioHang);
                            int roundedTotalPrice = (int)Math.Round(totalPrice);
                            DateTime ngaydat = new DateTime();
                            ngaydat = DateTime.Now;
                            int day = ngaydat.Day;
                            int month = ngaydat.Month;
                            int year = ngaydat.Year;
                            string noichuoi = month + "/" + day + "/" + year;                          
                            string query = "INSERT INTO HoaDon(MaKH, NgayDat, ThanhTien, TrangThai) OUTPUT INSERTED.MaHD VALUES (@UserID, @NgayDat, @ThanhTien, @TrangThai)";

                            using (SqlConnection conn = new SqlConnection(connectionString))
                            {
                                conn.Open();

                                SqlCommand cmd = new SqlCommand(query, conn);
                                cmd.Parameters.AddWithValue("@UserID", user.MaKH);
                                cmd.Parameters.AddWithValue("@NgayDat", noichuoi);
                                cmd.Parameters.AddWithValue("@ThanhTien", roundedTotalPrice);
                                cmd.Parameters.AddWithValue("@TrangThai", "Đã thanh toán");

                                int newMaHD = Convert.ToInt32(cmd.ExecuteScalar());
                                MAHD = (int)newMaHD;
                                foreach (var item in lstGioHang)
                                {
                                    string insertQuery = "INSERT INTO ChiTietHD (MaHD, MaSP, SoLuong, Gia) VALUES (@MaHD, @MaSP, @SoLuong, @Gia)";

                                    SqlCommand cmd1 = new SqlCommand(insertQuery, conn);
                                    cmd1.Parameters.AddWithValue("@MaHD", newMaHD); // Assuming iMaHD is the ID of the newly created invoice
                                    cmd1.Parameters.AddWithValue("@MaSP", item.iMaSP); // Assuming iMaSP is the product ID in 'item'
                                    cmd1.Parameters.AddWithValue("@SoLuong", item.iSoLuong); // Assuming iSoLuong is the quantity of the product in 'item'
                                    cmd1.Parameters.AddWithValue("@Gia", (int)(item.dTongTien / item.iSoLuong)); // Assuming dTongTien is the total price and iSoLuong is the quantity

                                    cmd1.ExecuteNonQuery();
                                }
                                conn.Close();
                            }

                            return RedirectToAction("ChiTietHoaDon", "GioHang", new {maHD = MAHD});
                        }
                        else
                        {
                            ViewBag.ErrorMessage = "Giỏ hàng của bạn đang trống.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    ViewBag.ErrorMessage = "Lỗi xảy ra khi thanh toán";
                }
            }
            else
            {
                ViewBag.ErrorMessage = "Vui lòng đăng nhập để thực hiện thanh toán.";
                return RedirectToAction("Login", "Account");
            }
            return RedirectToAction("GioHang");
        }
        private double CalculateTotalPrice(List<GioHang> cartItems)
        {
            double totalPrice = 0.0;

            if (cartItems != null && cartItems.Any())
            {
                foreach (var item in cartItems)
                {
                    totalPrice += item.dTongTien;
                }
            }

            return totalPrice;
        }
    }
}