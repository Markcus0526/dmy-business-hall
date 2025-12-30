package com.damytech.STData;

public class STServiceData {
	// Service Address
    //public static String serviceAddr = "http://192.168.1.38:10402/Service.svc/";
    //public static String serviceAddr = "http://218.203.173.183:8002/service.svc/";
    public static String serviceAddr = "http://218.60.131.41:10151/service.svc/";
    //public static String serviceAddr = "http://218.25.54.28:10231/Service.SVC/";

    // Command List
    public static String cmdGetShopList = "getShopList";
    public static String cmdgetBndSpcID = "getBndSpcID";
    public static String cmdgetSplashImgPath = "getSplashImgPath";
    public static String cmdgetVideoPath = "getVideoPath";
    public static String cmdgetFirstPageImgPath = "getFirstPageImgPath";
    public static String cmdgetBenefitList = "getBenefitList";
    public static String cmdgetSetList = "getSetList";
    public static String cmdgetSameBrandList = "getSameBrandList";
    public static String cmdgetSameKindList = "getSameKindList";
    public static String cmdgetTemplateID = "getTemplateID";
    public static String cmdgetGiftList = "getGiftList";
    public static String cmdgetSNCode = "getSNCode";
    public static String cmdgetReqGift = "getReqGift";
    public static String cmdgetAllImgList = "getAllImgList";
    public static String cmdcheckGiftPass = "checkGiftPass";

	// Connection Info
	public static int connectTimeout = 4 * 1000; // 5 Seconds
    public static int ERR_SERVER_ERROR = 1;
    public static int ERR_SERVER_SUCCESS = 0;
}
