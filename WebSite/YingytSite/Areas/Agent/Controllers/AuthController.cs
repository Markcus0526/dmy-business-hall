using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using System.Web.Security;

namespace YingytSite.Areas.Agent.Controllers
{
    public class AuthController : Controller
    {
        UserModel userModel = new UserModel();

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LogOn(string username, string userpwd, string returnUrl)
        {
            bool rememberme = true;
            ViewData["rootUri"] = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["base_url"] = ViewData["rootUri"] + "Account";

            //return RedirectToAction("AgentHome", "AHome");

            ViewData["curdate"] = DateTime.Today.ToString("yyyy年MM月dd日");

            //if (ModelState.IsValid)
            {
                var userInfo = userModel.ValidateUser(username, userpwd, "agent");
                if (userInfo != null)
                {
                    userModel.SignIn(username, rememberme);

                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1,
                            userInfo.username,
                            DateTime.Now,
                            DateTime.Now.AddMinutes(1440),
                            rememberme,
                            userInfo.role + "|" + userInfo.uid + "|agent",
                            FormsAuthentication.FormsCookiePath);
                    string encTicket = FormsAuthentication.Encrypt(ticket);
                    Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));

                    if (!String.IsNullOrEmpty(returnUrl))
                    {
                        return Redirect(returnUrl);
                    }
                    else
                    {
                        return RedirectToAction("AgentHome", "AHome");
                    }
                }
                else
                {
                    ModelState.AddModelError("modelerror", "帐号或密码错误，请重新输入");
                }
            }
            
            return View("LogOn");
        }

    }
}
