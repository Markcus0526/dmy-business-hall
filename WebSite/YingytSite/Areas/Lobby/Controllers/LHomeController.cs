using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;

namespace YingytSite.Areas.Lobby.Controllers
{
    public class LHomeController : Controller
    {
        HomeModel homeModel = new HomeModel();

        [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            var noticelist = homeModel.GetTopNotice();
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Home";
            ViewData["level2nav"] = "Home";
            ViewData["noticelist"] = noticelist;

            return View();
        }

        [Authorize]
        public ActionResult LNoticeDetail(long id)
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
