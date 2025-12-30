using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YingytSite.Models;
using YingytSite.Models.Library;
using System.Web.Script.Serialization;
using System.Text;

namespace YingytSite.Areas.Lobby.Controllers
{
    public class LBriefController : Controller
    {
        PhoneModel phoneModel = new PhoneModel();
        VideoModel videoModel = new VideoModel();
        ImageModel imageModel = new ImageModel();

        #region 智能手机库
        [Authorize]
        public ActionResult LPhoneList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "PhoneList";

            return View();
        }

        [Authorize]
        [AjaxOnly]
        //public virtual ActionResult GetPhoneList(string sidx, string sord, int page, int rows)
        public virtual ActionResult GetBrandList(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            var brandlist = PhoneModel.GetBrandList();

            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = brandlist.Count();
            var totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            if (_search)
            {
                var serializer = new JavaScriptSerializer();
                JqGridFilters f = serializer.Deserialize<JqGridFilters>(filters);

                if (f.rules.Count > 0)
                {
                    var sb = new StringBuilder();

                    foreach (JqGridFilters.Rule rule in f.rules)
                    {
                        if (sb.Length != 0)
                            sb.Append(f.groupOp);

                        sb.AppendFormat(JqGridFilters.FormatMapping[(int)rule.op], rule.field, rule.data);
                    }

                    brandlist = phoneModel.GetBrandFilterList(brandlist, sb.ToString());
                    //phones = phones.Where(x => x.serial.Contains("WW")).ToList();
                }
            }
            //else
            //{
                brandlist = brandlist.Skip(pageIndex * pageSize).Take(pageSize).ToList();
            //}

            long user_id = CommonModel.GetCurrentUserId();
            var jsonData = new
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (
                    from spec in brandlist
                    select new
                    {
                        id = spec.uid.ToString(),
                        brandname = spec.brandname,
                        note = spec.note,
                        sortid = spec.sortid.ToString(),
                        username = (spec.user_id == user_id) ? "我的品牌" : AgentModel.GetAgentName(spec.user_id)
                    }).ToList()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult EditBrand(FormCollection formCollection)
        {

            long id = 0;
            string brandname = "", note = "", sortid = "";
            string rst = "";

            var operation = formCollection["oper"];
            if (operation != "del")
            {
                if (formCollection["id"] != null)
                {
                    try
                    {
                        id = long.Parse(formCollection["id"]);
                    }
                    catch (System.Exception ex)
                    {

                    }
                }
                if (formCollection["brandname"] != null)
                {
                    brandname = formCollection["brandname"].ToString();
                }
                if (formCollection["note"] != null)
                {
                    note = formCollection["note"].ToString();
                }
                if (formCollection["sortid"] != null)
                {
                    sortid = formCollection["sortid"].ToString();
                }

                rst = phoneModel.InserOrUpdateDeleteBrand(id, brandname, note, sortid, operation);
            }
            else
            {
                if (formCollection["id"] != null)
                {
                    string[] ids = formCollection["id"].Split(',');
                    long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
                    rst = phoneModel.DeleteBrand(selcheckbox);
                }
            }            

            return Content(rst);
        }

        [Authorize]
        [AjaxOnly]
        public virtual ActionResult GetSpecList(long brandid, string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            var sublist = phoneModel.GetSpecListById(brandid);

            var pageIndex = Convert.ToInt32(page) - 1;
            var pageSize = rows;
            var totalRecords = sublist.Count();
            var totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            if (_search)
            {
                var serializer = new JavaScriptSerializer();
                JqGridFilters f = serializer.Deserialize<JqGridFilters>(filters);

                if (f.rules.Count > 0)
                {
                    var sb = new StringBuilder();

                    foreach (JqGridFilters.Rule rule in f.rules)
                    {
                        if (sb.Length != 0)
                            sb.Append(f.groupOp);

                        sb.AppendFormat(JqGridFilters.FormatMapping[(int)rule.op], rule.field, rule.data);
                    }

                    sublist = phoneModel.GetSpecFilterList(sublist, sb.ToString());
                    //phones = phones.Where(x => x.serial.Contains("WW")).ToList();
                }
            }

            sublist = sublist.Skip(pageIndex * pageSize).Take(pageSize).ToList();

            long user_id = CommonModel.GetCurrentUserId();
            var jsonData = new
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (
                    from app in sublist
                    select new
                    {
                        id = app.uid.ToString(),
                        specvalue = app.specvalue,
                        specsortid = app.sortid.ToString(),
                        username = (app.user_id == user_id) ? "我的型号" : AgentModel.GetAgentName(app.user_id)
                    }).ToList()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult EditSpec(long brandid, FormCollection formCollection)
        {

            long id = 0;
            string specvalue = "", specsortid = "";
            string rst = "";

            var operation = formCollection["oper"];
            if (formCollection["id"] != null)
            {
                try
                {
                    id = long.Parse(formCollection["id"]);
                }
                catch (System.Exception ex)
                {

                }
            }
            if (formCollection["specvalue"] != null)
            {
                specvalue = formCollection["specvalue"].ToString();
            }
            if (formCollection["specsortid"] != null)
            {
                specsortid = formCollection["specsortid"].ToString();
            }

            if (operation.Equals("add") || operation.Equals("edit"))
            {
                 rst = phoneModel.InserOrUpdateSpec(brandid, id, specvalue, specsortid, 0,0, operation);
            }
            else if (operation.Equals("del"))
            {
                if (formCollection["id"] != null)
                {
                    string[] ids = formCollection["id"].Split(',');
                    long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
                    rst = phoneModel.DeleteSpec(brandid, selcheckbox);
                }
                //phoneModel.DeleteSpec(brandid, id);
            }

            //return Content(repository.HasErrors.ToString().ToLower());
            return Content("");
        }

        [Authorize]
        [HttpPost]
        public JsonResult DeleteBrand(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            string rst = phoneModel.DeleteBrand(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult CheckUniqueBrandname(string brandname, long uid)
        {
            bool rst = phoneModel.CheckDuplicateName(brandname, uid);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public virtual ActionResult GetAuthority(long id, string type)
        {
            bool rst = true;
            if (type == "brand")
                rst = phoneModel.CheckBrandAuthority(id);
            else
                rst = phoneModel.CheckSpecAuthority(id);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region 视频库
        [Authorize]
        public ActionResult LVideoList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "MyVideoList";

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLVideoList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = videoModel.GetVideoDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult AddLVideo()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "VideoList";

            return View();
        }

        [Authorize]
        public ActionResult EditLVideo(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "VideoList";

            var videoinfo = videoModel.GetVideoById(id);
            ViewData["videoinfo"] = videoinfo;
            ViewData["uid"] = videoinfo.uid;

            return View("AddLVideo");
        }

        [Authorize]
        public ActionResult AddLMarketVideo(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "VideoList";

            ViewData["dataid"] = id;

            return View("AddLVideo");
        }

        [Authorize]
        [HttpPost]
        public JsonResult DeleteLVideo(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = videoModel.DeleteVideo(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitLVideo(long uid, string videoname, string filename, string path, long filesize, long dataid)
        {
            string rst = "";
            path = path.Trim(new char[] { '\"' });
            if (uid == 0)
            {
                rst = videoModel.InsertVideo(videoname, filename, filesize, path);
            }
            else
            {
                rst = videoModel.UpdateVideo(uid, videoname, filename, filesize, path);
            }

            if (dataid > 0 && rst == "")
            {
                long lastid = videoModel.GetLastInsertedId();
                MarketModel marketModel = new MarketModel();
                marketModel.SelectAVideo(dataid, new long[] { lastid });
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult CheckUniqueVideoname(long vid, string videoname)
        {
            bool rst = VideoModel.CheckDuplicateName(vid, videoname);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 图片库
        [Authorize]
        public ActionResult LImageList()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "ImageList";

            return View();
        }

        [Authorize]
        [AjaxOnly]
        public JsonResult RetrieveLImageList(JQueryDataTableParamModel param)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            JqDataTableInfo rst = imageModel.GetImageDataTable(param, Request.QueryString, rootUri);
            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        public ActionResult AddLImage()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "ImageList";

            return View();
        }

        [Authorize]
        public ActionResult EditLImage(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "ImageList";

            var imageinfo = imageModel.GetImageById(id);
            ViewData["imageinfo"] = imageinfo;
            ViewData["uid"] = imageinfo.uid;

            return View("AddLImage");
        }

        [Authorize]
        public ActionResult AddLMarketImage(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));

            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "BriefCase";
            ViewData["level2nav"] = "ImageList";

            ViewData["dataid"] = id;

            return View("AddLImage");
        }

        [Authorize]
        [HttpPost]
        public JsonResult DeleteLImage(string delids)
        {
            string[] ids = delids.Split(',');
            long[] selcheckbox = ids.Where(m => !String.IsNullOrWhiteSpace(m)).Select(m => long.Parse(m)).ToArray();
            bool rst = imageModel.DeleteImage(selcheckbox);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [Authorize]
        [HttpPost]
        [AjaxOnly]
        public JsonResult SubmitLImage(long uid, string imagename, string filename, string path, long filesize, long dataid)
        {
            string rst = "";
            path = path.Trim(new char[] { '\"' });
            if (uid == 0)
            {
                rst = imageModel.InsertImage(imagename, filename, filesize, path);
            }
            else
            {
                rst = imageModel.UpdateImage(uid, imagename, filename, filesize, path);
            }

            if (dataid > 0 && rst == "")
            {
                long lastid = imageModel.GetLastInsertedId();
                MarketModel marketModel = new MarketModel();
                marketModel.SelectAVideo(dataid, new long[] { lastid });
            }

            return Json(rst, JsonRequestBehavior.AllowGet);
        }

        [AjaxOnly]
        public JsonResult CheckUniqueImagename(long iid, string imagename)
        {
            bool rst = ImageModel.CheckDuplicateName(iid, imagename);

            return Json(rst, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }
}
