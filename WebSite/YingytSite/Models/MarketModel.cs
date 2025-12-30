using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;

namespace YingytSite.Models
{
    #region Models
    public class NestableImgInfo
    {
        public long uid { get; set; }
        public string imgurl { get; set; }
        public string title { get; set; }
        public string description { get; set; }
    }

    public class NestableImgID
    {
        public string id { get; set; }
    }

    public class YanshiInfo
    {
        public long uid { get; set; }
        public long user_id { get; set; }
        public long parentid { get; set; }
        public long android_id { get; set; }
        public long data_id { get; set; }
        public byte status { get; set; }
        public byte ustatus { get; set; }
    }

    public class RelDetailInfo
    {
        public long uid { get; set; }
        public string imgurl { get; set; }
    }
    #endregion

    public class MarketModel
    {
        YingytDBDataContext db = new YingytDBDataContext();

        #region Yanshivideo
        public List<YanshiInfo> GetYanshivideoList(long lobby_id, long brand_id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();
            List<YanshiInfo> alllist = null;
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id) && m.datatype == 0)
                    //.Where(m => m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid) && m.datatype == 0)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        //data_id = m.lobbydata_id,
                        ustatus = (byte)(m.data.data.lobbydata_id != 0 ? m.data.data.status : 0),
                        data_id = (m.data.data.status == 1) ? m.data.data.data_id : m.data.data.lobbydata_id,
                        status = m.data.data.status
                    })
                    .ToList();
            }
            else
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) && m.datatype == 0)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        //data_id = (usertype == "agent") ? m.data_id : m.lobbydata_id,
                        ustatus = (byte)((usertype == "agent") ? (m.data.data.data_id != 0 ? m.data.data.status : 0) : (m.data.data.lobbydata_id != 0 ? m.data.data.status : 0)),
                        data_id = (m.data.data.status == 1) ? m.data.data.data_id : m.data.data.lobbydata_id,
                        status = m.data.data.status
                    })
                    .ToList();
            }

            List<YanshiInfo> filteredbrand = new List<YanshiInfo>();
            if (brand_id > 0)
            {
                foreach (YanshiInfo item in alllist)
                {
                    tbl_androidspec specitem = PhoneModel.GetSpecById(item.android_id);
                    if (specitem != null && specitem.brandid == brand_id)
                        filteredbrand.Add(item);
                }
            } 
            else
                filteredbrand = alllist;

            List<YanshiInfo> filteredlobby;
            if (lobby_id > 0)
                filteredlobby = filteredbrand.Where(m => m.user_id == lobby_id).ToList();
            else
                filteredlobby = filteredbrand;

            return filteredlobby;
        }

        public JqDataTableInfo GetYanshivideoDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri, long lobby_id, long brand_id)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<YanshiInfo> filteredCompanies;

            List<YanshiInfo> alllist = GetYanshivideoList(lobby_id, brand_id);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist;
                //   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<YanshiInfo, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.user_id != user_id ? AgentModel.GetAgentName(c.user_id) : "我自己",
                PhoneModel.GetBrandNameBySpecId(c.android_id),
                PhoneModel.GetSpecNameById(c.android_id),
                VideoModel.GetVideoNameById(c.data_id),
                Convert.ToString(c.status),
                Convert.ToString(c.uid),
                VideoModel.GetVideoPathById(c.data_id),
                Convert.ToString(c.ustatus)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool BlockAVideo(long[] items)
        {
            string updateSql = "UPDATE tbl_androiddata SET status = 1 WHERE ";
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

        public bool UnblockAVideo(long[] items)
        {
            string updateSql = "UPDATE tbl_androiddata SET status = 2 WHERE ";
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

        public bool SelectAVideo(long id, long[] items)
        {
            string usertype = CommonModel.GetCurrentUserType();

            tbl_androiddata item = db.tbl_androiddatas
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();

            if (item != null && items.Length > 0)
            {
                if (usertype == "agent")
                {
                    item.data_id = items[0];
                    if (item.status == 0)
                        item.status = 1;
                }
                else
                {
                    item.lobbydata_id = items[0];
                    if (item.status == 0)
                        item.status = 2;
                }

                db.SubmitChanges();

                return true;
            }

            return false;
        }        
        #endregion

        #region Splash
        public List<YanshiInfo> GetSplashList(long lobby_id, long brand_id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();
            List<YanshiInfo> alllist = null;
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                alllist = db.tbl_androiddatas
                .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id) && m.datatype == 1)
                //.Where(m => m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid) && m.datatype == 1)
                .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                .OrderByDescending(m => m.data.data.uid)
                .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                .Select(m => new YanshiInfo
                {
                    uid = m.data.data.uid,
                    user_id = m.data.data.user_id,
                    parentid = m.data.data.parentid,
                    android_id = m.data.data.android_id,
                    //data_id = m.lobbydata_id,
                    ustatus = (byte)(m.data.data.lobbydata_id != 0 ? m.data.data.status : 0),
                    data_id = (m.data.data.status == 1) ? m.data.data.data_id : m.data.data.lobbydata_id,
                    status = m.data.data.status
                })
                .ToList();
            }
            else
            {
                alllist = db.tbl_androiddatas
                   .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) && m.datatype == 1)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                   .Select(m => new YanshiInfo
                   {
                       uid = m.data.data.uid,
                       user_id = m.data.data.user_id,
                       parentid = m.data.data.parentid,
                       android_id = m.data.data.android_id,
                       //data_id = (usertype == "agent") ? m.data_id : m.lobbydata_id,
                       ustatus = (byte)((usertype == "agent") ? (m.data.data.data_id != 0 ? m.data.data.status : 0) : (m.data.data.lobbydata_id != 0 ? m.data.data.status : 0)),
                       data_id = (m.data.data.status == 1) ? m.data.data.data_id : m.data.data.lobbydata_id,
                       status = m.data.data.status
                   })
                   .ToList();
            }

            List<YanshiInfo> filteredbrand = new List<YanshiInfo>();
            if (brand_id > 0)
            {
                foreach (YanshiInfo item in alllist)
                {
                    tbl_androidspec specitem = PhoneModel.GetSpecById(item.android_id);
                    if (specitem != null && specitem.brandid == brand_id)
                        filteredbrand.Add(item);
                }
            } 
            else
                filteredbrand = alllist;

            List<YanshiInfo> filteredlobby;
            if (lobby_id > 0)
                filteredlobby = filteredbrand.Where(m => m.user_id == lobby_id).ToList();
            else
                filteredlobby = filteredbrand;

            return filteredlobby;
        }

        public JqDataTableInfo GetSplashDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri, long lobby_id, long brand_id)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<YanshiInfo> filteredCompanies;

            List<YanshiInfo> alllist = GetSplashList(lobby_id, brand_id);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist;
                //   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<YanshiInfo, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.user_id != user_id ? AgentModel.GetAgentName(c.user_id) : "我自己",
                PhoneModel.GetBrandNameBySpecId(c.android_id),
                PhoneModel.GetSpecNameById(c.android_id),
                ImageModel.GetImagePathById(c.data_id),
                Convert.ToString(c.status),
                Convert.ToString(c.uid),
                Convert.ToString(c.ustatus)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }      
        #endregion

        #region Splash
        public List<YanshiInfo> GetHomeImgList(long lobby_id, long brand_id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();
            List<YanshiInfo> alllist = null;
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id) && m.datatype == 2)
                    //.Where(m => m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid) && m.datatype == 2)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                   .Select(m => new YanshiInfo
                   {
                       uid = m.data.data.uid,
                       user_id = m.data.data.user_id,
                       parentid = m.data.data.parentid,
                       android_id = m.data.data.android_id,
                       //data_id = m.lobbydata_id,
                       ustatus = (byte)(m.data.data.lobbydata_id != 0 ? m.data.data.status : 0),
                       data_id = (m.data.data.status == 1) ? m.data.data.data_id : m.data.data.lobbydata_id,
                       status = m.data.data.status
                   })
                   .ToList();
            }
            else
            {
                alllist = db.tbl_androiddatas
                   .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) && m.datatype == 2)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                   .Select(m => new YanshiInfo
                   {
                       uid = m.data.data.uid,
                       user_id = m.data.data.user_id,
                       parentid = m.data.data.parentid,
                       android_id = m.data.data.android_id,
                       //data_id = (usertype == "agent") ? m.data_id : m.lobbydata_id,
                       ustatus = (byte)((usertype == "agent") ? (m.data.data.data_id != 0 ? m.data.data.status : 0) : (m.data.data.lobbydata_id != 0 ? m.data.data.status : 0)),
                       data_id = (m.data.data.status == 1) ? m.data.data.data_id : m.data.data.lobbydata_id,
                       status = m.data.data.status
                   })
                   .ToList();
            }

            List<YanshiInfo> filteredbrand = new List<YanshiInfo>();
            if (brand_id > 0)
            {
                foreach (YanshiInfo item in alllist)
                {
                    tbl_androidspec specitem = PhoneModel.GetSpecById(item.android_id);
                    if (specitem != null && specitem.brandid == brand_id)
                        filteredbrand.Add(item);
                }
            }
            else
                filteredbrand = alllist;

            List<YanshiInfo> filteredlobby;
            if (lobby_id > 0)
                filteredlobby = filteredbrand.Where(m => m.user_id == lobby_id).ToList();
            else
                filteredlobby = filteredbrand;

            return filteredlobby;
        }

        public JqDataTableInfo GetHomeImgDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri, long lobby_id, long brand_id)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<YanshiInfo> filteredCompanies;

            List<YanshiInfo> alllist = GetHomeImgList(lobby_id, brand_id);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist;
                //   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<YanshiInfo, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.user_id != user_id ? AgentModel.GetAgentName(c.user_id) : "我自己",
                PhoneModel.GetBrandNameBySpecId(c.android_id),
                PhoneModel.GetSpecNameById(c.android_id),
                ImageModel.GetImagePathById(c.data_id),
                Convert.ToString(c.status),
                Convert.ToString(c.uid),
                Convert.ToString(c.ustatus)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }
        #endregion

        #region BrightSpot
        public List<YanshiInfo> GetBrightspotList(long lobby_id, long brand_id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();
            List<YanshiInfo> alllist = null;
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id) && m.datatype == 3)
                    //.Where(m => m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid) && m.datatype == 3)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        data_id = (usertype == "agent") ? m.data.data.data_id : m.data.data.lobbydata_id,
                        //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
                        status = m.data.data.status
                    })
                    .ToList();
            }
            else
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) && m.datatype == 3)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        data_id = (usertype == "agent") ? m.data.data.data_id : m.data.data.lobbydata_id,
                        //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
                        status = m.data.data.status
                    })
                    .ToList();
            }

            List<YanshiInfo> filteredbrand = new List<YanshiInfo>();
            if (brand_id > 0)
            {
                foreach (YanshiInfo item in alllist)
                {
                    tbl_androidspec specitem = PhoneModel.GetSpecById(item.android_id);
                    if (specitem != null && specitem.brandid == brand_id)
                        filteredbrand.Add(item);
                }
            }
            else
                filteredbrand = alllist;

            List<YanshiInfo> filteredlobby;
            if (lobby_id > 0)
                filteredlobby = filteredbrand.Where(m => m.user_id == lobby_id).ToList();
            else
                filteredlobby = filteredbrand;

            return filteredlobby;
        }

        public JqDataTableInfo GetBrightspotDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri, long lobby_id, long brand_id)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<YanshiInfo> filteredCompanies;

            List<YanshiInfo> alllist = GetBrightspotList(lobby_id, brand_id);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist;
                //   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<YanshiInfo, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.user_id != user_id ? AgentModel.GetAgentName(c.user_id) : "我自己",
                PhoneModel.GetBrandNameBySpecId(c.android_id),
                PhoneModel.GetSpecNameById(c.android_id),
                GetDataListById(c.uid, c.status),
                Convert.ToString(c.status),
                Convert.ToString(c.uid),
                //Convert.ToString(c.status),
                Convert.ToString(GetDataCountById(c.uid) != 0 ? c.status : 0),
                Convert.ToString(GetDataCountById(c.uid, c.status))
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public string GetDataListById(long id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            byte type = (byte)(usertype == "agent" ? 0 : 1);
            var pathlist = db.tbl_androiddatalists
                .Where(m => m.deleted == 0 && m.androiddata_id == id && m.type == type)
                .OrderBy(m => m.sortid)
                .Select(m => new
                {
                    path = ImageModel.GetImagePathById(m.data_id)
                }).ToList();

            string retinfo = "";
            for(int i = 0; i < pathlist.Count(); i++) {
                if (i >= 3)
                    break;

                retinfo += pathlist.ElementAt(i).path + ",";
            }

            return retinfo;
        }

        public string GetDataListById(long id, byte status)
        {
            byte type = (byte)(status == 1 ? 0 : 1);
            var pathlist = db.tbl_androiddatalists
                .Where(m => m.deleted == 0 && m.androiddata_id == id && m.type == type)
                .OrderBy(m => m.sortid)
                .Select(m => new
                {
                    path = ImageModel.GetImagePathById(m.data_id)
                }).ToList();

            string retinfo = "";
            for (int i = 0; i < pathlist.Count(); i++)
            {
                if (i >= 3)
                    break;

                retinfo += pathlist.ElementAt(i).path + ",";
            }

            if (pathlist.Count() == 0)
                retinfo = "--无图片--";

            return retinfo;
        }

        public int GetDataCountById(long id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            byte type = (byte)(usertype == "agent" ? 0 : 1);
            return db.tbl_androiddatalists
                .Where(m => m.deleted == 0 && m.androiddata_id == id && m.type == type)
                .Count();
        }

        public int GetDataCountById(long id, byte status)
        {
            byte type = (byte)(status == 1 ? 0 : 1);
            return db.tbl_androiddatalists
                .Where(m => m.deleted == 0 && m.androiddata_id == id && m.type == type)
                .Count();
        }

        public List<NestableImgInfo> GetDataList(long id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            byte type = (byte)(usertype == "agent" ? 0 : 1);
            return db.tbl_androiddatalists
                .Where(m => m.deleted == 0 && m.androiddata_id == id && m.type == type)
                .OrderBy(m => m.sortid)
                .Select(m => new NestableImgInfo
                {
                    uid = m.uid,
                    imgurl = ImageModel.GetImagePathById(m.data_id),
                    title = ImageModel.GetImageTitleById(m.data_id),
                    description = ImageModel.GetImageDescriptionById(m.data_id)
                }).ToList();
        }

        public bool DeleteData(long id)
        {
            string delSql = "UPDATE tbl_androiddatalist SET deleted = 1 WHERE uid = " + id;

            db.ExecuteCommand(delSql);

            return true;
        }

        public bool UpdateAndroidDataList(long androiddata_id, List<NestableImgID> dataids)
        {
            string usertype = CommonModel.GetCurrentUserType();
            int i = 1;
            foreach (NestableImgID item in dataids)
            {
                if (item.id.Length > 4 && item.id.Substring(0, 4) == "new_")
                {
                    string idstr = item.id.Substring(4);
                    long data_id = 0;
                    try { data_id = long.Parse(idstr); }
                    catch (Exception e) { }

                    tbl_androiddatalist newitem = new tbl_androiddatalist();

                    newitem.androiddata_id = androiddata_id;
                    newitem.data_id = data_id;
                    newitem.sortid = i;
                    if (usertype == "agent")
                        newitem.type = 0;
                    else
                        newitem.type = 1;

                    db.tbl_androiddatalists.InsertOnSubmit(newitem);

                    tbl_androiddata dataitem = db.tbl_androiddatas
                        .Where(m => m.deleted == 0 && m.uid == androiddata_id)
                        .FirstOrDefault();

                    if (usertype == "agent")
                    {
                        if (dataitem.status == 0)
                            dataitem.status = 1;
                    }
                    else
                    {
                        if (dataitem.status == 0)
                            dataitem.status = 2;
                    }
                }
                else
                {
                    long data_id = 0;
                    try { data_id = long.Parse(item.id); }
                    catch (Exception e) { }

                    tbl_androiddatalist edititem = (from m in db.tbl_androiddatalists
                                                    where m.deleted == 0 && m.uid == data_id
                                                    select m).FirstOrDefault();

                    if (edititem != null)
                    {
                        //edititem.androiddata_id = androiddata_id;
                        //edititem.data_id = data_id;
                        edititem.sortid = i;
                    }

                }
                i++;
            }
            db.SubmitChanges();

            return true;
        }

        public bool DeleteData(long[] items)
        {
            if (items.Length == 0)
                return true;

            string delSql = "UPDATE tbl_androiddatalist SET deleted = 1 WHERE ";
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

        #endregion

        #region BuySet
        public List<YanshiInfo> GetBuysetList(long lobby_id, long brand_id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();
            List<YanshiInfo> alllist = null;
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id) && m.datatype == 4)
                    //.Where(m => m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid) && m.datatype == 4)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        data_id = (usertype == "agent") ? m.data.data.data_id : m.data.data.lobbydata_id,
                        //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
                        status = m.data.data.status
                    })
                    .ToList();
            }
            else
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) && m.datatype == 4)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        data_id = (usertype == "agent") ? m.data.data.data_id : m.data.data.lobbydata_id,
                        //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
                        status = m.data.data.status
                    })
                    .ToList();
            }

            List<YanshiInfo> filteredbrand = new List<YanshiInfo>();
            if (brand_id > 0)
            {
                foreach (YanshiInfo item in alllist)
                {
                    tbl_androidspec specitem = PhoneModel.GetSpecById(item.android_id);
                    if (specitem != null && specitem.brandid == brand_id)
                        filteredbrand.Add(item);
                }
            }
            else
                filteredbrand = alllist;

            List<YanshiInfo> filteredlobby;
            if (lobby_id > 0)
                filteredlobby = filteredbrand.Where(m => m.user_id == lobby_id).ToList();
            else
                filteredlobby = filteredbrand;

            return filteredlobby;
        }

        public JqDataTableInfo GetBuysetDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri, long lobby_id, long brand_id)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<YanshiInfo> filteredCompanies;

            List<YanshiInfo> alllist = GetBuysetList(lobby_id, brand_id);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist;
                //   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<YanshiInfo, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.user_id != user_id ? AgentModel.GetAgentName(c.user_id) : "我自己",
                PhoneModel.GetBrandNameBySpecId(c.android_id),
                PhoneModel.GetSpecNameById(c.android_id),
                GetDataListById(c.uid, c.status),
                Convert.ToString(c.status),
                Convert.ToString(c.uid),
                //Convert.ToString(c.status),
                Convert.ToString(GetDataCountById(c.uid) != 0 ? c.status : 0),
                Convert.ToString(GetDataCountById(c.uid, c.status))
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }        

        #endregion

        #region BigWheel

        public tbl_gift GetGifts()
        {
            long user_id = CommonModel.GetCurrentUserId();
            return db.tbl_gifts
                .Where(m => m.deleted == 0 && m.user_id == user_id)
                .FirstOrDefault();
        }

        public List<tbl_snnumber> GetSNNumberList()
        {
            long user_id = CommonModel.GetCurrentUserId();
            return db.tbl_snnumbers
                .Where(m => m.deleted == 0 && m.user_id == user_id)
                .OrderByDescending(m => m.uid)      
                .ToList();
        }

        public JqDataTableInfo GetSNNumberDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<tbl_snnumber> filteredCompanies;

            List<tbl_snnumber> alllist = GetSNNumberList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.snnum.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<tbl_snnumber, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();
            var result = from c in displayedCompanies
                         select new[] { 
                c.snnum,
                Convert.ToString(c.rank),
                Convert.ToString(c.status),
                c.phonenum != null ? c.phonenum : "",
                c.lotter_time != null ? String.Format("{0:yyyy-MM-dd hh:mm:ss}", c.lotter_time): "未中奖",
                c.using_time != null ? String.Format("{0:yyyy-MM-dd hh:mm:ss}", c.using_time): "未使用",
                Convert.ToString(c.uid)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public string InsertOrUpdateGifts(byte status, string gift1_name, int gift1_quantity, string gift2_name, int gift2_quantity,
            string gift3_name, int gift3_quantity, string gift4_name, int gift4_quantity,
            string gift5_name, int gift5_quantity, string gift6_name, int gift6_quantity,
            decimal percent, string password, string wheelpass)
        {
            string rst = "";
            long user_id = CommonModel.GetCurrentUserId();
            tbl_gift edititem = db.tbl_gifts
                .Where(m => m.deleted == 0 && m.user_id == user_id)
                .FirstOrDefault();

            if (edititem != null)
            {
                edititem.status = status;
                //if (status == 1)
                {
                    if (gift1_name != null && gift1_name.Length > 0 && gift1_quantity > 0)
                    {
                        edititem.gift_1_name = gift1_name;
                        edititem.gift_1_quantity = gift1_quantity;
                    }
                    if (gift2_name != null && gift2_name.Length > 0 && gift2_quantity > 0)
                    {
                        edititem.gift_2_name = gift2_name;
                        edititem.gift_2_quantity = gift2_quantity;
                    }
                    if (gift3_name != null && gift3_name.Length > 0 && gift3_quantity > 0)
                    {
                        edititem.gift_3_name = gift3_name;
                        edititem.gift_3_quantity = gift3_quantity;
                    }
                    if (gift4_name != null && gift4_name.Length > 0 && gift4_quantity > 0)
                    {
                        edititem.gift_4_name = gift4_name;
                        edititem.gift_4_quantity = gift4_quantity;
                    }
                    if (gift5_name != null && gift5_name.Length > 0 && gift5_quantity > 0)
                    {
                        edititem.gift_5_name = gift5_name;
                        edititem.gift_5_quantity = gift5_quantity;
                    }
                    if (gift6_name != null && gift6_name.Length > 0 && gift6_quantity > 0)
                    {
                        edititem.gift_6_name = gift6_name;
                        edititem.gift_6_quantity = gift6_quantity;
                    }
                }
                edititem.probablity = percent;
                edititem.password = password;
                edititem.wheelpass = wheelpass;
            }
            else
            {
                tbl_gift newitem = new tbl_gift();

                newitem.status = status;
                //if (status == 1)
                {
                    if (gift1_name != null && gift1_name.Length > 0 && gift1_quantity > 0)
                    {
                        newitem.gift_1_name = gift1_name;
                        newitem.gift_1_quantity = gift1_quantity;
                    }
                    if (gift2_name != null && gift2_name.Length > 0 && gift2_quantity > 0)
                    {
                        newitem.gift_2_name = gift2_name;
                        newitem.gift_2_quantity = gift2_quantity;
                    }
                    if (gift3_name != null && gift3_name.Length > 0 && gift3_quantity > 0)
                    {
                        newitem.gift_3_name = gift3_name;
                        newitem.gift_3_quantity = gift3_quantity;
                    }
                    if (gift4_name != null && gift4_name.Length > 0 && gift4_quantity > 0)
                    {
                        newitem.gift_4_name = gift4_name;
                        newitem.gift_4_quantity = gift4_quantity;
                    }
                    if (gift5_name != null && gift5_name.Length > 0 && gift5_quantity > 0)
                    {
                        newitem.gift_5_name = gift5_name;
                        newitem.gift_5_quantity = gift5_quantity;
                    }
                    if (gift6_name != null && gift6_name.Length > 0 && gift6_quantity > 0)
                    {
                        newitem.gift_6_name = gift6_name;
                        newitem.gift_6_quantity = gift6_quantity;
                    }
                }
                newitem.probablity = percent;
                newitem.password = password;
                newitem.wheelpass = wheelpass;
                newitem.user_id = user_id;

                db.tbl_gifts.InsertOnSubmit(newitem);
            }

            db.SubmitChanges();

            if (status == 1)
            {
                //DeleteAllSNNumber();

                if (gift1_name != null && gift1_name.Length > 0 && gift1_quantity > 0)
                    rst = InsertSNNumber(0, gift1_name, gift1_quantity);
                if (gift2_name != null && gift2_name.Length > 0 && gift2_quantity > 0)
                    rst = InsertSNNumber(1, gift2_name, gift2_quantity);
                if (gift3_name != null && gift3_name.Length > 0 && gift3_quantity > 0)
                    rst = InsertSNNumber(2, gift3_name, gift3_quantity);
                if (gift4_name != null && gift4_name.Length > 0 && gift4_quantity > 0)
                    rst = InsertSNNumber(3, gift4_name, gift4_quantity);
                if (gift5_name != null && gift5_name.Length > 0 && gift5_quantity > 0)
                    rst = InsertSNNumber(4, gift5_name, gift5_quantity);
                if (gift6_name != null && gift6_name.Length > 0 && gift6_quantity > 0)
                    rst = InsertSNNumber(5, gift6_name, gift6_quantity);
            }

            return rst;
        }

        public string DeleteAllSNNumber()
        {
            string rst = "";

            long user_id = CommonModel.GetCurrentUserId();
            string delSql = "UPDATE tbl_snnumber SET deleted = 1 WHERE user_id = " + user_id;
            db.ExecuteCommand(delSql);

            return rst;
        }

        public string InsertSNNumber(byte order, string gift_name, int gift_quantity)
        {
            string rst = "";

            for (int i = 0; i < gift_quantity; i++)
            {
                string snnum = Captcha.GenerateRandomCode(1, 1) + Captcha.GenerateRandomCode(11, 0);

                long user_id = CommonModel.GetCurrentUserId();

                tbl_snnumber newitem = new tbl_snnumber();

                newitem.user_id = user_id;
                newitem.snnum = snnum;
                newitem.rank = order;

                db.tbl_snnumbers.InsertOnSubmit(newitem);
                db.SubmitChanges();
            }


            return rst;
        }

        public bool ChouzhongGift(long[] items)
        {
            //string updateSql = "UPDATE tbl_snnumber SET status = 1 WHERE ";
            string updateSql = "UPDATE tbl_snnumber SET status = 1, using_time = '" + DateTime.Now + "' WHERE ";
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

        public bool DuijiangGift(long[] items)
        {
            //string updateSql = "UPDATE tbl_snnumber SET status = 2 WHERE ";
            string updateSql = "UPDATE tbl_snnumber SET status = 2, lotter_time = '" + DateTime.Now + "' WHERE ";
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

        #endregion

        #region PhoneDetail
        public List<YanshiInfo> GetPhoneDetailList(long lobby_id, long brand_id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();
            List<YanshiInfo> alllist = null;
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id) && m.datatype == 3)
                    //.Where(m => m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid) && m.datatype == 3)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        data_id = (usertype == "agent") ? m.data.data.data_id : m.data.data.lobbydata_id,
                        //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
                        status = m.data.data.status
                    })
                    .ToList();
            }
            else
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) && m.datatype == 3)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        data_id = (usertype == "agent") ? m.data.data.data_id : m.data.data.lobbydata_id,
                        //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
                        status = m.data.data.status
                    })
                    .ToList();
            }

            List<YanshiInfo> filteredbrand = new List<YanshiInfo>();
            if (brand_id > 0)
            {
                foreach (YanshiInfo item in alllist)
                {
                    tbl_androidspec specitem = PhoneModel.GetSpecById(item.android_id);
                    if (specitem != null && specitem.brandid == brand_id)
                        filteredbrand.Add(item);
                }
            }
            else
                filteredbrand = alllist;

            List<YanshiInfo> filteredlobby;
            if (lobby_id > 0)
                filteredlobby = filteredbrand.Where(m => m.user_id == lobby_id).ToList();
            else
                filteredlobby = filteredbrand;

            return filteredlobby;
        }

        public JqDataTableInfo GetPhoneDetailDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri, long lobby_id, long brand_id)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<YanshiInfo> filteredCompanies;

            List<YanshiInfo> alllist = GetPhoneDetailList(lobby_id, brand_id);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist;
                //   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<YanshiInfo, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();

            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.user_id != user_id ? AgentModel.GetAgentName(c.user_id) : "我自己",
                PhoneModel.GetBrandNameBySpecId(c.android_id),
                PhoneModel.GetSpecNameById(c.android_id),
                PhoneModel.GetImageByDetailId(c.android_id),
                PhoneModel.GetPriceByDetailId(c.android_id),
                PhoneModel.GetSizeByDetailId(c.android_id),
                PhoneModel.GetCPUByDetailId(c.android_id),
                PhoneModel.GetMemByDetailId(c.android_id),
                PhoneModel.GetPixelCntByDetailId(c.android_id),
                PhoneModel.GetOSVerByDetailId(c.android_id),
                PhoneModel.GetDetailId(c.android_id)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public tbl_androiddetail GetAndroidDetailInfoById(long id)
        {
            return db.tbl_androiddetails
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();
        }

        public string UpdateAndroidDetail(long uid, string title, string imgurl1, string imgurl2, string imgurl3, string imgurl4,
            string description, decimal recommprice, decimal realprice, decimal screensize, string screenshowsize,
            string cpu, string showcpu, int memsize, string memshowsize, 
            long pixcnt, string pixshowcnt, decimal osver, string osshowver)
        {
            string rst = "";
            tbl_androiddetail edititem = db.tbl_androiddetails
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (edititem != null)
            {
                edititem.title = title;
                edititem.imgurl1 = imgurl1;
                edititem.imgurl2 = imgurl2;
                edititem.imgurl3 = imgurl3;
                edititem.imgurl4 = imgurl4;
                edititem.description = description;
                edititem.recommprice = recommprice;
                edititem.realprice = realprice;
                edititem.screensize = screensize;
                edititem.screenshowsize = screenshowsize;
                edititem.cpu = cpu;
                edititem.showcpu = showcpu;
                edititem.memsize = memsize;
                edititem.memshowsize = memshowsize;
                edititem.pixcnt = pixcnt;
                edititem.pixshowcnt = pixshowcnt;
                edititem.osver = osver;
                edititem.osshowver = osshowver;

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "资料不存在";
            }
             
            return rst;
        }

        public tbl_androiddetrel GetAndroidDetrelInfoByDetailid(long detail_id)
        {
            return db.tbl_androiddetrels
                .Where(m => m.deleted == 0 && m.detailid == detail_id)
                .FirstOrDefault();
        }

        public string UpdateAndroidDetrel(long uid, decimal minprice, decimal maxprice, decimal minscrsize, decimal maxscrsize,
            int minmemsize, int maxmemsize, long minpixcnt, long maxpixcnt, decimal minosver, decimal maxosver, string reldetailids)
        {
            string rst = "";
            tbl_androiddetrel edititem = db.tbl_androiddetrels
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (edititem != null)
            {
                edititem.minprice = minprice;
                edititem.maxprice = maxprice;
                edititem.minscrsize = minscrsize;
                edititem.maxscrsize = maxscrsize;
                edititem.minmemsize = minmemsize;
                edititem.maxmemsize = maxmemsize;
                edititem.minpixcnt = minpixcnt;
                edititem.maxpixcnt = maxpixcnt;
                edititem.minosver = minosver;
                edititem.maxosver = maxosver; 
                edititem.reldetailids = reldetailids.Trim(new char[] { ',' });

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "资料不存在";
            }

            return rst;
        }

        public List<RelDetailInfo> GetAndroidRelDetailListForId(long id)
        {
            List<RelDetailInfo> retlist = new List<RelDetailInfo>();

            var item = db.tbl_androiddetrels
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();

            if (item != null && item.reldetailids != null)
            {
                List<string> ids = item.reldetailids.Split(',').Where(m => !string.IsNullOrEmpty(m)).ToList();
                for (int i = 0; i < ids.Count(); i++)
                {
                    long detail_id = Convert.ToUInt32(ids[i]);
                    RelDetailInfo relitem = db.tbl_androiddetails
                        .Where(m => m.deleted == 0 && m.uid == detail_id)
                        .Select(m => new RelDetailInfo
                        {
                            uid = m.uid,
                            imgurl = m.imgurl1
                        }).FirstOrDefault();

                    if(relitem != null)
                        retlist.Add(relitem);
                }
            }

            return retlist;
        }

        public JqDataTableInfo GetPhoneDetailDataTable2(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<YanshiInfo> filteredCompanies;

            List<YanshiInfo> alllist = GetPhoneDetailList(0, 0);

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist;
                //   .Where(c => isNameSearchable && c.agentname.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<YanshiInfo, long> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.user_id :
                                                           0);

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
            long user_id = CommonModel.GetCurrentUserId();

            var result = from c in displayedCompanies
                         select new[] { 
                //Convert.ToString(c.uid), 
                PhoneModel.GetDetailId(c.android_id),
                PhoneModel.GetBrandNameBySpecId(c.android_id) + " " + PhoneModel.GetSpecNameById(c.android_id),
                PhoneModel.GetImageByDetailId(c.android_id)
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        #endregion
    }
}