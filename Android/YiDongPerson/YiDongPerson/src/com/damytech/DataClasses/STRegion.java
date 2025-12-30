package com.damytech.DataClasses;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-6-27
 * Time: 上午12:10
 * To change this template use File | Settings | File Templates.
 */
public class STRegion
{
	public long uid = 0;
	public String name = "";
	public ArrayList<STRegion> arrSubAreas = null;

	public static STRegion decodeFromJSON(JSONObject jsonObj)
	{
		STRegion region = new STRegion();

		try { region.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { region.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try {
			JSONArray arrJSONAreas = jsonObj.getJSONArray("subareas");

			region.arrSubAreas = new ArrayList<STRegion>();
			for (int i = 0; i < arrJSONAreas.length(); i++)
			{
				region.arrSubAreas.add(STRegion.decodeFromJSON(arrJSONAreas.getJSONObject(i)));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			region.arrSubAreas = null;
		}

		return region;
	}
}
