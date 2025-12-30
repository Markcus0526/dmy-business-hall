using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using YingytSite.Models.Library;

namespace YingytSite.Controllers
{
    public class HallController : Controller
    {
        HallModel hallModel = new HallModel();

        #region 营业厅管理
        [Authorize(Roles = "Lobby")]
        public ActionResult HallList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "", "", rootUri);
            //ViewData["config"] = SystemModel.GetMailConfig();

            return View();
        }

        [Authorize(Roles = "Lobby")]
        [AjaxOnly]
        public JsonResult RetrieveHallList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = hallModel.GetHallDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Lobby")]
        [AjaxOnly]
        public JsonResult CheckUniqueHallname(string hallname)
        {
            string rst = "";
            rst = hallModel.CheckUniqueHallname(hallname);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Lobby")]
        public ActionResult AddHall()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "AddHall", "", rootUri);

            var agentlist = HallModel.GetAgentList();
            ViewData["agents"] = agentlist;
            var provincelist = RegionModel.GetProvinceList();

            ViewData["provinces"] = provincelist;
            if (provincelist != null && provincelist.Count > 0)
            {
                var cities = RegionModel.GetCityList(provincelist.ElementAt(0).uid);
                if (cities == null || cities.Count() == 0) 
                    cities = new List<tbl_ecsregion>(provincelist.Take(1));
                ViewData["cities"] = cities;

                var districts = RegionModel.GetDistrictList(cities.ElementAt(0).uid);
                if (districts != null && districts.Count() > 0)
                    ViewData["districts"] = districts;
                else
                    ViewData["districts"] = new List<tbl_ecsregion>(cities.Take(1));
            }
            return View();
        }

        [Authorize(Roles = "Lobby")]
        public ActionResult EditHall(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditHall", "", rootUri);

            var hallinfo = hallModel.GetHallInfoById(id);
            ViewData["hallinfo"] = hallinfo;
            ViewData["uid"] = hallinfo.uid;


            var agentlist = HallModel.GetAgentList();
            ViewData["agents"] = agentlist;
            var districtinfo = RegionModel.GetRegionInfo(hallinfo.addrid);
            var cityinfo = new tbl_ecsregion();
            var provininfo = new tbl_ecsregion();
            if (districtinfo != null)
            {
                cityinfo = RegionModel.GetRegionInfo(districtinfo.parentid);
                if (cityinfo != null)
                {
                    provininfo = RegionModel.GetRegionInfo(cityinfo.parentid);
                    if (provininfo == null)
                        provininfo = cityinfo;
                }
                else
                {
                    cityinfo = districtinfo;
                    provininfo = districtinfo;
                }
            }
            if (cityinfo != null)
                ViewData["hallcity"] = cityinfo.uid;
            if (provininfo != null)
                ViewData["hallprovince"] = provininfo.uid;


            var provincelist = RegionModel.GetProvinceList();
            ViewData["provinces"] = provincelist;
            if (provincelist != null && provincelist.Count() > 0)
            {
                if (provininfo != null)
                {
                    var cities = RegionModel.GetCityList(provininfo.uid);
                    if (cities != null && cities.Count() > 0)
                    {
                        ViewData["cities"] = cities;
                        var districts = RegionModel.GetDistrictList(cityinfo.uid);
                        if (districts != null && districts.Count() > 0)
                            ViewData["districts"] = districts;
                        else
                            ViewData["districts"] = new List<tbl_ecsregion>(cities.Take(1));
                    }
                    else
                    {
                        ViewData["cities"] = new List<tbl_ecsregion>(provincelist.Take(1));
                        ViewData["districts"] = new List<tbl_ecsregion>(provincelist.Take(1));
                    }
                }
            }
            return View("AddHall");
        }

        [Authorize(Roles = "Lobby")]
        public ActionResult EditLPass(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditLPass", "", rootUri);

            var agentinfo = hallModel.GetHallById(id);
            ViewData["hallinfo"] = agentinfo;
            ViewData["uid"] = agentinfo.uid;

            return View();
        }

        //[Authorize(Roles = "Lobby")]
        [HttpPost]
        public JsonResult DeleteHall(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = hallModel.DeleteHall(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        //[Authorize(Roles = "Lobby")]
        [HttpPost]
        public JsonResult showHall(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = hallModel.showHall(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        //[Authorize(Roles = "Lobby")]
        [HttpPost]
        public JsonResult hideHall(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = hallModel.hideHall(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        //[Authorize(Roles = "Lobby")]
        [HttpPost]
        public JsonResult shareHall(long uid)
        {
            bool rst = hallModel.shareHall(uid);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        //[Authorize(Roles = "Lobby")]
        [HttpPost]
        public JsonResult unshareHall(long uid)
        {
            bool rst = hallModel.unshareHall(uid);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Lobby")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitHall(long uid, string hallname, string nickname ,string hallpwd, string province,
            string city, string district, string addrdetail, string categorylist, string phone, string email, string qqnumber)
        {
            string rst = "";

            if (uid == 0)
            {
                rst = hallModel.InsertHall(hallname, nickname, hallpwd, province,
                                            city, district, addrdetail, categorylist, phone, email, qqnumber);
            }
            else
            {
                rst = hallModel.UpdateHall(uid, hallname, nickname, hallpwd, province,
                                            city, district, addrdetail, categorylist, phone, email, qqnumber);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        //[Authorize]
        public ActionResult LoginHall(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            string loginurl = rootUri + "Lobby/Auth/LogOn";
            //string loginurl = "http://localhost:55418/Account/LogOn";

            var hallinfo = hallModel.GetHallInfoById(id);

            if (hallinfo == null)
            {
                return null;
            }

            ViewData["rootUri"] = rootUri;
            ViewData["loginurl"] = loginurl;
            ViewData["username"] = hallinfo.hallname;
            ViewData["password"] = hallinfo.password;

            return View();
        }

        [Authorize(Roles = "Lobby")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult UpdatePassword(long uid, string oldpassword, string newpassword)
        {
            string rst = "";

            rst = hallModel.UpdatePassword(uid, oldpassword, newpassword);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}
