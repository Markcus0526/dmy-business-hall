using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;
using System.IO;

namespace YingytSite.Models
{
    public class ImageInfo
    {
        public long uid { get; set; }
        public long user_id { get; set; }
        public string title { get; set; }
        public string filename { get; set; }
        public long filesize { get; set; }
        public long parentid { get; set; }
        public string path { get; set; }
    }

    public class UploadFileInfo
    {
        public string filename { get; set; }
        public long filesize { get; set; }
        public string path { get; set; }
    }

    public class ImageModel
    {
        static YingytDBDataContext db = new YingytDBDataContext();

        #region CRUD
        public List<ImageInfo> GetImageList()
        {
            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                return db.tbl_photos
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id/*m.parentid == parentid*/))
                    .OrderByDescending(m => m.uid)
                    .Select(m => new ImageInfo
                    {
                        uid = m.uid,
                        user_id = m.user_id,
                        title = m.title,
                        filename = m.filename,
                        filesize = m.filesize,
                        parentid = m.parentid,
                        path = m.path
                    })
                    .ToList();
            }
            else
            {
                return db.tbl_photos
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id))
                    .OrderByDescending(m => m.uid)
                    .Select(m => new ImageInfo
                    {
                        uid = m.uid,
                        user_id = m.user_id,
                        title = m.title,
                        filename = m.filename,
                        filesize = m.filesize,
                        parentid = m.parentid,
                        path = m.path
                    })
                    .ToList();
            }
        }

        public JqDataTableInfo GetImageDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<ImageInfo> filteredCompanies;

            List<ImageInfo> alllist = GetImageList();

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
            Func<ImageInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.title :
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
            long userid = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid),
                Convert.ToString(c.path),
                c.title,
                CommonModel.GetFileSizeString(c.filesize),
                (c.user_id == userid) ? "我的图片":AgentModel.GetAgentName(c.user_id),
                Convert.ToString(c.uid),
                Convert.ToString(c.path),
                (usertype == "agent" || c.user_id == userid) ? "1" : "0"
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool DeleteImage(long[] items)
        {
            string delSql = "UPDATE tbl_photo SET deleted = 1 WHERE ";
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

        public tbl_photo GetImageById(long uid)
        {
            return db.tbl_photos
               .Where(m => m.deleted == 0 && m.uid == uid)
               .FirstOrDefault();
        }

        public static string GetImagePathById(long uid)
        {
            if (uid == 0)
                return "--无图片--";

            tbl_photo item = db.tbl_photos
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.path;
            else
                return "--图片不存在--";
        }

        public static string GetImageTitleById(long uid)
        {
            tbl_photo item = db.tbl_photos
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.title;
            else
                return "--图片不存在--";
        }

        public string InsertImage(string title, string filename, long filesize, string path)
        {
            tbl_photo newphoto = new tbl_photo();

            newphoto.user_id = CommonModel.GetCurrentUserId();
            newphoto.title = title;
            newphoto.filename = filename;
            newphoto.filesize = filesize;
            newphoto.path = path;
            long user_id = CommonModel.GetCurrentUserId();
            newphoto.user_id = user_id;
            newphoto.parentid = AgentModel.GetAgentParentid(user_id);

            db.tbl_photos.InsertOnSubmit(newphoto);

            db.SubmitChanges();

            return "";
        }

        public string UpdateImage(long uid, string title, string filename, long filesize, string path)
        {
            string rst = "";
            tbl_photo edititem = GetImageById(uid);

            if (edititem != null)
            {
                //edititem.user_id = CommonModel.GetCurrentUserId();
                edititem.title = title;
                edititem.filename = filename;
                edititem.filesize = filesize;
                edititem.path = path;
                //long user_id = CommonModel.GetCurrentUserId();
                //edititem.user_id = user_id;
                //edititem.parentid = AgentModel.GetAgentParentid(user_id);

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "图片不存在";
            }

            return rst;
        }

        public static bool CheckDuplicateName(long iid, string title)
        {
            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            bool rst = true;
            if (usertype == "lobby" && allowShare == 1)
            {
                rst = ((from m in db.tbl_photos
                        where m.deleted == 0 && m.title == title && m.uid != iid && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id)
                        select m).FirstOrDefault() == null);
            }
            else
            {
                rst = ((from m in db.tbl_photos
                        where m.deleted == 0 && m.title == title && m.uid != iid && m.user_id == user_id
                        select m).FirstOrDefault() == null);
            }

            return rst;
        }

        public static NestableImgInfo GetNestableImgInfo(long androiddata_id, long id)
        {
            var item = db.tbl_androiddatalists
                .Where(m => m.deleted == 0 && m.androiddata_id == androiddata_id && m.data_id == id)
                .FirstOrDefault();

            if (item == null)
            {
                var imageitem = (from m in  db.tbl_photos
                    where m.deleted == 0 && m.uid == id
                        select m).FirstOrDefault();

                return new NestableImgInfo
                    {
                        uid = imageitem.uid,
                        imgurl = imageitem.path,
                        title = imageitem.title,
                        description = "文件名称: " + imageitem.filename + "\n文件大小: " + CommonModel.GetFileSizeString(imageitem.filesize)
                    };
            }
            else
                return null;

        }

        public static List<NestableImgInfo> GetNestableImgList(long androiddata_id, long[] items)
        {
            List<NestableImgInfo> retlist = new List<NestableImgInfo>();
            for (int i = 0; i < items.Length; i++)
            {
                NestableImgInfo imginfo = GetNestableImgInfo(androiddata_id, items[i]);
                if (imginfo != null)
                    retlist.Add(imginfo);
            }

            return retlist;
        }

        public List<NestableImgInfo> InsertAndGetNestableImgInfo(List<UploadFileInfo> filelist)
        {
            List<NestableImgInfo> retlist = new List<NestableImgInfo>();
            long lastid = GetLastInsertedId();
            for (int i = 0; i < filelist.Count(); i++)
            {
                UploadFileInfo item = filelist.ElementAt(i);
                InsertImage("M" + lastid + "_" + Path.GetFileNameWithoutExtension(item.filename),
                    item.filename, item.filesize, item.path);
                lastid = GetLastInsertedId();

                retlist.Add(GetNestableImgInfo(0, lastid));
            }

            return retlist;
        }

        public static string GetImageDescriptionById(long id)
        {
            tbl_photo item = db.tbl_photos
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();

            if (item != null)
                return "文件名称: " + item.filename + "\n文件大小: " + CommonModel.GetFileSizeString(item.filesize);
            else
                return "";
        }

        public long GetLastInsertedId()
        {
            return db.tbl_photos
                .Where(m => m.deleted == 0)
                .OrderByDescending(m => m.uid)
                .FirstOrDefault()
                .uid;
        }

        #endregion
    }
}