# CockpitRandomizer — F-4E Phantom II

A DCS World Export script that randomizes cockpit switch positions each time
you sit down for a **cold start**, forcing you to perform a proper interior
check before doing anything else.

---

## Why this exists

In DCS, every time you occupy a cockpit the aircraft spawns with all switches
in their factory-default positions. For taxi, runway hold, and in-flight slots
this makes sense. For cold-start scenarios it breaks immersion: a real Phantom
coming out of a previous sortie would have been left in whatever state the last
crew left it in. Landing lights on, STAB AUG engaged, IFF in an unexpected
mode — anything is possible.

CockpitRandomizer recreates that reality. Each cold start is different. You
cannot skip the interior check.

---

## Features

- Randomizes **40 cockpit controls** across all major systems: comms, IFF,
  fuel, flight controls, navigation, HUD, weapons, lights, audio, and more.
- **Cold-start only**: the script reads both engine RPM values via
  `LoGetEngineInfo()`. If either engine is at or above 10% RPM the script
  silently does nothing. Taxi, runway, and in-flight slots are unaffected.
- **Non-destructive**: chains into any existing `LuaExport*` functions.
  Compatible with DCS-BIOS, SRS, Tacview, and similar Export.lua-based tools.
- **Weighted probabilities**: safety-critical switches (Arm Fuze, Delivery
  Mode) are more likely to remain in safe/off positions, but not guaranteed.
- All activity is logged to `DCS.log` under the `COCKPIT_RANDOMIZER` tag for
  easy debugging.

---

## Requirements

- DCS World (Steam or standalone)
- Heatblur F-4E Phantom II module
- No additional mods or tools required

---

## Installation

**Step 1 — Create the Scripts folder** (skip if it already exists)

Navigate to your DCS Saved Games folder:
```
%USERPROFILE%\Saved Games\DCS\
```
Create a new folder named `Scripts` if it does not exist.

**Step 2 — Copy the script**

Place `CockpitRandomizer_Export.lua` inside:
```
Saved Games\DCS\Scripts\CockpitRandomizer_Export.lua
```

**Step 3 — Create or update Export.lua**

Inside the same `Scripts` folder, check whether `Export.lua` already exists.

- **If it does not exist:** Create a new text file named `Export.lua`
  (make sure the extension is `.lua`, not `.lua.txt`) and paste the following:

  ```lua
  -- Saved Games\DCS\Scripts\Export.lua
  local cr_status, cr_err = pcall(function()
      local lfs = require('lfs')
      local cr_path = lfs.writedir() .. "Scripts\\CockpitRandomizer_Export.lua"
      dofile(cr_path)
  end)
  if not cr_status then
      log.write("COCKPIT_RANDOMIZER", log.ERROR, "Load failed: " .. tostring(cr_err))
  end
  ```

- **If it already exists** (DCS-BIOS, SRS, etc.): Add the same block above to
  the **top** of your existing `Export.lua`. Do not replace the file.

> **Do not touch** `SteamLibrary\steamapps\common\DCSWorld\Scripts\Export.lua`.
> That file is read-only reference material. Your changes belong exclusively in
> `Saved Games\DCS\Scripts\Export.lua`.

**Step 4 — Verify**

Launch DCS and fly any cold-start F-4E mission. After ~3 seconds in the
cockpit, switches will randomize. Check `Saved Games\DCS\Logs\dcs.log` and
search for `COCKPIT_RANDOMIZER` to confirm the script is running.

---

## Uninstallation

**Full removal:**

1. Delete `Saved Games\DCS\Scripts\CockpitRandomizer_Export.lua`.
2. Open `Saved Games\DCS\Scripts\Export.lua` and remove the
   `CockpitRandomizer` block you added in Step 3.
3. If `Export.lua` is now empty (you created it only for this script),
   delete it as well.

**Temporary disable** (without uninstalling):

Open `CockpitRandomizer_Export.lua` and set:
```lua
CR.ENABLED = false
```

---

## Configuration

All user-facing settings are at the top of `CockpitRandomizer_Export.lua`:

| Setting | Default | Description |
|---|---|---|
| `CR.ENABLED` | `true` | Set to `false` to disable without uninstalling |
| `CR.DELAY_SECONDS` | `3.0` | Seconds to wait after cockpit load before randomizing. Increase if switches snap back to default. |
| `CR.TARGET_AIRCRAFT` | `"F-4E-45MC"` | DCS aircraft name string. Set to `""` to run on any aircraft. |
| `CR.RPM_THRESHOLD` | `10.0` | Both engines must be below this RPM % for cold-start detection. |

---

## Randomized controls

| # | Control | System | Positions |
|---|---|---|---|
| 1 | Select Dispense Program | AN/ALE-40 | NORMAL, SALVO |
| 2 | Set Mode | ICS | COLD MIC, HOT MIC |
| 3 | Select Communication Antenna | ARC-164 | UPR, LWR |
| 4 | Select Radio Mode | ARC-164 | OFF, T, T/R, A/G, SQL, G |
| 5 | Select Frequency Mode | ARC-164 | PRESET, MANUAL |
| 6 | Select Master Mode | IFF | OFF, SBY, NORM, EMER, IDENT |
| 7 | Wing Fuel Dump Selector | Fuel System | NORM, DUMP |
| 8 | Internal Wing Tanks Feed | Fuel System | NORMAL, TRANSFER |
| 9 | STAB AUG Yaw | AFCS | off, ENGAGE |
| 10 | STAB AUG Roll | AFCS | off, ENGAGE |
| 11 | STAB AUG Pitch | AFCS | off, ENGAGE |
| 12 | AFCS Autopilot | AFCS | AFCS, ENGAGE |
| 13 | ALT Hold | AFCS | ALT, ENGAGE |
| 14 | Anti-Skid Toggle | Landing Gear | OFF, ON |
| 15 | Emergency Wheel Brake | Landing Gear | stowed … fully pulled |
| 16 | Select Reference System | ADI | STBY, PRIM |
| 17 | Select TACAN Mode | TACAN | OFF, REC, T/R, A/A, BCN |
| 18 | Select Navigation Input | Flight Director | TACAN, VOR/ILS, ADF, NAV COMP |
| 19 | Select Navigation Mode | Flight Director | HDG, NAV, NAV COMP, ATT |
| 20 | Toggle Flight Director | Flight Director | OFF, ON |
| 21 | Select HUD Mode | HUD | OFF, NAV, ILS/NAV, ILS/MAN, A/G, A/A RDR, A/A COLL |
| 22 | Arm Fuze | Weapons | SAFE, NOSE, TAIL, NOSE&TAIL |
| 23 | Select Delivery Mode | Weapons | DIRECT … CMPTR (13 positions) |
| 24 | Select Quantity | Weapons | 1 … 12 |
| 25 | Select Oxygen Mixture | Oxygen | NORMAL OXYGEN, 100% OXYGEN |
| 26 | Emergency Release Cockpit Pressure | Oxygen | sealed, venting |
| 27 | ARI Circuit Breaker | Circuit Breakers | in (active), out |
| 28 | Standby Attitude Indicator CB | Circuit Breakers | in (powered), out |
| 29 | Taxi/Landing Light | Exterior Lights | LDG LT, OFF, TAXI LT |
| 30 | Set Formation Lights Mode | Exterior Lights | OFF, BRT |
| 31 | Change Formation Lights Brightness | Exterior Lights | 0 … 0.5 |
| 32 | Set Console Floodlight Brightness | Interior Lights | MED, OFF, BRT |
| 33 | Change Console Light Brightness | Interior Lights | 0 … 1.0 |
| 34 | Toggle White Floodlight | Interior Lights | OFF, ON |
| 35 | Set Instrument Floodlight Brightness | Interior Lights | DIM, OFF, BRT |
| 36 | Toggle Rain Removal | Environmental | OFF, ON |
| 37 | Change Temperature | Environmental | 0 … 1.0 (visual only) |
| 38 | Defog Handle | Environmental | fully fwd … fully aft (visual only) |
| 39 | AoA Stall Warning Volume | Audio | 0 … 1.0 |
| 40 | Aural Tone Volume | Audio | 0 … 1.0 |

> Controls marked **visual only** are not yet simulated in DCS. The handle or
> knob will move but have no functional effect.

---

## Debugging

Search `Saved Games\DCS\Logs\dcs.log` for `COCKPIT_RANDOMIZER`.

Typical output on a successful cold start:
```
[COCKPIT_RANDOMIZER] Aircraft detected: F-4E-45MC — arming with 3.0s delay.
[COCKPIT_RANDOMIZER] RPM check: left=0.0%  right=0.0%  threshold=10.0%
[COCKPIT_RANDOMIZER] Randomizing cockpit on: F-4E-45MC
[COCKPIT_RANDOMIZER]   Select Dispense Program   dev=5   cmd=3001 -> 1
[COCKPIT_RANDOMIZER]   STAB AUG Yaw              dev=9   cmd=3010 -> 1
...
[COCKPIT_RANDOMIZER] Randomizer v3.1 complete.
```

Typical output when skipped (taxi / in-flight):
```
[COCKPIT_RANDOMIZER] RPM check: left=62.3%  right=61.1%  threshold=10.0%
[COCKPIT_RANDOMIZER] Skipping: engines running (RPM >= threshold). Not a cold start.
```

---

## Extending to other aircraft

The switch table is the only aircraft-specific part of the script. To add
support for another module:

1. Locate the aircraft's `clickabledata.lua` and `command_defs.lua` files
   (usually under `DCSWorld\Mods\aircraft\<module>\Cockpit\Scripts\`).
2. Find the device IDs in `devices.lua`.
3. Add a new `CR.SWITCHES` table (or extend the existing one with an aircraft
   check) and set `CR.TARGET_AIRCRAFT` accordingly.

---

## License

Free to use, modify, and redistribute. Credit appreciated but not required.
