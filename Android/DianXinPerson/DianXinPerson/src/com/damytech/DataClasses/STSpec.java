package com.damytech.DataClasses;

import org.json.JSONObject;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-7-1
 * Time: 上午1:24
 * To change this template use File | Settings | File Templates.
 */
public class STSpec
{
	public long uid = 0;
	public String name = "";

	public static STSpec decodeFromJSON(JSONObject jsonObj)
	{
		STSpec spec = new STSpec();

		try { spec.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { spec.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }

		return spec;
	}
}
