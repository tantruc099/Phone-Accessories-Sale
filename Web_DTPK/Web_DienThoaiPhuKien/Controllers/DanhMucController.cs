using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_DienThoaiPhuKien.Models;

namespace Web_DienThoaiPhuKien.Controllers
{
    public class DanhMucController : Controller
    {
        QL_DTPKDataContext db = new QL_DTPKDataContext();
        // GET: DanhMuc
        public ActionResult DanhMucPartial()
        {
            var listDM = db.DanhMucs.Take(4).ToList();
            return View(listDM);
        }
    }
}