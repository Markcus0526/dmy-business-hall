using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;

namespace YingytSite.Models
{
    #region Models
    public class SysNoticeInfo
    {
        public long     uid { get; set; }
        public string   title { get; set; }
        public int      cateid { get; set; }
        public string      categorylist { get; set; }
        public DateTime createtime { get; set; }
        public int      enable { get; set; }
    }
    public class SysEditInfo
    {
        public long uid { get; set; }
        public string title { get; set; }
        public int cateid { get; set; }
        public string categorylist { get; set; }
        public string contents { get; set; }
    }
    #endregion

    public class SystemModel
    {
        static YingytDBDataContext db = new YingytDBDataContext();

        #region CRUD
        public List<SysNoticeInfo> GetSysNoticeList()
        {
            List<SysNoticeInfo> rst = new List<SysNoticeInfo>();
            rst = (from m in db.tbl_sysnews
                   where m.deleted == 0
                   orderby m.uid descending
                   select new SysNoticeInfo
                   {
                       uid = m.uid,
                       title = m.title,
                       cateid = m.cateid,
                       categorylist = m.rangeid,
                       createtime = m.createtime,
                       enable = m.enabled
                   }).ToList();
            return rst;
        }

        public JqDataTableInfo GetSysNoticeDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<SysNoticeInfo> filteredCompanies;

            List<SysNoticeInfo> alllist = GetSysNoticeList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.title.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<SysNoticeInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.title :
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
                c.title,
                Convert.ToString(c.cateid== 1 ? "全部" : (c.cateid == 2 ? "代理通知" : "营业厅通知")),
                Convert.ToString(AgentModel.GetAgentNameByString(c.categorylist) ),
                String.Format("{0:yyyy-MM-dd hh:mm:dd}", c.createtime),
                Convert.ToString(c.enable),
                Convert.ToString(c.uid),
                Convert.ToString(c.enable)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public List<SysNoticeInfo> GetASysNoticeList()
        {
            List<SysNoticeInfo> rst = new List<SysNoticeInfo>();
            rst = (from m in db.tbl_sysnews
                   where m.deleted == 0 && m.userid == CommonModel.GetCurrentUserId()
                   orderby m.uid descending
                   select new SysNoticeInfo
                   {
                       uid = m.uid,
                       title = m.title,
                       categorylist = m.rangeid,
                       createtime = m.createtime,
                       enable = m.enabled
                   }).ToList();
            return rst;
        }

        public JqDataTableInfo GetASysNoticeDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<SysNoticeInfo> filteredCompanies;

            List<SysNoticeInfo> alllist = GetASysNoticeList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.title.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<SysNoticeInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.title :
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
                c.title,
                Convert.ToString(AgentModel.GetAgentNameByString(c.categorylist) ),
                String.Format("{0:yyyy-MM-dd hh:mm:dd}", c.createtime),
                Convert.ToString(c.enable),
                Convert.ToString(c.uid),
                Convert.ToString(c.enable)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool DeleteSysNotice(long[] items)
        {
            string delSql = "UPDATE tbl_sysnews SET deleted = 1 WHERE ";
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

        public bool showSysNotice(long[] items)
        {
            string updateSql = "UPDATE tbl_sysnews SET enabled = 1 WHERE ";
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

        public bool hideSysNotice(long[] items)
        {
            string updateSql = "UPDATE tbl_sysnews SET enabled = 0 WHERE ";
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

        public SysEditInfo GetSysNoticeInfoById(long uid)
        {
            SysEditInfo rst = new SysEditInfo();
            rst = (from m in db.tbl_sysnews
                   where m.uid == uid && m.deleted == 0
                   select new SysEditInfo
                   {
                       uid = m.uid,
                       title = m.title,
                       cateid = m.cateid,
                       categorylist = m.rangeid,
                       contents = m.contents
                   }).FirstOrDefault();
            return rst;
        }
        public tbl_sysnew GetSysNoticeById(long uid)
        {
            tbl_sysnew rst = new tbl_sysnew();
            rst = (from m in db.tbl_sysnews
                   where m.uid == uid && m.deleted == 0
                   select m).FirstOrDefault();
            return rst;
        }

        public string InsertSysNotice(string title, int cateid, string categorylist, string contents)
        {
            tbl_sysnew newsysnew = new tbl_sysnew();

            newsysnew.title = title;
            newsysnew.cateid = cateid;
            newsysnew.rangeid = categorylist;
            newsysnew.contents = contents;
            newsysnew.createtime = DateTime.Now;
            newsysnew.adminid = (int)CommonModel.GetCurrentUserId();
            newsysnew.userid = 0;
            newsysnew.enabled = 1;

            db.tbl_sysnews.InsertOnSubmit(newsysnew);
            db.SubmitChanges();
            return "";
        }

        public string UpdateSysNotice(long uid, string title, int cateid, string categorylist, string contents)
        {
            string rst = "";
            tbl_sysnew edititem = GetSysNoticeById(uid);

            if (edititem != null)
            {
                edititem.title = title;
                edititem.cateid = cateid;
                edititem.rangeid = categorylist;
                edititem.contents = contents;
                db.SubmitChanges(); 
                rst = "";
            }
            else
            {
                rst = "用户不存在";
            }
             
            return rst;
        }

        public string InsertASysNotice(string title, string categorylist, string contents)
        {
            tbl_sysnew newsysnew = new tbl_sysnew();

            newsysnew.title = title;
            newsysnew.cateid = 3;
            newsysnew.rangeid = categorylist;
            newsysnew.contents = contents;
            newsysnew.createtime = DateTime.Now;
            newsysnew.userid = (int)CommonModel.GetCurrentUserId();
            newsysnew.adminid = 0;
            newsysnew.enabled = 1;

            db.tbl_sysnews.InsertOnSubmit(newsysnew);
            db.SubmitChanges();
            return "";
        }

        public string UpdateASysNotice(long uid, string title, string categorylist, string contents)
        {
            string rst = "";
            tbl_sysnew edititem = GetSysNoticeById(uid);

            if (edititem != null)
            {
                edititem.title = title;
                edititem.cateid = 3;
                edititem.rangeid = categorylist;
                edititem.contents = contents;
                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "用户不存在";
            }

            return rst;
        }
        #endregion
    }
}