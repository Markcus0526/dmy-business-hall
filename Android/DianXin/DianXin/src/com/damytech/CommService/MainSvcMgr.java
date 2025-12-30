package com.damytech.CommService;

import com.damytech.HttpConn.AsyncHttpClient;
import com.damytech.HttpConn.AsyncHttpResponseHandler;
import com.damytech.HttpConn.RequestParams;
import com.damytech.STData.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

public class MainSvcMgr {

    public void GetShopList(AsyncHttpResponseHandler handler)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdGetShopList;
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, handler);
        }
		catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String parseGetShopList(JSONObject jsonObject, ArrayList<STRegion> arrRegion, ArrayList<STShop> arrShop)
    {
        String retMsg = "";
        int i, retResult = 0;

        try {
            retResult = jsonObject.getInt("RETCODE");
            if (STServiceData.ERR_SERVER_SUCCESS != retResult)
            {
                retMsg = jsonObject.getString("RETMSG");
            }
            else
            {
                JSONObject jsonRetDataObject = jsonObject.getJSONObject("RETDATA");

                /*
                 * get Region List
                 */
                JSONArray jsonRegionListArr = jsonRetDataObject.getJSONArray("Regions");
                for (i = 0; i < jsonRegionListArr.length(); i++)
                {
                    arrRegion.add(STRegion.decodeFromJSON(jsonRegionListArr.getJSONObject(i)));
                }

                /*
                 * get Shop List
                 */
                JSONArray jsonShopListArr = jsonRetDataObject.getJSONArray("Shops");
                for (i = 0; i < jsonShopListArr.length(); i++)
                {
                    JSONObject objShop = jsonShopListArr.getJSONObject(i);
                    STShop newShop = new STShop();
                    newShop.uid = objShop.getLong("uid");
                    newShop.regionid = objShop.getLong("regionid");
                    newShop.shopname = objShop.getString("shopname");

                    arrShop.add(newShop);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return retMsg;
    }

    public void getBndSpcID(AsyncHttpResponseHandler handler, String uid, String name, String specname, String width, String height)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetBndSpcID;
            params.put("uid", uid);
            params.put("name", name);
            params.put("specname", specname);
            params.put("width", width);
            params.put("height", height);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetBndSpcID(JSONObject jsonObject, STBndSpcInfo info)
    {
        long retVal = STServiceData.ERR_SERVER_SUCCESS;

        try {
            JSONObject item = jsonObject.getJSONObject("RETDATA");
            info.brandid = item.getLong("brandid");
            info.specid = item.getLong("specid");
            info.title = item.getString("title");
        } catch (Exception ex) {
            ex.printStackTrace();
            retVal = STServiceData.ERR_SERVER_ERROR;
        }

        return retVal;
    }

    public void getSplashImgPath(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetSplashImgPath;
            params.put("uid", uid);
            params.put("brandid", brandid);
            params.put("specid", specid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetSplashImgPath(JSONObject jsonObject, STString info)
    {
        long retVal = STServiceData.ERR_SERVER_SUCCESS;

        try {
            info.data = jsonObject.getString("RETDATA");
        } catch (Exception ex) {
            ex.printStackTrace();
            retVal = STServiceData.ERR_SERVER_ERROR;
        }

        return retVal;
    }

    public void getFirstPageImgPath(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetFirstPageImgPath;
            params.put("uid", uid);
            params.put("brandid", brandid);
            params.put("specid", specid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetFirstPageImgPath(JSONObject jsonObject, STString info)
    {
        long retVal = STServiceData.ERR_SERVER_SUCCESS;

        try {
            info.data = jsonObject.getString("RETDATA");
        } catch (Exception ex) {
            ex.printStackTrace();
            retVal = STServiceData.ERR_SERVER_ERROR;
        }

        return retVal;
    }

    public void getVideoPath(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetVideoPath;
            params.put("uid", uid);
            params.put("brandid", brandid);
            params.put("specid", specid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetVideoPath(JSONObject jsonObject, STString info)
    {
        long retVal = STServiceData.ERR_SERVER_SUCCESS;

        try {
            info.data = jsonObject.getString("RETDATA");
        } catch (Exception ex) {
            ex.printStackTrace();
            retVal = STServiceData.ERR_SERVER_ERROR;
        }

        return retVal;
    }

    public void getBenefitList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetBenefitList;
            params.put("uid", uid);
            params.put("brandid", brandid);
            params.put("specid", specid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<String> parsegetBenefitList(JSONObject jsonObject)
    {
        ArrayList<String> arrData = new ArrayList<String>();

        try {
            JSONArray array = jsonObject.getJSONArray("RETDATA");
            for (int i = 0; i < array.length(); i++)
            {
                JSONObject object = array.getJSONObject(i);
                arrData.add(object.getString("imgPath"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            arrData = null;
        }

        return arrData;
    }

    public void getSetList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetSetList;
            params.put("uid", uid);
            params.put("brandid", brandid);
            params.put("specid", specid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<String> parsegetSetList(JSONObject jsonObject)
    {
        ArrayList<String> arrData = new ArrayList<String>();

        try {
            JSONArray array = jsonObject.getJSONArray("RETDATA");
            for (int i = 0; i < array.length(); i++)
            {
                JSONObject object = array.getJSONObject(i);
                arrData.add(object.getString("imgPath"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            arrData = null;
        }

        return arrData;
    }

    public void getSameBrandList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetSameBrandList;
            params.put("uid", uid);
            params.put("brandid", brandid);
            params.put("specid", specid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetSameBrandList(JSONObject jsonObject, ArrayList<STDetailInfo> arrData)
    {
        long retVal = STServiceData.ERR_SERVER_SUCCESS;

        try {
            JSONArray arrObject = jsonObject.getJSONArray("RETDATA");
            for (int i = 0; i < arrObject.length(); i++)
            {
                JSONObject object = arrObject.getJSONObject(i);
                STDetailInfo info = new STDetailInfo();
                info.uid = object.getLong("uid");
                info.imgpath = object.getString("imgpath");
                info.name = object.getString("name");
                info.price = object.getDouble("price");
                info.cpu = object.getString("cpu");
                info.dispsize = object.getString("dispsize");
                info.pixcnt = object.getString("pixcnt");
                info.osver = object.getString("osver");
                info.memsize = object.getString("memsize");

                arrData.add(info);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            retVal = STServiceData.ERR_SERVER_ERROR;
        }

        return retVal;
    }

    public void getSameKindList(AsyncHttpResponseHandler handler, String uid, String brandid, String specid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetSameKindList;
            params.put("uid", uid);
            params.put("brandid", brandid);
            params.put("specid", specid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetSameKindList(JSONObject jsonObject, ArrayList<STDetailInfo> arrData)
    {
        long retVal = STServiceData.ERR_SERVER_SUCCESS;

        try {
            JSONArray arrObject = jsonObject.getJSONArray("RETDATA");
            for (int i = 0; i < arrObject.length(); i++)
            {
                JSONObject object = arrObject.getJSONObject(i);
                STDetailInfo info = new STDetailInfo();
                info.uid = object.getLong("uid");
                info.imgpath = object.getString("imgpath");
                info.name = object.getString("name");
                info.price = object.getDouble("price");
                info.cpu = object.getString("cpu");
                info.dispsize = object.getString("dispsize");
                info.pixcnt = object.getString("pixcnt");
                info.osver = object.getString("osver");
                info.memsize = object.getString("memsize");

                arrData.add(info);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            retVal = STServiceData.ERR_SERVER_ERROR;
        }

        return retVal;
    }
    
    public void getTemplateID(AsyncHttpResponseHandler handler, String uid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetTemplateID;
            params.put("uid", uid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetTemplateID(JSONObject jsonObject)
    {
    	long nRet = 0;
        try {
            nRet = jsonObject.getLong("RETDATA");
        } catch (Exception ex) {
            ex.printStackTrace();
            nRet = 1;
        }

        return nRet;
    }

    public void getGiftList(AsyncHttpResponseHandler handler, String uid, String macaddr)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetGiftList;
            params.put("uid", uid);
            params.put("macaddr", macaddr);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetGiftList(JSONObject jsonObject, STGiftList giftList)
    {
        long nRet = 0;
        try {
            JSONObject obj = jsonObject.getJSONObject("RETDATA");
            giftList.onegift = obj.getString("onegift");
            giftList.twogift = obj.getString("twogift");
            giftList.threegift = obj.getString("threegift");
            giftList.fourgift = obj.getString("fourgift");
            giftList.fivegift = obj.getString("fivegift");
            giftList.sixgift = obj.getString("sixgift");
            giftList.pass = obj.getString("pass");
            giftList.isused = obj.getLong("isused");
        } catch (Exception ex) {
            ex.printStackTrace();
            giftList = new STGiftList();
            nRet = 1;
        }

        return nRet;
    }

    public void getSNCode(AsyncHttpResponseHandler handler, String uid, String macaddr)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetSNCode;
            params.put("uid", uid);
            params.put("macaddr", macaddr);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetSNCode(JSONObject jsonObject, STSNCode snCode)
    {
        long nRet = 0;
        try {
            JSONObject obj = jsonObject.getJSONObject("RETDATA");
            snCode.rank = obj.getLong("rank");
            snCode.snnum = obj.getString("snnum");
        } catch (Exception ex) {
            ex.printStackTrace();
            snCode = new STSNCode();
            nRet = 1;
        }

        return nRet;
    }

    public void getReqGift(AsyncHttpResponseHandler handler, String uid, String pwd, String macaddr, String snnum)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetReqGift;
            params.put("uid", uid);
            params.put("pwd", pwd);
            params.put("macaddr", macaddr);
            params.put("snnum", snnum);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetReqGift(JSONObject jsonObject)
    {
        long nRet = 0;
        try {
            nRet = jsonObject.getLong("RETDATA");
        } catch (Exception ex) {
            ex.printStackTrace();
            nRet = 1;
        }

        return nRet;
    }

    public void getAllImgList(AsyncHttpResponseHandler handler, String shopid, String detid)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdgetAllImgList;
            params.put("shopid", shopid);
            params.put("detid", detid);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsegetAllImgList(JSONObject jsonObject, ArrayList<STString> arrInfo)
    {
        long retVal = STServiceData.ERR_SERVER_SUCCESS;

        try {
            JSONArray arrData = jsonObject.getJSONArray("RETDATA");
            for (int i = 0; i < arrData.length(); i++)
            {
                JSONObject obj = arrData.getJSONObject(i);
                STString stData = new STString();
                stData.data = obj.getString("imgPath");

                arrInfo.add(stData);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            retVal = STServiceData.ERR_SERVER_ERROR;
        }

        return retVal;
    }

    public void checkGiftPass(AsyncHttpResponseHandler handler, String shopid, String pwd)
    {
        String url = "";
        AsyncHttpClient client = new AsyncHttpClient();
        RequestParams params = new RequestParams();

        try {
            url = STServiceData.serviceAddr + STServiceData.cmdcheckGiftPass;
            params.put("shopid", shopid);
            params.put("pwd", pwd);
            client.setTimeout(STServiceData.connectTimeout);
            client.get(url, params, handler);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public long parsecheckGiftPass(JSONObject jsonObject)
    {
        long nRet = 0;
        try {
            nRet = jsonObject.getLong("RETDATA");
        } catch (Exception ex) {
            ex.printStackTrace();
            nRet = -1;
        }

        return nRet;
    }
}
