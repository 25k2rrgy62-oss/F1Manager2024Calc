# F1M Setup Calculator

A car setup solver for **F1 Manager 2024**. It runs entirely in your browser: no server, no account, no internet needed once loaded.

- Pick the **season** (2024 in-game, 2025, or 2026), the **Grand Prix** from that year's calendar, and the **driver** from that year's grid (or type a custom name).
- Enter the setup you ran in practice and the driver's feedback (Optimal / Great / Good / Bad) for Oversteer, Braking, Cornering, Traction and Straights.
- The calculator works out where the ideal setup can still be and recommends the next setup to try. Repeat until everything is Optimal.
- Runs are saved per season + track + driver on your device. Use **Export** / **Import** to back them up or move them to another device.

## How it works

Each of the 5 setup values (Front Wing, Rear Wing, Anti-Roll, Tyre Camber, Toe-Out) is converted to a 0–1 scale. Each feedback stat is a fixed linear mix of those 5 values. The driver's feedback tells you how far each stat was from the hidden ideal:

| Feedback | Distance from ideal |
|---|---|
| Optimal | < 0.007 |
| Great | 0.007 – 0.04 |
| Good | 0.04 – 0.10 |
| Bad | ≥ 0.10 (use "Bad ↑ high" / "Bad ↓ low" if you know the direction) |

Every run narrows down the possible ideal for each stat. The tool then checks every legal in-game setup (about 1 million combinations, in roughly 15 ms) and picks the one that best targets what's left. It never re-suggests a setup you already ran, so each run adds new information. In simulated tests starting from a neutral setup, it reaches all-Optimal in about 7 runs (median). Starting from the track's starting point usually takes fewer.

**Calendars included:** 2024 (24 rounds), 2025 (24 rounds), and 2026 (22 rounds, with Madrid). Bahrain and Saudi Arabia were cancelled in 2026; they are listed separately as "cancelled" so you can still label them. Track starting points come from known game data. Circuits with no game data (Shanghai, Las Vegas, Qatar, Madrid) start from a neutral setup; the solver still works from your feedback.

Inspired by [f1setup.it](https://f1setup.it).

## Use it offline

**Option 1 — just open the file.** Download this repo (green **Code** button → **Download ZIP**), unzip it, and double-click `index.html`. It works with no internet connection. Data is stored in that browser.

**Option 2 — install it from the website.** Once it's hosted (see below), open the site in Chrome, Edge or Safari and choose **Install app** or **Add to Home Screen**. A service worker caches the app, so it keeps working offline after your first visit.

## Host it for free

It's plain static files (`index.html`, `sw.js`, `manifest.webmanifest`, `icon.svg`), so any static host works.

### GitHub Pages (recommended, since the code is already on GitHub)

1. Merge this code into your default branch (`main`).
2. On GitHub, open the repo → **Settings** → **Pages**.
3. Under **Build and deployment**, set **Source** to **Deploy from a branch**. Pick `main` and `/ (root)`, then press **Save**.
4. After a minute or two your site is live at `https://<your-username>.github.io/<repo-name>/`.

Note: free GitHub Pages requires the repository to be **public**. Every push to `main` redeploys automatically.

### Netlify Drop (no account setup needed beyond sign-in)

Go to <https://app.netlify.com/drop> and drag the folder containing `index.html` onto the page. You get a free `*.netlify.app` URL.

### Cloudflare Pages

Go to **Workers & Pages** → **Create** → **Pages** → connect this GitHub repo. Leave the build command empty and set the output directory to `/`. You get a free `*.pages.dev` URL that updates on every push.

## Files

| File | Purpose |
|---|---|
| `index.html` | The whole app (UI, game model, solver, calendars, drivers) |
| `sw.js` | Service worker for offline use when hosted |
| `manifest.webmanifest`, `icon.svg` | Makes it installable as an app |
| `.nojekyll` | Tells GitHub Pages to serve files as-is |

Fan-made tool. Not affiliated with Frontier Developments, Formula 1, or any team.
