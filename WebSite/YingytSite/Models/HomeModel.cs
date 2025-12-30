using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace YingytSite.Models
{
    #region Modesl
    public class NewsTipInfo
    {
        public long uid { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public string coverimg { get; set; }
        public DateTime createtime { get; set; }
        public string beforetime { get; set; }
    }
    #endregion

    public class HomeModel
    {
        static YingytDBDataContext db = new YingytDBDataContext();

        public List<NewsTipInfo> GetTopNotice()
        {
            List<NewsTipInfo> rst = new List<NewsTipInfo>();

            string usertype = CommonModel.GetCurrentUserType();
            byte cateid = (byte)(usertype == "agent" ? 2 : 3);
            long user_id = CommonModel.GetCurrentUserId();

            var newslist = db.tbl_sysnews
                .Where(m => m.enabled == 1 && m.deleted == 0 && (m.cateid == 1 || m.cateid == cateid))
                .OrderByDescending(m => m.uid)
                .ToList();

            foreach(tbl_sysnew item in newslist ) {
                if (item.rangeid == "0")
                {
                    rst.Add(new NewsTipInfo
                    {
                        uid = item.uid,
                        title = CommonModel.han_cut(item.title, 20),
                        description = CommonModel.han_cut(item.contents, 50),
                        beforetime = CommonModel.GetTimeDiffFromNow(item.createtime)
                    });
                }
                else
                {
                    long[] rangeids = item.rangeid.Split(',')
                        .Where(m => !String.IsNullOrWhiteSpace(m))
                        .Select(m => long.Parse(m))
                        .ToArray();

                    var found = rangeids.Where(m => m == user_id).ToList();
                    if (found != null && found.Count() > 0)
                    {
                        rst.Add(new NewsTipInfo
                        {
                            uid = item.uid,
                            title = CommonModel.han_cut(item.title, 20),
                            description = CommonModel.han_cut(item.contents, 50),
                            beforetime = CommonModel.GetTimeDiffFromNow(item.createtime)
                        });
                    }                    
                }
            }

            //if (newslist != null && newslist.Count() > 0)
            //{
            //    foreach (var item in newslist)
            //    {
            //        if (!String.IsNullOrEmpty(item.coverimg))
            //        {
            //            if (item.coverimg.First() == '/')
            //            {
            //                item.coverimg = item.coverimg.Substring(1);
            //            }
            //        }
            //    }
            //    rst = newslist;
            //}

            return rst;
        }

        public tbl_sysnew GetNoticeInfo(long id)
        {
            var rst = db.tbl_sysnews
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();

            //if (rst != null)
            //{
            //    if (!String.IsNullOrEmpty(rst.coverimg))
            //    {
            //        if (rst.coverimg.First() == '/')
            //        {
            //            rst.coverimg = rst.coverimg.Substring(1);
            //        }
            //    }
            //}

            return rst;
        }
    }
}