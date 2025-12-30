package com.damytech.DataClasses;

import org.json.JSONObject;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-7-1
 * Time: 上午2:46
 * To change this template use File | Settings | File Templates.
 */
public class STPhone
{
	public long uid = 0;
	public String imgpath = "";
	public String name = "";
	public double price = 0;
	public String cpu = "";
	public String dispsize = "";
	public String pixcnt = "";
	public String osver = "";

	public static STPhone decodeFromJSON(JSONObject jsonObj)
	{
		STPhone phone = new STPhone();

		try { phone.uid = jsonObj.getLong("uid"); } catch (Exception ex) { ex.printStackTrace(); }
		try { phone.name = jsonObj.getString("name"); } catch (Exception ex) { ex.printStackTrace(); }
		try { phone.imgpath = jsonObj.getString("imgpath"); } catch (Exception ex) { ex.printStackTrace(); }
		try { phone.price = jsonObj.getDouble("price"); } catch (Exception ex) { ex.printStackTrace(); }
		try { phone.cpu = jsonObj.getString("cpu"); } catch (Exception ex) { ex.printStackTrace(); }
		try { phone.dispsize = jsonObj.getString("dispsize"); } catch (Exception ex) { ex.printStackTrace(); }
		try { phone.pixcnt = jsonObj.getString("pixcnt"); } catch (Exception ex) { ex.printStackTrace(); }
		try { phone.osver = jsonObj.getString("osver"); } catch (Exception ex) { ex.printStackTrace(); }

		return phone;
	}
}
