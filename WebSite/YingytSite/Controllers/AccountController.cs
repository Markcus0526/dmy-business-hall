using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using System.Web.Security;

namespace YingytSite.Controllers
{
    public class AccountController : Controller
    {
        UserModel userModel = new UserModel();

        public ActionResult LogOn(string returnUrl)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["navi"] = "LogOn";
            ViewData["returnUrl"] = returnUrl;

            if (User.Identity.IsAuthenticated)
            {
                string usertype = CommonModel.GetCurrentUserType();

                if(usertype == "admin")
                    return RedirectToAction("Index", "Home");
                else if (usertype == "agent")
                    return RedirectToAction("AgentHome", "Agent/AHome");
                else if (usertype == "lobby")
                    return RedirectToAction("Index", "Lobby/LHome");
            }

            return View();
        }

        [HttpPost]
        public ActionResult LogOn(string username, string userpwd, string returnUrl)
        {
            bool rememberme = true;
            //string origin = "";
            ViewData["rootUri"] = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["base_url"] = ViewData["rootUri"] + "Account";

            /*if (Request.Form["origin"] != null)
            {
                origin = Request.Form["origin"].ToString();
            }*/

            ViewData["curdate"] = DateTime.Today.ToString("yyyy年MM月dd日");

            if (ModelState.IsValid)
            {
                var userInfo = userModel.ValidateUser(username, userpwd, "");
                if (userInfo != null)
                {
                    userModel.SignIn(username, rememberme);
                    userModel.SetLoginInfo(userInfo.uid, Request.UserHostAddress);

                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1,
                            userInfo.username,
                            DateTime.Now,
                            DateTime.Now.AddMinutes(1440),
                            rememberme,
                            userInfo.role + "|" + userInfo.uid + "|admin",
                            FormsAuthentication.FormsCookiePath);
                    string encTicket = FormsAuthentication.Encrypt(ticket);
                    Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));

                    if (!String.IsNullOrEmpty(returnUrl))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        return RedirectToAction("Index", "Home");
                    }
                }
                else
                {
                    string sha1pwd = CommonModel.GetMD5Hash(userpwd);

                    userInfo = userModel.ValidateUser(username, sha1pwd, "agent");
                    if (userInfo != null)
                        return RedirectToAction("LoginAgent/" + Convert.ToString(userInfo.uid), "Agt");
                    else
                    {
                        userInfo = userModel.ValidateUser(username, sha1pwd, "lobby");
                        if (userInfo != null)
                            return RedirectToAction("LoginHall/" + Convert.ToString(userInfo.uid), "Hall");
                        else
                        {
                            ModelState.AddModelError("modelerror", "帐号或密码错误，请重新输入");
                        }
                    }
                }
            }

            return View("LogOn");
        }

        public ActionResult LogOff()
        {
            userModel.SignOut();

            return RedirectToAction("LogOn", "Account");
        }

//         [Authorize]
//         public ActionResult Profile()
//         {
//             string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
// 
//             ViewData["rootUri"] = rootUri;
//             ViewData["level1nav"] = "Home";
//             ViewData["level2nav"] = "Home";
//             ViewData["navinfo"] = CommonModel.GetTopNavInfo(ViewData["level1nav"].ToString(), "", "", "", rootUri);
//             //ViewData["config"] = SystemModel.GetMailConfig();
// 
//             return View();
//         }
    }
}
