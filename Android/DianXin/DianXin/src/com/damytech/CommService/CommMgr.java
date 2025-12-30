package com.damytech.CommService;

import com.damytech.HttpConn.AsyncHttpResponseHandler;
import com.damytech.STData.*;
import org.json.JSONObject;
import java.util.ArrayList;

public class CommMgr {
	
	public static CommMgr commService = new CommMgr();
    public MainSvcMgr mainMgr = new MainSvcMgr();

	public CommMgr() {}

    public void GetShopList(AsyncHttpResponseHandler handler)
    {
        mainMgr.GetShopList(handler);
    }

    public String parseGetShopList(JSONObject jsonObject, ArrayList<STRegion> dataList, ArrayList<STShop> arrShop)
    {
        return mainMgr.parseGetShopList(jsonObject, dataList, arrShop);
    }

    public void getBndSpcID(AsyncHttpResponseHandler handler, String uid, String name, String specname, String width, String height)
    {
        mainMgr.getBndSpcID(handler, uid, name, specname, width, height);
    }

    public long parsegetBndSpcID(JSONObject jsonObject, STBndSpcInfo info)
    {
        return mainMgr.parsegetBndSpcID(jsonObject, info);
    }

    public void getSplashImgPath(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        mainMgr.getSplashImgPath(handler, uid, brandid, specid);
    }

    public long parsegetSplashImgPath(JSONObject jsonObject, STString info)
    {
        return mainMgr.parsegetSplashImgPath(jsonObject, info);
    }

    public void getFirstPageImgPath(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        mainMgr.getFirstPageImgPath(handler, uid, brandid, specid);
    }

    public long parsegetFirstPageImgPath(JSONObject jsonObject, STString info)
    {
        return mainMgr.parsegetFirstPageImgPath(jsonObject, info);
    }

    public void getVideoPath(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        mainMgr.getVideoPath(handler, uid, brandid, specid);
    }

    public long parsegetVideoPath(JSONObject jsonObject, STString info)
    {
        return mainMgr.parsegetVideoPath(jsonObject, info);
    }

    public void getBenefitList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        mainMgr.getBenefitList(handler, uid, brandid, specid);
    }

    public ArrayList<String> parsegetBenefitList(JSONObject jsonObject)
    {
        return mainMgr.parsegetBenefitList(jsonObject);
    }

    public void getSetList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        mainMgr.getSetList(handler, uid, brandid, specid);
    }

    public ArrayList<String> parsegetSetList(JSONObject jsonObject)
    {
        return mainMgr.parsegetSetList(jsonObject);
    }

    public void getSameBrandList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        mainMgr.getSameBrandList(handler, uid, brandid, specid);
    }

    public long parsegetSameBrandList(JSONObject jsonObject, ArrayList<STDetailInfo> arrData)
    {
        return mainMgr.parsegetSameBrandList(jsonObject, arrData);
    }

    public void getSameKindList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        mainMgr.getSameKindList(handler, uid, brandid, specid);
    }

    public long parsegetSameKindList(JSONObject jsonObject, ArrayList<STDetailInfo> arrData)
    {
        return mainMgr.parsegetSameKindList(jsonObject, arrData);
    }
    
    public void getTemplateID(AsyncHttpResponseHandler handler, String uid)
    {
    	mainMgr.getTemplateID(handler, uid);
    }
    
    public long parsegetTemplateID(JSONObject jsonObject)
    {
    	return mainMgr.parsegetTemplateID(jsonObject);
    }

    public void getGiftList(AsyncHttpResponseHandler handler, String uid, String macaddr)
    {
        mainMgr.getGiftList(handler, uid, macaddr);
    }

    public long parsegetGiftList(JSONObject jsonObject, STGiftList giftList)
    {
        return mainMgr.parsegetGiftList(jsonObject, giftList);
    }

    public void getSNCode(AsyncHttpResponseHandler handler, String uid, String macaddr)
    {
        mainMgr.getSNCode(handler, uid, macaddr);
    }

    public long parsegetSNCode(JSONObject jsonObject, STSNCode snCode)
    {
        return mainMgr.parsegetSNCode(jsonObject, snCode);
    }

    public void getReqGift(AsyncHttpResponseHandler handler, String uid, String pwd, String macaddr, String snnum)
    {
        mainMgr.getReqGift(handler, uid, pwd, macaddr, snnum);
    }

    public long parsegetReqGift(JSONObject jsonObject)
    {
        return mainMgr.parsegetReqGift(jsonObject);
    }

    public void getAllImgList(AsyncHttpResponseHandler handler, String shopid, String detid)
    {
        mainMgr.getAllImgList(handler, shopid, detid);
    }

    public long parsegetAllImgList(JSONObject jsonObject, ArrayList<STString> arrInfo)
    {
        return mainMgr.parsegetAllImgList(jsonObject, arrInfo);
    }

    public void checkGiftPass(AsyncHttpResponseHandler handler, String shopid, String pwd)
    {
        mainMgr.checkGiftPass(handler, shopid, pwd);
    }

    public long parsecheckGiftPass(JSONObject jsonObject)
    {
        return mainMgr.parsecheckGiftPass(jsonObject);
    }
}
