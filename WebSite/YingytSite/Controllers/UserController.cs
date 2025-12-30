using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using YingytSite.Models.Library;

namespace YingytSite.Controllers
{
    public class UserController : Controller
    {
        private UserModel userModel = new UserModel();

        #region UserManage
        [Authorize(Roles = "User")]
        public ActionResult UserList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "User";
            ViewData["level2nav"] = "UserList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "", "", rootUri);
            //ViewData["config"] = SystemModel.GetMailConfig();

            return View();
        }

        [Authorize(Roles = "User")]
        [AjaxOnly]
        public JsonResult RetrieveUserList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = userModel.GetUserDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "User")]
        public ActionResult AddUser()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "User";
            ViewData["level2nav"] = "UserList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "AddUser", "", rootUri);
            ViewData["rolelist"] = userModel.GetUserRoleList();
            //ViewData["config"] = SystemModel.GetMailConfig();

            return View();
        }

        [Authorize(Roles = "User")]
        public ActionResult EditUser(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "User";
            ViewData["level2nav"] = "UserList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditUser", "", rootUri);
            ViewData["rolelist"] = userModel.GetUserRoleList();

            var userinfo = userModel.GetUserById(id);
            ViewData["userinfo"] = userinfo;
            ViewData["uid"] = userinfo.uid;
            //ViewData["config"] = SystemModel.GetMailConfig();

            return View("AddUser");
        }

        [Authorize(Roles = "User")]
        [HttpPost]
        public JsonResult DeleteUser(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = userModel.DeleteUser(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "User")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitUser(long uid, string username, string userpwd, long userrole)
        {
            string rst = "";

            if (uid == 0)
            {
                rst = userModel.InsertUser(username, userpwd, userrole);
            }
            else
            {
                rst = userModel.UpdateUser(uid, username, userpwd, userrole);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult CheckUniqueUsername(string username)
        {
            bool rst = userModel.CheckDuplicateName(username);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "User")]
        public ActionResult ChangePwd()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ChangePwd";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), "", "", "", rootUri);
            //ViewData["config"] = SystemModel.GetMailConfig();
            ViewData["uid"] = CommonModel.GetCurrAccountId();

            return View();
        }

        [Authorize(Roles = "User")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SetChangePwd(string userpwd)
        {
            string rst = "";
            long nId = 0;

            try
            {
                nId = CommonModel.GetSessionUserID();
            }
            catch (System.Exception ex)
            {
                CommonModel.WriteLogFile("Feature", "CheckUniqureKeyword()", ex.ToString());
            }
            rst = userModel.UpdatePwd(nId, userpwd);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region UserRole
        [Authorize(Roles = "User")]
        public ActionResult RoleList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "User";
            ViewData["level2nav"] = "RoleList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "", "", rootUri);
            //ViewData["config"] = SystemModel.GetMailConfig();

            return View();
        }

        [Authorize(Roles = "User")]
        [AjaxOnly]
        public JsonResult RetrieveRoleList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = userModel.GetRoleDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "User")]
        public ActionResult AddRole()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "User";
            ViewData["level2nav"] = "RoleList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "AddRole", "", rootUri);

            return View();
        }

        [Authorize(Roles = "User")]
        public ActionResult EditRole(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["userrole"] = CommonModel.GetUserRoleInfo();

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "User";
            ViewData["level2nav"] = "RoleList";
            ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), ViewData["level2nav"].ToString(), "EditRole", "", rootUri);

            var roleinfo = userModel.GetRoleById(id);
            ViewData["roleinfo"] = roleinfo;
            ViewData["uid"] = roleinfo.uid;
            ViewData["role"] = roleinfo.role;

            return View("AddRole");
        }

        [Authorize(Roles = "User")]
        [HttpPost]
        public JsonResult DeleteRole(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = userModel.DeleteRole(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "User")]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitRole(long uid, string rolename, string[] configuration)
        {
            string rst = "";

            string role = "";

            if (configuration != null)
            {
                role = String.Join(",", configuration);
            }

            if (uid == 0)
            {
                rst = userModel.InsertRole(rolename, role);
            }
            else
            {
                rst = userModel.UpdateRole(uid, rolename, role);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult CheckUniqueRolename(long rid, string rolename)
        {
            bool rst = userModel.CheckDuplicateRoleName(rid, rolename);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}
