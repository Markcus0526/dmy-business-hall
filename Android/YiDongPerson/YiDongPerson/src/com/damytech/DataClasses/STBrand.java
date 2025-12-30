package com.damytech.DataClasses;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-7-1
 * Time: 上午1:23
 * To change this template use File | Settings | File Templates.
 */
public class STBrand
{
	public long uid = 0;
	public String name = "";

	public static STBrand decodeFromJSON(JSONObject jsonObj)
	{
		STBrand brand = new STBrand();

		try { brand.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { brand.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }

		return brand;
	}
}
