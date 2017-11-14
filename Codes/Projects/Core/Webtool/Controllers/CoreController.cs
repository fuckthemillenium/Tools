using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Webtool.Models;

namespace Webtool.Controllers
{
    public class CoreController : Controller
    {
        public IActionResult Index()
        { 
            return View();
        }

        public IActionResult Login()
        {
            return View();
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
