using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web_DienThoaiPhuKien.Models
{
    public partial class ChiTietHD
    {
        QL_DTPKDataContext db = new QL_DTPKDataContext();
        public int iMaCTHD { get; set; }
        public int iMaHD { get; set; }
        public int iMaSP { get; set; }
        public int iSoLuong { get; set; }
        public int iGia { get; set; }
    }
}