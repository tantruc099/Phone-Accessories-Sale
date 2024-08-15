using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_DienThoaiPhuKien.Models
{
    public class GioHang
    {
        QL_DTPKDataContext db = new QL_DTPKDataContext();
        public int iMaSP { get; set; }
        public string sTenSP { get; set; }
        public string sHinhAnh { get; set; }
        public double dGia { get; set; }
        public int iSoLuong { get; set; }
        public double dTongTien
        {
            get { return iSoLuong * dGia; }
        }
        public GioHang(int MaSP)
        {
            iMaSP = MaSP;
            SanPham sp = db.SanPhams.Single(s => s.MaSP == iMaSP);
            sTenSP = sp.TenSP;
            sHinhAnh = sp.HinhAnh;
            dGia = double.Parse(sp.Gia.ToString());
            iSoLuong = 1;
        }
    }
}