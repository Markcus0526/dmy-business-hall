using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using YingytSite.Models.Library;
using System.Collections.Specialized;
using System.Web.Hosting;
using Newtonsoft.Json;

namespace YingytSite.Areas.Lobby.Controllers
{
    public class LMarketController : Controller
    {
        MarketModel marketModel = new MarketModel();

        #region 演示视频
        [Authorize]
        public ActionResult LVideoList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "VideoList";

            long user_id = CommonModel.GetCurrentUserId();
            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLVideoList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetYanshivideoDataTable(param, Request.QueryString, rootUri, 0, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        public JsonResult BlockAVideo(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = marketModel.BlockAVideo(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        public JsonResult UnblockAVideo(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = marketModel.UnblockAVideo(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        public JsonResult SelectAVideo(long id, string selids)
        {
            string[] ids = selids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = marketModel.SelectAVideo(id, selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region SPLASH图片
        [Authorize]
        public ActionResult LSplashList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "SplashList";

            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLSplashList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long lobby_id = 0;
            try { lobby_id = long.Parse(Request.QueryString["lobby"]); }
            catch (Exception e) { }
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetSplashDataTable(param, Request.QueryString, rootUri, 0, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 首页图片
        [Authorize]
        public ActionResult LHomeImgList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "HomeImgList";

            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLHomeImgList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long lobby_id = 0;
            try { lobby_id = long.Parse(Request.QueryString["lobby"]); }
            catch (Exception e) { }
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetHomeImgDataTable(param, Request.QueryString, rootUri, 0, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 手机亮点
        [Authorize]
        public ActionResult LBrightSpotList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "BrightSpotList";

            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLBrightSpotList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetBrightspotDataTable(param, Request.QueryString, rootUri, 0, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult LManageBrightSpot(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "BrightSpotList";

            ViewData["androiddata_id"] = id;
            ViewData["items"] = marketModel.GetDataList(id);

            return View();
        }

        /// <summary>
        /// 선택된 亮点그림을 삭제한다.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="delid"></param>
        /// <returns></returns>
        public JsonResult DelBriSpotImgItem(long id, long delid)
        {
            bool rst = false;
            rst = marketModel.DeleteData(delid);

            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveBrightSpotItemList(long id, string idsortlist, string delids)//NameValueCollection formdata)
        {
            string rootpath = HostingEnvironment.MapPath("~/");
            
            List<NestableImgID> dataids = JsonConvert.DeserializeObject<List<NestableImgID>>(idsortlist);

            bool rst = marketModel.UpdateAndroidDataList(id, dataids);

            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            rst &= marketModel.DeleteData(selcheckbox);           

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult GetNestableImgInfo(long id, string selids)
        {
            string[] ids = selids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            NestableImgInfo imgInfo = ImageModel.GetNestableImgInfo(id, selcheckbox[0]);

            return Json(imgInfo, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 购机套餐
        [Authorize]
        public ActionResult LBuySetList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "BuySetList";

            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLBuySetList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }


            JqDataTableInfo rst = marketModel.GetBuysetDataTable(param, Request.QueryString, rootUri, 0, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult LManageBuySet(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "BuySetList";

            ViewData["androiddata_id"] = id;
            ViewData["items"] = marketModel.GetDataList(id);

            return View();
        }

        /// <summary>
        /// 선택된 亮点그림을 삭제한다.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="delid"></param>
        /// <returns></returns>
        /*public JsonResult DelBuySetImgItem(long id, long delid)
        {
            bool rst = false;
            //             tbl_albumitem delitem = (from m in db.tbl_albumitems
            //                                      where m.deleted == 0 && m.uid == delid
            //                                      select m).FirstOrDefault();
            // 
            //             if (delitem != null)
            //             {
            //                 delitem.deleted = 1;
            //                 db.SubmitChanges();
            // 
            //                 rst =  true;
            //             }

            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public bool SaveBuySetItemList(long id, NameValueCollection formdata)
        {
            string rootpath = HostingEnvironment.MapPath("~/");
            string idlist = formdata["idsortlist"].ToString();
            List<NestableImgID> ids = JsonConvert.DeserializeObject<List<NestableImgID>>(idlist);
            int i = 1;

            //             foreach (NestableImgID item in ids)
            //             {
            //                 if (item.id.Length > 5 && item.id.Substring(0, 4) == "new_")
            //                 {
            //                     string idstr = item.id.Substring(4);
            //                     tbl_albumitem newitem = new tbl_albumitem();
            // 
            //                     newitem.title = formdata["title_" + idstr].ToString();
            //                     newitem.description = formdata["desc_" + idstr].ToString();
            //                     newitem.sortid = i;
            //                     newitem.url = MoveImageFile(idstr);
            //                     db.tbl_albumitems.InsertOnSubmit(newitem);
            //                 }
            //                 else
            //                 {
            //                     long id = long.Parse(item.id);
            //                     tbl_albumitem edititem = (from m in db.tbl_albumitems
            //                                               where m.deleted == 0 && m.uid == id
            //                                               select m).FirstOrDefault();
            // 
            //                     if (edititem != null)
            //                     {
            //                         edititem.sortid = i;
            //                         edititem.title = formdata["title_" + item.id].ToString();
            //                         edititem.description = formdata["desc_" + item.id].ToString();
            //                     }
            // 
            //                 }
            //                 i++;
            //             }
            //             db.SubmitChanges();

            return true;
        }*/

        #endregion

        #region 活动专区
        [Authorize]
        public ActionResult BigWheel()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "Activity";
            ViewData["level3nav"] = "BigWheel";

            ViewData["giftinfo"] = marketModel.GetGifts();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLSNNumberList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = marketModel.GetSNNumberDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitGifts(string status, string gift1name, string gift1cnt, string gift2name, string gift2cnt,
            string gift3name, string gift3cnt, string gift4name, string gift4cnt,
            string gift5name, string gift5cnt, string gift6name, string gift6cnt,
            decimal percent, string password, string wheelpass)
        {
            string rst = "";   
            byte bstatus = (byte)(status == "on" ? 1 : 0);
            int igift1cnt = 0; try { igift1cnt = int.Parse(gift1cnt); }
            catch (Exception e) { }
            int igift2cnt = 0; try { igift2cnt = int.Parse(gift2cnt); }
            catch (Exception e) { }
            int igift3cnt = 0; try { igift3cnt = int.Parse(gift3cnt); }
            catch (Exception e) { }
            int igift4cnt = 0; try { igift4cnt = int.Parse(gift4cnt); }
            catch (Exception e) { }
            int igift5cnt = 0; try { igift5cnt = int.Parse(gift5cnt); }
            catch (Exception e) { }
            int igift6cnt = 0; try { igift6cnt = int.Parse(gift6cnt); }
            catch (Exception e) { }

            rst = marketModel.InsertOrUpdateGifts(bstatus, gift1name, igift1cnt, gift2name, igift2cnt,
                gift3name, igift3cnt, gift4name, igift4cnt,
                gift5name, igift5cnt, gift6name, igift6cnt,
                percent, password, wheelpass);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        public JsonResult ChouzhongGift(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = marketModel.ChouzhongGift(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        public JsonResult DuijiangGift(string updateids)
        {
            string[] ids = updateids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = marketModel.DuijiangGift(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 手机详细信息
        [Authorize]
        public ActionResult LPhoneDetail()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "PhoneDetail";

            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLPhoneDetail(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetPhoneDetailDataTable(param, Request.QueryString, rootUri, 0, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult LManagePhoneDetail(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "PhoneDetail";

            ViewData["uid"] = id;
            ViewData["detailinfo"] = marketModel.GetAndroidDetailInfoById(id);

            return View();
        }

        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitAndroidDetail(long uid, string title, string imgurl1, string imgurl2, string imgurl3, string imgurl4,
            string description, decimal recommprice, decimal realprice, decimal screensize, string screenshowsize,
            string cpu, string showcpu, int memsize, string memshowsize, long pixcnt, string pixshowcnt, 
            decimal osver, string osshowver)
        {
            string rst = "";

            if (uid > 0)
            {
                rst = marketModel.UpdateAndroidDetail(uid, title, imgurl1, imgurl2, imgurl3, imgurl4, description,
                    recommprice, realprice, screensize, screenshowsize, cpu, showcpu, memsize, memshowsize,
                    pixcnt, pixshowcnt, osver, osshowver);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult LManagePhoneRel(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "PhoneDetail";

            ViewData["androiddetail_id"] = id;
            var detrelinfo = marketModel.GetAndroidDetrelInfoByDetailid(id);
            ViewData["detrelinfo"] = detrelinfo;
            if (detrelinfo != null)
            {
                ViewData["uid"] = detrelinfo.uid;
                ViewData["reldetaillist"] = marketModel.GetAndroidRelDetailListForId(detrelinfo.uid);
            }

            return View();
        }

        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitAndroidDetrel(long uid, decimal minprice, decimal maxprice, decimal minscrsize, decimal maxscrsize,
            int minmemsize, int maxmemsize, long minpixcnt, long maxpixcnt, decimal minosver, decimal maxosver, string reldetailids)
        {
            string rst = "";

            if (uid > 0)
            {
                rst = marketModel.UpdateAndroidDetrel(uid, minprice, maxprice, minscrsize, maxscrsize, minmemsize, maxmemsize,
                    minpixcnt, maxpixcnt, minosver, maxosver, reldetailids);
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLPhoneDetail2(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = marketModel.GetPhoneDetailDataTable2(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        #endregion
    }
}
