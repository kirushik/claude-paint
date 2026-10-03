# Three paintings from one session (2026-10-03)

Painted live at the easel, one chunk at a time, looking between chunks.
Each `.lua` file is the painting's log: `easel run <file>` replays it.

| log | box | engine | notes |
|---|---|---|---|
| `blue_hour_first_snow.lua` | default tube box | upstream | snow field at blue hour, one lit window; 64 chunks |
| `grey_river_fog.lua` | default tube box | upstream | grey river in fog, willow, a punt; 45 chunks |
| `dream_of_the_sea.lua` | `sargent` (`EASEL_BOX=sargent`) | this branch (raw canvas, `pour`, `blot`) | "a dream of the sea", the first soak-stain painting; 12 chunks |

The third was painted under a "no replays" rule: nothing was re-run from a
log to get a second try; a fresh attempt means painting again by hand. An
earlier start of it (2 chunks) was abandoned after a bug (charcoal lost under
stains) and repainted from scratch rather than replayed.

## Journal

- Blue hour: smalt is weak (needs little white to read mid-value); a heavy
  glaze with `fill=true` printed a scale pattern that had to be badgered out;
  every blend near a hard mask left a halo, then chased.
- Fog: the far bank breathed in wet-into-wet; a glaze went down as brown
  streaks and was lifted with a clean brush wiped after every stroke; the
  sun was found by painting the fog around it, lighter, not darker.
- Dream of the sea: a pour lands where its mask is, so a wide mask makes a
  flat stain with no travel (the teal islands, the yellow bar); pour from
  small points and let the cloth spread it. Wet cloth lets new pours run
  through it. The crescent was blotted out of the wet night veil and came out
  beside the charcoal one.
