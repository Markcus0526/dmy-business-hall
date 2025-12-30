using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models.Library;
using YingytSite.Models;


namespace YingytSite.Areas.Agent.Controllers
{
    public class ASystemController : Controller
    {
        AgentModel agentModel = new AgentModel();

        tbl_user userInfo = new tbl_user();
        SystemModel sysModel = new SystemModel();

        #region 个人中心
        [Authorize]
        public ActionResult Profile()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            var currId = CommonModel.GetSessionUserID();
            var userinfo = agentModel.GetAgentById(currId);

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "Profile";
            ViewData["userinfo"] = userinfo;

            long user_id = CommonModel.GetCurrentUserId();
            ViewData["lobbylist"] = AgentModel.GetLobbyListForAgentId(user_id);
            
            return View();
        }

        [Authorize]
        [AjaxOnly]
        [HttpPost]
        public JsonResult SubmitUserInfo(string img, string uid, string username, string birthday, /*string family_name, string last_name, *///DateTime birthday, 
            byte sex, string notice, string mailaddr, string qqnum, string phonenum, 
            string mailnotice, string newpassword, string allowshare, long? lobby_id)
        {           
            string rst = "";
            string p_number = "";
            byte m_notice = 0;

            string[] tmp = phonenum.Split(new Char[] { '-' });
            for (int i = 0; i < tmp.Count(); i++)
                p_number += tmp[i];

            if (mailnotice == "on")
                m_notice = 1;

            byte share = (byte)(allowshare == "on" ? 1 : 0);

//             rst = agentModel.UpdateUserInfo(img, Convert.ToInt64(uid),  username, family_name, last_name, birthday,
//                                          sex, notice,  mailaddr, qqnum,  p_number, m_notice, newpassword, share);
            rst = agentModel.UpdateUserInfo(img, Convert.ToInt64(uid), username, birthday,
                sex, notice, mailaddr, qqnum, p_number, m_notice, newpassword, share, lobby_id!=null?(long)lobby_id:0);
       
            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 通知管理
        [Authorize]
        public ActionResult NoticeList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "NoticeList";

            return View();
        }

        [Authorize]
        public ActionResult AddNotice()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "NoticeList";

            var agentlist = HallModel.GetAgentList();
            ViewData["agents"] = agentlist;

            var halllist = HallModel.GetHallList();
            ViewData["halls"] = halllist;

            return View();
        }

        [Authorize]
        public ActionResult EditNotice(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "System";
            ViewData["level2nav"] = "NoticeList";

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
            return View("AddNotice");
        }
        
        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveANoticeList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = sysModel.GetASysNoticeDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitASysNotice(long uid, string title, int ecatetype, string categorylist, string r_contents)
        {
            string rst = "";
            string category_data = "";
            if (ecatetype == 0)
                category_data = "0";
            else
                category_data = Request.Form["categorylist"].ToString();
            if (uid == 0)
            {
                rst = sysModel.InsertASysNotice(title, category_data, r_contents);
            }
            else
            {
                rst = sysModel.UpdateASysNotice(uid, title, category_data, r_contents);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}
