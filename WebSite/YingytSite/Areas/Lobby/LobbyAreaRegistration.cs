using System.Web.Mvc;

namespace YingytSite.Areas.Lobby
{
    public class LobbyAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "Lobby";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Lobby_default",
                "Lobby/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
