using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Web;

namespace Web_DienThoaiPhuKien.Models
{
    public partial class HoaDon
    {
        QL_DTPKDataContext db = new QL_DTPKDataContext();
        public int iMaHD { get; set; }
        public int iMaKH { get; set; }
        public DateTime dNgayDat { get; set; }
        public int iThanhTien { get; set; }
        public string sTrangThai { get; set; }
    }

}