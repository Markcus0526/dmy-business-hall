using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Globalization;

namespace YingytSite.Models
{
    public class UserInfo
    {
        public long uid { get; set; }
        public string username { get; set; }
        public string rolename { get; set; }
        public string role { get; set; }
        public DateTime createtime { get; set; }
        public DateTime? lasttime { get; set; }
        public string lastip { get; set; }
    }

    #region LogOnModel
    public class LogOnModel
    {
        [Required(ErrorMessage = "用户名不能为空")]
        [DisplayName("用户名:")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "密码不能为空")]
        [ValidatePasswordLength]
        [DataType(DataType.Password)]
        [DisplayName("密码:")]
        public string Password { get; set; }

        [DisplayName("下次自动登录")]
        public bool RememberMe { get; set; }
    }

    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, AllowMultiple = false, Inherited = true)]
    public sealed class ValidatePasswordLengthAttribute : ValidationAttribute
    {
        private const string _defaultErrorMessage = "{0}至少为{1}位.";
        private readonly int _minCharacters = 6;

        public ValidatePasswordLengthAttribute()
            : base(_defaultErrorMessage)
        {
        }

        public override string FormatErrorMessage(string name)
        {
            return String.Format(CultureInfo.CurrentUICulture, ErrorMessageString,
                name, _minCharacters);
        }

        public override bool IsValid(object value)
        {
            string valueAsString = value as string;
            return (valueAsString != null && valueAsString.Length >= _minCharacters);
        }
    }
    #endregion

    public class UserModel
    {
        static YingytDBDataContext db = new YingytDBDataContext();

        #region User CRUD
        public List<UserInfo> GetUserList()
        {
            return db.tbl_admins
                .Where(m => m.deleted == 0)
                .OrderByDescending(m => m.createtime)
                .Join(db.tbl_adminroles, m => m.roleid , r => r.uid, (m, r) => new {user = m, role = r})
                .Select(m => new UserInfo { 
                    uid = m.user.uid,
                    username = m.user.username,
                    rolename = m.role.rolename,
                    role = m.role.role,
                    createtime = m.user.createtime,
                    lastip = m.user.lastip,
                    lasttime = m.user.lasttime
                })
                .ToList();
        }

        public UserInfo GetUserByNamePwd(string uname, string upwd)
        {
            return db.tbl_admins
                .Where(m => m.deleted == 0 && m.username == uname && m.userpwd == upwd)
                .OrderBy(m => m.createtime)
                .Join(db.tbl_adminroles, m => m.roleid, r => r.uid, (m, r) => new { user = m, role = r })
                .Select(m => new UserInfo
                {
                    uid = m.user.uid,
                    username = m.user.username,
                    rolename = m.role.rolename,
                    role = m.role.role,
                    createtime = m.user.createtime,
                    lastip = m.user.lastip,
                    lasttime = m.user.lasttime
                })
                .FirstOrDefault();
        }

        public JqDataTableInfo GetUserDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<UserInfo> filteredCompanies;

            List<UserInfo> alllist = GetUserList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.username.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<UserInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.username :
                                                           "");

            var sortDirection = Request["sSortDir_0"]; // asc or desc
            if (sortDirection == "asc")
                filteredCompanies = filteredCompanies.OrderBy(orderingFunction);
            else
                filteredCompanies = filteredCompanies.OrderByDescending(orderingFunction);

            var displayedCompanies = filteredCompanies.Skip(param.iDisplayStart);
            if (param.iDisplayLength > 0)
            {
                displayedCompanies = displayedCompanies.Take(param.iDisplayLength);
            }
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.username,
                c.rolename,
                String.Format("{0:yyyy-MM-dd HH:mm:ss}", c.createtime),
                c.lasttime == null ? "未登录" : String.Format("{0:yyyy-MM-dd HH:mm:ss}", (DateTime)c.lasttime),
                c.lastip == null ? "-" : c.lastip,
                Convert.ToString(c.uid)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool DeleteUser(long[] items)
        {
            string delSql = "UPDATE tbl_admin SET deleted = 1 WHERE ";
            string whereSql = "";
            foreach (long uid in items)
            {
                if (whereSql != "") whereSql += " OR";
                whereSql += " uid = " + uid;
            }

            delSql += whereSql;

            db.ExecuteCommand(delSql);

            return true;
        }

        public List<tbl_adminrole> GetUserRoleList()
        {
            return db.tbl_adminroles
                .Where(m => m.deleted == 0)
                .ToList();
        }

        public tbl_admin GetUserById(long uid)
        {
            return db.tbl_admins
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();
        }

        public string InsertUser(string username, string userpwd, long rolename)
        {
            tbl_admin newuser = new tbl_admin();

            newuser.username = username;
            newuser.userpwd = CommonModel.GetMD5Hash(userpwd);
            newuser.roleid = rolename;
            newuser.createtime = DateTime.Now;

            db.tbl_admins.InsertOnSubmit(newuser);

            db.SubmitChanges();

            return "";
        }

        public string UpdateUser(long uid, string username, string userpwd, long rolename)
        {
            string rst = "";
            tbl_admin edititem = GetUserById(uid);

            if (edititem != null)
            {
                if(userpwd != null && edititem.userpwd != userpwd)
                    edititem.userpwd = CommonModel.GetMD5Hash(userpwd);
                edititem.roleid = rolename;

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "用户不存在";
            }

            return rst;
        }

        public bool CheckDuplicateName(string username)
        {
            bool rst = true;
            rst = ((from m in db.tbl_admins
                    where m.deleted == 0 && m.username == username
                    select m).FirstOrDefault() == null);

            return rst;
        }

        public string UpdatePwd(long uid, string newpwd)
        {
            try
            {
                var aInfo = GetUserById(uid);
                if (aInfo != null)
                {
                    aInfo.userpwd = CommonModel.GetMD5Hash(newpwd);
                    db.SubmitChanges();

                    return "";
                }
            }
            catch (System.Exception ex)
            {
                CommonModel.WriteLogFile("MerchantModel", "UpdatePwd()", ex.ToString());
                return ex.ToString();
            }

            return "";
        }
        #endregion

        #region User Login
        public void SignIn(string userName, bool createPersistentCookie)
        {
            if (String.IsNullOrEmpty(userName)) throw new ArgumentException("Value cannot be null or empty.", "userName");

            FormsAuthentication.SetAuthCookie(userName, createPersistentCookie);
        }

        public UserInfo ValidateUser(string username, string password, string origin)
        {
            if (String.IsNullOrEmpty(origin))
            {
                string sha1Pswd = CommonModel.GetMD5Hash(password);
                UserInfo userObj = GetUserByNamePwd(username, sha1Pswd);

                if (userObj != null)
                    return userObj;
            }
            else if(origin == "agent")
            {
                UserInfo userObj = AgentModel.GetAgentByNamePwd(username, password);

                if (userObj != null)
                    return userObj;
            } if (origin == "lobby")
            {
                UserInfo userObj = AgentModel.GetLobbyByNamePwd(username, password);

                if (userObj != null)
                    return userObj;
            }

            return null;
        }

        public bool SetLoginInfo(long id, string lastip)
        {
            try
            {
                tbl_admin item = (from m in db.tbl_admins
                                  where m.deleted == 0 && m.uid == id
                                  select m).FirstOrDefault();
                if (item != null)
                {
                    item.lasttime = DateTime.Now;
                    item.lastip = lastip;
                    db.SubmitChanges();

                    return true;
                }
            }
            catch (Exception e)
            {
                CommonModel.WriteLogFile("ShopModel", "RegisterShop()", e.ToString());
                return false;
            }

            return false;
        }

        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
        #endregion

        #region Role CRUD
        public List<tbl_adminrole> GetRoleList()
        {
            return db.tbl_adminroles
                .Where(m => m.deleted == 0)
                .OrderByDescending(m => m.uid)
                .ToList();
        }

        public JqDataTableInfo GetRoleDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<tbl_adminrole> filteredCompanies;

            List<tbl_adminrole> alllist = GetRoleList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.rolename.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<tbl_adminrole, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.rolename :
                                                           "");

            var sortDirection = Request["sSortDir_0"]; // asc or desc
            if (sortDirection == "asc")
                filteredCompanies = filteredCompanies.OrderBy(orderingFunction);
            else
                filteredCompanies = filteredCompanies.OrderByDescending(orderingFunction);

            var displayedCompanies = filteredCompanies.Skip(param.iDisplayStart);
            if (param.iDisplayLength > 0)
            {
                displayedCompanies = displayedCompanies.Take(param.iDisplayLength);
            }
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.rolename,
                Convert.ToString(c.uid)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool DeleteRole(long[] items)
        {
            try
            {
                string delSql = "UPDATE tbl_adminrole SET deleted = 1 WHERE ";
                string whereSql = "";
                foreach (long uid in items)
                {
                    if (whereSql != "") whereSql += " OR";
                    whereSql += " uid = " + uid;
                }

                delSql += whereSql;

                db.ExecuteCommand(delSql);

                return true;

                /*var dellist = db.tbl_adminroles
                    .Where(m => items.Contains(m.uid))
                    .ToList();

                db.tbl_adminroles.DeleteAllOnSubmit(dellist);

                db.SubmitChanges();*/
            }
            catch (System.Exception ex)
            {
                return false;
            }

            return true;
        }

        public tbl_adminrole GetRoleById(long uid)
        {
            return db.tbl_adminroles
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();
        }

        public string InsertRole(string rolename, string role)
        {
            tbl_adminrole newitem = new tbl_adminrole();

            newitem.rolename= rolename;
            newitem.role = role;

            db.tbl_adminroles.InsertOnSubmit(newitem);

            db.SubmitChanges();

            return "";
        }

        public string UpdateRole(long uid, string rolename, string role)
        {
            string rst = "";
            tbl_adminrole edititem = GetRoleById(uid);

            if (edititem != null)
            {
                edititem.rolename = rolename;
                edititem.role = role;

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "数据不存在";
            }

            return rst;
        }

        public bool CheckDuplicateRoleName(long rid, string rolename)
        {   
            bool rst = true;
            rst = ((from m in db.tbl_adminroles
                    where m.deleted == 0 && m.rolename == rolename && m.uid != rid
                    select m).FirstOrDefault() == null);

            return rst;
        }
        #endregion
    }
}