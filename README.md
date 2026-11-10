# F1 Manager 2024 Setup Calculator

A car setup calculator for **F1 Manager 2024**. Enter the setup you ran and what the driver said about it, and it works out the next setup to try.

It is one static page (`index.html`). There is no server and no account, and it works offline if you open the file directly.

## How to use it

1. Pick the track and the driver from the drop-downs. **Next →** beside the track moves every slot on that track to the next round. Drivers are the 2024 grid, grouped by team; choose **Custom name…** to type your own.
2. The **Base setup** card shows the starting setup for that track, and the sliders are already on it. Put the same values on the car in the game.
3. Run a practice stint. For each of Oversteer, Braking, Cornering, Traction and Straights, tap what the driver said: **Optimal**, **Great**, **Good** or **Bad**. Leave an area blank if the driver hasn't rated it yet.
4. Press **Find setup**. The run is saved and the sliders move to the next setup to try.
5. Repeat until all five areas are Optimal.

Each driver slot has its own tab with its own track, setup and runs. Everything is saved in your browser. The page has no ads and no tracking, and it is laid out for phones as well as desktop.

## How it works

The game scales each of the five setup values to 0–1. Each feedback area is a fixed linear mix of those five numbers, and the driver has a hidden ideal value for each area. The feedback word tells you how far the run was from that ideal:

| Feedback | Distance from ideal |
|---|---|
| Optimal | under 0.007 |
| Great | 0.007 – 0.04 |
| Good | 0.04 – 0.10 |
| Bad | 0.10 or more |

Every run narrows the range the ideal can be in (the blue band on each feedback bar). The calculator then checks all 1,012,095 legal setups and suggests the one that sits inside every remaining range and closest to the middle of each.

The search always starts from all 1,012,095 setups: nothing is ruled out until the driver gives feedback. The track only decides the base setup you run first.

### Setup ranges

| Setting | Range | Step |
|---|---|---|
| Front Wing Angle | 0.0 – 10.0 | 0.5 |
| Rear Wing Angle | 9.0 – 16.0 | 0.5 |
| Anti-Roll Distribution | 9:1 – 1:9 | 1 |
| Tyre Camber | −2.70° – −3.50° | 0.05° |
| Toe-Out | 0.00° – 1.00° | 0.05° |

## Hosting

`.github/workflows/pages.yml` publishes the page to GitHub Pages on every push to `main`.

Inspired by [f1setup.it](https://f1setup.it). Unofficial fan tool, not associated with Formula 1 or Frontier Developments.
