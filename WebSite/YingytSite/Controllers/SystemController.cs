using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models.Library;
using YingytSite.Models;

namespace YingytSite.Controllers
{
    public class SystemController : Controller
    {
        SystemModel sysModel = new SystemModel();

        #region 系统通知
        [Authorize(Roles = "SysNotice")]
        public ActionResult SysNoticeList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "SysNoticeList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "", "", rootUri);
            //ViewData["config"] = SystemModel.GetMailConfig();

            return View();
        }

        [Authorize(Roles = "SysNotice")]
        [AjaxOnly]
        public JsonResult RetrieveSysNoticeList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = sysModel.GetSysNoticeDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "SysNotice")]
        public ActionResult AddSysNotice()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "SysNoticeList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "AddSysNotice", "", rootUri);
            
            var agentlist = HallModel.GetAgentList();
            ViewData["agents"] = agentlist;

            var halllist = HallModel.GetHallList();
            ViewData["halls"] = halllist;
            return View();
        }

        [Authorize(Roles = "SysNotice")]
        public ActionResult EditSysNotice(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "SysNoticeList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditSysNotice", "", rootUri);

            var noticeinfo = sysModel.GetSysNoticeInfoById(id);
            ViewData["noticeinfo"] = noticeinfo;
            ViewData["uid"] = noticeinfo.uid;
            ViewData["title"] = noticeinfo.title;
            ViewData["cateid"] = noticeinfo.cateid;
            ViewData["categorylist"] = noticeinfo.categorylist;
            ViewData["contents"] = noticeinfo.contents;

            var agentlist = HallModel.GetAgentList();
            ViewData["agents"] = agentlist;

            var halllist = HallModel.GetHallList();
            ViewData["halls"] = halllist;

            return View("AddSysNotice");
        }

        [Authorize(Roles = "SysNotice")]
        [HttpPost]
        public JsonResult DeleteSysNotice(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = sysModel.DeleteSysNotice(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "SysNotice")]
        [HttpPost]
        public JsonResult showSysNotice(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = sysModel.showSysNotice(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "SysNotice")]
        [HttpPost]
        public JsonResult hideSysNotice(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = sysModel.hideSysNotice(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "SysNotice")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitSysNotice(long uid, string title, string cateid, string ecatetype, string categorylist, string r_contents)
        {
            string rst = "";
            string category_data = "";
            var _cateid = Convert.ToInt16(cateid);
            var _ecatetype = Convert.ToInt16(ecatetype);
            if (_ecatetype == 0)
                category_data = "0";
            else
            {
                if (Request.Form["categorylist"] != null)
                    category_data = Request.Form["categorylist"].ToString();
            }   
            if (uid == 0)
            {
                rst = sysModel.InsertSysNotice(title, _cateid, category_data, r_contents);
            }
            else
            {
                rst = sysModel.UpdateSysNotice(uid, title, _cateid, category_data, r_contents);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }
}
