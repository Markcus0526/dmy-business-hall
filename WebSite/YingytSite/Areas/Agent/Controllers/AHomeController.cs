using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;

namespace YingytSite.Areas.Agent.Controllers
{
    public class AHomeController : Controller
    {
        HomeModel homeModel = new HomeModel();

        [Authorize]
        public ActionResult AgentHome()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            var noticelist = homeModel.GetTopNotice();
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Home";
            ViewData["level2nav"] = "Home";
            ViewData["noticelist"] = noticelist;

            ViewData["visitlist"] = PhonereadModel.GetBest5VisitList();

            return View();
        }

        [Authorize]
        public ActionResult NoticeDetail(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            var noticeinfo = homeModel.GetNoticeInfo(id);
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Home";
            ViewData["level2nav"] = "NoticeDetail";
            ViewData["noticeinfo"] = noticeinfo;

            return View();
        }
    }
}
