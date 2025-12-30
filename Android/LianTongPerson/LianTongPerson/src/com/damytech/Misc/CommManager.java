package com.damytech.Misc;

import com.damytech.HttpConn.AsyncHttpClient;
import com.damytech.HttpConn.AsyncHttpResponseHandler;
import org.apache.http.entity.StringEntity;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-1-10
 * Time: 上午1:41
 * To change this template use File | Settings | File Templates.
 */
public class CommManager {
	public static int getTimeOut() { return 5 * 1000; }
	public static String getServiceBaseUrl() { return "http://116.112.15.30:8002/Service.svc/"; }


	public static void getShopRegionList(AsyncHttpResponseHandler handler)
	{
		String url = getServiceBaseUrl() + "getShopList";

		try
		{
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, handler);
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}

	public static void getBrandList(long shopid, AsyncHttpResponseHandler handler)
	{
		String url = getServiceBaseUrl() + "getBrandList?uid=" + shopid;

		try
		{
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, handler);
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}

	public static void getSpecList(long shopid, long brandid, AsyncHttpResponseHandler handler)
	{
		String url = getServiceBaseUrl() + "getSpecList?uid=" + shopid + "&brandid=" + brandid;

		try
		{
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, handler);
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}

	public static void getDetInfoList(long shopid, long brandid, long specid, double minprice, double maxprice, AsyncHttpResponseHandler handler)
	{
		String url = getServiceBaseUrl() + "getDetInfoList?uid=" + shopid
				+ "&brandid=" + brandid
				+ "&specid=" + specid
				+ "&minprice=" + minprice
				+ "&maxprice=" + maxprice;

		try
		{
			AsyncHttpClient client = new AsyncHttpClient();
			client.setTimeout(getTimeOut());
			client.get(url, handler);
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
		}
	}

}
