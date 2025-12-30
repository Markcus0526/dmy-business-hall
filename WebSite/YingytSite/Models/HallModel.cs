using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;

namespace YingytSite.Models
{
    #region Models
    public class HallInfo
    {
        public long uid { get; set; }
        public long parentid { get; set; }
        public string hallname { get; set; }
        public string nickname { get; set; }
        public string password { get; set; }
        public string company { get; set; }
        public string addr { get; set; }
        public long addrid { get; set; }
        public string owneragent { get; set; }
        public string phonenum { get; set; }
        public string mail { get; set; }
        public string qqnum { get; set; }
        public byte state { get; set; }
    }

    public class VisitInfo
    {
        public string hallname { get; set; }
        public string address { get; set; }
        public int visitcount { get; set; }
    }
    #endregion

    public class HallModel
    {
        YingytDBDataContext db = new YingytDBDataContext();

        #region CRUD
        public static List<HallInfo> GetHallList()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            List<HallInfo> rst = new List<HallInfo>();
            rst = (from m in db.tbl_users
                   where m.deleted == 0 && m.parentid != 0
                   orderby m.uid descending                   
                   select new HallInfo
                   {
                       uid = m.uid,
                       hallname = m.userid,
                       nickname = m.username,
                       addr = m.addr,
                       addrid = m.addrid,
                       phonenum = m.phonenum,
                       mail = m.mailaddr,
                       state = m.status,
                       parentid = m.parentid
                   }).ToList();            
            return rst;
        }

        public List<HallInfo> GetAHallList(long cur_user_id)
        {
            List<HallInfo> rst = new List<HallInfo>();
            rst = (from m in db.tbl_users
                   where m.deleted == 0 && m.parentid == cur_user_id
                   select new HallInfo
                   {
                       uid = m.uid,
                       hallname = m.userid,
                       nickname = m.username,
                       addr = m.addr,
                       addrid = m.addrid,
                       phonenum = m.phonenum,
                       mail = m.mailaddr,
                       state = m.status,
                   }).ToList();
            return rst;
        }

        public static List<tbl_user> GetAgentList()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            List<tbl_user> rst = (from m in db.tbl_users
                            where m.deleted == 0 && m.parentid == 0
                            select m).ToList();
            return rst;
        }

        public static List<tbl_user> GetHallListByParentid(long parentid)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return (from m in db.tbl_users
                    where m.deleted == 0 && m.parentid == parentid
                    select m).ToList();
        }

        public tbl_user GetHallById(long uid)
        {
            tbl_user rst = new tbl_user();
            rst = (from m in db.tbl_users
                   where m.uid == uid && m.parentid != 0 && m.deleted == 0
                   select m).FirstOrDefault();
            return rst;
        }

        public HallInfo GetHallInfoById(long uid)
        {
            HallInfo rst = (from m in db.tbl_users
                            where m.uid == uid && m.parentid != 0 && m.deleted == 0
                            select new HallInfo
                            {
                                uid = m.uid,
                                parentid = m.parentid,
                                hallname = m.userid,
                                nickname = m.username,
                                password = m.password,
                                company = m.agentname,
                                owneragent = m.connector,
                                addr = m.addr,
                                addrid = m.addrid,
                                phonenum = m.phonenum,
                                mail = m.mailaddr,
                                qqnum = m.qqnum,
                                state = m.status
                            }).FirstOrDefault();
            return rst;
        }

        public string CheckUniqueHallname(string hallname)
        {
            string rst = "";
            tbl_user user = new tbl_user();
            user = (from m in db.tbl_users
                    where m.deleted == 0 && m.parentid != 0 && m.userid == hallname
                    select m).FirstOrDefault();
            if (user != null)
                rst = "exist";
            else
                rst = "noexist";
            return rst;
        }

        public JqDataTableInfo GetHallDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<HallInfo> filteredCompanies;

            List<HallInfo> alllist = GetHallList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.hallname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<HallInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.hallname :
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
                c.hallname,
                c.nickname,
                AgentModel.GetAgentName(c.parentid),
                c.addr,
                c.phonenum,
                c.mail,
                Convert.ToString(c.state),
                Convert.ToString(c.uid),
                Convert.ToString(c.state),
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }
        public JqDataTableInfo GetAHallDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<HallInfo> filteredCompanies;
            long cur_user_id = CommonModel.GetCurrentUserId();
            List<HallInfo> alllist = GetAHallList(cur_user_id);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.hallname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<HallInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.hallname :
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
                c.hallname,
                c.nickname,
                c.addr,
                c.phonenum,
                c.mail,
                Convert.ToString(c.state),
                Convert.ToString(c.uid),
                Convert.ToString(c.state),
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool DeleteHall(long[] items)
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
        public bool showHall(long[] items)
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

        public bool hideHall(long[] items)
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
        
        public bool shareHall(long uid)
        {
            string updateSql = "UPDATE tbl_user SET allowshare = 1 WHERE uid = " + uid;
            
            db.ExecuteCommand(updateSql);

            return true;
        }

        public bool unshareHall(long uid)
        {
            string updateSql = "UPDATE tbl_user SET allowshare = 0 WHERE uid = " + uid;

            db.ExecuteCommand(updateSql);

            return true;
        }
        
        public string InsertHall(string hallname, string nickname, string hallpwd, string province,
            string city, string district, string addrdetail, string categorylist, string phone, string email, string qqnumber)
        {
            tbl_user newuser = new tbl_user();
            
            newuser.userid = hallname;
            newuser.username = nickname;
            newuser.password = CommonModel.GetMD5Hash(hallpwd);
            newuser.connector = "";
            newuser.addr = addrdetail;
            newuser.addrid = Convert.ToInt64(district);
            newuser.parentid = Convert.ToInt64(categorylist);
            newuser.phonenum = phone;
            newuser.mailaddr = email;
            newuser.qqnum = qqnumber;
            newuser.agentname = "";
            newuser.regtime = DateTime.Now;
            newuser.status = 1;

            db.tbl_users.InsertOnSubmit(newuser);
            db.SubmitChanges();
            return "";
        }

        public string UpdateHall(long uid, string hallname, string nickname, string hallpwd, string province,
            string city, string district, string addrdetail, string categorylist, string phone, string email, string qqnumber)
        {
            string rst = "";
            tbl_user edititem = GetHallById(uid);

            if (edititem != null)
            {
                edititem.userid = hallname;
                edititem.username = nickname;
                //if(edititem.password != hallpwd)
                //    edititem.password = CommonModel.GetMD5Hash(hallpwd);
                edititem.addr = addrdetail;
                edititem.addrid = Convert.ToInt64(district);
                if(categorylist != null) 
                    edititem.parentid = Convert.ToInt64(categorylist);
                //shoushudaili???
                edititem.phonenum = phone;
                edititem.mailaddr = email;
                edititem.qqnum = qqnumber;
                edititem.agentname = "";
                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "用户不存在";
            }
             
            return rst;
        }

        public string UpdatePassword(long uid, string oldpassword, string newpassword)
        {
            string rst = "";
            tbl_user edititem = GetHallById(uid);

            if (edititem != null)
            {
                string sha1password = CommonModel.GetMD5Hash(oldpassword);
                if (edititem.password == sha1password)
                {
                    edititem.password = CommonModel.GetMD5Hash(newpassword);

                    db.SubmitChanges();
                    rst = "";
                }
                else
                    rst = "原密码错误";

            }
            else
            {
                rst = "用户不存在";
            }

            return rst;
        }

        public string UpdateUserInfo(string img, long uid, string username, string family_name, string last_name, string birthday,
           byte sex, string notice, string mailaddr, string qqnum, string phonenum, byte mailnotice, string newpassword)
        {
            string rst = "";
            tbl_user edititem = GetHallById(uid);

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

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "用?不存在";
            }

            return rst;
        }

        //public static byte GetHallAllowshare(long id)
        //{
        //    tbl_user item = db.tbl_users
        //        .Where(m => m.deleted == 0 && m.uid == id)
        //        .FirstOrDefault();
        //    if (item != null)
        //        return item.allowshare;
        //    else
        //        return 0;
        //}        

        public static long GetHallTotalCount()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_users
                .Where(m => m.deleted == 0 && m.parentid > 0)
                .Count();
        }

        #endregion
    }
}