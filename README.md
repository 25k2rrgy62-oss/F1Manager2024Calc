# F1M Setup Calculator

**Website:** https://25k2rrgy62-oss.github.io/F1Manager2024Calc/ · **iOS app:** see [iOS app](#ios-app)

A car setup solver for **F1 Manager 2024**. It runs entirely in your browser: no server, no account, and no internet needed once loaded. It's built for phones as well as desktop.

## Features

- **Season, track and driver labels.** Pick the season (2024 in-game, 2025 or 2026), the Grand Prix from that year's calendar, and a driver from that year's grid. You can also type a custom name.
- **Only F1 Manager 2024 tracks.** Every setup uses the game's own cars, setup ranges and the 24 circuits that ship with it. Real-world venues that aren't in the game are hidden. Right now that's only **Madring (Madrid, 2026)**. Round numbers still match the real calendar.
- **Baseline presets.** Every track has a built-in baseline (starting setup). You can save your own baselines, load them, and set one as the **default for a track**. New sessions at that track then start from your baseline.
- **Touch-friendly controls.** Each setup value has a large slider plus − / + buttons that move one in-game click at a time. Driver feedback is entered by tapping a chip, with no cycling or right-clicking.
- **Solver.** Enter the setup you ran and the driver's feedback for each stat. The calculator shows where the ideal can still be and recommends the next setup. Repeat until everything is Optimal.
- **Saved on your device.** Runs are saved per season, track and driver. Use **Export** / **Import** to back them up or move them to another device, including your baselines.

## How to use it

1. Choose the season, Grand Prix and driver.
2. Load a baseline, or keep the track's default. Set the same values in the game.
3. Run a practice stint. Then, for each of Oversteer, Braking, Cornering, Traction and Straights, tap what the driver said: **Optimal / Great / Good / Bad**. For Bad, also tap *Too high* or *Too low* if you know which way it was off.
4. Press **Add practice run**. The sliders jump to the recommended next setup. Copy it into the game and repeat.

## How it works

The game converts each of the 5 setup values (Front Wing, Rear Wing, Anti-Roll, Tyre Camber, Toe-Out) to a 0–1 scale. Each feedback stat is a fixed linear mix of those 5 values. The driver's feedback tells you how far each stat was from the driver's hidden ideal:

| Feedback | Distance from ideal |
|---|---|
| Optimal | < 0.007 |
| Great | 0.007 – 0.04 |
| Good | 0.04 – 0.10 |
| Bad | ≥ 0.10 |

Every run narrows down where the ideal can be for each stat. The tool then checks every legal in-game setup (about 1 million combinations, in roughly 15 ms) and picks the one that best targets what's left. It never re-suggests a setup you already ran, so each run adds new information. In 200 simulated tests starting from a neutral setup, the median was 7 runs to all-Optimal. A good baseline usually takes fewer.

### Setup ranges (F1 Manager 2024)

| Setting | Range | Step |
|---|---|---|
| Front Wing | 0.0 – 10.0 | 0.5 |
| Rear Wing | 9.0 – 16.0 | 0.5 |
| Anti-Roll | 9:1 – 1:9 | 1 |
| Tyre Camber | −2.70° – −3.50° | 0.05° |
| Toe-Out | 0.00° – 1.00° | 0.05° |

### Calendars

| Season | Rounds | Notes |
|---|---|---|
| 2024 | 24 | The calendar in the game |
| 2025 | 24 | All circuits are in the game |
| 2026 | 22 | Madring isn't in the game, so it's hidden. Bahrain and Saudi Arabia were cancelled; they're listed under "Cancelled" so you can still label them. |

Built-in baselines for most tracks come from the game's per-track data. Shanghai, Las Vegas and Qatar use community starting setups. The solver works from your feedback either way.

Inspired by [f1setup.it](https://f1setup.it).

## Use it offline

**Option 1: open the file.** Download this repo (green **Code** button → **Download ZIP**), unzip it, and double-click `index.html`. It works with no internet connection.

**Option 2: install from the website.** Open the website in Chrome, Edge or Safari and choose **Install app** or **Add to Home Screen**. It keeps working offline after your first visit.

## Website (GitHub Pages)

`.github/workflows/pages.yml` publishes the site every time something is pushed to `main`.

**One-time setup:** on GitHub, open the repo → **Settings** → **Pages**. Under **Build and deployment**, set **Source** to **GitHub Actions**. Then open the **Actions** tab, choose **Deploy website**, and press **Run workflow**. Pushes after that deploy automatically.

The site is then live at **https://25k2rrgy62-oss.github.io/F1Manager2024Calc/**.

Other free hosts work too, because the site is just static files:
- **Netlify Drop:** drag the folder onto <https://app.netlify.com/drop>.
- **Cloudflare Pages:** connect the repo, leave the build command empty, and set the output directory to `/`.

## iOS app

`ios/` contains a native SwiftUI app that bundles the same calculator, so it works fully offline. Alerts, prompts and **Export** use native iOS dialogs and the share sheet.

There are three ways to get it on your iPhone or iPad:

1. **Add to Home Screen (free, no Mac).** Open the website in Safari → **Share** → **Add to Home Screen**. It opens full-screen with its own icon and works offline after the first visit.
2. **Sideload the built app (free, no Mac).** Every push that touches the app runs **Build iOS app** in the **Actions** tab. Open the latest run and download **F1MSetup-unsigned-ipa**. Install it with [AltStore](https://altstore.io) or [Sideloadly](https://sideloadly.io), which sign it with your Apple ID. With a free Apple ID, the app has to be refreshed every 7 days.
3. **Build it in Xcode (Mac).**
   ```sh
   brew install xcodegen
   cd ios
   ./sync-web.sh        # copies index.html into the app
   xcodegen generate    # creates F1MSetup.xcodeproj
   open F1MSetup.xcodeproj
   ```
   In Xcode, select the **F1MSetup** target → **Signing & Capabilities**. Choose your Team and change the bundle identifier (`io.github.f1msetup.app`) to something unique. Then plug in your phone and press **Run**. Publishing on the App Store or TestFlight needs a paid Apple Developer account ($99/year).

The app always uses the root `index.html`. Every build copies it in, so updating the website also updates the app on its next build.

## Files

| File | Purpose |
|---|---|
| `index.html` | The whole app: UI, game model, solver, calendars, drivers, baselines |
| `sw.js` | Service worker for offline use when hosted |
| `manifest.webmanifest`, `icon.svg` | Makes it installable as an app |
| `.nojekyll` | Tells GitHub Pages to serve the files as-is |
| `apple-touch-icon.png` | Home-screen icon on iPhone and iPad |
| `.github/workflows/pages.yml` | Deploys the website to GitHub Pages |
| `.github/workflows/ios.yml` | Builds the iOS app and uploads an unsigned `.ipa` |
| `ios/` | iOS app: `project.yml` (XcodeGen), Swift source, app icon, `sync-web.sh` |
| `LICENSE` | MIT License |

## License

[MIT](LICENSE). This is a fan-made tool and isn't affiliated with Frontier Developments, Formula 1 or any team.
