package com.damytech.LianTongPerson;

import android.graphics.Color;
import android.graphics.Point;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.*;
import com.damytech.DataClasses.*;
import com.damytech.HttpConn.AsyncHttpResponseHandler;
import com.damytech.Misc.CommManager;
import com.damytech.Misc.Global;
import com.damytech.Utils.Android_PullToRefresh.PullToRefreshBase;
import com.damytech.Utils.Android_PullToRefresh.PullToRefreshListView;
import com.damytech.Utils.Android_PullToRefresh.PullToRefreshScrollView;
import com.damytech.Utils.ResolutionSet;
import com.damytech.Utils.SmartImageView.SmartImageView;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Timer;


public class MainActivity extends SuperActivity {
	private final int PROV_ADAPTER = 0;
	private final int CITY_ADAPTER = 1;
	private final int AREA_ADAPTER = 2;
	private final int SHOP_ADAPTER = 3;
	private final int BRAND_ADAPTER = 4;
	private final int TYPE_ADAPTER = 5;

	private int curAdapter = PROV_ADAPTER;

	PullToRefreshScrollView listView = null;
	LinearLayout scrollContentLayout = null;

	ArrayList<STRegion> arrRegions = new ArrayList<STRegion>();
	ArrayList<STShop> arrShops = new ArrayList<STShop>();
	ArrayList<STBrand> arrBrands = new ArrayList<STBrand>();
	ArrayList<STSpec> arrSpecs = new ArrayList<STSpec>();
	ArrayList<STPhone> arrPhones = new ArrayList<STPhone>();

	STRegion curProv = null, curCity = null, curArea = null;

	long curRegionID = 0;
	long curShopID = 0;
	long curBrandID = 0;
	long curTypeID = 0;

	TextView txtProv = null, txtCity = null, txtArea = null, txtShop = null;
	ImageButton btnProv = null, btnCity = null, btnArea = null, btnShop = null;
	TextView txtBrand = null, txtType = null;
	ImageButton btnBrand = null, btnType = null;
	EditText edtMinPrice = null, edtMaxPrice = null;

	RelativeLayout condLayout = null;
	ImageButton btnSelCondition = null;

	Button btnOK = null, btnCancel = null;

	RelativeLayout listLayout = null;
	ListView adapterListView = null;
	ItemAdapter adapter = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

	    initResolution();
	    initControls();
	}


	private void initResolution() {
		RelativeLayout parent_layout = (RelativeLayout)findViewById(R.id.parent_layout);
		parent_layout.getViewTreeObserver().addOnGlobalLayoutListener (new ViewTreeObserver.OnGlobalLayoutListener() {
			@Override
			public void onGlobalLayout() {
				Point ptTemp = getScreenSize();
				boolean bNeedUpdate = false;
				if (mScrSize.x == 0 && mScrSize.y == 0)
				{
					mScrSize = ptTemp;
					bNeedUpdate = true;
				}
				else if (mScrSize.x != ptTemp.x || mScrSize.y != ptTemp.y)
				{
					mScrSize = ptTemp;
					bNeedUpdate = true;
				}

				if (bNeedUpdate)
				{
					runOnUiThread(new Runnable() {
						@Override
						public void run() {
							ResolutionSet.instance.iterateChild(findViewById(R.id.parent_layout), mScrSize.x, mScrSize.y);
						}
					});
				}
			}
		});
	}


	private void initControls()
	{
		listView = (PullToRefreshScrollView)findViewById(R.id.list_view);
		{
			listView.setMode(PullToRefreshBase.Mode.PULL_FROM_END);
			listView.setScrollContainer(true);
			listView.setOnRefreshListener(scrollViewListener);
			scrollContentLayout = new LinearLayout(listView.getContext());
			scrollContentLayout.setOrientation(LinearLayout.VERTICAL);
			LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
			layoutParams.setMargins(0, 0, 0, 0);
			scrollContentLayout.setLayoutParams(layoutParams);
			listView.addView(scrollContentLayout);
		}

		txtProv = (TextView)findViewById(R.id.txt_prov);
		txtCity = (TextView)findViewById(R.id.txt_city);
		txtArea = (TextView)findViewById(R.id.txt_area);
		txtShop = (TextView)findViewById(R.id.txt_shop);

		btnProv = (ImageButton)findViewById(R.id.btn_prov);
		btnProv.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				onClickProv();
			}
		});

		btnCity = (ImageButton)findViewById(R.id.btn_city);
		btnCity.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				onClickCity();
			}
		});

		btnArea = (ImageButton)findViewById(R.id.btn_area);
		btnArea.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				onClickArea();
			}
		});

		btnShop = (ImageButton)findViewById(R.id.btn_shop);
		btnShop.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				onClickShop();
			}
		});

		txtBrand = (TextView)findViewById(R.id.txt_brand);
		txtType = (TextView)findViewById(R.id.txt_type);

		btnBrand = (ImageButton)findViewById(R.id.btn_brand);
		btnType = (ImageButton)findViewById(R.id.btn_type);

		btnBrand.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				onClickBrand();
			}
		});

		btnType.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				onClickType();
			}
		});

		edtMinPrice = (EditText)findViewById(R.id.edt_price_from);
		edtMaxPrice = (EditText)findViewById(R.id.edt_price_to);

		btnSelCondition = (ImageButton)findViewById(R.id.btn_selcond);
		btnSelCondition.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				onClickSelCondition();
			}
		});

		btnOK = (Button)findViewById(R.id.btn_ok);
		btnCancel = (Button)findViewById(R.id.btn_cancel);
		btnOK.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				Global.hideKeyboardFromText(edtMinPrice, getApplicationContext());
				Global.hideKeyboardFromText(edtMaxPrice, getApplicationContext());

				condLayout.setVisibility(View.GONE);
				getProductList();
			}
		});

		btnCancel.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				Global.hideKeyboardFromText(edtMinPrice, getApplicationContext());
				Global.hideKeyboardFromText(edtMaxPrice, getApplicationContext());

				condLayout.setVisibility(View.GONE);
			}
		});

		condLayout = (RelativeLayout)findViewById(R.id.select_layout);
//		condLayout.setOnClickListener(new View.OnClickListener()
//		{
//			@Override
//			public void onClick(View v)
//			{
//				condLayout.setVisibility(View.GONE);
//			}
//		});

		listLayout = (RelativeLayout)findViewById(R.id.list_layout);
		listLayout.setClickable(true);
		listLayout.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				condLayout.setVisibility(View.VISIBLE);
				listLayout.setVisibility(View.GONE);
			}
		});
		adapterListView = (ListView)findViewById(R.id.adapter_list);
		adapter = new ItemAdapter();
		adapterListView.setAdapter(adapter);

		startProgress();
		CommManager.getShopRegionList(logs_handler);
	}


	private PullToRefreshBase.OnRefreshListener scrollViewListener = new PullToRefreshBase.OnRefreshListener() {
		@Override
		public void onRefresh(PullToRefreshBase refreshView) {
			listView.onRefreshComplete();
		}
	};


	private String szTemp = "";
	private Thread thread = new Thread(new Runnable()
	{
		@Override
		public void run()
		{
			try
			{
				JSONObject jsonObject = new JSONObject(szTemp);
				int nRetCode = jsonObject.getInt("RETCODE");
				String szMsg = jsonObject.getString("RETMSG");

				JSONObject objResult = jsonObject.getJSONObject("RETDATA");

				JSONArray arrJsonRegions = objResult.getJSONArray("Regions");
				JSONArray arrJsonShops = objResult.getJSONArray("Shops");

				for (int i = 0; i < arrJsonRegions.length(); i++)
				{
					STRegion regionInfo = STRegion.decodeFromJSON(arrJsonRegions.getJSONObject(i));
					arrRegions.add(regionInfo);
				}

				for (int i = 0; i < arrJsonShops.length(); i++)
				{
					STShop shopInfo = STShop.decodeFromJSON(arrJsonShops.getJSONObject(i));
					arrShops.add(shopInfo);
				}

				if (arrRegions != null && arrRegions.size() != 0)
				{
					curProv = arrRegions.get(0);
					ArrayList<STRegion> arrDefaultCities = curProv.arrSubAreas;
					if (arrDefaultCities != null && arrDefaultCities.size() > 0)
					{
						curCity = arrDefaultCities.get(0);
						ArrayList<STRegion> arrDefaultAreas = curCity.arrSubAreas;
						if (arrDefaultAreas != null && arrDefaultAreas.size() > 0)
						{
							curArea = arrDefaultAreas.get(0);

							runOnUiThread(new Runnable()
							{
								@Override
								public void run()
								{
									txtProv.setText(curProv.name);
									txtCity.setText(curCity.name);
									txtArea.setText(curArea.name);
									curRegionID = curArea.uid;

									setDefaultShop();
								}
							});
						}
						else
						{
							runOnUiThread(new Runnable()
							{
								@Override
								public void run()
								{
									txtProv.setText(curProv.name);
									txtCity.setText(curCity.name);
									txtArea.setText("");
									curRegionID = curCity.uid;
									setDefaultShop();
								}
							});
						}
					}
					else
					{
						runOnUiThread(new Runnable()
						{
							@Override
							public void run()
							{
								txtCity.setText("");
								txtArea.setText("");
								txtProv.setText(curProv.name);
								curRegionID = curProv.uid;
								setDefaultShop();
							}
						});
					}
				}
				else
				{
					runOnUiThread(new Runnable()
					{
						@Override
						public void run()
						{
							txtCity.setText("");
							txtArea.setText("");
							txtProv.setText("");
							curRegionID = 0;
							curShopID = 0;
							curBrandID = 0;
							curTypeID = 0;
						}
					});
				}
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}

			runOnUiThread(new Runnable()
			{
				@Override
				public void run()
				{
					stopProgress();
				}
			});
		}
	});


	private AsyncHttpResponseHandler logs_handler = new AsyncHttpResponseHandler()
	{
		@Override
		public void onSuccess(String content) {
			super.onSuccess(content);    //To change body of overridden methods use File | Settings | File Templates.
			szTemp = content;
			m_dlgProg.setMessage(getResources().getString(R.string.STR_LOADING));
			thread.start();
		}

		@Override
		public void onFailure(Throwable error, String content) {
			super.onFailure(error, content);    //To change body of overridden methods use File | Settings | File Templates.

			txtCity.setText("");
			txtArea.setText("");
			txtProv.setText("");
			curRegionID = 0;
			curShopID = 0;
			curBrandID = 0;
			curTypeID = 0;

			stopProgress();
		}
	};

	private void setDefaultShop()
	{
		STShop shopinfo = getShopFromRegionID(curRegionID);
		if (shopinfo == null)
		{
			txtShop.setText("");
			txtBrand.setText("");
			txtType.setText("");
			curShopID = 0;
			curBrandID = 0;
			curTypeID = 0;
			return;
		}

		txtShop.setText(shopinfo.shopname);
		curShopID = shopinfo.uid;
		getBrands();
	}

	private STShop getShopFromRegionID(long regionid)
	{
		if (arrShops == null || arrShops.size() == 0)
			return null;

		for (int i = 0; i < arrShops.size(); i++)
		{
			STShop shopInfo = arrShops.get(i);
			if (shopInfo.regionid == curRegionID)
			{
				return shopInfo;
			}
		}

		return null;
	}

	private void onClickProv()
	{
		if (arrRegions == null || arrRegions.size() == 0)
			return;

		curAdapter = PROV_ADAPTER;
		adapter.notifyDataSetChanged();
		condLayout.setVisibility(View.GONE);
		listLayout.setVisibility(View.VISIBLE);
		adapterListView.setSelectionAfterHeaderView();
	}

	private void onClickCity()
	{
		if (curProv == null || curProv.arrSubAreas == null || curProv.arrSubAreas.size() == 0)
			return;

		curAdapter = CITY_ADAPTER;
		adapter.notifyDataSetChanged();
		condLayout.setVisibility(View.GONE);
		listLayout.setVisibility(View.VISIBLE);
		adapterListView.setSelectionAfterHeaderView();
	}

	private void onClickArea()
	{
		if (curCity == null || curCity.arrSubAreas == null || curCity.arrSubAreas.size() == 0)
			return;

		curAdapter = AREA_ADAPTER;
		adapter.notifyDataSetChanged();
		condLayout.setVisibility(View.GONE);
		listLayout.setVisibility(View.VISIBLE);
		adapterListView.setSelectionAfterHeaderView();
	}

	private void onClickShop()
	{
		if (arrShops == null || arrShops.size() == 0)
			return;

		curAdapter = SHOP_ADAPTER;
		adapter.notifyDataSetChanged();
		condLayout.setVisibility(View.GONE);
		listLayout.setVisibility(View.VISIBLE);
		adapterListView.setSelectionAfterHeaderView();
	}


	private void onClickBrand()
	{
		if (arrBrands == null || arrBrands.size() == 0)
			return;

		curAdapter = BRAND_ADAPTER;
		adapter.notifyDataSetChanged();
		condLayout.setVisibility(View.GONE);
		listLayout.setVisibility(View.VISIBLE);
		adapterListView.setSelectionAfterHeaderView();
	}

	private void onClickType()
	{
		if (arrSpecs == null || arrSpecs.size() == 0)
			return;

		curAdapter = TYPE_ADAPTER;
		adapter.notifyDataSetChanged();
		condLayout.setVisibility(View.GONE);
		listLayout.setVisibility(View.VISIBLE);
		adapterListView.setSelectionAfterHeaderView();
	}


	private void onClickSelCondition()
	{
		condLayout.setVisibility(View.VISIBLE);
	}


	private STShop getShopInfoFromIndex(int position)
	{
		int nIndex = 0;
		STShop shopInfo = null;
		for (int i = 0; i < arrShops.size(); i++)
		{
			shopInfo = arrShops.get(i);
			if (shopInfo.regionid == curRegionID)
			{
				if (nIndex == position)
					return shopInfo;
				else
					nIndex++;
			}
		}
		return shopInfo;
	}


	public class ItemAdapter extends BaseAdapter
	{
		@Override
		public int getCount() {
			if (curAdapter == PROV_ADAPTER)
			{
				if (arrRegions == null)
					return 0;
				return arrRegions.size();
			}
			else if (curAdapter == CITY_ADAPTER)
			{
				if (curProv == null || curProv.arrSubAreas == null)
					return 0;
				return curProv.arrSubAreas.size();
			}
			else if (curAdapter == AREA_ADAPTER)
			{
				if (curCity == null || curCity.arrSubAreas == null)
					return 0;
				return curCity.arrSubAreas.size();
			}
			else if (curAdapter == SHOP_ADAPTER)
			{
				if (arrShops == null)
					return 0;

				int nCount = 0;
				for (int i = 0; i < arrShops.size(); i++)
				{
					STShop shop = arrShops.get(i);
					if (shop.regionid == curRegionID)
						nCount++;
				}
				return nCount;
			}
			else if (curAdapter == BRAND_ADAPTER)
			{
				if (arrBrands == null)
					return 0;

				return arrBrands.size();
			}
			else if (curAdapter == TYPE_ADAPTER)
			{
				if (arrSpecs == null)
					return 0;

				return arrSpecs.size();
			}

			return 0;
		}

		@Override
		public Object getItem(int position) {
			if (curAdapter == PROV_ADAPTER)
			{
				return arrRegions.get(position);
			}
			else if (curAdapter == CITY_ADAPTER)
			{
				return curProv.arrSubAreas.get(position);
			}
			else if (curAdapter == AREA_ADAPTER)
			{
				return curCity.arrSubAreas.get(position);
			}
			else if (curAdapter == SHOP_ADAPTER)
			{
				getShopInfoFromIndex(position);
			}
			else if (curAdapter == BRAND_ADAPTER)
			{
				return arrBrands.get(position);
			}
			else if (curAdapter == TYPE_ADAPTER)
			{
				return arrSpecs.get(position);
			}

			return null;
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		public boolean hasStableIds() {
			return true;
		}

		@Override
		public boolean isEmpty() {
			return getCount() == 0;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			STRegion regionInfo = null;
			STShop shopInfo = null;
			STBrand brandInfo = null;
			STSpec specInfo = null;

			if (curAdapter == PROV_ADAPTER)
			{
				regionInfo = arrRegions.get(position);
			}
			else if (curAdapter == CITY_ADAPTER)
			{
				regionInfo = curProv.arrSubAreas.get(position);
			}
			else if (curAdapter == AREA_ADAPTER)
			{
				regionInfo = curCity.arrSubAreas.get(position);
			}
			else if (curAdapter == SHOP_ADAPTER)
			{
				shopInfo = getShopInfoFromIndex(position);
			}
			else if (curAdapter == BRAND_ADAPTER)
			{
				brandInfo = arrBrands.get(position);
			}
			else if (curAdapter == TYPE_ADAPTER)
			{
				specInfo = arrSpecs.get(position);
			}
			else
			{
				return null;
			}

			if (convertView == null)
			{
				convertView = new RelativeLayout(parent.getContext());
				AbsListView.LayoutParams layoutParams = new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, 60);
				convertView.setLayoutParams(layoutParams);
				convertView.setBackgroundColor(Color.GRAY);

				TextView txtItem = new TextView(convertView.getContext());
				txtItem.setTextSize(TypedValue.COMPLEX_UNIT_PX, 29);
				txtItem.setTextColor(Color.WHITE);
				txtItem.setPadding(40, 0, 0, 0);
				txtItem.setGravity(Gravity.CENTER_VERTICAL);
				AbsListView.LayoutParams txtLayoutParams = new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, AbsListView.LayoutParams.MATCH_PARENT);
				txtItem.setLayoutParams(txtLayoutParams);
				if (regionInfo != null)
					txtItem.setText(regionInfo.name);
				else if (shopInfo != null)
					txtItem.setText(shopInfo.shopname);
				else if (brandInfo != null)
					txtItem.setText(brandInfo.name);
				else if (specInfo != null)
					txtItem.setText(specInfo.name);
				((RelativeLayout)convertView).addView(txtItem);

				Button btnItem = new Button(convertView.getContext());
				btnItem.setBackgroundResource(R.drawable.btn_empty);
				AbsListView.LayoutParams btnLayoutParams = new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, AbsListView.LayoutParams.MATCH_PARENT);
				btnItem.setLayoutParams(btnLayoutParams);
				if (regionInfo != null)
				{
					btnItem.setTag("" + regionInfo.uid);
					btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectRegion(uid);
						}
					});
				}
				else if (shopInfo != null)
				{
					btnItem.setTag("" + shopInfo.uid);
					btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectShop(uid);
						}
					});
				}
				else if (brandInfo != null)
				{
					btnItem.setTag("" + brandInfo.uid);
					btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectBrand(uid);
						}
					});
				}
				else if (specInfo != null)
				{
					btnItem.setTag("" + specInfo.uid);
					btnItem.setOnClickListener(new View.OnClickListener()
					{
						@Override
						public void onClick(View v)
						{
							String szUid = (String) v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectType(uid);
						}
					});
				}

				((RelativeLayout)convertView).addView(btnItem);

				Point ptSize = getScreenSize();
				ResolutionSet.instance.iterateChild(convertView, ptSize.x, ptSize.y);

				STViewHolder viewHolder = new STViewHolder();
				viewHolder.btnItem = btnItem;
				viewHolder.txtItem = txtItem;

				convertView.setTag(viewHolder);
			}
			else
			{
				STViewHolder viewHolder = (STViewHolder)convertView.getTag();
				if (regionInfo != null)
				{
					viewHolder.txtItem.setText(regionInfo.name);
					viewHolder.btnItem.setTag("" + regionInfo.uid);
					viewHolder.btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectRegion(uid);
						}
					});

				}
				else if (shopInfo != null)
				{
					viewHolder.txtItem.setText(shopInfo.shopname);
					viewHolder.btnItem.setTag("" + shopInfo.uid);

					viewHolder.btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectShop(uid);
						}
					});

				}
				else if (brandInfo != null)
				{
					viewHolder.txtItem.setText(brandInfo.name);
					viewHolder.btnItem.setTag("" + brandInfo.uid);

					viewHolder.btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectBrand(uid);
						}
					});
				}
				else if (specInfo != null)
				{
					viewHolder.txtItem.setText(specInfo.name);
					viewHolder.btnItem.setTag("" + specInfo.uid);

					viewHolder.btnItem.setOnClickListener(new View.OnClickListener()
					{
						@Override
						public void onClick(View v)
						{
							String szUid = (String) v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectType(uid);
						}
					});
				}
			}

			return convertView;
		}
	}

	public class STViewHolder
	{
		public TextView txtItem = null;
		public Button btnItem = null;
	}

	private STRegion getRegionFromID(long uid)
	{
		if (arrRegions == null)
			return null;

		for (int i = 0; i < arrRegions.size(); i++)
		{
			STRegion prov = arrRegions.get(i);
			if (prov.uid == uid)
				return prov;

			if (prov.arrSubAreas == null)
				continue;

			for (int j = 0; j < prov.arrSubAreas.size(); j++)
			{
				STRegion city = prov.arrSubAreas.get(j);
				if (city.uid == uid)
					return city;

				if (city.arrSubAreas == null)
					continue;

				for (int k = 0; k < city.arrSubAreas.size(); k++)
				{
					STRegion area = city.arrSubAreas.get(k);
					if (area.uid == uid)
						return area;
				}
			}
		}

		return null;
	}

	private STShop getShopFromID(long uid)
	{
		if (arrShops == null)
			return null;

		for (int i = 0; i < arrShops.size(); i++)
		{
			STShop shop = arrShops.get(i);
			if (shop.uid == uid)
				return shop;
		}

		return null;
	}


	private STBrand getBrandFromID(long uid)
	{
		if (arrBrands == null)
			return null;

		for (int i = 0; i < arrBrands.size(); i++)
		{
			STBrand brand = arrBrands.get(i);
			if (brand.uid == uid)
				return brand;
		}

		return null;
	}

	private STSpec getSpecFromID(long uid)
	{
		if (arrSpecs == null)
			return null;

		for (int i = 0; i < arrSpecs.size(); i++)
		{
			STSpec spec = arrSpecs.get(i);
			if (spec.uid == uid)
				return spec;
		}

		return null;
	}


	private void onSelectRegion(long uid)
	{
		condLayout.setVisibility(View.VISIBLE);
		listLayout.setVisibility(View.GONE);

		if (curAdapter == PROV_ADAPTER)
		{
			STRegion curRegion = getRegionFromID(uid);
			curProv = curRegion;
			ArrayList<STRegion> arrCities = curProv.arrSubAreas;
			if (arrCities != null && arrCities.size() > 0)
			{
				curCity = arrCities.get(0);
				ArrayList<STRegion> arrAreas = curCity.arrSubAreas;
				if (arrAreas != null && arrAreas.size() > 0)
				{
					curArea = arrAreas.get(0);

					txtProv.setText(curProv.name);
					txtCity.setText(curCity.name);
					txtArea.setText(curArea.name);
					curRegionID = curArea.uid;

					setDefaultShop();
				}
				else
				{
					txtProv.setText(curProv.name);
					txtCity.setText(curCity.name);
					txtArea.setText("");
					curRegionID = curCity.uid;
					setDefaultShop();
				}
			}
			else
			{
				txtCity.setText("");
				txtArea.setText("");
				txtProv.setText(curProv.name);
				curRegionID = curProv.uid;
				setDefaultShop();
			}
		}
		else if (curAdapter == CITY_ADAPTER)
		{
			STRegion curRegion = getRegionFromID(uid);
			curCity = curRegion;
			ArrayList<STRegion> arrAreas = curCity.arrSubAreas;
			if (arrAreas != null && arrAreas.size() > 0)
			{
				curArea = arrAreas.get(0);

				txtProv.setText(curProv.name);
				txtCity.setText(curCity.name);
				txtArea.setText(curArea.name);
				curRegionID = curArea.uid;

				setDefaultShop();
			}
			else
			{
				txtProv.setText(curProv.name);
				txtCity.setText(curCity.name);
				txtArea.setText("");
				curRegionID = curCity.uid;
				setDefaultShop();
			}
		}
		else if (curAdapter == AREA_ADAPTER)
		{
			STRegion curRegion = getRegionFromID(uid);
			curArea = curRegion;

			txtProv.setText(curProv.name);
			txtCity.setText(curCity.name);
			txtArea.setText(curArea.name);
			curRegionID = curArea.uid;

			setDefaultShop();
		}
	}


	private void onSelectShop(long uid)
	{
		condLayout.setVisibility(View.VISIBLE);
		listLayout.setVisibility(View.GONE);

		if (curAdapter == SHOP_ADAPTER)
		{
			STShop curShop = getShopFromID(uid);
			if (curShop == null)
			{
				txtShop.setText("");
				txtBrand.setText("");
				txtType.setText("");
				curShopID = 0;
				curBrandID = 0;
				curTypeID = 0;
			}
			else
			{
				txtShop.setText(curShop.shopname);
				curShopID = curShop.uid;
				getBrands();
			}
		}
	}


	private void onSelectBrand(long uid)
	{
		condLayout.setVisibility(View.VISIBLE);
		listLayout.setVisibility(View.GONE);

		if (curAdapter == BRAND_ADAPTER)
		{
			STBrand curBrand = getBrandFromID(uid);
			if (curBrand == null)
			{
				txtBrand.setText("");
				txtType.setText("");
				curBrandID = 0;
				curTypeID = 0;
			}
			else
			{
				txtBrand.setText(curBrand.name);
				curBrandID = curBrand.uid;
				getTypes();
			}
		}
	}


	private void onSelectType(long uid)
	{
		condLayout.setVisibility(View.VISIBLE);
		listLayout.setVisibility(View.GONE);

		if (curAdapter == TYPE_ADAPTER)
		{
			STSpec curSpec = getSpecFromID(uid);
			if (curSpec == null)
			{
				txtType.setText("");
				curTypeID = 0;
			}
			else
			{
				txtType.setText(curSpec.name);
			}
		}
	}


	private void getBrands()
	{
		STShop shopInfo = getShopFromRegionID(curRegionID);
		if (shopInfo == null)
			return;

		CommManager.getBrandList(shopInfo.uid, brands_handler);
	}

	private void getTypes()
	{
		STShop shopInfo = getShopFromRegionID(curRegionID);
		if (shopInfo == null)
			return;

		CommManager.getSpecList(shopInfo.uid, curBrandID, types_handler);
	}

	private AsyncHttpResponseHandler brands_handler = new AsyncHttpResponseHandler()
	{
		@Override
		public void onSuccess(String content)
		{
			super.onSuccess(content);    //To change body of overridden methods use File | Settings | File Templates.

			try
			{
				JSONObject jsonObj = new JSONObject(content);
				int nRetCode = jsonObj.getInt("RETCODE");
				String szMsg = jsonObj.getString("RETMSG");

				arrBrands.clear();
				JSONArray arrJsonBrands = jsonObj.getJSONArray("RETDATA");
				for (int i = 0; i < arrJsonBrands.length(); i++)
				{
					JSONObject jsonBrandItem = arrJsonBrands.getJSONObject(i);
					STBrand brandItem = STBrand.decodeFromJSON(jsonBrandItem);
					arrBrands.add(brandItem);
				}

				if (arrBrands.size() > 0)
				{
					STBrand firstBrand = arrBrands.get(0);
					txtBrand.setText(firstBrand.name);
					curBrandID = firstBrand.uid;

					getTypes();
				}
				else
				{
					txtBrand.setText("");
					curBrandID = 0;
					curTypeID = 0;
				}
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}
		}

		@Override
		public void onFailure(Throwable error, String content)
		{
			super.onFailure(error, content);    //To change body of overridden methods use File | Settings | File Templates.
		}
	};


	private AsyncHttpResponseHandler types_handler = new AsyncHttpResponseHandler()
	{
		@Override
		public void onSuccess(String content)
		{
			super.onSuccess(content);    //To change body of overridden methods use File | Settings | File Templates.

			try
			{
				JSONObject jsonObj = new JSONObject(content);
				int nRetCode = jsonObj.getInt("RETCODE");
				String szMsg = jsonObj.getString("RETMSG");

				arrSpecs.clear();
				JSONArray arrJsonSpecs = jsonObj.getJSONArray("RETDATA");
				for (int i = 0; i < arrJsonSpecs.length(); i++)
				{
					JSONObject jsonSpecItem = arrJsonSpecs.getJSONObject(i);
					STSpec specItem = STSpec.decodeFromJSON(jsonSpecItem);
					arrSpecs.add(specItem);
				}

				if (arrSpecs.size() > 0)
				{
					STSpec firstSpec = arrSpecs.get(0);
					txtType.setText(firstSpec.name);
					curTypeID = firstSpec.uid;
				}
				else
				{
					txtType.setText("");
					curTypeID = 0;
				}
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}
		}

		@Override
		public void onFailure(Throwable error, String content)
		{
			super.onFailure(error, content);    //To change body of overridden methods use File | Settings | File Templates.
		}
	};

	private void getProductList()
	{
		STShop shopInfo = getShopFromRegionID(curRegionID);
		if (curRegionID <= 0 || shopInfo == null || curBrandID <= 0 || curTypeID <= 0)
			return;

		String szMinPrice = edtMinPrice.getText().toString();
		String szMaxPrice = edtMaxPrice.getText().toString();

		double minPrice = 0, maxPrice = 0;

		if (szMinPrice.equals("") || szMaxPrice.equals(""))
		{
			Global.showToast(MainActivity.this, getResources().getString(R.string.STR_PLEASE_INPUTPRICE));
			return;
		}

		try
		{
			minPrice = Long.parseLong(szMinPrice);
			maxPrice = Long.parseLong(szMaxPrice);
		}
		catch (Exception ex)
		{
			ex.printStackTrace();

			Global.showToast(MainActivity.this, getResources().getString(R.string.STR_PLEASE_INPUTPRICE));
			return;
		}

		if (minPrice > maxPrice)
		{
			Global.showToast(MainActivity.this, getResources().getString(R.string.STR_PLEASE_INPUTPRICE));
			return;
		}

		startProgress();
		CommManager.getDetInfoList(shopInfo.uid, curBrandID, curTypeID, minPrice, maxPrice, products_handler);
	}


	private AsyncHttpResponseHandler products_handler = new AsyncHttpResponseHandler()
	{
		@Override
		public void onSuccess(String content)
		{
			super.onSuccess(content);    //To change body of overridden methods use File | Settings | File Templates.

			stopProgress();

			try
			{
				JSONObject jsonObj = new JSONObject(content);
				int nRetCode = jsonObj.getInt("RETCODE");
				String szMsg = jsonObj.getString("RETMSG");

				arrPhones.clear();
				JSONArray arrJsonPhones = jsonObj.getJSONArray("RETDATA");
				for (int i = 0; i < arrJsonPhones.length(); i++)
				{
					JSONObject jsonPhoneItem = arrJsonPhones.getJSONObject(i);
					STPhone phoneItem = STPhone.decodeFromJSON(jsonPhoneItem);
					arrPhones.add(phoneItem);
				}

				addPhoneItemsToList();
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
			}
		}

		@Override
		public void onFailure(Throwable error, String content)
		{
			super.onFailure(error, content);    //To change body of overridden methods use File | Settings | File Templates.

			stopProgress();
		}
	};


	private void addPhoneItemsToList()
	{
		scrollContentLayout.removeAllViews();

		for (int i = 0; i < arrPhones.size(); i++)
		{
			RelativeLayout itemLayout = createItemLayout(arrPhones.get(i));
			ResolutionSet.instance.iterateChild(itemLayout, -1, -1);
			scrollContentLayout.addView(itemLayout);
		}
	}

	private RelativeLayout createItemLayout(STPhone phone)
	{
		RelativeLayout itemLayout = new RelativeLayout(scrollContentLayout.getContext());
		itemLayout.setBackgroundColor(Color.WHITE);
		LinearLayout.LayoutParams item_params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 200);
		item_params.setMargins(0, 0, 0, 0);
		itemLayout.setLayoutParams(item_params);

		// Add phone image
		SmartImageView imgView = new SmartImageView(itemLayout.getContext());
		imgView.setBackgroundColor(Color.LTGRAY);
		RelativeLayout.LayoutParams imgViewLayoutaprams = new RelativeLayout.LayoutParams(120, 120);
		imgViewLayoutaprams.setMargins(10, 40, 0, 0);
		imgView.setLayoutParams(imgViewLayoutaprams);
		imgView.setImageUrl(phone.imgpath);
		itemLayout.addView(imgView);


		// Add phone brand
		TextView txtName = new TextView(itemLayout.getContext());
		RelativeLayout.LayoutParams nameLayoutParams = new RelativeLayout.LayoutParams(350, 35);
		nameLayoutParams.setMargins(140, 20, 0, 0);
		txtName.setLayoutParams(nameLayoutParams);
		txtName.setTextColor(Color.BLACK);
		txtName.setTextSize(TypedValue.COMPLEX_UNIT_PX, 27);
		txtName.setText(phone.name);
		itemLayout.addView(txtName);


		// Add phone price
		TextView txtPrice = new TextView(itemLayout.getContext());
		RelativeLayout.LayoutParams priceLayoutParams = new RelativeLayout.LayoutParams(350, 25);
		priceLayoutParams.setMargins(140, 55, 0, 0);
		txtPrice.setLayoutParams(priceLayoutParams);
		txtPrice.setTextColor(Color.BLUE);
		txtPrice.setTextSize(TypedValue.COMPLEX_UNIT_PX, 21);
		txtPrice.setText(getResources().getString(R.string.STR_PHONE_PRICE) + phone.price + getResources().getString(R.string.STR_YUAN));
		itemLayout.addView(txtPrice);


		// Add phone cpu
		TextView txtCpu = new TextView(itemLayout.getContext());
		RelativeLayout.LayoutParams cpuLayoutParams = new RelativeLayout.LayoutParams(350, 25);
		cpuLayoutParams.setMargins(140, 80, 0, 0);
		txtCpu.setLayoutParams(cpuLayoutParams);
		txtCpu.setTextColor(Color.BLUE);
		txtCpu.setTextSize(TypedValue.COMPLEX_UNIT_PX, 21);
		txtCpu.setText(getResources().getString(R.string.STR_PHONE_CPU) + phone.cpu);
		itemLayout.addView(txtCpu);


		// Add phone cpu
		TextView txtScrSize = new TextView(itemLayout.getContext());
		RelativeLayout.LayoutParams scrSizeLayoutParams = new RelativeLayout.LayoutParams(350, 25);
		scrSizeLayoutParams.setMargins(140, 105, 0, 0);
		txtScrSize.setLayoutParams(scrSizeLayoutParams);
		txtScrSize.setTextColor(Color.BLUE);
		txtScrSize.setTextSize(TypedValue.COMPLEX_UNIT_PX, 21);
		txtScrSize.setText(getResources().getString(R.string.STR_PHONE_SCRSIZE) + phone.dispsize);
		itemLayout.addView(txtScrSize);


		// Add phone cpu
		TextView txtCam = new TextView(itemLayout.getContext());
		RelativeLayout.LayoutParams camLayoutParams = new RelativeLayout.LayoutParams(350, 25);
		camLayoutParams.setMargins(140, 130, 0, 0);
		txtCam.setLayoutParams(camLayoutParams);
		txtCam.setTextColor(Color.BLUE);
		txtCam.setTextSize(TypedValue.COMPLEX_UNIT_PX, 21);
		txtCam.setText(getResources().getString(R.string.STR_PHONE_CAM) + phone.pixcnt);
		itemLayout.addView(txtCam);


		// Add phone system version
		TextView txtSysVer = new TextView(itemLayout.getContext());
		RelativeLayout.LayoutParams verLayoutParams = new RelativeLayout.LayoutParams(350, 25);
		verLayoutParams.setMargins(140, 155, 0, 0);
		txtSysVer.setLayoutParams(verLayoutParams);
		txtSysVer.setTextColor(Color.BLUE);
		txtSysVer.setTextSize(TypedValue.COMPLEX_UNIT_PX, 21);
		txtSysVer.setText(getResources().getString(R.string.STR_PHONE_SYSVER) + phone.osver);
		itemLayout.addView(txtSysVer);


		// Add separator
		View sepView = new View(itemLayout.getContext());
		RelativeLayout.LayoutParams sepLayoutParams = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 1);
		sepView.setLayoutParams(sepLayoutParams);
		sepView.setBackgroundColor(Color.LTGRAY);
		itemLayout.addView(sepView);


		return itemLayout;
	}
}