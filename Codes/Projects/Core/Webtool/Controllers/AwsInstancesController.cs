using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Webtool.Data;
using Webtool.Models;

namespace Webtool.Controllers
{
    public class AwsInstancesController : Controller
    {
        private readonly AwsContext _context;

        public AwsInstancesController(AwsContext context)
        {
            _context = context;
        }

        // GET: AwsInstances
        public async Task<IActionResult> Index()
        {
            return View(await _context.AwsInstances.ToListAsync());
        }

        // GET: AwsInstances/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var awsInstance = await _context.AwsInstances
                .SingleOrDefaultAsync(m => m.AwsInstanceID == id);
            if (awsInstance == null)
            {
                return NotFound();
            }

            return View(awsInstance);
        }

        // GET: AwsInstances/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: AwsInstances/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("AwsInstanceID,Region,InstanceState")] AwsInstance awsInstance)
        {
            if (ModelState.IsValid)
            {
                _context.Add(awsInstance);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(awsInstance);
        }

        // GET: AwsInstances/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var awsInstance = await _context.AwsInstances.SingleOrDefaultAsync(m => m.AwsInstanceID == id);
            if (awsInstance == null)
            {
                return NotFound();
            }
            return View(awsInstance);
        }

        // POST: AwsInstances/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("AwsInstanceID,Region,InstanceState")] AwsInstance awsInstance)
        {
            if (id != awsInstance.AwsInstanceID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(awsInstance);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AwsInstanceExists(awsInstance.AwsInstanceID))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(awsInstance);
        }

        // GET: AwsInstances/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var awsInstance = await _context.AwsInstances
                .SingleOrDefaultAsync(m => m.AwsInstanceID == id);
            if (awsInstance == null)
            {
                return NotFound();
            }

            return View(awsInstance);
        }

        // POST: AwsInstances/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var awsInstance = await _context.AwsInstances.SingleOrDefaultAsync(m => m.AwsInstanceID == id);
            _context.AwsInstances.Remove(awsInstance);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AwsInstanceExists(string id)
        {
            return _context.AwsInstances.Any(e => e.AwsInstanceID == id);
        }
    }
}
