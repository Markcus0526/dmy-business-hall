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

namespace YingytSite.Areas.Agent.Controllers
{
    public class AMarketController : Controller
    {
        MarketModel marketModel = new MarketModel();

        #region 演示视频
        [Authorize]
        public ActionResult AVideoList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "VideoList";

            long user_id = CommonModel.GetCurrentUserId();
            ViewData["lobbylist"] = AgentModel.GetLobbyListForAgentId(user_id);
            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveAVideoList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long lobby_id = 0;
            try { lobby_id = long.Parse(Request.QueryString["lobby"]); }
            catch (Exception e) { }
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetYanshivideoDataTable(param, Request.QueryString, rootUri, lobby_id, brand_id);
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
        public ActionResult ASplashList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "SplashList";

            long user_id = CommonModel.GetCurrentUserId();
            ViewData["lobbylist"] = AgentModel.GetLobbyListForAgentId(user_id);
            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveASplashList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long lobby_id = 0;
            try { lobby_id = long.Parse(Request.QueryString["lobby"]); }
            catch (Exception e) { }
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetSplashDataTable(param, Request.QueryString, rootUri, lobby_id, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 首页图片
        [Authorize]
        public ActionResult AHomeImgList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "HomeImgList";

            long user_id = CommonModel.GetCurrentUserId();
            ViewData["lobbylist"] = AgentModel.GetLobbyListForAgentId(user_id);
            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveAHomeImgList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long lobby_id = 0;
            try { lobby_id = long.Parse(Request.QueryString["lobby"]); }
            catch (Exception e) { }
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetHomeImgDataTable(param, Request.QueryString, rootUri, lobby_id, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 手机亮点
        [Authorize]
        public ActionResult ABrightSpotList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "BrightSpotList";

            long user_id = CommonModel.GetCurrentUserId();
            ViewData["lobbylist"] = AgentModel.GetLobbyListForAgentId(user_id);
            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveABrightSpotList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long lobby_id = 0;
            try { lobby_id = long.Parse(Request.QueryString["lobby"]); }
            catch (Exception e) { }
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }

            JqDataTableInfo rst = marketModel.GetBrightspotDataTable(param, Request.QueryString, rootUri, lobby_id, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult AManageBrightSpot(long id)
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
        public JsonResult DelBriSpotImgItem(long delid)
        {
            bool rst = false;
            rst = marketModel.DeleteData(delid);

            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveBrightSpotItemList(long id, string idsortlist, string delids)//NameValueCollection formdata)
        {
            string rootpath = HostingEnvironment.MapPath("~/");

            //string idlist = formdata["idsortlist"].ToString();
            //List<NestableImgID> dataids = JsonConvert.DeserializeObject<List<NestableImgID>>(idlist);

            List<NestableImgID> dataids = JsonConvert.DeserializeObject<List<NestableImgID>>(idsortlist);

            bool rst = marketModel.UpdateAndroidDataList(id, dataids);

            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            rst &= marketModel.DeleteData(selcheckbox);

            /*foreach (NestableImgID item in ids)
            {
                if (item.id.Length > 5 && item.id.Substring(0, 4) == "new_")
                {
                    string idstr = item.id.Substring(4);
                    tbl_albumitem newitem = new tbl_albumitem();

                    newitem.title = formdata["title_" + idstr].ToString();
                    newitem.description = formdata["desc_" + idstr].ToString();
                    newitem.sortid = i;
                    newitem.url = MoveImageFile(idstr);
                    db.tbl_albumitems.InsertOnSubmit(newitem);
                }
                else
                {
                    long id = long.Parse(item.id);
                    tbl_albumitem edititem = (from m in db.tbl_albumitems
                                              where m.deleted == 0 && m.uid == id
                                              select m).FirstOrDefault();

                    if (edititem != null)
                    {
                        edititem.sortid = i;
                        edititem.title = formdata["title_" + item.id].ToString();
                        edititem.description = formdata["desc_" + item.id].ToString();
                    }

                }
                i++;
            }
            db.SubmitChanges();*/

           return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult GetNestableImgInfo(long id, string selids)
        {
            string[] ids = selids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            var retlist = ImageModel.GetNestableImgList(id, selcheckbox);

            return Json(retlist, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult InsertAndGetNestableImgInfo(string data)
        {
            List<UploadFileInfo> filelist = JsonConvert.DeserializeObject<List<UploadFileInfo>>(data);

            ImageModel imageModel = new ImageModel();
            var retlist = imageModel.InsertAndGetNestableImgInfo(filelist);

            return Json(retlist, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 购机套餐
        [Authorize]
        public ActionResult ABuySetList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Market";
            ViewData["level2nav"] = "BuySetList";

            long user_id = CommonModel.GetCurrentUserId();
            ViewData["lobbylist"] = AgentModel.GetLobbyListForAgentId(user_id);
            ViewData["brandlist"] = PhoneModel.GetBrandList();

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveABuySetList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            long lobby_id = 0;
            try { lobby_id = long.Parse(Request.QueryString["lobby"]); }
            catch (Exception e) { }
            long brand_id = 0;
            try { brand_id = long.Parse(Request.QueryString["brand"]); }
            catch (Exception e) { }


            JqDataTableInfo rst = marketModel.GetBuysetDataTable(param, Request.QueryString, rootUri, lobby_id, brand_id);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult AManageBuySet(long id)
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

    }
}
