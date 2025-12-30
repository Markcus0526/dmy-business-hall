using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using YingytSite.Models.Library;
using System.Collections.Specialized;
using System.Web.Hosting;
using Newtonsoft.Json;

namespace YingytSite.Areas.Lobby.Controllers
{
    public class LStatisticsController : Controller
    {
        [Authorize]
        public ActionResult LStatistics()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Statistics";
            ViewData["level2nav"] = "Statistics";

            PhoneModel phoneModel = new PhoneModel();
            var brandlist = PhoneModel.GetBrandList();
            ViewData["brandlist"] = brandlist;

            ViewData["startdate"] = String.Format("{0:0}-01-01", DateTime.Now.Year);
            ViewData["enddate"] = String.Format("{0:yyyy-MM-dd}", DateTime.Now);
            ViewData["daydiff"] = (DateTime.Now - (new DateTime(DateTime.Now.Year, 1, 1))).TotalDays;

            return View();
        }

        //[AjaxOnly]
        //[Authorize]
        //public JsonResult GetSpecList(long brand_id)
        //{
        //    string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            
        //    PhoneModel phoneModel = new PhoneModel();
        //    var rst = phoneModel.GetSpecInfoListById(brand_id);

        //    return Json(rst, JsonRequestBehavior.AllowGet);
        //}

        //[AjaxOnly]
        //[Authorize]
        //public JsonResult RetriveStatisticsList(long brand_id, long spec_id, byte type, string startdate, string enddate)
        //{
        //    DateTime start = DateTime.Now;
        //    try { start = Convert.ToDateTime(startdate); }
        //    catch(Exception e) {}

        //    DateTime end = DateTime.Now;
        //    try { end = Convert.ToDateTime(enddate); }
        //    catch(Exception e) {}

        //    PhonereadModel aModel = new PhonereadModel();
        //     if (type == 0)
        //     {
        //         List<StatisticsMonthlyInfo> rst = aModel.GetMonthlyStatisticsList(brand_id, spec_id, start, end);
        //         return Json(rst, JsonRequestBehavior.AllowGet);
        //     }
        //     else
        //     {
        //         List<StatisticsDailyInfo> rst = aModel.GetDailyStatisticsList(brand_id, spec_id, start, end);
        //         return Json(rst, JsonRequestBehavior.AllowGet);
        //     }
        //}
    }
}
