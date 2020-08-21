using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using CoreWebAPI.Models;

namespace CoreWebAPI.Controllers
{
     
    public class LandproOrdersController : Controller
    {
        private readonly ApplicationContext _context;

        public LandproOrdersController(ApplicationContext context)
        {
            _context = context;
        }

        // GET: LandproOrders
        public async Task<IActionResult> Index()
        {
            return View(await _context.LandproOrders.ToListAsync());
        }

        // GET: LandproOrders/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var landproOrder = await _context.LandproOrders
                .FirstOrDefaultAsync(m => m.order_id == id);
            if (landproOrder == null)
            {
                return NotFound();
            }

            return View(landproOrder);
        }

        // GET: LandproOrders/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: LandproOrders/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("order_id,id,userName,phone")] LandproOrder landproOrder)
        {
            if (ModelState.IsValid)
            {
                _context.Add(landproOrder);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(landproOrder);
        }

        // GET: LandproOrders/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var landproOrder = await _context.LandproOrders.FindAsync(id);
            if (landproOrder == null)
            {
                return NotFound();
            }
            return View(landproOrder);
        }

        // POST: LandproOrders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("order_id,id,userName,phone")] LandproOrder landproOrder)
        {
            if (id != landproOrder.order_id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(landproOrder);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!LandproOrderExists(landproOrder.order_id))
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
            return View(landproOrder);
        }

        // GET: LandproOrders/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var landproOrder = await _context.LandproOrders
                .FirstOrDefaultAsync(m => m.order_id == id);
            if (landproOrder == null)
            {
                return NotFound();
            }

            return View(landproOrder);
        }

        // POST: LandproOrders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var landproOrder = await _context.LandproOrders.FindAsync(id);
            _context.LandproOrders.Remove(landproOrder);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool LandproOrderExists(int id)
        {
            return _context.LandproOrders.Any(e => e.order_id == id);
        }
    }
}
