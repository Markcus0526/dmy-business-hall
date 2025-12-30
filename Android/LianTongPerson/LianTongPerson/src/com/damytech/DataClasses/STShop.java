package com.damytech.DataClasses;

import org.json.JSONObject;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-6-27
 * Time: 上午12:18
 * To change this template use File | Settings | File Templates.
 */
public class STShop
{
	public long uid = 0;
	public long regionid = 0;
	public String shopname = "";

	public static STShop decodeFromJSON(JSONObject jsonObj)
	{
		STShop shopInfo = new STShop();

		try {
			shopInfo.uid = jsonObj.getLong("uid");
			shopInfo.regionid = jsonObj.getLong("regionid");
			shopInfo.shopname = jsonObj.getString("shopname");
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return shopInfo;
	}
}
