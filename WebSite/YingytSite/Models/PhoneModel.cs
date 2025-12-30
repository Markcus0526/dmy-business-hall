using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;
using System.Text.RegularExpressions;

namespace YingytSite.Models
{
    public class SpecInfo
    {
        public long uid { get; set; }
        public string specvalue { get; set; }
    }


    public class PhoneModel
    {
        YingytDBDataContext db = new YingytDBDataContext();

        public static List<tbl_androidbrand> GetBrandList()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                return db.tbl_androidbrands
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id/*m.parentid == parentid*/))
                    .OrderBy(m => m.sortid)
                    .ToList();
            }
            else
            {
                return db.tbl_androidbrands
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id))
                    .OrderBy(m => m.sortid)
                    .ToList();
            }
        }

        public List<tbl_androidbrand> GetBrandFilterList(List<tbl_androidbrand> brandlist, string filter)
        {
            filter = filter.Replace("==", "=");

            var results = db.ExecuteQuery<tbl_androidbrand>("SELECT * FROM tbl_androidbrand WHERE " + filter);

            return results
                .Where(p => p.deleted == 0)
                .OrderBy(p => p.sortid)
                .Join(brandlist, p => p.uid, m => m.uid, (p, m) => m)
                .ToList();
        }

        public string InserOrUpdateDeleteBrand(long id, string brandname, string note, string sortid, string oper)
        {
            try
            {
                long accountid = CommonModel.GetCurrAccountId();

                if (!CheckDuplicateName(brandname, id))
                {
                    return "规格名称重复！";
                }

                if (oper.Equals("add"))
                {
                    tbl_androidbrand newitem = new tbl_androidbrand();

                    newitem.brandname = brandname;
                    newitem.note = note;
                    newitem.sortid = int.Parse(sortid);
                    newitem.createtime = DateTime.Now;
                    long user_id = CommonModel.GetCurrentUserId();
                    newitem.user_id = user_id;
                    newitem.parentid = AgentModel.GetAgentParentid(user_id);

                    db.tbl_androidbrands.InsertOnSubmit(newitem);
                }
                else if (oper.Equals("edit"))
                {
                    if(!CheckBrandAuthority(id))
                        return "没有权限，只能操作你添加的";

                    var edititem = db.tbl_androidbrands.Where(m => m.uid == id).FirstOrDefault();

                    if (edititem != null)
                    {
                        edititem.brandname = brandname;
                        edititem.note = note;
                        edititem.sortid = int.Parse(sortid);
                        //long user_id = CommonModel.GetCurrentUserId();
                        //edititem.user_id = user_id;
                        //edititem.parentid = AgentModel.GetAgentParentid(user_id);
                    }
                }
                else if (oper.Equals("del"))
                {
                    if (!CheckBrandAuthority(id))
                        return "没有权限，只能操作你添加的";

                    var delitem = db.tbl_androidbrands.Where(m => m.uid == id).FirstOrDefault();
                    if (delitem != null)
                    {
                        delitem.deleted = 1;
                    }
                }

                db.SubmitChanges();
            }
            catch (System.Exception ex)
            {
                return ex.ToString();
            }
            return "";
        }

        public string DeleteBrand(long[] items)
        {
            for (int i = 0; i < items.Length; i++)
            {
                if (!CheckBrandAuthority(items[i]))
                    return "没有权限，只能操作你添加的";
            }

            string delSql = "UPDATE tbl_androidbrand SET deleted = 1 WHERE ";
            string whereSql = "";
            foreach (long uid in items)
            {
                if (whereSql != "") whereSql += " OR";
                whereSql += " uid = " + uid;
            }

            delSql += whereSql;

            db.ExecuteCommand(delSql);

            return "";
        }

        public string InserOrUpdateSpec(long brandid, long id, string specvalue, string specsortid, int swidth, int sheight, string oper)
        {
            string rst = "";
            long accountid = CommonModel.GetCurrAccountId();

            try
            {
                if (!CheckDuplicateSpecName(specvalue, brandid, id))
                {
                    return "规格名称重复！";
                }

                if (oper.Equals("add"))
                {
                    tbl_androidspec newitem = new tbl_androidspec();

                    newitem.brandid = brandid;
                    newitem.specvalue = specvalue;
                    newitem.sortid = int.Parse(specsortid);
                    newitem.scrwidth = swidth;
                    newitem.scrheight = sheight;
                    long user_id = CommonModel.GetCurrentUserId();
                    newitem.user_id = user_id;
                    newitem.parentid = AgentModel.GetAgentParentid(user_id);

                    db.tbl_androidspecs.InsertOnSubmit(newitem);

                }
                else if (oper.Equals("edit"))
                {
                    if (!CheckSpecAuthority(id))
                        return "没有权限，只能操作你添加的";

                    var edititem = db.tbl_androidspecs.Where(m => m.brandid == brandid && m.uid == id).FirstOrDefault();
                    if (edititem != null)
                    {
                        edititem.specvalue = specvalue;
                        edititem.sortid = int.Parse(specsortid);
                        edititem.scrwidth = swidth;
                        edititem.scrheight = sheight;
                        //long user_id = CommonModel.GetCurrentUserId();
                        //edititem.user_id = user_id;
                        //edititem.parentid = AgentModel.GetAgentParentid(user_id);
                    }
                }
                db.SubmitChanges();

                if (oper.Equals("add"))
                {
                    InsertAndroidData();                    
                }
            }
            catch (System.Exception ex)
            {
                return ex.ToString();
            }

            return rst;
        }

        public string DeleteSpec(long brandid, long id)
        {
            if (!CheckSpecAuthority(id))
                return "没有权限，只能操作你添加的";

            try
            {
                var delitem = db.tbl_androidspecs.Where(m => m.brandid == brandid && m.uid == id).FirstOrDefault();

                if (delitem != null)
                {
                    //db.tbl_androidspecs.DeleteOnSubmit(delitem);
                    delitem.deleted = 1;

                    db.SubmitChanges();
                }

                //DeleteSpecData(brandid, id);
            }
            catch (System.Exception ex)
            {
                return "失败";
            }

            return "";
        }

//         public void DeleteSpecData(long brandid, long specid)
//         {
//             string usertype = CommonModel.GetCurrentUserType();
//             long user_id = CommonModel.GetCurrentUserId();
//             List<YanshiInfo> alllist = null;
//             long parentid = AgentModel.GetAgentParentid(user_id);
//             byte allowShare = AgentModel.GetAgentAllowshare(parentid);
//             if (usertype == "lobby" && allowShare == 1)
//             {
//                 alllist = db.tbl_androiddatas
//                     .Where(m => m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid))
//                     .OrderByDescending(m => m.uid)
//                     .Select(m => new YanshiInfo
//                     {
//                         uid = m.uid,
//                         user_id = m.user_id,
//                         parentid = m.parentid,
//                         android_id = m.android_id,
//                         data_id = (usertype == "agent") ? m.data_id : m.lobbydata_id,
//                         //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
//                         status = m.status
//                     })
//                     .ToList();
//             }
//             else
//             {
//                 alllist = db.tbl_androiddatas
//                     .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id))
//                     .OrderByDescending(m => m.uid)
//                     .Select(m => new YanshiInfo
//                     {
//                         uid = m.uid,
//                         user_id = m.user_id,
//                         parentid = m.parentid,
//                         android_id = m.android_id,
//                         data_id = (usertype == "agent") ? m.data_id : m.lobbydata_id,
//                         //status = (byte)(GetDataCountById(m.uid) != 0 ? m.status : 0)
//                         status = m.status
//                     })
//                     .ToList();
//             }
// 
//             List<YanshiInfo> filteredbrand = new List<YanshiInfo>();
//             if (brandid > 0)
//             {
//                 foreach (YanshiInfo item in alllist)
//                 {
//                     tbl_androidspec specitem = PhoneModel.GetSpecById(item.android_id);
//                     if (specitem != null && specitem.brandid == brand_id)
//                         filteredbrand.Add(item);
//                 }
//             }
//             else
//                 filteredbrand = alllist;
// 
//             List<YanshiInfo> filteredlobby;
//             if (lobby_id > 0)
//                 filteredlobby = filteredbrand.Where(m => m.user_id == lobby_id).ToList();
//             else
//                 filteredlobby = filteredbrand;
// 
//             return filteredlobby;
// 
//         }

        public string DeleteSpec(long brandid, long[] items)
        {
            for (int i = 0; i < items.Length; i++)
            {
                if (!CheckSpecAuthority(items[i]))
                    return "没有权限，只能操作你添加的";
            }

            string delSql = "UPDATE tbl_androidspec SET deleted = 1 WHERE brandid = " + brandid + " and ";
            string whereSql = "";
            foreach (long uid in items)
            {
                if (whereSql != "") whereSql += " OR";
                whereSql += " uid = " + uid;
            }

            delSql += whereSql;

            db.ExecuteCommand(delSql);

            return "";
        }

        public static tbl_androidbrand GetBrandById(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_androidbrands
                .Where(m => m.deleted == 0 && m.uid == uid)
                .OrderBy(m => m.sortid)
                .FirstOrDefault();
        }

        public static string GetBrandNameById(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            tbl_androidbrand item = db.tbl_androidbrands
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.brandname;
            else
                return "";
        }

        public static string GetBrandNameBySpecId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            
            tbl_androidspec item = db.tbl_androidspecs
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
            {
                tbl_androidbrand branditem = db.tbl_androidbrands
                .Where(m => m.deleted == 0 && m.uid == item.brandid)
                .FirstOrDefault();

                if (branditem != null)
                    return branditem.brandname;
                else
                    return "";
            }
            else
                return "";            
        }

        public static tbl_androidspec GetSpecById(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_androidspecs
                .Where(m => m.uid == uid && m.deleted == 0)
                .OrderBy(m => m.sortid)
                .FirstOrDefault();
        }

        public List<tbl_androidspec> GetSpecListById(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                return db.tbl_androidspecs
                    .Where(m => m.deleted == 0 && m.brandid == uid && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id/*m.parentid == parentid*/))
                    .OrderBy(m => m.sortid)
                    .ToList();
            }
            else
            {
                return db.tbl_androidspecs
                    .Where(m => m.deleted == 0 && m.brandid == uid && (m.user_id == user_id || m.parentid == user_id))
                    .OrderBy(m => m.sortid)
                    .ToList();
            }
        }

        public List<SpecInfo> GetSpecInfoListById(long uid)
        {
            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                return db.tbl_androidspecs
                    .Where(m => m.deleted == 0 && m.brandid == uid && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id/*m.parentid == parentid*/))
                    .OrderBy(m => m.sortid)
                    .Select(m => new SpecInfo { 
                        uid = m.uid,
                        specvalue = m.specvalue
                    })
                    .ToList();
            }
            else
            {
                return db.tbl_androidspecs
                    .Where(m => m.deleted == 0 && m.brandid == uid && (m.user_id == user_id || m.parentid == user_id))
                    .OrderBy(m => m.sortid)
                    .Select(m => new SpecInfo
                    {
                        uid = m.uid,
                        specvalue = m.specvalue
                    })
                    .ToList();
            }
        }

        public List<tbl_androidspec> GetSpecFilterList(List<tbl_androidspec> speclist, string filter)
        {
            filter = filter.Replace("==", "=");

            var results = db.ExecuteQuery<tbl_androidspec>("SELECT * FROM tbl_androidspec WHERE " + filter);

            return results
                .Where(p => p.deleted == 0)
                .OrderBy(p => p.sortid)
                .Join(speclist, p => p.uid, m => m.uid, (p, m) => m)
                .ToList();
        }

        public static string GetSpecNameById(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();

            tbl_androidspec item = db.tbl_androidspecs
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.specvalue;
            else
                return "";
        }

        public static List<string> SubIndexNames(NameValueCollection request, string prefix)
        {
            var list = new List<string>();
            var subIndexPattern = new Regex("^" + prefix + @"\[[^\]]+\]"); // "[" then one or more not "]", then "]"
            foreach (var key in request.Keys)
            {
                var match = subIndexPattern.Match(key.ToString());
                if (match.Success && !list.Contains(match.Value))
                    list.Add(request[match.Value]);
            }
            return list;
        }

//         public string InsertBrand(string brandname, string note, int sortid, List<string> specvalues, List<string> specsortids)
//         {
//             string rst = "";
// 
//             try
//             {
//                 db.Connection.Open();
//                 db.Transaction = db.Connection.BeginTransaction();
// 
//                 tbl_androidbrand newuser = new tbl_androidbrand();
// 
//                 newuser.brandname = brandname;
//                 newuser.note = note;
//                 newuser.sortid = sortid;
//                 newuser.createtime = DateTime.Now;
// 
//                 db.tbl_androidbrands.InsertOnSubmit(newuser);
//                 db.SubmitChanges();
// 
//                 if (specvalues.Count() != specsortids.Count())
//                 {
//                     throw new Exception("添加规格值中发生问题，请再确认是否正常~");
//                 }
// 
//                 for (int i = 0; i < specvalues.Count(); i++)
//                 {
//                     tbl_androidspec newitem = new tbl_androidspec();
// 
//                     newitem.brandid = newuser.uid;
//                     newitem.specvalue = specvalues.ElementAt(i);
//                     newitem.sortid = int.Parse(specsortids.ElementAt(i));
// 
//                     db.tbl_androidspecs.InsertOnSubmit(newitem);
//                 }
// 
//                 db.SubmitChanges();
// 
//                 db.Transaction.Commit();
//             }
//             catch (System.Exception ex)
//             {
//                 CommonModel.WriteLogFile("PhoneModel", "InsertBrand()", ex.ToString());
//                 db.Transaction.Rollback();
//                 rst = ex.ToString();
//             }
// 
//             return rst;
//         }
// 
//         public string UpdateBrand(long uid, string brandname, string note, int sortid, List<string> specvalues, List<string> specsortids)
//         {
//             string rst = "";
//             tbl_androidbrand edititem = GetBrandById(uid);
//             long accountid = CommonModel.GetCurrAccountId();
// 
//             if (edititem != null)
//             {
//                 try
//                 {
//                     db.Connection.Open();
//                     db.Transaction = db.Connection.BeginTransaction();
// 
//                     edititem.brandname = brandname;
//                     edititem.note = note;
//                     edititem.sortid = sortid;
// 
//                     if (specvalues.Count() != specsortids.Count())
//                     {
//                         throw new Exception("添加规格值中发生问题，请再确认是否正常~");
//                     }
// 
//                     var delitemlist = db.tbl_androidspecs.Where(m => m.brandid == edititem.uid).ToList();
//                     db.tbl_androidspecs.DeleteAllOnSubmit(delitemlist);
//                     for (int i = 0; i < specvalues.Count(); i++)
//                     {
//                         tbl_androidspec newitem = new tbl_androidspec();
//                         newitem.brandid = edititem.uid;
//                         newitem.specvalue = specvalues.ElementAt(i);
//                         newitem.sortid = int.Parse(specsortids.ElementAt(i));
// 
//                         db.tbl_androidspecs.InsertOnSubmit(newitem);
//                     }
// 
//                     db.SubmitChanges();
// 
//                     db.Transaction.Commit();
//                 }
//                 catch (System.Exception ex)
//                 {
//                     CommonModel.WriteLogFile("PhoneModel", "UpdateBrand()", ex.ToString());
//                     db.Transaction.Rollback();
//                     rst = ex.ToString();
// 
//                 }
//             }
//             else
//             {
//                 rst = "此规格不存在";
//             }
// 
//             return rst;
//         }

        public bool CheckDuplicateName(string brandname, long uid)
        {
            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            bool rst = true;
            if (usertype == "lobby" && allowShare == 1)
            {
                rst = ((from m in db.tbl_androidbrands
                        where m.deleted == 0 && m.brandname == brandname && m.uid != uid && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id)
                        select m).FirstOrDefault() == null);
            }
            else
            {
                rst = ((from m in db.tbl_androidbrands
                        where m.deleted == 0 && m.brandname == brandname && m.uid != uid && m.user_id == user_id
                        select m).FirstOrDefault() == null);
            }

            return rst;
        }

        public bool CheckDuplicateSpecName(string specvalue, long brandid, long uid)
        {
            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            bool rst = true;
            if (usertype == "lobby" && allowShare == 1)
            {
                rst = ((from m in db.tbl_androidspecs
                        where m.deleted == 0 && m.specvalue == specvalue && m.uid != uid && m.brandid == brandid && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id)
                        select m).FirstOrDefault() == null);
            }
            else
            {
                rst = ((from m in db.tbl_androidspecs
                        where m.deleted == 0 && m.specvalue == specvalue && m.uid != uid && m.brandid == brandid && m.user_id == user_id
                        select m).FirstOrDefault() == null);
            }

            return rst;
        }

        public bool InsertAndroidData()
        {
            tbl_androidspec specitem = db.tbl_androidspecs
                .Where(m => m.deleted == 0)
                .OrderByDescending(m => m.uid)
                .FirstOrDefault();

            if (specitem != null)
            {
                for (byte type = 0; type < 5; type++)
                {
                    tbl_androiddata newitem = new tbl_androiddata();

                    newitem.android_id = specitem.uid;
                    newitem.user_id = specitem.user_id;
                    newitem.parentid = specitem.parentid;
                    newitem.datatype = type;

                    db.tbl_androiddatas.InsertOnSubmit(newitem);
                }
                
                db.SubmitChanges();

                InsertAndroidDetailData();

                return true;
            }

            return false;
        }

        public bool InsertAndroidDetailData()
        {
            tbl_androidspec specitem = db.tbl_androidspecs
                .Where(m => m.deleted == 0)
                .OrderByDescending(m => m.uid)
                .FirstOrDefault();

            if (specitem != null)
            {
                tbl_androiddetail newdetail = new tbl_androiddetail();
                
                newdetail.specid = specitem.uid;
                newdetail.userid = specitem.user_id;
                newdetail.isdefshow = 0;
                newdetail.imgurl1 = "";

                db.tbl_androiddetails.InsertOnSubmit(newdetail);

                db.SubmitChanges();

                InsertAndroidDetrelData();

                return true;
            }

            return false;
        }

        public bool InsertAndroidDetrelData()
        {
            tbl_androiddetail detailitem = db.tbl_androiddetails
                .Where(m => m.deleted == 0)
                .OrderByDescending(m => m.uid)
                .FirstOrDefault();

            if (detailitem != null)
            {
                tbl_androiddetrel newdetrel = new tbl_androiddetrel();

                newdetrel.detailid = detailitem.uid;
                newdetrel.minpixcnt = 0;
                newdetrel.deleted = 0;

                db.tbl_androiddetrels.InsertOnSubmit(newdetrel);

                db.SubmitChanges();
                return true;
            }

            return false;
        }



        public bool CheckBrandAuthority(long id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();

            if (usertype == "lobby")
            {
                tbl_androidbrand item = db.tbl_androidbrands
                    .Where(m => m.deleted == 0 && m.uid == id)
                    .FirstOrDefault();

                if (item != null && item.user_id == user_id)
                    return true;
                else
                    return false;
            }

            return true;
        }

        public bool CheckSpecAuthority(long id)
        {
            string usertype = CommonModel.GetCurrentUserType();
            long user_id = CommonModel.GetCurrentUserId();

            if (usertype == "lobby")
            {
                tbl_androidspec item = db.tbl_androidspecs
                    .Where(m => m.deleted == 0 && m.uid == id)
                    .FirstOrDefault();

                if (item != null && item.user_id == user_id)
                    return true;
                else
                    return false;
            }

            return true;
        }

        public static string GetImageByDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string image = "--无图片--";
            if (item != null)
                image = item.imgurl1;
            if (image.Length == 0)
                image = "--无图片--";

            return image;
        }

        public static string GetPriceByDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string price = "";
            if (item != null)
                price = Convert.ToString(item.recommprice);

            return price;
        }

        public static string GetSizeByDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string size = "";
            if (item != null)
                size = item.screenshowsize;

            return size;
        }

        public static string GetCPUByDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string cpu = "";
            if (item != null)
                cpu = item.showcpu;

            return cpu;
        }

        public static string GetMemByDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string mem = "";
            if (item != null)
                mem = item.memshowsize;

            return mem;
        }

        public static string GetPixelCntByDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string pixel = "";
            if (item != null)
                pixel = item.pixshowcnt;

            return pixel;
        }

        public static string GetOSVerByDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string os = "";
            if (item != null)
                os = item.osshowver;

            return os;
        }

        public static string GetDetailId(long uid)
        {
            YingytDBDataContext db = new YingytDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string id = "";
            if (item != null)
                id = Convert.ToString(item.uid);

            return id;
        }

    }
}