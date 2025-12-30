using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;
using System.Configuration;

namespace YYTService
{
	[DataContract]
	public class STResult
	{
		int retcode = 0;
		[DataMember(Name = "RETCODE", Order = 1)]
		public int RETCODE
		{
			get { return retcode; }
			set { retcode = value; }
		}


		string msg = string.Empty;
		[DataMember(Name = "RETMSG", Order = 2)]
		public string RETMSG
		{
			get { return msg; }
			set { msg = value; }
		}


		object data = string.Empty;
		[DataMember(Name = "RETDATA", Order = 3)]
		public object RETDATA
		{
			get { return data; }
			set { data = value; }
		}
	}

	[DataContract]
	public class STRegion
	{
		long uid = 0;
		[DataMember(Name = "uid")]
		public long Uid
		{
			get { return uid; }
			set { uid = value; }
		}

		string name = string.Empty;
		[DataMember(Name = "name")]
		public string Name
		{
			get { return name; }
			set { name = value; }
		}

		object subAreas = string.Empty;
		[DataMember(Name = "subareas")]
		public object SubAreas
		{
			get { return subAreas; }
			set { subAreas = value; }
		}
	}

	[DataContract]
	public class STShop
	{
		long uid = 0;
		[DataMember(Name = "uid")]
		public long Uid
		{
			get { return uid; }
			set { uid = value; }
		}

		long regionid = 0;
		[DataMember(Name = "regionid")]
		public long Regionid
		{
			get { return regionid; }
			set { regionid = value; }
		}

		string shopname = string.Empty;
		[DataMember(Name = "shopname")]
		public string ShopName
		{
			get { return shopname; }
			set { shopname = value; }
		}
	}

    [DataContract]
    public class STBrand
    {
        long uid = 0;
        [DataMember(Name = "uid")]
        public long Uid
        {
            get { return uid; }
            set { uid = value; }
        }

        string name = string.Empty;
        [DataMember(Name = "name")]
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
    }

    [DataContract]
    public class STSpec
    {
        long uid = 0;
        [DataMember(Name = "uid")]
        public long Uid
        {
            get { return uid; }
            set { uid = value; }
        }

        string name = string.Empty;
        [DataMember(Name = "name")]
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
    }

    [DataContract]
    public class STBndSpcInfo
    {
        long brandid = 0;
        [DataMember(Name = "brandid")]
        public long BrandId
        {
            get { return brandid; }
            set { brandid = value; }
        }

        long specid = 0;
        [DataMember(Name = "specid")]
        public long SpecId
        {
            get { return specid; }
            set { specid = value; }
        }

        string title = string.Empty;
        [DataMember(Name = "title")]
        public string Title
        {
            get { return title; }
            set { title = value; }
        }
    }

    [DataContract]
    public class STDetailInfo
    {
        long uid = 0;
        [DataMember(Name = "uid")]
        public long Uid
        {
            get { return uid; }
            set { uid = value; }
        }

        string imgpath = string.Empty;
        [DataMember(Name = "imgpath")]
        public string ImgPath
        {
            get { return imgpath; }
            set { imgpath = value; }
        }

        string name = string.Empty;
        [DataMember(Name = "name")]
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        double price = 0;
        [DataMember(Name = "price")]
        public double Price
        {
            get { return price; }
            set { price = value; }
        }

        string cpu = string.Empty;
        [DataMember(Name = "cpu")]
        public string Cpu
        {
            get { return cpu; }
            set { cpu = value; }
        }

        string dispsize = string.Empty;
        [DataMember(Name = "dispsize")]
        public string DispSize
        {
            get { return dispsize; }
            set { dispsize = value; }
        }       

        string pixcnt = string.Empty;
        [DataMember(Name = "pixcnt")]
        public string PixCnt
        {
            get { return pixcnt; }
            set { pixcnt = value; }
        }

        string osver = string.Empty;
        [DataMember(Name = "osver")]
        public string OsVer
        {
            get { return osver; }
            set { osver = value; }
        }

        string memsize = string.Empty;
        [DataMember(Name = "memsize")]
        public string MemSize
        {
            get { return memsize; }
            set { memsize = value; }
        }
    }

    [DataContract]
    public class STGift
    {
        string onegift = string.Empty;
        [DataMember(Name = "onegift")]
        public string OneGift
        {
            get { return onegift; }
            set { onegift = value; }
        }

        string twogift = string.Empty;
        [DataMember(Name = "twogift")]
        public string TwoGift
        {
            get { return twogift; }
            set { twogift = value; }
        }

        string threegift = string.Empty;
        [DataMember(Name = "threegift")]
        public string ThreeGift
        {
            get { return threegift; }
            set { threegift = value; }
        }

        string fourgift = string.Empty;
        [DataMember(Name = "fourgift")]
        public string FourGift
        {
            get { return fourgift; }
            set { fourgift = value; }
        }

        string fivegift = string.Empty;
        [DataMember(Name = "fivegift")]
        public string FiveGift
        {
            get { return fivegift; }
            set { fivegift = value; }
        }

        string sixgift = string.Empty;
        [DataMember(Name = "sixgift")]
        public string SixGift
        {
            get { return sixgift; }
            set { sixgift = value; }
        }

        string pass = string.Empty;
        [DataMember(Name = "pass")]
        public string Pass
        {
            get { return pass; }
            set { pass = value; }
        }

        long isused = 0;
        [DataMember(Name = "isused")]
        public long IsUsed
        {
            get { return isused; }
            set { isused = value; }
        }
    }

    [DataContract]
    public class STSNCode
    {
        long rank = -1;
        [DataMember(Name = "rank")]
        public long Rank
        {
            get { return rank; }
            set { rank = value; }
        }

        string snnum = string.Empty;
        [DataMember(Name = "snnum")]
        public string SNNum
        {
            get { return snnum; }
            set { snnum = value; }
        }
    }

	public class DBMgr
	{
        public static int ITEM_COUNT = 6;

        public static long GetAgentParentid(long id)
        {
            YYTDBDataContext db = new YYTDBDataContext();

            tbl_user item = (from m in db.tbl_users
                             where m.deleted == 0 && m.uid == id
                             select m).FirstOrDefault();

            if (item != null)
                return item.parentid;
            else
                return 0;
        }

        public static byte GetAgentAllowshare(long id)
        {
            YYTDBDataContext db = new YYTDBDataContext();

            tbl_user item = db.tbl_users
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();
            if (item != null)
                return item.allowshare;
            else
                return 0;
        }

        public static tbl_androidspec GetSpecById(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();

            return db.tbl_androidspecs
                .Where(m => m.uid == uid && m.deleted == 0)
                .OrderBy(m => m.sortid)
                .FirstOrDefault();
        }

        public static tbl_photo GetImgPathById(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();

            return db.tbl_photos
                .Where(m => m.uid == uid && m.deleted == 0)
                .FirstOrDefault();
        }

        public static tbl_video GetVideoPathById(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();

            return db.tbl_videos
                .Where(m => m.uid == uid && m.deleted == 0)
                .FirstOrDefault();
        }

		public static STResult getShopList()
		{
			STResult result = new STResult();

			try
			{
				YYTDBDataContext db = new YYTDBDataContext();
				STRegion[] arrRegions = (from m in db.tbl_ecsregions
													where m.regiontype == 1
													select new STRegion
													{
														Uid = m.uid,
														Name = m.regionname,
														SubAreas = (from n in db.tbl_ecsregions
																	where n.regiontype == 2 && n.parentid == m.uid
																	select new STRegion
																	{
																		Uid = n.uid,
																		Name = n.regionname,
																		SubAreas = (from k in db.tbl_ecsregions
																					where k.regiontype == 3 && k.parentid == n.uid
																					select new STRegion
																					{
																						Uid = k.uid,
																						Name = k.regionname,
																						SubAreas = string.Empty
																					}).ToArray()
																	}).ToArray(),
													}).ToArray();

				STShop[] arrShops = (from m in db.tbl_users
									 where m.deleted == 0 && m.addrid != 0 && m.addrid != null
									 select new STShop
									 {
										 Uid = m.uid,
										 Regionid = m.addrid,
										 ShopName = m.username
									 }).ToArray();

				Dictionary<string, object> retdata = new Dictionary<string, object>();
				retdata.Add("Regions", arrRegions);
				retdata.Add("Shops", arrShops);

				result.RETDATA = retdata;
			}
			catch (Exception ex)
			{
				Global.logMessage(ex.Message);
			}

			return result;
		}

        public static STResult getBrandList(string uid)
        {
            STResult result = new STResult();

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();
                long userid = long.Parse(uid);

                STBrand[] arrBrands = (from m in db.tbl_androidbrands
                                       where m.deleted == 0 && m.user_id == userid
                                       select new STBrand
                                     {
                                         Uid = m.uid,
                                         Name = m.brandname
                                     }).ToArray();
                
                result.RETDATA = arrBrands;
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
            }

            return result;
        }

        public static STResult getSpecList(string uid, string brandid)
        {
            STResult result = new STResult();

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();
                long userid = long.Parse(uid);
                long brand_id = long.Parse(brandid);

                STSpec[] arrSpecs = (from m in db.tbl_androidspecs
                                       where m.deleted == 0 && m.user_id == userid && m.brandid == brand_id
                                     select new STSpec
                                       {
                                           Uid = m.uid,
                                           Name = m.specvalue
                                       }).ToArray();

                result.RETDATA = arrSpecs;
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
            }

            return result;
        }

        public static STResult getDetInfoList(string uid, string brandid, string specid, string minprice, string maxprice)
        {
            STResult result = new STResult();
            long userid = long.Parse(uid);
            long brand_id = long.Parse(brandid);
            long spec_id = long.Parse(specid);
            Decimal min_price = Convert.ToDecimal(minprice);
            Decimal max_price = Convert.ToDecimal(maxprice);

            YYTDBDataContext db = new YYTDBDataContext();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];
            List<STDetailInfo> arrDetailInfos = new List<STDetailInfo>();

            List<tbl_androiddetail> arrDetails = (from m in db.tbl_androiddetails
                                            where m.deleted == 0 && m.userid == userid && m.specid == spec_id
                                            select m).ToList();

            if (arrDetails != null && arrDetails.Count > 0)
            {
                foreach (tbl_androiddetail item in arrDetails)
                {
                    tbl_androiddetrel detRel = (from n in db.tbl_androiddetrels
                                                where n.deleted == 0 && n.detailid == item.uid
                                                select n).FirstOrDefault();
                    if (detRel != null)
                    {
                        if (detRel.minprice <= min_price && max_price <= detRel.maxprice)
                        {
                            STDetailInfo newInfo = new STDetailInfo();

                            newInfo.Uid = item.uid;
                            newInfo.ImgPath = strBaseURL + item.imgurl1;
                            newInfo.Name = item.title;
                            newInfo.OsVer = item.osshowver;
                            newInfo.PixCnt = item.pixshowcnt;
                            try
                            {
                                newInfo.Price = Convert.ToDouble(item.recommprice);
                            }
                            catch (System.Exception ex)
                            {
                                Global.logMessage(ex.Message);
                                newInfo.Price = 0.0f;
                            }
                            newInfo.Cpu = item.showcpu;
                            newInfo.DispSize = item.screenshowsize;
                            newInfo.MemSize = item.memshowsize;

                            arrDetailInfos.Add(newInfo);
                        }
                    }
                }
            }
            else
                arrDetailInfos = null;

            result.RETDATA = arrDetailInfos;

            return result;
        }

        public static bool InsertAndroidDetailData()
        {
            YYTDBDataContext db = new YYTDBDataContext();

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

        public static bool InsertAndroidDetrelData()
        {
            YYTDBDataContext db = new YYTDBDataContext();

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

        public static STResult getBndSpcID(string uid, string name, string specname, string width, string height)
        {
            STResult result = new STResult();
            STBndSpcInfo bndspec = new STBndSpcInfo();
            YYTDBDataContext db = new YYTDBDataContext();

            long userid = long.Parse(uid);
            long parentid = GetAgentParentid(long.Parse(uid));
            byte allowShare = GetAgentAllowshare(parentid);
            long share_id = GetAgentShareLobbyId(parentid);

            string strTitle = (from o in db.tbl_users
                               where o.deleted == 0 && o.uid == long.Parse(uid)
                               select o.username).FirstOrDefault();

            try
            {
                tbl_androidbrand brand = new tbl_androidbrand();
                if (allowShare == 1)
                {
                    brand = (from m in db.tbl_androidbrands
                             where m.deleted == 0 && m.brandname == name && (m.user_id == userid || m.user_id == parentid || m.user_id == share_id)
                               select m).FirstOrDefault();
//                     brand = (from m in db.tbl_androidbrands
//                              where m.deleted == 0 && m.user_id == userid && m.brandname.Equals(name) == true
//                              select m).FirstOrDefault();
                }
                else
                {
                    brand = (from m in db.tbl_androidbrands
                             where m.deleted == 0 && m.brandname == name && (m.user_id == userid || m.parentid == userid)
                            select m).FirstOrDefault();
                }                
                if (brand != null)
                {
                    bndspec.BrandId = brand.uid;

                    tbl_androidspec spec = new tbl_androidspec();
                    if (allowShare == 1)
                    {
                        spec = (from m in db.tbl_androidspecs
                                where m.deleted == 0 && (m.user_id == userid || m.user_id == parentid || m.user_id == share_id) && m.brandid == brand.uid && m.specvalue.Equals(specname) == true
                                select m).FirstOrDefault();
                    }
                    else
                    {
                        spec = (from m in db.tbl_androidspecs
                                where m.deleted == 0 && (m.user_id == userid || m.parentid == userid) && m.brandid == brand.uid && m.specvalue.Equals(specname) == true
                                select m).FirstOrDefault();
                    }

//                     tbl_androidspec spec = (from m in db.tbl_androidspecs
//                                             where m.deleted == 0 && m.user_id == userid && m.brandid == brand.uid && m.specvalue.Equals(specname) == true
//                                             select m).FirstOrDefault();

                    if (spec != null)
                    {
                        bndspec.SpecId = spec.uid;                        
                    }
                    else
                    {
                        tbl_androidspec newSpec = new tbl_androidspec();
                        newSpec.brandid = brand.uid;
                        newSpec.specvalue = specname;
                        newSpec.sortid = 1;
                        newSpec.scrwidth = int.Parse(width);
                        newSpec.scrheight = int.Parse(height);
                        newSpec.user_id = userid;
                        newSpec.parentid = parentid;
                        newSpec.deleted = 0;
                        db.tbl_androidspecs.InsertOnSubmit(newSpec);
                        db.SubmitChanges();
                                              

                        tbl_androidspec insertedspec = (from m in db.tbl_androidspecs
                                                        where m.deleted == 0 && m.user_id == userid && m.brandid == brand.uid && m.specvalue.Equals(specname) == true && m.parentid == parentid
                                                        select m).FirstOrDefault();
                        for (byte type = 0; type < 5; type++)
                        {
                            tbl_androiddata newitem = new tbl_androiddata();
                            newitem.android_id = insertedspec.uid;
                            newitem.user_id = insertedspec.user_id;
                            newitem.parentid = insertedspec.parentid;
                            newitem.datatype = type;

                            db.tbl_androiddatas.InsertOnSubmit(newitem);
                        }
                        db.SubmitChanges();

                        InsertAndroidDetailData();
                        
                        bndspec.SpecId = insertedspec.uid;
                    }
                }
                else
                {
                    tbl_androidbrand newBrand = new tbl_androidbrand();
                    newBrand.brandname = name;
                    newBrand.note = string.Empty;
                    newBrand.sortid = 1;
                    newBrand.createtime = DateTime.Now;
                    newBrand.deleted = 0;
                    newBrand.user_id = userid;
                    newBrand.parentid = parentid;

                    db.tbl_androidbrands.InsertOnSubmit(newBrand);
                    db.SubmitChanges();

                    long insertBrandID = 0;
                    tbl_androidbrand insertedbrand = (from m in db.tbl_androidbrands
                                                      where m.deleted == 0 && m.user_id == userid && m.brandname.Equals(name) == true && m.parentid == parentid
                                                      select m).FirstOrDefault();
                    insertBrandID = insertedbrand.uid;

                    tbl_androidspec newSpec = new tbl_androidspec();
                    newSpec.brandid = insertBrandID;
                    newSpec.specvalue = specname;
                    newSpec.sortid = 1;
                    newSpec.user_id = userid;
                    newSpec.parentid = parentid; 
                    newSpec.scrwidth = int.Parse(width);
                    newSpec.scrheight = int.Parse(height);
                    newSpec.deleted = 0;
                    db.tbl_androidspecs.InsertOnSubmit(newSpec);
                    db.SubmitChanges();

                    long insertSpecID = 0;
                    tbl_androidspec insertedspec = (from m in db.tbl_androidspecs
                                                    where m.deleted == 0 && m.user_id == userid && m.brandid == insertBrandID && m.specvalue.Equals(specname) == true && m.parentid == parentid
                                                    select m).FirstOrDefault();
                    insertSpecID = insertedspec.uid;

                    for (byte type = 0; type < 5; type++)
                    {
                        tbl_androiddata newitem = new tbl_androiddata();
                        newitem.android_id = insertedspec.uid;
                        newitem.user_id = insertedspec.user_id;
                        newitem.parentid = insertedspec.parentid;
                        newitem.datatype = type;

                        db.tbl_androiddatas.InsertOnSubmit(newitem);
                    }
                    db.SubmitChanges();

                    InsertAndroidDetailData();

                    bndspec.BrandId = insertBrandID;
                    bndspec.SpecId = insertSpecID;
                }

                // add tbl_phoneread RCJ 2015.02.02

                tbl_phoneread newRead = new tbl_phoneread();
                newRead.user_id = userid;
                newRead.parentid = parentid;
                newRead.brand_id = bndspec.BrandId;
                newRead.spec_id = bndspec.SpecId;
                newRead.read_date = DateTime.Now;
                newRead.deleted = 0;
                db.tbl_phonereads.InsertOnSubmit(newRead);
                db.SubmitChanges();
            }
            catch (System.Exception ex)
            {
                Global.logMessage(ex.Message);
                bndspec = new STBndSpcInfo();
            }

            bndspec.Title = strTitle;
            result.RETDATA = bndspec;

            return result;
        }

        public static long GetAgentShareLobbyId(long id)
        {
            YYTDBDataContext db = new YYTDBDataContext();

            tbl_user item = db.tbl_users
                .Where(m => m.deleted == 0 && m.uid == id)
                .FirstOrDefault();
            if (item != null)
                return item.share_id;
            else
                return 0;
        }

        public static STResult getSplashImgPath(string uid, string brandid, string specid)
        {
            STResult result = new STResult();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();
                long userid = long.Parse(uid);
                long brand_id = long.Parse(brandid);
                long spec_id = long.Parse(specid);
                long parentid = GetAgentParentid(long.Parse(uid));
                byte allowShare = GetAgentAllowshare(parentid);
                long share_id = GetAgentShareLobbyId(parentid);

                List<tbl_androiddata> alllist = null;
                if (allowShare == 1)
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid || m.user_id == share_id) && m.android_id == spec_id && m.datatype == 1
                               orderby m.uid descending
                               select m).ToList();
                }
                else
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == userid || m.parentid == userid) && m.android_id == spec_id && m.datatype == 1
                               orderby m.uid descending
                               select m).ToList();
                }

                List<tbl_androiddata> filterlist = new List<tbl_androiddata>();
                if (brand_id > 0)
                {
                    foreach (tbl_androiddata item in alllist)
                    {
                        tbl_androidspec specitem = GetSpecById(item.android_id);
                        if (specitem != null && specitem.brandid == brand_id)
                            filterlist.Add(item);
                    }
                }

                if (filterlist != null && filterlist.Count > 0)
                {
                    tbl_photo photo = null;
                    if (filterlist[0].status == 1)
                        photo = GetImgPathById(filterlist[0].data_id);
                    else
                        photo = GetImgPathById(filterlist[0].lobbydata_id);

                    if (photo != null)
                        result.RETDATA = strBaseURL + photo.path;
                    else
                        result.RETDATA = string.Empty;
                }
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = string.Empty;
            }

            return result;
        }

        public static STResult getVideoPath(string uid, string brandid, string specid)
        {
            STResult result = new STResult();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();
                long userid = long.Parse(uid);
                long brand_id = long.Parse(brandid);
                long spec_id = long.Parse(specid);
                long parentid = GetAgentParentid(long.Parse(uid));
                byte allowShare = GetAgentAllowshare(parentid);
                long share_id = GetAgentShareLobbyId(parentid);

                List<tbl_androiddata> alllist = null;
                if (allowShare == 1)
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid || m.user_id == share_id) && m.android_id == spec_id && m.datatype == 0
                               orderby m.uid descending
                               select m).ToList();
                }
                else
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == userid || m.parentid == userid) && m.android_id == spec_id && m.datatype == 0
                               orderby m.uid descending
                               select m).ToList();
                }

                List<tbl_androiddata> filterlist = new List<tbl_androiddata>();
                if (brand_id > 0)
                {
                    foreach (tbl_androiddata item in alllist)
                    {
                        tbl_androidspec specitem = GetSpecById(item.android_id);
                        if (specitem != null && specitem.brandid == brand_id)
                            filterlist.Add(item);
                    }
                }

                if (filterlist != null && filterlist.Count > 0)
                {
                    tbl_video video = null;
                    if (filterlist[0].status == 1)
                        video = GetVideoPathById(filterlist[0].data_id);
                    else
                        video = GetVideoPathById(filterlist[0].lobbydata_id);

                    if (video != null)
                        result.RETDATA = strBaseURL + video.path;
                    else
                        result.RETDATA = string.Empty;
                }
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = string.Empty;
            }

            return result;
        }

        public static STResult getFirstPageImgPath(string uid, string brandid, string specid)
        {
            STResult result = new STResult();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();
                long userid = long.Parse(uid);
                long brand_id = long.Parse(brandid);
                long spec_id = long.Parse(specid);
                long parentid = GetAgentParentid(long.Parse(uid));
                byte allowShare = GetAgentAllowshare(parentid);
                long share_id = GetAgentShareLobbyId(parentid);

                List<tbl_androiddata> alllist = null;
                if (allowShare == 1)
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid || m.user_id == share_id) && m.android_id == spec_id && m.datatype == 2
                               orderby m.uid descending
                               select m).ToList();
                }
                else
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == userid || m.parentid == userid) && m.android_id == spec_id && m.datatype == 2
                               orderby m.uid descending
                               select m).ToList();
                }

                List<tbl_androiddata> filterlist = new List<tbl_androiddata>();
                if (brand_id > 0)
                {
                    foreach (tbl_androiddata item in alllist)
                    {
                        tbl_androidspec specitem = GetSpecById(item.android_id);
                        if (specitem != null && specitem.brandid == brand_id)
                            filterlist.Add(item);
                    }
                }

                if (filterlist != null && filterlist.Count > 0)
                {
                    tbl_photo photo = null;
                    if (filterlist[0].status == 1)
                        photo = GetImgPathById(filterlist[0].data_id);
                    else
                        photo = GetImgPathById(filterlist[0].lobbydata_id);

                    if (photo != null)
                        result.RETDATA = strBaseURL + photo.path;
                    else
                        result.RETDATA = string.Empty;
                }
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
                //result.RETDATA = string.Empty;
                result.RETDATA = ex.Message;
            }

            return result;
        }

        public class PathItem
        {
            public string imgPath = "";
        }
        public static STResult getBenefitList(string uid, string brandid, string specid)
        {
            YYTDBDataContext db = new YYTDBDataContext();
            STResult result = new STResult();
            List<PathItem> arrImgPath = new List<PathItem>();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];

            try
            {
                long userid = long.Parse(uid);
                long brand_id = long.Parse(brandid);
                long spec_id = long.Parse(specid);
                long parentid = GetAgentParentid(long.Parse(uid));
                byte allowShare = GetAgentAllowshare(parentid);
                long share_id = GetAgentShareLobbyId(parentid);

                List<tbl_androiddata> alllist = null;
                if (allowShare == 1)
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid || m.user_id == share_id) && m.android_id == spec_id && m.datatype == 3
                               orderby m.uid descending
                               select m).ToList();
                }
                else
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == userid || m.parentid == userid) && m.android_id == spec_id && m.datatype == 3
                               orderby m.uid descending
                               select m).ToList();
                }

                List<tbl_androiddatalist> filterlist = new List<tbl_androiddatalist>();
                if (alllist != null && alllist.Count > 0)
                {
                    foreach (tbl_androiddata item in alllist)
                    {
                        List<tbl_androiddatalist> filterTemplist = new List<tbl_androiddatalist>();
                        filterTemplist = (from m in db.tbl_androiddatalists
                                          orderby m.sortid ascending
                                          where m.deleted == 0 && m.androiddata_id == item.uid
                                          select m).ToList();
                        if (filterTemplist != null && filterTemplist.Count > 0)
                        {
                            for (int i = 0; i < filterTemplist.Count; i++)
                            {
                                filterlist.Add(filterTemplist[i]);
                            }
                        }
                    }
                }

                if (filterlist != null && filterlist.Count > 0)
                {
                    foreach (tbl_androiddatalist item in filterlist)
                    {
                        tbl_photo photo = null;
                        if (allowShare == 1)
                            photo = GetImgPathById(item.data_id);
                        else
                            photo = GetImgPathById(item.data_id);

                        if (photo != null)
                        {
                            PathItem newitem = new PathItem();
                            newitem.imgPath = strBaseURL + photo.path;
                            arrImgPath.Add(newitem);
                        }
                    }

                    //var oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    //result.RETDATA = oSerializer.Serialize(arrImgPath.ToArray()); ;//arrImgPath;
                    result.RETDATA = arrImgPath.ToArray();
                }
                else
                    result.RETDATA = null;
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = null;
            }

            return result;
        }

        public static STResult getSetList(string uid, string brandid, string specid)
        {
            YYTDBDataContext db = new YYTDBDataContext();
            STResult result = new STResult();
            List<PathItem> arrImgPath = new List<PathItem>();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];

            try
            {
                long userid = long.Parse(uid);
                long brand_id = long.Parse(brandid);
                long spec_id = long.Parse(specid);
                long parentid = GetAgentParentid(long.Parse(uid));
                byte allowShare = GetAgentAllowshare(parentid);
                long share_id = GetAgentShareLobbyId(parentid);

                List<tbl_androiddata> alllist = null;
                if (allowShare == 1)
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == parentid || m.parentid == parentid || m.user_id == share_id) && m.android_id == spec_id && m.datatype == 4
                               orderby m.uid descending
                               select m).ToList();
                }
                else
                {
                    alllist = (from m in db.tbl_androiddatas
                               where m.deleted == 0 && (m.user_id == userid || m.parentid == userid) && m.android_id == spec_id && m.datatype == 4
                               orderby m.uid descending
                               select m).ToList();
                }

                List<tbl_androiddatalist> filterlist = new List<tbl_androiddatalist>();
                if (alllist != null && alllist.Count > 0)
                {
                    foreach (tbl_androiddata item in alllist)
                    {
                        List<tbl_androiddatalist> filterTemplist = new List<tbl_androiddatalist>();
                        filterTemplist = (from m in db.tbl_androiddatalists
                                          orderby m.sortid ascending
                                          where m.deleted == 0 && m.androiddata_id == item.uid
                                          select m).ToList();
                        if (filterTemplist != null && filterTemplist.Count > 0)
                        {
                            for (int i = 0; i < filterTemplist.Count; i++)
                            {
                                filterlist.Add(filterTemplist[i]);
                            }
                        }
                    }
                }

                if (filterlist != null && filterlist.Count > 0)
                {
                    foreach (tbl_androiddatalist item in filterlist)
                    {
                        tbl_photo photo = null;
                        if (allowShare == 1)
                            photo = GetImgPathById(item.data_id);
                        else
                            photo = GetImgPathById(item.data_id);

                        if (photo != null)
                        {
                            PathItem newitem = new PathItem();
                            newitem.imgPath = strBaseURL + photo.path;
                            arrImgPath.Add(newitem);
                        }
                    }

                    //var oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    //result.RETDATA = oSerializer.Serialize(arrImgPath); ;//arrImgPath;
                    result.RETDATA = arrImgPath.ToArray();
                }
                else
                    result.RETDATA = null;
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = null;
            }

            return result;
        }

        public static string GetBrandNameBySpecId(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();

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

        public static string GetSpecNameById(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();

            tbl_androidspec item = db.tbl_androidspecs
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.specvalue;
            else
                return "";
        }

        public static string GetImageByDetailId(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string image = "";
            if (item != null)
                image = item.imgurl1;
            if (image.Length == 0)
                image = "";

            return image;
        }

        public static string GetPriceByDetailId(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string price = "0";
            if (item != null)
                price = Convert.ToString(item.recommprice);
            if (price != null && price.Length == 0)
                price = "0";

            return price;
        }

        public static string GetSizeByDetailId(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();
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
            YYTDBDataContext db = new YYTDBDataContext();
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
            YYTDBDataContext db = new YYTDBDataContext();
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
            YYTDBDataContext db = new YYTDBDataContext();
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
            YYTDBDataContext db = new YYTDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            string os = "";
            if (item != null)
                os = item.osshowver;

            return os;
        }

        public static List<YanshiInfo> GetPhoneDetailList(long lobby_id, long brand_id)
        {
            YYTDBDataContext db = new YYTDBDataContext();
            List<YanshiInfo> alllist = null;
            long parentid = GetAgentParentid(lobby_id);
            byte allowShare = GetAgentAllowshare(parentid);
            long share_id = GetAgentShareLobbyId(parentid);

            if (allowShare == 1)
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == lobby_id || m.user_id == parentid || m.user_id == share_id) && m.datatype == 3)
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
                        data_id = m.data.data.lobbydata_id,
                        status = m.data.data.status
                    })
                    .ToList();
            }
            else
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == lobby_id || m.parentid == lobby_id) && m.datatype == 3)
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
                        data_id = m.data.data.lobbydata_id,
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
                    tbl_androidspec specitem = GetSpecById(item.android_id);
                    if (specitem != null && specitem.brandid == brand_id)
                        filteredbrand.Add(item);
                }
            }
            else
                filteredbrand = alllist;
            
            return filteredbrand;
        }
        public static STResult getSameBrandList(string uid, string brandid, string specid)
        {
            YYTDBDataContext db = new YYTDBDataContext();
            STResult result = new STResult();
            List<STDetailInfo> arrDetailInfos = new List<STDetailInfo>();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];

            try
            {
                long userid = long.Parse(uid);
                long brand_id = long.Parse(brandid);
                long parentid = GetAgentParentid(long.Parse(uid));
                byte allowShare = GetAgentAllowshare(parentid);
                long share_id = GetAgentShareLobbyId(parentid);

                List<YanshiInfo> allData = GetPhoneDetailList(userid, brand_id);

                arrDetailInfos = (from c in allData
                         select new STDetailInfo {
                            Uid = c.android_id,
                            ImgPath = strBaseURL + GetImageByDetailId(c.android_id),
                            Name = GetSpecNameById(c.android_id),
                            Price = Double.Parse(GetPriceByDetailId(c.android_id)),
                            Cpu = GetCPUByDetailId(c.android_id),
                            DispSize = GetPixelCntByDetailId(c.android_id),
                            PixCnt = GetPixelCntByDetailId(c.android_id),
                            OsVer = GetOSVerByDetailId(c.android_id),
                            MemSize = GetMemByDetailId(c.android_id)
                        }).ToList();

                List<STDetailInfo> allRealData = new List<STDetailInfo>();
                for (int i = 0; i < arrDetailInfos.Count; i++ )
                {
                    try
                    {
                        if (arrDetailInfos[i].Cpu.Equals("null") || arrDetailInfos[i].DispSize.Equals("null") || arrDetailInfos[i].PixCnt.Equals("null")
                        || arrDetailInfos[i].OsVer.Equals("null") || arrDetailInfos[i].MemSize.Equals("null"))
                            continue;
                        else
                            allRealData.Add(arrDetailInfos[i]);
                    }
                    catch
                    {
                        continue;
                    }                    
                }

                result.RETDATA = allRealData;
            }
            catch (Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = null;
            }

            return result;
        }

        public static bool isSameKind(tbl_androiddetail youdetail, long mydetailid)
        {
            if (youdetail.uid == mydetailid)
                return false;

            YYTDBDataContext db = new YYTDBDataContext();

            tbl_androiddetrel myRel = new tbl_androiddetrel();
            myRel = (from m in db.tbl_androiddetrels
                     where m.deleted == 0 && m.detailid == mydetailid
                     select m).FirstOrDefault();

            if (myRel == null)
                return false;

            if (myRel.reldetailids != null && myRel.Equals("null") == false)
            {
                string[] arrRelIds = myRel.reldetailids.Split(',');
                if (arrRelIds.Contains(youdetail.uid.ToString()))
                    return true;
            }

            if ((myRel.minprice == null) || (youdetail.recommprice == null) || (myRel.minprice.Equals("null") == false) || (youdetail.recommprice.Equals("null") == false) )
                return false;
            else if (youdetail.recommprice < myRel.minprice)
                return false;

            if ((myRel.maxprice == null) || (youdetail.recommprice == null) || (myRel.maxprice.Equals("null") == false) || (youdetail.recommprice.Equals("null") == false))
                return false;
            else if (myRel.maxprice != null && youdetail.recommprice > myRel.maxprice)
                return false;

            if ((myRel.minscrsize == null) || (youdetail.screensize == null) || (myRel.minscrsize.Equals("null") == false) || (youdetail.screensize.Equals("null") == false))
                return false;
            else if (myRel.minscrsize != null && youdetail.screensize < myRel.minscrsize)
                return false;

            if ((myRel.maxscrsize == null) || (youdetail.screensize == null) || (myRel.maxscrsize.Equals("null") == false) || (youdetail.screensize.Equals("null") == false))
                return false;
            else if (myRel.maxscrsize != null && youdetail.screensize > myRel.maxscrsize)
                return false;

            if ((myRel.minpixcnt == null) || (youdetail.pixcnt == null) || (myRel.minpixcnt.Equals("null") == false) || (youdetail.pixcnt.Equals("null") == false))
                return false;
            else if (myRel.minpixcnt != null && youdetail.pixcnt < myRel.minpixcnt)
                return false;

            if ((myRel.maxpixcnt == null) || (youdetail.pixcnt == null) || (myRel.maxpixcnt.Equals("null") == false) || (youdetail.pixcnt.Equals("null") == false))
                return false;
            else if (myRel.maxpixcnt != null && youdetail.pixcnt > myRel.maxpixcnt)
                return false;

            if ((myRel.minosver == null) || (youdetail.osver == null) || (myRel.minosver.Equals("null") == false) || (youdetail.osver.Equals("null") == false))
                return false;
            else if (myRel.minosver != null && youdetail.osver < myRel.minosver)
                return false;

            if ((myRel.maxosver == null) || (youdetail.osver == null) || (myRel.maxosver.Equals("null") == false) || (youdetail.osver.Equals("null") == false))
                return false;
            else if (myRel.maxosver != null && youdetail.osver > myRel.maxosver)
                return false;

            return true;
        }

        /*
         * 
        */
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

        public static YanshiInfo GetPhoneDetailList(long user_id, long brand_id, long specid)
        {
            YYTDBDataContext db = new YYTDBDataContext();            
            YanshiInfo alllist = null;
            long parentid = GetAgentParentid(user_id);
            byte allowShare = GetAgentAllowshare(parentid);
            long share_id = GetAgentShareLobbyId(parentid);

            if (allowShare == 1)
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
                        status = m.data.data.status
                    }).FirstOrDefault();
            }
            else
            {
                alllist = db.tbl_androiddatas
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id) && m.datatype == 3)
                    .Join(db.tbl_androidspecs, m => m.android_id, l => l.uid, (m, l) => new { data = m, spec = l })
                    .Join(db.tbl_androidbrands, m => m.spec.brandid, l => l.uid, (m, l) => new { data = m, brand = l })
                    .OrderByDescending(m => m.data.data.uid)
                    .Where(m => m.data.spec.deleted == 0 && m.brand.deleted == 0 && m.data.spec.uid == specid)
                    .Select(m => new YanshiInfo
                    {
                        uid = m.data.data.uid,
                        user_id = m.data.data.user_id,
                        parentid = m.data.data.parentid,
                        android_id = m.data.data.android_id,
                        status = m.data.data.status
                    }).FirstOrDefault();
            }

            return alllist;
        }

        public static long GetDetailId(long uid)
        {
            YYTDBDataContext db = new YYTDBDataContext();
            tbl_androiddetail item = (from m in db.tbl_androiddetails
                                      where m.specid == uid && m.deleted == 0
                                      select m).FirstOrDefault();
            long id = 0;
            if (item != null)
                id = item.uid;

            return id;
        }

        public static tbl_androiddetrel GetAndroidDetrelInfoByDetailid(long detail_id)
        {
            YYTDBDataContext context = new YYTDBDataContext();
            return context.tbl_androiddetrels
                .Where(m => m.deleted == 0 && m.detailid == detail_id)
                .FirstOrDefault();
        }

        public static tbl_androiddata GetAndroidDataBySpecId(long specid)
        {
            YYTDBDataContext context = new YYTDBDataContext();
            return context.tbl_androiddatas
                .Where(m => m.deleted == 0 && m.android_id == specid && m.datatype == 3)
                .FirstOrDefault();
        }

        public static STResult getSameKindList(string uid, string brandid, string specid)        
        {
            YYTDBDataContext context = new YYTDBDataContext();
            STResult result = new STResult();
            List<STDetailInfo> retlist = new List<STDetailInfo>();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];

            long userid = long.Parse(uid);
            long brand_id = long.Parse(brandid);
            long spec_id = long.Parse(specid);

            try
            {
                long nnID = 0;
                if (spec_id != 0)
                {
                    nnID = GetDetailId(spec_id);
                }
                tbl_androiddetrel newData = GetAndroidDetrelInfoByDetailid(nnID);

                if (newData != null)
                {
                    var item = context.tbl_androiddetrels
                            .Where(m => m.deleted == 0 && m.uid == newData.uid)
                            .FirstOrDefault();

                    if (item != null && item.reldetailids != null)
                    {
                        List<string> ids = item.reldetailids.Split(',').Where(m => !string.IsNullOrEmpty(m)).ToList();
                        for (int i = 0; i < ids.Count(); i++)
                        {
                            long detail_id = Convert.ToUInt32(ids[i]);

                            STDetailInfo detailInfo = context.tbl_androiddetails
                                                    .Where(m => m.deleted == 0 && m.uid == detail_id)
                                                    .Select(m => new STDetailInfo
                                                    {
                                                        Uid = m.specid,
                                                        ImgPath = strBaseURL + m.imgurl1,
                                                        Name = m.title,
                                                        Price = (m.recommprice != null) ? Convert.ToDouble(m.recommprice) : 0.0f,
                                                        Cpu = m.showcpu,
                                                        DispSize = m.screenshowsize,
                                                        PixCnt = m.pixshowcnt,
                                                        OsVer = m.osshowver,
                                                        MemSize = m.memshowsize
                                                    }).FirstOrDefault();

                            if (detailInfo != null)
                                retlist.Add(detailInfo);
                        }
                    }

                    List<STDetailInfo> retReallist = new List<STDetailInfo>();
                    for (int i = 0; i < retlist.Count; i++)
                    {
                        try
                        {
                            if (retlist[i].Cpu.Equals("null") || retlist[i].DispSize.Equals("null") || retlist[i].PixCnt.Equals("null")
                                || retlist[i].OsVer.Equals("null") || retlist[i].MemSize.Equals("null"))
                                continue;
                            else
                                retReallist.Add(retlist[i]);
                        }
                        catch
                        {
                            continue;
                        }
                    }

                    result.RETDATA = retReallist;
                }
            }
            catch (System.Exception ex)
            {
                result.RETDATA = null;
            }

            return result;
        }

        /*
         * 
        */
// 
//         public static STResult getSameKindList(string uid, string brandid, string specid)
//         {
//             YYTDBDataContext db = new YYTDBDataContext();
//             STResult result = new STResult();
//             List<STDetailInfo> arrDetailInfos = new List<STDetailInfo>();
//             string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];
//             
//             try
//             {
//                 long userid = long.Parse(uid);
//                 long brand_id = long.Parse(brandid);
//                 long spec_id = long.Parse(specid);
// 
//                 tbl_androiddetail myPhoneInfo = null;
//                 myPhoneInfo = (from m in db.tbl_androiddetails
//                            where m.deleted == 0 && m.userid == userid && m.specid == spec_id
//                            orderby m.uid descending
//                            select m).FirstOrDefault();
//                 if (myPhoneInfo == null)
//                 {
//                     result.RETDATA = null;
//                     return result;
//                 }
//                 
//                 List<tbl_androiddetail> alllist = null;
//                 alllist = (from m in db.tbl_androiddetails
//                            where m.deleted == 0 && m.userid == userid
//                            orderby m.uid ascending
//                            select m).ToList();
// 
//                 List<tbl_androiddetail> filterlist = new List<tbl_androiddetail>();
//                 if (brand_id > 0)
//                 {
//                     foreach (tbl_androiddetail item in alllist)
//                     {
//                         if (isSameKind(item, myPhoneInfo.uid))
//                             filterlist.Add(item);
//                     }
//                 }
// 
//                 if (filterlist != null)
//                 {
//                     if (filterlist.Count > 0)
//                     {
//                         foreach (tbl_androiddetail item in filterlist)
//                         {
//                             STDetailInfo detailInfo = new STDetailInfo();
//                             detailInfo.Uid = item.uid;
//                             detailInfo.ImgPath = strBaseURL + item.imgurl1;
//                             detailInfo.Name = item.title;
//                             try
//                             {
//                                 detailInfo.Price = Convert.ToDouble(item.recommprice);
//                             }
//                             catch
//                             {
//                                 detailInfo.Price = 0.0f;
//                             }
// 
//                             detailInfo.Cpu = item.showcpu;
//                             detailInfo.DispSize = item.screenshowsize;
//                             detailInfo.PixCnt = item.pixshowcnt;
//                             detailInfo.OsVer = item.osshowver;
//                             detailInfo.MemSize = item.memshowsize;
// 
//                             arrDetailInfos.Add(detailInfo);
//                         }
//                     }
//                     else
//                         arrDetailInfos = new List<STDetailInfo>();
// 
//                     result.RETDATA = arrDetailInfos;
//                 }
//                 else
//                     result.RETDATA = null;
//             }
//             catch (Exception ex)
//             {
//                 Global.logMessage(ex.Message);
//                 result.RETDATA = null;
//             }
// 
//             return result;
//         }

        public static STResult getTemplateID(string uid)
        {
            STResult result = new STResult();

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();

                long userid = long.Parse(uid);
                tbl_usertemplate temp = (from m in db.tbl_usertemplates
                                         where m.deleted == 0 && m.user_id == userid
                                         select m).FirstOrDefault();

                if (temp == null)
                {
                    result.RETDATA = 1;
                }
                else
                {
                    result.RETDATA = temp.template_id;
                }
            }
            catch (System.Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = 1;
            }

            return result;
        }

        public static STResult getGiftList(string uid, string macaddr)
        {
            STResult result = new STResult();
            STGift stGift = new STGift();

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();

                long userid = long.Parse(uid);
                tbl_gift temp = (from m in db.tbl_gifts
                                         where m.deleted == 0 && m.user_id == userid && m.status == 0
                                         select m).FirstOrDefault();

                if (temp == null)
                {
                    result.RETDATA = null;
                }
                else
                {
                    stGift.OneGift = temp.gift_1_name;
                    stGift.TwoGift = temp.gift_2_name;
                    stGift.ThreeGift = temp.gift_3_name;
                    stGift.FourGift = temp.gift_4_name;
                    stGift.FiveGift = temp.gift_5_name;
                    stGift.SixGift = temp.gift_6_name;
                    stGift.Pass = temp.password;
                }

                tbl_usedgiftlist usedGiftList = (from m in db.tbl_usedgiftlists
                                                 where m.deleted == 0 && m.macaddr.Equals(macaddr) == true && m.isused == 1
                                                 select m).FirstOrDefault();
                if (usedGiftList == null)
                {
                    tbl_snnumber snnum = (from m in db.tbl_snnumbers
                                          where m.deleted == 0 && m.user_id == userid && m.macaddr.Equals(macaddr) == true
                                          select m).FirstOrDefault();
                    if (snnum == null)
                        stGift.IsUsed = 0;
                    else
                        stGift.IsUsed = snnum.status;
                }
                else
                {
                    stGift.IsUsed = 2;
                }

                result.RETDATA = stGift;
            }
            catch (System.Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = null;
            }           

            return result;
        }

        public static STResult getSNCode(string uid, string macaddr)
        {
            STResult result = new STResult();
            STSNCode snCode = new STSNCode();

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();

                long userid = long.Parse(uid);
                tbl_gift temp = (from m in db.tbl_gifts
                                 where m.deleted == 0 && m.user_id == userid && m.status == 0
                                 select m).FirstOrDefault();

                if (temp != null)
                {
                    long nProb = Convert.ToInt64(temp.probablity);
                    Random random = new Random();
                    int nRandVal = random.Next(101);
                    if (nRandVal < nProb)
                    {
                        int nRank = random.Next(6);
                        tbl_snnumber tblNumber = (from m in db.tbl_snnumbers
                                                  where m.user_id == userid && m.deleted == 0 && m.status == 0 && m.rank == nRank
                                                  select m).FirstOrDefault();
                        if (tblNumber == null)
                        {
                            snCode.Rank = -1;
                            snCode.SNNum = string.Empty;
                        }
                        else
                        {
                            snCode.Rank = nRank;
                            snCode.SNNum = tblNumber.snnum;

                            tblNumber.macaddr = macaddr;
                            tblNumber.using_time = DateTime.Now;
                            tblNumber.status = 1;
                            db.SubmitChanges();
                        }
                    }
                    else
                    {
                        snCode.Rank = -2;
                        snCode.SNNum = string.Empty;

                        tbl_usedgiftlist newItem = new tbl_usedgiftlist();
                        newItem.macaddr = macaddr;
                        newItem.isused = 1;
                        newItem.deleted = 0;

                        db.tbl_usedgiftlists.InsertOnSubmit(newItem);
                        db.SubmitChanges();
                    }
                }
            }
            catch (System.Exception ex)
            {
                Global.logMessage(ex.Message);
                snCode.Rank = -1;
                snCode.SNNum = string.Empty;
            }

            result.RETDATA = snCode;

            return result;
        }

        public static STResult getReqGift(string uid, string password, string macaddr, string snnum)
        {
            STResult result = new STResult();
            long userid = long.Parse(uid);

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();

                tbl_gift gift = (from m in db.tbl_gifts
                                where m.deleted == 0 && m.user_id == userid && m.password.Equals(password) == true
                                select m).FirstOrDefault();
                if (gift == null)
                {
                    result.RETDATA = 1;
                }
                else
                {
                    tbl_snnumber tblSnNum = (from m in db.tbl_snnumbers
                                            where m.deleted == 0 && m.status == 1 && m.user_id == userid && m.macaddr.Equals(macaddr) == true && m.snnum.Equals(snnum) == true
                                            select m).FirstOrDefault();
                    if (tblSnNum != null)
                    {
                        result.RETDATA = 0;

                        tblSnNum.status = 2;
                        tblSnNum.lotter_time = DateTime.Now;
                        db.SubmitChanges();
                    }
                    else
                    {
                        result.RETDATA = 1;
                    }
                }
            }
            catch (System.Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = 500;
            }

            return result;
        }

        public static string GetImagePathById(long uid)
        {
            YYTDBDataContext context = new YYTDBDataContext();

            if (uid == 0)
                return "--无图片--";

            tbl_photo item = context.tbl_photos
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.path;
            else
                return "--图片不存在--";
        }


        public static List<PathItem> GetDataList(long id)
        {
            YYTDBDataContext context = new YYTDBDataContext();

            byte type = 1;

            List<long> arrUID = context.tbl_androiddatas
                .Where(m => m.deleted == 0 && m.android_id == id && (m.datatype == 3 || m.datatype == 4))
                .Select(m => m.uid).ToList();

            List<PathItem> arrRealData = new List<PathItem>();
            if (arrUID != null)
            {
                for (int i = 0; i < arrUID.Count; i++)
                {
                    List<PathItem> arrData = context.tbl_androiddatalists
                        .Where(m => m.deleted == 0 && m.type == type && m.androiddata_id == arrUID[i])
                        .OrderBy(m => m.sortid)
                        .Select(m => new PathItem
                        {
                            imgPath = GetImagePathById(m.data_id),
                        }).ToList();

                    for (int j = 0; j < arrData.Count; j++)
                    {
                        arrRealData.Add(arrData[j]);
                    }
                }
            }

            return arrRealData;            
        }


        public static STResult getAllImgList(string shopid, string detid)
        {
            STResult result = new STResult();
            List<PathItem> arrImgPath = new List<PathItem>();
            YYTDBDataContext context = new YYTDBDataContext();
            string strBaseURL = ConfigurationManager.AppSettings["siteUrl"];
            
            long nShopID = long.Parse(shopid);
            long nDetailID = long.Parse(detid);
            long parentid = GetAgentParentid(nShopID);
            byte allowShare = GetAgentAllowshare(parentid);
            long share_id = GetAgentShareLobbyId(parentid);
            
            try
            {
                arrImgPath = GetDataList(nDetailID);
                if (arrImgPath != null)
                {
                    for (int i = 0; i < arrImgPath.Count; i++)
                    {
                        arrImgPath[i].imgPath = strBaseURL + arrImgPath[i].imgPath;
                    }
                }
                result.RETDATA = arrImgPath;
                result.RETCODE = 0;
            }
            catch
            {
                result.RETCODE = 500;
                result.RETMSG = "服务器内部错误";
            }

            return result;
        }

        public static STResult checkGiftPass(string shopid, string pwd)
        {
            STResult result = new STResult();
            long userid = long.Parse(shopid);

            try
            {
                YYTDBDataContext db = new YYTDBDataContext();

                tbl_gift gift = (from m in db.tbl_gifts
                                 where m.deleted == 0 && m.user_id == userid && m.wheelpass.Equals(pwd) == true
                                 select m).FirstOrDefault();
                if (gift != null)
                {
                    result.RETDATA = 1;
                }
                else
                {
                    result.RETDATA = -1;
                }
            }
            catch (System.Exception ex)
            {
                Global.logMessage(ex.Message);
                result.RETDATA = 500;
            }

            return result;
        }
	}    
}