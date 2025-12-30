package com.damytech.STData;

import org.json.JSONObject;

/**
 * Created by RiGS on 14-6-25.
 */
public class STShop {
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
