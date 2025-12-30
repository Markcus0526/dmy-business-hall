using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace YYTService
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
	public class Service : IService
	{
		public string GetData(int value)
		{
			return string.Format("You entered: {0}", value);
		}

        public STResult getBndSpcID(string uid, string name, string specname, string width, string height)
        {
            return DBMgr.getBndSpcID(uid, name, specname, width, height);
        }

		public STResult getShopList()
		{
			return DBMgr.getShopList();
		}

        public STResult getBrandList(string uid)
        {
            return DBMgr.getBrandList(uid);
        }

        public STResult getDetInfoList(string uid, string brandid, string specid, string minprice, string maxprice)
        {
            return DBMgr.getDetInfoList(uid, brandid, specid, minprice, maxprice);
        }

        public STResult getSpecList(string uid, string brandid)
        {
            return DBMgr.getSpecList(uid, brandid);
        }

        public STResult getVideoPath(string uid, string brandid, string specid)
        {
            return DBMgr.getVideoPath(uid, brandid, specid);
        }

        public STResult getSplashImgPath(string uid, string brandid, string specid)
        {
            return DBMgr.getSplashImgPath(uid, brandid, specid);
        }

        public STResult getFirstPageImgPath(string uid, string brandid, string specid)
        {
            return DBMgr.getFirstPageImgPath(uid, brandid, specid);
        }

        public STResult getBenefitList(string uid, string brandid, string specid)
        {
            return DBMgr.getBenefitList(uid, brandid, specid);
        }

        public STResult getSetList(string uid, string brandid, string specid)
        {
            return DBMgr.getSetList(uid, brandid, specid);
        }

        public STResult getSameBrandList(string uid, string brandid, string specid)
        {
            return DBMgr.getSameBrandList(uid, brandid, specid);
        }

        public STResult getSameKindList(string uid, string brandid, string specid)
        {
            return DBMgr.getSameKindList(uid, brandid, specid);
        }

        public STResult getTemplateID(string uid)
        {
            return DBMgr.getTemplateID(uid);
        }

        public STResult getGiftList(string uid, string macaddr)
        {
            return DBMgr.getGiftList(uid, macaddr);
        }

        public STResult getSNCode(string uid, string macaddr)
        {
            return DBMgr.getSNCode(uid, macaddr);
        }

        public STResult getReqGift(string uid, string pwd, string macaddr, string snnum)
        {
            return DBMgr.getReqGift(uid, pwd, macaddr, snnum);
        }

        public STResult getAllImgList(string shopid, string detid)
        {
            return DBMgr.getAllImgList(shopid, detid);
        }

        public STResult checkGiftPass(string shopid, string pwd)
        {
            return DBMgr.checkGiftPass(shopid, pwd);
        }
	}
}
