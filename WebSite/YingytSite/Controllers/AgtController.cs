using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using YingytSite.Models.Library;

namespace YingytSite.Controllers
{
    public class AgtController : Controller
    {
        AgentModel agentModel = new AgentModel();

        #region 城市代理
        [Authorize(Roles = "Agent")]
        public ActionResult AgentList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Agent";
            ViewData["level2nav"] = "AgentList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "", "", rootUri);
            //ViewData["config"] = SystemModel.GetMailConfig();

            return View();
        }

        [Authorize(Roles = "Agent")]
        [AjaxOnly]
        public JsonResult RetrieveAgentList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = agentModel.GetAgentDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Agent")]
        public ActionResult AddAgent()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Agent";
            ViewData["level2nav"] = "AgentList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "AddAgent", "", rootUri);

            var provincelist = RegionModel.GetProvinceList();
            ViewData["provinces"] = provincelist;
            if (provincelist != null && provincelist.Count() > 0)
            {
                var cities = RegionModel.GetCityList(provincelist.ElementAt(0).uid);
                if (cities != null && cities.Count() > 0)
                    ViewData["cities"] = cities;
                else
                    ViewData["cities"] = new List<tbl_ecsregion>(provincelist.Take(1));
            }

            return View();
        }

        [Authorize(Roles = "Agent")]
        public ActionResult EditAgent(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Agent";
            ViewData["level2nav"] = "AgentList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditAgent", "", rootUri);

            var agentinfo = agentModel.GetAgentById(id);
            ViewData["agentinfo"] = agentinfo;
            ViewData["uid"] = agentinfo.uid;

            var cityinfo = RegionModel.GetRegionInfo(agentinfo.addrid);
            tbl_ecsregion provininfo = null;
            if (cityinfo != null)
                provininfo = RegionModel.GetRegionInfo(cityinfo.parentid);
            else
                provininfo = cityinfo;
            if (provininfo != null)
                ViewData["agentprovince"] = provininfo.uid;


            var provincelist = RegionModel.GetProvinceList();
            ViewData["provinces"] = provincelist;
            if (provincelist != null && provincelist.Count() > 0)
            {
                if (provininfo != null)
                {
                    var cities = RegionModel.GetCityList(provininfo.uid);
                    if (cities != null && cities.Count() > 0)
                        ViewData["cities"] = cities;
                    else
                        ViewData["cities"] = new List<tbl_ecsregion>(provincelist.Take(1));
                }
            }

            return View("AddAgent");
        }

        [Authorize(Roles = "Agent")]
        public ActionResult EditAPass(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Agent";
            ViewData["level2nav"] = "AgentList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditAPass", "", rootUri);

            var agentinfo = agentModel.GetAgentById(id);
            ViewData["agentinfo"] = agentinfo;
            ViewData["uid"] = agentinfo.uid;

            return View();
        }

        [AjaxOnly]
        public JsonResult CheckUniqueAgentname(string agentid)
        {
            UserModel userModel = new UserModel();
            bool rst = userModel.CheckDuplicateName(agentid);
            rst &= agentModel.CheckDuplicateName(agentid);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Agent")]
        [HttpPost]
        public JsonResult DeleteAgent(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = agentModel.DeleteAgent(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Agent")]
        [HttpPost]
        public JsonResult BlockAgent(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = agentModel.BlockAgent(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Agent")]
        [HttpPost]
        public JsonResult ActivateAgent(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = agentModel.ActivateAgent(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "Agent")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitAgent(long uid, string userid, string username, string agentpwd, string agentname, long city, string addr, 
            string connector, string phonenum, string mailaddr, string qqnum, string status)
        {
            string rst = "";

            byte bstatus = (byte)(status == "on" ? 1 : 0);

            if (uid == 0)
            {
                rst = agentModel.InsertAgent(userid, username, agentpwd, agentname, city, addr, 
                    connector, phonenum, mailaddr, qqnum, bstatus);
            }
            else
            {
                rst = agentModel.UpdateAgent(uid, userid, username, agentpwd, agentname, city, addr,
                    connector, phonenum, mailaddr, qqnum, bstatus);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        //[Authorize]
        public ActionResult LoginAgent(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            string loginurl = rootUri + "Agent/Auth/LogOn";
            //string loginurl = "http://localhost:55418/Account/LogOn";

            var agentinfo = agentModel.GetAgentById(id);

            if (agentinfo == null)
            {
                return null;
            }

            ViewData["rootUri"] = rootUri;
            ViewData["loginurl"] = loginurl;
            ViewData["username"] = agentinfo.userid;
            ViewData["password"] = agentinfo.password;

            return View();
        }

        [Authorize(Roles = "Agent")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult UpdatePassword(long uid, string newpassword)
        {
            string rst = "";

            rst = agentModel.UpdatePassword(uid, newpassword);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }
}
