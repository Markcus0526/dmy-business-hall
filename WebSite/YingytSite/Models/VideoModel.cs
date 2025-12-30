using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;
using DirectShowLib;
using DirectShowLib.DES;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.IO;
using System.Web.Hosting;

namespace YingytSite.Models
{
    #region Models
    public class VideoInfo
    {
        public long uid { get; set; }
        public string title { get; set; }
        public string filename { get; set; }
        public long filesize { get; set; }
        public int length { get; set; }
        public long user_id { get; set; }
        public string path { get; set; }
    }
    #endregion

    public class VideoModel
    {
        static YingytDBDataContext db = new YingytDBDataContext();

        #region CRUD
        public List<VideoInfo> GetVideoList()
        {
            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            if (usertype == "lobby" && allowShare == 1)
            {
                return db.tbl_videos
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id/*m.parentid == parentid*/))
                    .OrderByDescending(m => m.uid)
                    .Select(m => new VideoInfo
                    {
                        uid = m.uid,
                        title = m.title,
                        filename = m.filename,
                        filesize = m.filesize,
                        length = m.length,
                        user_id = m.user_id,
                        path = m.path
                    })
                    .ToList();
            }
            else
            {
                return db.tbl_videos
                    .Where(m => m.deleted == 0 && (m.user_id == user_id || m.parentid == user_id))
                    .OrderByDescending(m => m.uid)
                    .Select(m => new VideoInfo
                    {
                        uid = m.uid,
                        title = m.title,
                        filename = m.filename,
                        filesize = m.filesize,
                        length = m.length,
                        user_id = m.user_id,
                        path = m.path
                    })
                    .ToList();
            }
        }

        public JqDataTableInfo GetVideoDataTable(JQueryDataTableParamModel param, NameValueCollection Request, String rootUri)
        {
            JqDataTableInfo rst = new JqDataTableInfo();
            IEnumerable<VideoInfo> filteredCompanies;

            List<VideoInfo> alllist = GetVideoList();

            //Check whether the companies should be filtered by keyword
            if (!string.IsNullOrEmpty(param.sSearch))
            {
                //Used if particulare columns are filtered 
                var nameFilter = Convert.ToString(Request["sSearch_1"]);

                //Optionally check whether the columns are searchable at all 
                var isNameSearchable = Convert.ToBoolean(Request["bSearchable_1"]);

                filteredCompanies = alllist
                   .Where(c => isNameSearchable && c.title.ToLower().Contains(param.sSearch.ToLower()));
            }
            else
            {
                filteredCompanies = alllist;
            }

            var isNameSortable = Convert.ToBoolean(Request["bSortable_1"]);
            var sortColumnIndex = Convert.ToInt32(Request["iSortCol_0"]);
            Func<VideoInfo, string> orderingFunction = (c => sortColumnIndex == 1 && isNameSortable ? c.title :
                                                           "");

            var sortDirection = Request["sSortDir_0"]; // asc or desc
            if (sortDirection == "asc")
                filteredCompanies = filteredCompanies.OrderBy(orderingFunction);
            else
                filteredCompanies = filteredCompanies.OrderByDescending(orderingFunction);

            var displayedCompanies = filteredCompanies.Skip(param.iDisplayStart);
            if (param.iDisplayLength > 0)
            {
                displayedCompanies = displayedCompanies.Take(param.iDisplayLength);
            }

            long userid = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            var result = from c in displayedCompanies
                         select new[] { 
                Convert.ToString(c.uid), 
                c.title,
                c.filename,
                CommonModel.GetFileSizeString(c.filesize),
                Convert.ToString(c.length), 
                (c.user_id == userid) ? "我的视频":AgentModel.GetAgentName(c.user_id),
                Convert.ToString(c.uid),
                (usertype == "agent" || c.user_id == userid) ? "1" : "0"
            };

            rst.sEcho = param.sEcho;
            rst.iTotalRecords = alllist.Count();
            rst.iTotalDisplayRecords = filteredCompanies.Count();
            rst.aaData = result;

            return rst;
        }

        public bool DeleteVideo(long[] items)
        {
            string delSql = "UPDATE tbl_video SET deleted = 1 WHERE ";
            string whereSql = "";
            foreach (long uid in items)
            {
                if (whereSql != "") whereSql += " OR";
                whereSql += " uid = " + uid;
            }

            delSql += whereSql;

            db.ExecuteCommand(delSql);

            return true;
        }

        public tbl_video GetVideoById(long uid)
        {
            return db.tbl_videos
               .Where(m => m.deleted == 0 && m.uid == uid)
               .FirstOrDefault();
        }

        public static string GetVideoNameById(long uid)
        {
            if (uid == 0)
                return "--无视频--";

            tbl_video item = db.tbl_videos
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.filename;
            else
                return "--视频不存在--";
        }

        public static string GetVideoPathById(long uid)
        {
            tbl_video item = db.tbl_videos
                .Where(m => m.deleted == 0 && m.uid == uid)
                .FirstOrDefault();

            if (item != null)
                return item.path;
            else
                return "";
        }

        public string InsertVideo(string title, string filename, long filesize, string path)
        {
            string rootpath = HostingEnvironment.MapPath("~/");
            string ext = Path.GetExtension(filename);
            string dur = "";
            if (ext.ToLower() == ".mp4")
                dur = GetFFMpegVideoLength(rootpath + path);
            else
            {
                dur = GetFFMpegVideoLengthAfterConvert(rootpath + path);
                File.Delete(rootpath + path);

                filename = filename.Substring(0, filename.Length - ext.Length) + ".mp4";
                path = path.Substring(0, path.Length - ext.Length) + ".mp4";

                filesize = GetFileSize(rootpath + path);
            }

            double duration = 0;
            try { duration = Convert.ToDateTime(dur).TimeOfDay.TotalSeconds; }
            catch (Exception e) { return "文件格式错误"; }

            tbl_video newitem = new tbl_video();

            newitem.user_id = CommonModel.GetCurrentUserId();
            newitem.title = title;
            newitem.filename = filename;
            newitem.filesize = filesize;
            newitem.length = (int)duration;
            newitem.path = path;
            long user_id = CommonModel.GetCurrentUserId();
            newitem.user_id = user_id;
            newitem.parentid = AgentModel.GetAgentParentid(user_id);

            db.tbl_videos.InsertOnSubmit(newitem);

            db.SubmitChanges();

            return "";
        }

        public string UpdateVideo(long uid, string title, string filename, long filesize, string path)
        {
            string rootpath = HostingEnvironment.MapPath("~/");
            string ext = Path.GetExtension(filename);
            string dur = "";
            if (ext.ToLower() == ".mp4")
                dur = GetFFMpegVideoLength(rootpath + path);
            else
            {
                dur = GetFFMpegVideoLengthAfterConvert(rootpath + path);
                File.Delete(rootpath + path);

                filename = filename.Substring(0, filename.Length - ext.Length) + ".mp4";
                path = path.Substring(0, path.Length - ext.Length) + ".mp4";

                filesize = GetFileSize(rootpath + path);
            }

            double duration = 0;
            try { duration = Convert.ToDateTime(dur).TimeOfDay.TotalSeconds; }
            catch (Exception e) { return "文件格式错误"; }

            string rst = "";
            tbl_video edititem = GetVideoById(uid);

            if (edititem != null)
            {
                //edititem.user_id = CommonModel.GetCurrentUserId();
                edititem.title = title;
                edititem.filename = filename;
                edititem.filesize = filesize;
                edititem.length = (int)duration;
                edititem.path = path;
                //long user_id = CommonModel.GetCurrentUserId();
                //edititem.user_id = user_id;
                //edititem.parentid = AgentModel.GetAgentParentid(user_id);

                db.SubmitChanges();
                rst = "";
            }
            else
            {
                rst = "视频不存在";
            }
             
            return rst;
        }

        public static bool CheckDuplicateName(long vid, string title)
        {
            long user_id = CommonModel.GetCurrentUserId();
            string usertype = CommonModel.GetCurrentUserType();
            long parentid = AgentModel.GetAgentParentid(user_id);
            byte allowShare = AgentModel.GetAgentAllowshare(parentid);
            long share_id = AgentModel.GetAgentShareLobbyId(parentid);

            bool rst = true;
            if (usertype == "lobby" && allowShare == 1)
            {
                rst = ((from m in db.tbl_videos
                        where m.deleted == 0 && m.title == title && m.uid != vid && (m.user_id == user_id || m.user_id == parentid || m.user_id == share_id)
                        select m).FirstOrDefault() == null);
            }
            else
            {
                rst = ((from m in db.tbl_videos
                        where m.deleted == 0 && m.title == title && m.uid != vid && m.user_id == user_id
                        select m).FirstOrDefault() == null);
            }

            return rst;
        }

        public long GetLastInsertedId()
        {
            return db.tbl_videos
                .Where(m => m.deleted == 0)
                .OrderByDescending(m => m.uid)
                .FirstOrDefault()
                .uid;
        }

        #endregion

        #region MediaGet lib
        //public double GetVideoLength(string fname)
        //{
        //    var mediaDet = (IMediaDet)new MediaDet();
        //    DsError.ThrowExceptionForHR(mediaDet.put_Filename(fname));

        //    // find the video stream in the file
        //    int index;
        //    var type = Guid.Empty;
        //    for (index = 0; index < 1000 && type != MediaType.Video; index++)
        //    {
        //        mediaDet.put_CurrentStream(index);
        //        mediaDet.get_StreamType(out type);
        //    }

        //    // retrieve some measurements from the video
        //    double frameRate;
        //    mediaDet.get_FrameRate(out frameRate);

        //    var mediaType = new AMMediaType();
        //    mediaDet.get_StreamMediaType(mediaType);
        //    var videoInfo = (VideoInfoHeader)Marshal.PtrToStructure(mediaType.formatPtr, typeof(VideoInfoHeader));
        //    DsUtils.FreeAMMediaType(mediaType);
        //    var width = videoInfo.BmiHeader.Width;
        //    var height = videoInfo.BmiHeader.Height;

        //    double mediaLength;
        //    mediaDet.get_StreamLength(out mediaLength);
        //    var frameCount = (int)(frameRate * mediaLength);
        //    var duration = frameCount / frameRate;

        //    return duration;
        //}

        public string GetFFMpegVideoLength(string fname)
        {
            string rootpath = HostingEnvironment.MapPath("~/");
            string oname = fname.Substring(0, fname.Length - Path.GetExtension(fname).Length) + ".mp4";

            using (Process ffmpeg = new Process())
            {
                String duration;  // soon will hold our video's duration in the form "HH:MM:SS.UU"
                String result;  // temp variable holding a string representation of our video's duration
                StreamReader errorreader;  // StringWriter to hold output from ffmpeg

                // we want to execute the process without opening a shell
                ffmpeg.StartInfo.UseShellExecute = false;
                ffmpeg.StartInfo.ErrorDialog = false;

                // redirect StandardError so we can parse it
                // for some reason the output comes through over StandardError
                ffmpeg.StartInfo.RedirectStandardError = true;

                // set the file name of our process, including the full path
                // (as well as quotes, as if you were calling it from the command-line)
                ffmpeg.StartInfo.FileName = rootpath + "Content/ffmpeg/ffmpeg.exe";

                // set the command-line arguments of our process, including full paths of any files
                // (as well as quotes, as if you were passing these arguments on the command-line)
                //ffmpeg.StartInfo.Arguments = "-v 0 -y -i \"" + fname + "\" " + oname;
                ffmpeg.StartInfo.Arguments = "-i \"" + fname + "\"";

                ffmpeg.StartInfo.CreateNoWindow = true;
                ffmpeg.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;

                // start the process
                ffmpeg.Start();

                // now that the process is started, we can redirect output to the StreamReader we defined
                errorreader = ffmpeg.StandardError;

                // wait until ffmpeg comes back
                int time_to_wait_in_milliseconds = 10;
                ffmpeg.WaitForExit(time_to_wait_in_milliseconds);

                // read the output from ffmpeg, which for some reason is found in Process.StandardError
                result = errorreader.ReadToEnd();

                // a little convoluded, this string manipulation...
                // working from the inside out, it:
                // takes a substring of result, starting from the end of the "Duration: " label contained within,
                // (execute "ffmpeg.exe -i somevideofile" on the command-line to verify for yourself that it is there)
                // and going the full length of the timestamp.
                // The resulting substring is of the form "HH:MM:SS.UU"

                duration = result.Substring(result.IndexOf("Duration: ") + ("Duration: ").Length, ("00:00:00.00").Length);

                return duration;
            }
            return "----";
        }

        public string GetFFMpegVideoLengthAfterConvert(string fname)
        {
            string rootpath = HostingEnvironment.MapPath("~/");
            string oname = fname.Substring(0, fname.Length - Path.GetExtension(fname).Length) + ".mp4";

            using (Process ffmpeg = new Process())
            {
                String duration;  // soon will hold our video's duration in the form "HH:MM:SS.UU"
                String result;  // temp variable holding a string representation of our video's duration
                StreamReader errorreader;  // StringWriter to hold output from ffmpeg

                // we want to execute the process without opening a shell
                ffmpeg.StartInfo.UseShellExecute = false;
                ffmpeg.StartInfo.ErrorDialog = false;

                // redirect StandardError so we can parse it
                // for some reason the output comes through over StandardError
                ffmpeg.StartInfo.RedirectStandardError = true;

                // set the file name of our process, including the full path
                // (as well as quotes, as if you were calling it from the command-line)
                ffmpeg.StartInfo.FileName = rootpath + "Content/ffmpeg/ffmpeg.exe";

                // set the command-line arguments of our process, including full paths of any files
                // (as well as quotes, as if you were passing these arguments on the command-line)

                string extName = Path.GetExtension(fname);

                if (extName.ToLower() == "flv")
                {
                    ffmpeg.StartInfo.Arguments = "-i \"" + fname + "\" -ar 22050 " + oname;
                }
                else
                {
                    ffmpeg.StartInfo.Arguments = "-v 0 -y -i \"" + fname + "\" " + oname;
                }

                ffmpeg.StartInfo.CreateNoWindow = true;
                ffmpeg.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;

                // start the process
                ffmpeg.Start();

                // now that the process is started, we can redirect output to the StreamReader we defined
                errorreader = ffmpeg.StandardError;

                // wait until ffmpeg comes back
                int time_to_wait_in_milliseconds = 10;
                ffmpeg.WaitForExit(time_to_wait_in_milliseconds);

                // read the output from ffmpeg, which for some reason is found in Process.StandardError
                result = errorreader.ReadToEnd();

                // a little convoluded, this string manipulation...
                // working from the inside out, it:
                // takes a substring of result, starting from the end of the "Duration: " label contained within,
                // (execute "ffmpeg.exe -i somevideofile" on the command-line to verify for yourself that it is there)
                // and going the full length of the timestamp.
                // The resulting substring is of the form "HH:MM:SS.UU"

                duration = result.Substring(result.IndexOf("Duration: ") + ("Duration: ").Length, ("00:00:00.00").Length);

                return duration;
            }
            return "----";
        }
        #endregion

        public long GetFileSize(string filepath)
        {
            long size = 0;
            FileStream fs = File.OpenRead(filepath);
            size = fs.Length;
            fs.Close();

            return size;
        }
    }
}