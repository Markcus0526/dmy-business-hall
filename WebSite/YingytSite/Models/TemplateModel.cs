using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YingytSite.Models.Library;
using System.Collections.Specialized;

namespace YingytSite.Models
{
    public class TemplateModel
    {
        YingytDBDataContext db = new YingytDBDataContext();

        public List<tbl_template> GetTemplateList()
        {
            return db.tbl_templates
                .Where(m => m.deleted == 0)
                .ToList();
        }
        
        public long GetUserTemplateId()
        {
            long user_id = CommonModel.GetCurrentUserId();
            tbl_usertemplate item = db.tbl_usertemplates
                .Where(m => m.deleted == 0 && m.user_id == user_id)
                .FirstOrDefault();
            if (item != null)
                return item.template_id;
            else
                return 0;
        }

        public bool InsertOrUpdateUserTemplateId(long template_id)
        {
            long user_id = CommonModel.GetCurrentUserId();
            tbl_usertemplate edititem = db.tbl_usertemplates
                .Where(m => m.deleted == 0 && m.user_id == user_id)
                .FirstOrDefault();

            if (edititem != null)
                edititem.template_id = template_id;
            else
            {
                tbl_usertemplate newitem = new tbl_usertemplate();

                newitem.user_id = user_id;
                newitem.template_id = template_id;

                db.tbl_usertemplates.InsertOnSubmit(newitem);
            }

            db.SubmitChanges();

            return true;
        }
    }
}