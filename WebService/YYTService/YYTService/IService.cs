using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace YYTService
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService" in both code and config file together.
	[ServiceContract]
	public interface IService
	{
		[WebGet, OperationContract]
		string GetData(int value);

        [WebGet, OperationContract]
        STResult getBndSpcID(string uid, string name, string specname, string width, string height);

        [WebGet, OperationContract]
		STResult getShopList();

        [WebGet, OperationContract]
        STResult getBrandList(string uid);

        [WebGet, OperationContract]
        STResult getSpecList(string uid, string brandid);

        [WebGet, OperationContract]
        STResult getDetInfoList(string uid, string brandid, string specid, string minprice, string maxprice);

        [WebGet, OperationContract]
        STResult getVideoPath(string uid, string brandid, string specid);

        [WebGet, OperationContract]
        STResult getSplashImgPath(string uid, string brandid, string specid);

        [WebGet, OperationContract]
        STResult getFirstPageImgPath(string uid, string brandid, string specid);

        [WebGet, OperationContract]
        STResult getBenefitList(string uid, string brandid, string specid);

        [WebGet, OperationContract]
        STResult getSetList(string uid, string brandid, string specid);

        [WebGet, OperationContract]
        STResult getSameBrandList(string uid, string brandid, string specid);

        [WebGet, OperationContract]
        STResult getSameKindList(string uid, string brandid, string specid);

        [WebGet, OperationContract]
        STResult getTemplateID(string uid);

        [WebGet, OperationContract]
        STResult getGiftList(string uid, string macaddr);

        [WebGet, OperationContract]
        STResult getSNCode(string uid, string macaddr);

        [WebGet, OperationContract]
        STResult getReqGift(string uid, string pwd, string macaddr, string snnum);

        [WebGet, OperationContract]
        STResult getAllImgList(string shopid, string detid);

        [WebGet, OperationContract]
        STResult checkGiftPass(string shopid, string pwd);
	}

}
