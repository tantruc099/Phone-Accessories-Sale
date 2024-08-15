using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_DienThoaiPhuKien.Models;
using System.IO;
using System.Configuration;

namespace Web_DienThoaiPhuKien.Controllers
{
    public class AdminController : Controller
    {
        private readonly string connectionString;
        public AdminController()
        {
            connectionString = ConfigurationManager.AppSettings["connectionString"];
        }
        QL_DTPKDataContext context = new QL_DTPKDataContext();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Function()
        {
            return View();
        }
        public ActionResult Procedure()
        {
            return View();
        }
        public ActionResult DanhGiaTrungBinh(int MaSP)
        {
            decimal result = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.DanhGiaTrungBinh", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.AddWithValue("@MaSP", MaSP);

                    // Define the output parameter for the return value
                    SqlParameter returnValue = new SqlParameter("@ReturnValue", SqlDbType.Decimal);
                    returnValue.Direction = ParameterDirection.ReturnValue;
                    command.Parameters.Add(returnValue);

                    connection.Open();
                    command.ExecuteNonQuery();

                    if (returnValue.Value != DBNull.Value)
                    {
                        result = Convert.ToDecimal(returnValue.Value);
                    }
                }
            }
            ViewBag.AverageRating = result;
            return PartialView("_Function1");
        }
        public ActionResult SoHoaDonCuaKhachHang(int MaKH)
        {
            int sl = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.SoLuongHoaDonCuaKhachHang", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@MaKH", MaKH);

                    SqlParameter returnValue = command.Parameters.Add("@SLHD", SqlDbType.Int);
                    returnValue.Direction = ParameterDirection.ReturnValue;

                    connection.Open();
                    command.ExecuteNonQuery();

                    if (returnValue.Value != DBNull.Value)
                    {
                        sl = (int)(returnValue.Value);
                    }
                }
            }
            ViewBag.SL = sl;
            return PartialView("_Function1");
        }
        public ActionResult XoaHoaDonVaCacBangLienQuan(int MaHD)
        {
            HoaDon hoaDonToDelete = null;
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM HoaDon WHERE MaHD = @MaHD";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@MaHD", MaHD);
                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        hoaDonToDelete = new HoaDon
                        {
                            MaHD = Convert.ToInt32(reader["MaHD"]),
                            MaKH = Convert.ToInt32(reader["MaKH"]),
                            NgayDat = Convert.ToDateTime(reader["NgayDat"]),
                            ThanhTien = Convert.ToInt32(reader["ThanhTien"]),
                            TrangThai = Convert.ToString(reader["TrangThai"])
                        };
                    }
                    connection.Close();
                }
                using (SqlCommand command = new SqlCommand("dbo.XoaHoaDon", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@MaHD", MaHD);

                    SqlParameter returnValue = command.Parameters.Add("@MaHDMuonXoa", SqlDbType.Int);
                    returnValue.Direction = ParameterDirection.ReturnValue;

                    connection.Open();
                    rowsAffected = command.ExecuteNonQuery();
                    if (returnValue.Value != DBNull.Value)
                    {
                        rowsAffected = (int)(returnValue.Value);
                    }
                }
            }
            ViewBag.MaHD = rowsAffected;
            return PartialView("_Procedure1", hoaDonToDelete);
        }
        public List<SanPham> Lay5SanPhamDatNhat()
        {
            List<SanPham> products = new List<SanPham>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("dbo.Lay5SanPhamDatNhat", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        SanPham product = new SanPham();
                        product.TenSP = reader["ProductName"].ToString();
                        product.Gia = Convert.ToInt32(reader["Price"]);
                        products.Add(product);
                    }

                    reader.Close();
                }
            }

            return products;
        }
        public ActionResult Lay5SanPham()
        {
            List<SanPham> products = Lay5SanPhamDatNhat();
            ViewBag.ShowLay5SanPhamPartial = true;
            return PartialView("_Procedure2", products);
        }
        public ActionResult DanhMucPartialA(int MaDM)
        {
            var listDM = context.DanhMucs.Take(4).ToList();
            ViewBag.MaDM = MaDM;
            return PartialView(listDM);
        }
        public ActionResult QLSP()
        {
            var listSP = context.SanPhams.OrderBy(s => s.TenSP).ToList();
            return View(listSP);
        }
        public ActionResult ThemSanPham()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ThemSanPham(SanPham sanPham, HttpPostedFileBase file)
        {
            if (ModelState.IsValid && file != null)
            {
                var fileName = Path.GetFileName(file.FileName);
                var path = Path.Combine(Server.MapPath("~/Assets/image/products"), fileName);
                file.SaveAs(path);
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Insert the new product into the database
                    string insertQuery = "INSERT INTO SanPham (TenSP, MoTa, Gia, HinhAnh, MaDM, SoLuongTon) " +
                                         "VALUES (@TenSP, @MoTa, @Gia, @HinhAnh, @MaDM, @SoLuongTon);";

                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        command.Parameters.AddWithValue("@TenSP", sanPham.TenSP);
                        command.Parameters.AddWithValue("@MoTa", sanPham.MoTa);
                        command.Parameters.AddWithValue("@Gia", sanPham.Gia);
                        command.Parameters.AddWithValue("@HinhAnh", fileName);
                        command.Parameters.AddWithValue("@MaDM", sanPham.MaDM);
                        command.Parameters.AddWithValue("@SoLuongTon", sanPham.SoLuongTon);

                        command.ExecuteNonQuery();
                    }
                    connection.Close();
                }

                return RedirectToAction("QLSP");
            }

            return View(sanPham);
        }
        public ActionResult DeleteSanPham(int MaSP)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string deleteQuery = "DELETE FROM SanPham WHERE MaSP = @ProductId;";

                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", MaSP);
                    command.ExecuteNonQuery();
                }
                connection.Close();
            }

            return RedirectToAction("QLSP");
        }
        public ActionResult EditSanPham(int MaSP)
        {
            return View();
        }
        [HttpPost]
        public ActionResult EditSanPham(SanPham sanPham, HttpPostedFileBase file, int MaSP)
        {
            try
            {
                if (ModelState.IsValid && file != null)
                {
                    var fileName = Path.GetFileName(file.FileName);
                    var path = Path.Combine(Server.MapPath("~/Assets/image/products"), fileName);
                    file.SaveAs(path);

                    UpdateProduct(sanPham, fileName, MaSP);

                    return RedirectToAction("QLSP");
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "An error occurred while updating the product.");
            }

            return View(sanPham);
        }

        private void UpdateProduct(SanPham sanPham, string fileName, int MaSP)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "UPDATE SanPham SET TenSP = @TenSP, MoTa = @MoTa, Gia = @Gia, HinhAnh = @HinhAnh, MaDM = @MaDM, SoLuongTon = @SoLuongTon WHERE MaSP = @ProductId;";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@TenSP", sanPham.TenSP);
                command.Parameters.AddWithValue("@MoTa", sanPham.MoTa);
                command.Parameters.AddWithValue("@Gia", sanPham.Gia);
                command.Parameters.AddWithValue("@HinhAnh", fileName);
                command.Parameters.AddWithValue("@MaDM", sanPham.MaDM);
                command.Parameters.AddWithValue("@SoLuongTon", sanPham.SoLuongTon);
                command.Parameters.AddWithValue("@ProductId", MaSP);

                command.ExecuteNonQuery();

                connection.Close();
            }
        }
        public ActionResult DetailProductA(int MaSP)
        {
            SanPham sp = context.SanPhams.Single(s => s.MaSP == MaSP);
            if (sp == null)
            {
                return HttpNotFound();
            }
            return View(sp);
        }
        public ActionResult ThongKe()
        {
            var tongSanPham = context.SanPhams.Sum(s => s.SoLuongTon);
            var soIphone = context.SanPhams.Count(s => s.MaDM == 1);
            ViewBag.soIphone = (double)soIphone / tongSanPham * 100;
            var soOppo = context.SanPhams.Count(s => s.MaDM == 2);
            ViewBag.soOppo = (double)soOppo / tongSanPham * 100;
            var soSamsung = context.SanPhams.Count(s => s.MaDM == 3);
            ViewBag.soSamsung = (double)soSamsung / tongSanPham * 100;
            var soPhuKien = context.SanPhams.Count(s => s.MaDM == 4);
            ViewBag.soPhuKien = (double)soPhuKien / tongSanPham * 100 ;
            return View();
        }
        //=================
        public ActionResult QuanLyHoaDon()
        {
            QL_DTPKDataContext db = new QL_DTPKDataContext();
            var listHD = db.HoaDons.ToList();
            return View(listHD);
        }
        public ActionResult XoaHoaDon(int maHD)
        {
            QL_DTPKDataContext db = new QL_DTPKDataContext();
            var listHD = db.HoaDons.Where(s => s.MaHD == maHD).ToList();
            foreach (var hd in listHD)
            {
                db.HoaDons.DeleteOnSubmit(hd);
            }
            db.SubmitChanges();
            return RedirectToAction("QuanLyHoaDon", "Admin");
        }
        public ActionResult EditHoaDon(int maHD)
        {
            QL_DTPKDataContext db = new QL_DTPKDataContext();
            var listHD = db.HoaDons.SingleOrDefault(s => s.MaHD == maHD);
            if (listHD == null)
            {
                return HttpNotFound();
            }
            return View(listHD);
        }
        [HttpPost]
        public ActionResult UpdateHoaDon(HoaDon hoaDon)
        {
            QL_DTPKDataContext db = new QL_DTPKDataContext();
            if (ModelState.IsValid)
            {
                var tontai = db.HoaDons.SingleOrDefault(hd => hd.MaHD == hoaDon.MaHD);
                if (tontai != null)
                {
                    tontai.MaKH = hoaDon.MaKH;
                    tontai.NgayDat = hoaDon.NgayDat;
                    tontai.ThanhTien = hoaDon.ThanhTien;
                    tontai.TrangThai = hoaDon.TrangThai;
                    db.SubmitChanges();
                }
                return RedirectToAction("ChiTietHoaDon", new { maHD = hoaDon.MaHD });
            }
            return View("EditHoaDon", hoaDon);
        }
        public ActionResult ChiTietHoaDon(int maHD)
        {
            QL_DTPKDataContext db = new QL_DTPKDataContext();
            var listCTHD = db.ChiTietHDs.Where(s => s.MaHD == maHD).ToList();
            return View(listCTHD);
        }
        public ActionResult XoaChiTietHoaDon(int maCTHD)
        {
            QL_DTPKDataContext db = new QL_DTPKDataContext();
            var listCTHD = db.ChiTietHDs.Where(s => s.MaCTHD == maCTHD).ToList();
            foreach (var cthd in listCTHD)
            {
                db.ChiTietHDs.DeleteOnSubmit(cthd);
            }
            db.SubmitChanges();
            return RedirectToAction("QuanLyHoaDon", "Admin");
        }
    }
}