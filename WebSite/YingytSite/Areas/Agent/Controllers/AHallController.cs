using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using YingytSite.Models.Library;

namespace YingytSite.Areas.Agent.Controllers
{
    public class AHallController : Controller
    {
        HallModel hallModel = new HallModel();

        #region 营业厅
        [Authorize]
        public ActionResult AHallList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveAHallList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = hallModel.GetAHallDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult AddAHall()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "AddHall", "", rootUri);

            var agentlist = HallModel.GetAgentList();
            ViewData["agents"] = agentlist;
            var provincelist = RegionModel.GetProvinceList();

            ViewData["provinces"] = provincelist;
            if (provincelist != null && provincelist.Count > 0)
                ViewData["cities"] = RegionModel.GetCityList(provincelist.ElementAt(0).uid);
            return View();
        }

        [Authorize]
        public ActionResult EditAHall(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditHall", "", rootUri);

            var hallinfo = hallModel.GetHallInfoById(id);
            ViewData["hallinfo"] = hallinfo;
            ViewData["uid"] = hallinfo.uid;

            long user_id = CommonModel.GetCurrentUserId();
            var agentlist = HallModel.GetHallListByParentid(user_id);
            ViewData["agents"] = agentlist;
            tbl_ecsregion districtinfo = RegionModel.GetRegionInfo(hallinfo.addrid);
            tbl_ecsregion cityinfo = null;
            tbl_ecsregion provininfo = null;
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
            return View("AddAHall");
        }

        public ActionResult AHallEditPass(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Hall";
            ViewData["level2nav"] = "HallList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditLPass", "", rootUri);

            var agentinfo = hallModel.GetHallById(id);
            ViewData["hallinfo"] = agentinfo;
            ViewData["uid"] = agentinfo.uid;

            return View();
        }
        #endregion

    }
}