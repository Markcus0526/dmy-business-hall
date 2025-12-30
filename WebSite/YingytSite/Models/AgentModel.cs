using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;

namespace YingytSite.Models
{
    #region Models
    public class AgentInfo
    {
        public long uid { get; set; }
        public string userid { get; set; }
        public string username { get; set; }
        public string agentname { get; set; }
        public string connector { get; set; }
        public string phonenum { get; set; }
        public byte status { get; set; }
    }

    public class HavehallInfo
    {
        public string agentname { get; set; }
        public string regtime { get; set; }
        public int hallcount { get; set; }
    }
    #endregion

    public class AgentModel
    {
        YingytDBDataContext db = new YingytDBDataContext();

        #region LOGIN

        public static UserInfo GetAgentByNamePwd(string uname, string upwd)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_users
                .Where(m => m.deleted == 0 && m.userid == uname && m.password == upwd && m.parentid == 0)
                .OrderBy(m => m.uid)
                .Select(m => new UserInfo
                {
                    uid = m.uid,
                    username = m.username,
                    rolename = "agent",
                    createtime = DateTime.Now,
                    lastip = "",
                    lasttime = DateTime.Now
                })
                .FirstOrDefault();
        }

        public static UserInfo GetLobbyByNamePwd(string uname, string upwd)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_users
                .Where(m => m.deleted == 0 && m.userid == uname && m.password == upwd && m.parentid > 0)
                .OrderBy(m => m.uid)
                .Select(m => new UserInfo
                {
                    uid = m.uid,
                    username = m.username,
                    rolename = "agent",
                    createtime = DateTime.Now,
                    lastip = "",
                    lasttime = DateTime.Now
                })
                .FirstOrDefault();
        }

        #endregion

        #region CRUD
        public static string GetAgentName(long id)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            tbl_user item = db.tbl_users
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();
            if (item != null)
                return item.username;
            else
                return "";
        }

        public static long GetAgentParentid(long id)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            tbl_user item = db.tbl_users
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();
            if (item != null)
                return item.parentid;
            else
                return 0;
        }

        public static string GetAgentNameByString(string list)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            string res = "";
            if (list == null)
                return "";
            
            string[] stringlist = list.Split(',');
            long count = 0;
            
            foreach (string eachstring in stringlist)
            {
                if (eachstring != "")
                {
                    res += GetAgentName(Convert.ToInt64(eachstring));
                    count = count + 1;
                    if (count != stringlist.Count())
                    {
                        res += ",";
                    }
                }
            }

            if (res == "")
                res = "全部";

            return res;
        }
        public List<AgentInfo> GetAgentList()
        {
            return db.tbl_users
                .Where(m => m.deleted == 0 && m.parentid == 0)
                .OrderByDescending(m => m.uid)
                .Select(m => new AgentInfo
                {
                    uid = m.uid,
                    userid = m.userid,
                    username = m.username,
                    agentname = m.agentname,
                    connector = m.connector,
                    phonenum = m.phonenum,
                    status = m.status
                })
                .ToList();
        }

        public JqDataTableInfo GetAgentDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<AgentInfo> filteredCompanies;

            List<AgentInfo> alllist = GetAgentList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<AgentInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.agentname :
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
                c.userid,
                c.username,
                c.agentname,
                c.connector,
                c.phonenum,
                Convert.ToString(c.status),
                Convert.ToString(c.uid),
                Convert.ToString(c.status)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool CheckDuplicateName(string userid)
        {
            bool rst = true;
            rst = ((from m in db.tbl_users
                    where m.deleted == 0 && m.userid == userid
                    select m).FirstOrDefault() == null);

            return rst;
        }

        public bool DeleteAgent(long[] items)
        {
            string delSql = "UPDATE tbl_user SET deleted = 1 WHERE ";
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

        public bool BlockAgent(long[] items)
        {
            string updateSql = "UPDATE tbl_user SET status = 0 WHERE ";
            string whereSql = "";
            foreach (long uid in items)
            {
                if (whereSql != "") whereSql += " OR";
                whereSql += " uid = " + uid;
            }

            updateSql += whereSql;

            db.ExecuteCommand(updateSql);

            return true;
        }

        public bool ActivateAgent(long[] items)
        {
            string updateSql = "UPDATE tbl_user SET status = 1 WHERE ";
            string whereSql = "";
            foreach (long uid in items)
            {
                if (whereSql != "") whereSql += " OR";
                whereSql += " uid = " + uid;
            }

            updateSql += whereSql;

            db.ExecuteCommand(updateSql);

            return true;
        }

        public tbl_user GetAgentById(long uid)
        {
            return db.tbl_users
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();
        }

        public string InsertAgent(string userid, string username, string agentpwd, string agentname, long city, string addr,
            string connector, string phonenum, string mailaddr, string qqnum, byte status)
        {
            tbl_user newitem = new tbl_user();

            newitem.userid = userid;
            newitem.username = username;
            newitem.password = CommonModel.GetMD5Hash(agentpwd);
            newitem.agentname = agentname;
            newitem.addrid = city;
            newitem.addr = addr;
            newitem.connector = connector;
            newitem.phonenum = phonenum;
            newitem.mailaddr = mailaddr;
            newitem.qqnum = qqnum;
            newitem.parentid = 0;
            newitem.status = status;
            newitem.regtime = DateTime.Now;

            db.tbl_users.InsertOnSubmit(newitem);

            db.SubmitChanges();

            return "";
        }

        public string UpdateAgent(long uid, string userid, string username, string agentpwd, string agentname, long city, string addr,
            string connector, string phonenum, string mailaddr, string qqnum, byte status)
        {
            string rst = "";
            tbl_user edititem = GetAgentById(uid);

            if (edititem != null)
            {
                edititem.userid = userid;
                edititem.username = username;
                //if(edititem.password != agentpwd)
                //    edititem.password = CommonModel.GetMD5Hash(agentpwd);
                edititem.agentname = agentname;
                edititem.addrid = city;
                edititem.addr = addr;
                edititem.connector = connector;
                edititem.phonenum = phonenum;
                edititem.mailaddr = mailaddr;
                edititem.qqnum = qqnum;
                edititem.parentid = 0;
                edititem.status = status;

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "用户不存在";
            }
 
            return rst;
        }

        public string UpdatePassword(long uid, string newpassword)
        {
            string rst = "";
            tbl_user edititem = GetAgentById(uid);

            if (edititem != null)
            {              
                edititem.password = CommonModel.GetMD5Hash(newpassword);
                db.SubmitChanges();
                rst = "";               
            }
            else
            {
                rst = "用户不存在";
            }

            return rst;
        }

        public string UpdateUserInfo(string img, long uid, string username, /*string family_name, string last_name, */string birthday,
            byte sex, string notice, string mailaddr, string qqnum, string phonenum, byte mailnotice, string newpassword, byte allowshare, long share_id)
        {
            string rst = "";
            tbl_user edititem = GetAgentById(uid);

            if (edititem != null)
            {

                edititem.username = username;
                if ((edititem.password != newpassword) && (newpassword != ""))
                    edititem.password = CommonModel.GetMD5Hash(newpassword);
                try { edititem.birthday = Convert.ToDateTime(birthday); }
                catch (Exception e) { }                    
               // edititem.family_name = family_name;
               // edititem.last_name = last_name;                
                edititem.sex = sex;
                edititem.notice = notice;
                edititem.mailaddr = mailaddr;
                edititem.mailnotice = mailnotice;
                edititem.phonenum = phonenum;
                edititem.mailaddr = mailaddr;
                edititem.qqnum = qqnum;
                edititem.img = img;

                edititem.allowshare = allowshare;
                if (allowshare == 1)
                    edititem.share_id = share_id;

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "用?不存在";
            }

            return rst;
        }

        public static List<tbl_user> GetLobbyListForAgentId(long id)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_users
                .Where(m => m.deleted == 0 && m.parentid == id)
                .OrderByDescending(m => m.uid)
                .ToList();
        }

        public static byte GetAgentAllowshare(long id)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            tbl_user item = db.tbl_users
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();
            if (item != null)
                return item.allowshare;
            else
                return 0;
        }

        public static long GetAgentShareLobbyId(long id)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            tbl_user item = db.tbl_users
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();
            if (item != null)
                return item.share_id;
            else
                return 0;
        }

        public static List<HavehallInfo> GetBest5HavehallList()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            var userlist = db.tbl_users
                .Where(m => m.deleted == 0 && m.parentid > 0)
                .GroupBy(m => m.parentid)
                .Select(g => new
                {
                    user_id = g.Select(l => l.parentid).FirstOrDefault(),
                    count = g.Count()
                }).OrderByDescending(m => m.count)
                .ToList();

            var retlist = (from m in userlist
                           from l in db.tbl_users
                           where m.user_id == l.uid && l.deleted == 0
                           orderby m.count descending
                           select new HavehallInfo
                           {
                               agentname = l.username,
                               regtime = String.Format("{0:yyyy年MM月dd日 hh:mm:ss}", l.regtime),
                               hallcount = m.count
                           }).Take(5).ToList();

            return retlist;
        }

        public static long GetAgentTotalCount()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_users
                .Where(m => m.deleted == 0 && m.parentid == 0)
                .Count();
        }

        public static List<long> GetChildHallIdList()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            long user_id = CommonModel.GetCurrentUserId();
            return db.tbl_users
                .Where(m => m.deleted == 0 && m.parentid == user_id)
                .Select(m => m.uid).ToList();
        }

        #endregion
    }
}