using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models.Library;
using YingytSite.Models;

namespace YingytSite.Areas.Lobby.Controllers
{
    public class LSystemController : Controller
    {
        HallModel hallModel = new HallModel();
        tbl_user userInfo = new tbl_user();

        #region 个人中心
        [Authorize]
        public ActionResult Profile()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            var currId = CommonModel.GetCurrentUserId();
            var userinfo = hallModel.GetHallById(currId);

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "Profile";
            ViewData["userinfo"] = userinfo;

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult SubmitUserInfo(string img, string uid, string username, string family_name, string last_name, string birthday, byte sex, string notice, string mailaddr, string qqnum, string phonenum, string mailnotice, string newpassword)
        {
            string rst = "";
            string p_number = "";
            byte m_notice = 0;

            string[] tmp = phonenum.Split(new Char[] { '-' });
            for (int i = 0; i < tmp.Count(); i++)
                p_number += tmp[i];

            if (mailnotice == "on")
                m_notice = 1;

            rst = hallModel.UpdateUserInfo(img, Convert.ToInt64(uid), username, family_name, last_name, birthday,
                                         sex, notice, mailaddr, qqnum, p_number, m_notice, newpassword);         

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}
