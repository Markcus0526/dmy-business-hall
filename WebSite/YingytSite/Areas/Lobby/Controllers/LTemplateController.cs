using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;

namespace YingytSite.Areas.Lobby.Controllers
{
    public class LTemplateController : Controller
    {
        TemplateModel templateModel = new TemplateModel();

        [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Template";

            ViewData["templates"] = templateModel.GetTemplateList();
            ViewData["tid"] = templateModel.GetUserTemplateId();

            return View();
        }

        [Authorize]
        [HttpPost]
        public JsonResult SetTemplate(long id)
        {
            bool rst = templateModel.InsertOrUpdateUserTemplateId(id);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
    }
}
