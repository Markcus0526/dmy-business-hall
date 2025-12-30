using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace YingytSite.Models
{
    #region Models
    public class StatisticsDailyInfo
    {
        public double date { get; set; }
        public int count { get; set; }
    }

    public class StatisticsMonthlyInfo
    {
        //public int month { get; set; }
        public double date { get; set; }
        public int count { get; set; }
    }

    public class PhonereadInfo
    {
        public long uid { get; set; }
        public DateTime regtime { get; set; }
        public long spec_id { get; set; }
    }
    #endregion

    public class PhonereadModel
    {
        YingytDBDataContext db = new YingytDBDataContext();

        public List<StatisticsMonthlyInfo> GetMonthlyStatisticsList(long brand_id, long spec_id, DateTime startdate, DateTime enddate)
        {
            List<StatisticsMonthlyInfo> retList = new List<StatisticsMonthlyInfo>();

            List<PhonereadInfo> list = GetPhonereadListByBrandAndSpec(brand_id, spec_id);

            double inc = (new DateTime(1970, 1, 2, 0, 0, 0) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;

            DateTime origin = new DateTime(1970, 1, 1, 0, 0, 0);
            for (DateTime cur = startdate/*new DateTime(startdate.Year, startdate.Month, 1)*/; cur <= enddate.Date; cur = cur.AddMonths(1))
            {
                retList.Add(new StatisticsMonthlyInfo
                {
                    date = cur.Subtract(origin).TotalMilliseconds + inc,
                    count = list.Where(p => p.regtime.Year == cur.Year && p.regtime.Month == cur.Month).Count()
                });
            }

            //DateTime now = DateTime.Today;
            //for (int i = 1; i <= 12; i++)
            //{
            //    retList.Add(new StatisticsMonthlyInfo
            //    {
            //        month = i,
            //        count = list.Where(p => p.regtime.Year == now.Year && p.regtime.Month == i).Count()
            //    });
            //}

            return retList;
        }

        public List<StatisticsDailyInfo> GetDailyStatisticsList(long brand_id, long spec_id, DateTime startdate, DateTime enddate)
        {
            List<StatisticsDailyInfo> retList = new List<StatisticsDailyInfo>();

            List<PhonereadInfo> list = GetPhonereadListByBrandAndSpec(brand_id, spec_id);

            double inc = (new DateTime(1970, 1, 2, 0, 0, 0) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;

            DateTime origin = new DateTime(1970, 1, 1, 0, 0, 0);
            for (DateTime cur = startdate.Date; cur <= enddate.Date; cur = cur.AddDays(1) )
            {
                retList.Add(new StatisticsDailyInfo
                {
                    date = cur.Subtract(origin).TotalMilliseconds + inc,
                    count = list.Where(p => p.regtime.Date == cur).Count()
                });
            }

            return retList;
        }

        public List<PhonereadInfo> GetPhonereadListByBrandAndSpec(long brand_id, long spec_id)
        {
            List<PhonereadInfo> retlist = null;

            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                retlist = (from m in db.tbl_phonereads
                           where m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id/*m.parentid == parentid*/) &&
                            (brand_id == 0 || (brand_id != 0 && (m.brand_id == brand_id && (spec_id == 0 || (spec_id != 0 && (m.spec_id == spec_id))))))
                           select new PhonereadInfo
                           {
                               uid = m.uid,
                               regtime = m.read_date,
                               spec_id = m.spec_id
                           }).ToList();
            }
            else
            {
                retlist = (from m in db.tbl_phonereads
                           where m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) &&
                            (brand_id == 0 || (brand_id != 0 && (m.brand_id == brand_id && (spec_id == 0 || (spec_id != 0 && (m.spec_id == spec_id))))))
                           select new PhonereadInfo
                           {
                               uid = m.uid,
                               regtime = m.read_date,
                               spec_id = m.spec_id
                           }).ToList();
            }
            
            //List<long> userlist = new List<long>();
            //long user_id = CommonModel.GetCurrentUserId();
            //string usertype = CommonModel.GetCurrentUserType();
            //userlist.Add(user_id);
            //if (usertype == "agent")
            //    userlist = userlist.Union(AgentModel.GetChildHallIdList()).ToList();

            //var list1 = (from m in db.tbl_phonereads.ToList()
            //             from l in userlist
            //             where m.deleted == 0 && m.user_id == l
            //             select new
            //             {
            //                 uid = m.uid,
            //                 regtime = m.read_date,
            //                 spec_id = m.spec_id
            //             }).ToList()
            //        .GroupBy(m => m.uid)
            //        .Select(g => new PhonereadInfo
            //        {
            //            uid = g.Key,
            //            regtime = g.Select(l => l.regtime).FirstOrDefault(),
            //            spec_id = g.Select(l => l.spec_id).FirstOrDefault()
            //        }).ToList();
            //List<PhonereadInfo> retlist = null;
            //if (brand_id == 0)
            //{
            //    retlist = list1;
            //}
            //else if (spec_id == 0)
            //{
            //    retlist = (from m in db.tbl_androidspecs
            //            from l in list1
            //            where m.deleted == 0 && m.uid == l.spec_id && m.brandid == brand_id
            //            select new
            //            {
            //                uid = l.uid,
            //                regtime = l.regtime,
            //                spec_id = l.spec_id,
            //                brand_id = m.brandid
            //            }).ToList()
            //                .GroupBy(m => m.uid)
            //                .Select(g => new PhonereadInfo
            //                {
            //                    uid = g.Key,
            //                    regtime = g.Select(l => l.regtime).FirstOrDefault(),
            //                    spec_id = g.Select(l => l.spec_id).FirstOrDefault()
            //                }).ToList();
            //}
            //else
            //{
            //    retlist = (from m in list1
            //            where m.spec_id == spec_id
            //            select m).ToList();
            //}

            return retlist;
        }

        public static List<VisitInfo> GetBest5VisitList()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            var visitList = db.tbl_phonereads
                .Where(m => m.deleted == 0)
                .GroupBy(m => m.user_id)
                .Select(g => new
                {
                    user_id = g.Select(l => l.user_id).FirstOrDefault(),
                    spec_id = g.Select(l => l.spec_id).FirstOrDefault(),
                    count = g.Count()
                }).OrderByDescending(m => m.count)
                .ToList();

            var retlist = (from m in visitList
                           from l in db.tbl_users
                           where m.user_id == l.uid && l.deleted == 0
                           orderby m.count descending
                           select new VisitInfo
                           {
                               hallname = AgentModel.GetAgentName(m.user_id),
                               address = RegionModel.GetFullAddress(l.addrid, l.addr),
                               visitcount = m.count
                           }).Take(5).ToList();

            return retlist;
        }

        public static long GetVisitTotalCount()
        {
            YingytDBDataContext db = new YingytDBDataContext();

            return db.tbl_phonereads
                .Where(m => m.deleted == 0)
                .Count();
        }
    }
}
