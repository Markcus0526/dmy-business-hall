using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;

namespace YingytSite.Controllers
{
    public class HomeController : Controller
    {
        HomeModel homeModel = new HomeModel();

        [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            var noticelist = homeModel.GetTopNotice();
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Home";
            ViewData["level2nav"] = "Home";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), "", "", "", rootUri);
            ViewData["noticelist"] = noticelist;

            ViewData["totalagent"] = AgentModel.GetAgentTotalCount();
            ViewData["totalhall"] = HallModel.GetHallTotalCount();
            ViewData["totalvisit"] = PhonereadModel.GetVisitTotalCount();
            ViewData["best5"] = AgentModel.GetBest5HavehallList();

            return View();
        }

        [Authorize(Roles = "SysNotice")]
        public ActionResult LNoticeDetail(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            var noticeinfo = homeModel.GetNoticeInfo(id);
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Home";
            ViewData["level2nav"] = "NoticeDetail";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), "", "", "", rootUri);
            ViewData["noticeinfo"] = noticeinfo;

            return View();
        }
    }
}