-- =============================================================================
-- CockpitRandomizer — fa18c.lua
-- F/A-18C Hornet | Pilot seat
-- Switch table for: FA-18C_hornet
--
-- Device IDs: DCSWorld\Mods\aircraft\FA-18C\Cockpit\Scripts\devices.lua
-- Command IDs: command_defs.lua (each device table resets to 3001)
--
-- HOW vals WORK (delta semantics — not absolute positions):
--   performClickableAction(cmd, val) applies val as a DELTA to the current
--   arg value, clamped to arg_lim. It does NOT set an absolute position.
--
--   val = 0   → no movement, switch stays at cold-start default
--   val = +1  → arg increases (moves toward upper limit)
--   val = -1  → arg decreases (moves toward lower limit)
--   val = +d  → multiposition: one step forward  (d = switch delta)
--   val = -d  → multiposition: one step backward
--
-- ENCODING CONVENTION used in this file:
--   "stay at default"  → val = 0   (always safe, no movement)
--   "move away"        → val = ±1 or ±delta (one or more steps from default)
--
-- DEFAULT WEIGHT POLICY:
--   All fixed-position switches have their default delta (0 = stay) weighted
--   at 85%–90% of the vals pool. Continuous axis/brightness/volume knobs are
--   exempt and retain uniform sampling.
-- =============================================================================

CR.register("FA-18C_hornet", {

    -- -------------------------------------------------------------------------
    -- OXYGEN SYSTEM   dev=10 (OXYGEN_INTERFACE)
    -- -------------------------------------------------------------------------

    -- OXY Flow Knob | default_axis_limited, continuous | arg 366
    -- Exempt: continuous rotary, no fixed default position
    { dev=10, cmd=3005, vals={0, 0.25, 0.5, 0.75, 1.0},    label="OXY Flow Knob" },

    -- OBOGS Control Switch | default_2_position_tumb | arg 365 | arg_lim={0,1}
    -- Cold start: ON (arg=0). val=0 → stay ON (default). val=+1 → OFF.
    -- ON=stay (chance: 90%, default) / OFF=+1 (chance: 10%)
    { dev=10, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},   label="OBOGS Control Switch" },

    -- -------------------------------------------------------------------------
    -- INTERCOM   dev=40 (INTERCOM)
    -- -------------------------------------------------------------------------

    -- TACAN Volume Knob | default_axis_limited, continuous | arg 363
    -- intercom_commands.TCN_Volume = 3008 (3032 is TCN_Volume_AXIS, the axis-input channel)
    -- Exempt: continuous volume knob, no fixed default position
    { dev=40, cmd=3008, vals={0, 0.25, 0.5, 0.75, 1.0},    label="TACAN Volume Knob" },

    -- -------------------------------------------------------------------------
    -- EXTERIOR LIGHTS   dev=8 (EXT_LIGHTS)
    -- -------------------------------------------------------------------------

    -- POSITION Lights Dimmer | default_axis_limited, continuous | arg 338
    -- Exempt: continuous dimmer, no fixed default position
    { dev=8,  cmd=3006, vals={0, 0.25, 0.5, 0.75, 1.0},    label="POSITION Lights Dimmer" },

    -- FORMATION Lights Dimmer | default_axis_limited, continuous | arg 337
    -- Exempt: continuous dimmer, no fixed default position
    { dev=8,  cmd=3008, vals={0, 0.25, 0.5, 0.75, 1.0},    label="FORMATION Lights Dimmer" },

    -- LDG/TAXI LIGHT Switch | default_2_position_tumb | arg 237 | arg_lim={0,1}
    -- Cold start: OFF (arg=1). val=0 → stay OFF (default). val=-1 → ON.
    -- OFF=stay (chance: 90%, default) / ON=-1 (chance: 10%)
    { dev=8,  cmd=3004, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -1},  label="LDG/TAXI LIGHT Switch" },

    -- -------------------------------------------------------------------------
    -- COCKPIT LIGHTS   dev=9 (CPT_LIGHTS)
    -- -------------------------------------------------------------------------

    -- HOOK BYPASS Switch | springloaded_2_pos_tumb2 | arg 239
    -- Springloaded: momentary action, val=+1 pulses the switch.
    -- FIELD=stay (chance: 85%, default) / CARRIER pulse=+1 (chance: 15%)
    { dev=9,  cmd=3009, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},   label="HOOK BYPASS Switch" },

    -- CONSOLES Dimmer | default_axis_limited, continuous | arg 413
    -- Exempt: continuous dimmer, no fixed default position
    { dev=9,  cmd=3011, vals={0, 0.25, 0.5, 0.75, 1.0},    label="CONSOLES Dimmer" },

    -- INST PNL Dimmer | default_axis_limited, continuous | arg 414
    -- Exempt: continuous dimmer, no fixed default position
    { dev=9,  cmd=3013, vals={0, 0.25, 0.5, 0.75, 1.0},    label="INST PNL Dimmer" },

    -- FLOOD Dimmer | default_axis_limited, continuous | arg 415
    -- Exempt: continuous dimmer, no fixed default position
    { dev=9,  cmd=3015, vals={0, 0.25, 0.5, 0.75, 1.0},    label="FLOOD Dimmer" },

    -- MODE Switch | default_3_position_tumb | arg 419 | arg_lim={-1,1}
    -- Hint: NVG/NITE/DAY. Cold start: DAY (arg=1, right end).
    -- val=0 → stay DAY (default). val=-1 → NITE. Sending -1 twice → NVG.
    -- DAY=stay (chance: 87%, default) / NITE=-1 (chance: 13%)
    { dev=9,  cmd=3004, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1},  label="MODE Switch" },

    -- WARN/CAUTION Dimmer | default_axis_limited, continuous | arg 417
    -- Exempt: continuous dimmer, no fixed default position
    { dev=9,  cmd=3023, vals={0, 0.25, 0.5, 0.75, 1.0},    label="WARN/CAUTION Dimmer" },

    -- CHART Dimmer | default_axis_limited, continuous | arg 418
    -- Exempt: continuous dimmer, no fixed default position
    { dev=9,  cmd=3018, vals={0, 0.25, 0.5, 0.75, 1.0},    label="CHART Dimmer" },

    -- -------------------------------------------------------------------------
    -- LANDING GEAR   dev=5 (GEAR_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Anti Skid Switch | default_2_position_tumb | arg 238 | arg_lim={0,1}
    -- Hint: ON/OFF. Cold start: ON (arg=0). val=0 → stay ON (default). val=+1 → OFF.
    -- ON=stay (chance: 90%, default) / OFF=+1 (chance: 10%)
    { dev=5,  cmd=3004, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},   label="Anti Skid Switch" },

    -- -------------------------------------------------------------------------
    -- HUD   dev=34 (HUD)
    -- -------------------------------------------------------------------------

    -- Altitude Switch | default_2_position_tumb | arg 147 | arg_lim={0,1}
    -- Hint: BARO/RDR. Cold start: BARO (arg=0). val=0 → stay BARO (default). val=+1 → RDR.
    -- BARO=stay (chance: 87%, default) / RDR=+1 (chance: 13%)
    { dev=34, cmd=3008, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},  label="Altitude Switch" },

    -- HUD Symbology Brightness Selector | default_3_position_tumb | arg 51/76
    -- OFF/NIGHT/DAY, arg_value=0.1, arg_lim={0,0.2}. Cold start: DAY (arg=0.2, right end).
    -- val=0 → stay DAY (default). val=-0.1 → NIGHT. Sending -0.1 twice → OFF.
    -- DAY=stay (chance: 90%, default) / NIGHT=-0.1 (chance: 10%)
    { dev=34, cmd=3003, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1},  label="HUD Symbology Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- UFC   dev=25 (UFC)
    -- -------------------------------------------------------------------------

    -- UFC COMM 1 Volume | continuous rotary — no default bias applied
    { dev=25, cmd=3037, vals={0, 0.25, 0.5, 0.75, 1.0},    label="UFC COMM 1 Volume" },

    -- UFC COMM 2 Volume | continuous rotary — no default bias applied
    { dev=25, cmd=3039, vals={0, 0.25, 0.5, 0.75, 1.0},    label="UFC COMM 2 Volume" },

    -- -------------------------------------------------------------------------
    -- MDI LEFT   dev=35 (MDI_LEFT)
    -- -------------------------------------------------------------------------

    -- Left MDI Brightness Selector | default_3_position_tumb | arg 51 | arg_lim={0,0.2}
    -- OFF/NIGHT/DAY. Cold start: DAY (arg=0.2, right end).
    -- val=0 → stay DAY (default). val=-0.1 → NIGHT.
    -- DAY=stay (chance: 90%, default) / NIGHT=-0.1 (chance: 10%)
    { dev=35, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1},  label="Left MDI Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- MDI RIGHT   dev=36 (MDI_RIGHT)
    -- -------------------------------------------------------------------------

    -- Right MDI Brightness Selector | default_3_position_tumb | arg 76 | arg_lim={0,0.2}
    -- OFF/NIGHT/DAY. Cold start: DAY (arg=0.2, right end).
    -- val=0 → stay DAY (default). val=-0.1 → NIGHT.
    -- DAY=stay (chance: 90%, default) / NIGHT=-0.1 (chance: 10%)
    { dev=36, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1},  label="Right MDI Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- AMPCD   dev=37 (AMPCD)
    -- -------------------------------------------------------------------------

    -- AMPCD Off/Brightness Knob | default_axis_limited, continuous | arg 203
    -- Exempt: continuous brightness knob, no fixed default position
    { dev=37, cmd=3002, vals={0, 0.25, 0.5, 0.75, 1.0},    label="AMPCD Off/Brightness Knob" },

    -- -------------------------------------------------------------------------
    -- WEAPONS   dev=23 (SMS)
    -- -------------------------------------------------------------------------

    -- Master Arm Switch | default_2_position_tumb | arg 49 | arg_lim={0,1}
    -- Hint: ARM/SAFE. Cold start: SAFE (arg=1). val=0 → stay SAFE (default). val=-1 → ARM.
    -- SAFE=stay (chance: 90%, default) / ARM=-1 (chance: 10%)
    { dev=23, cmd=3003, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -1},   label="Master Arm Switch" },

    -- -------------------------------------------------------------------------
    -- ELECTRICAL   dev=3 (ELEC_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Left Generator Switch | default_2_position_tumb | arg 402 | arg_lim={0,1}
    -- Hint: NORM/OFF. Cold start: NORM (arg=0). val=0 → stay NORM (default). val=+1 → OFF.
    -- NORM=stay (chance: 90%, default) / OFF=+1 (chance: 10%)
    { dev=3,  cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},    label="Left Generator Switch" },

    -- Right Generator Switch | default_2_position_tumb | arg 403 | arg_lim={0,1}
    -- Hint: NORM/OFF. Cold start: NORM (arg=0). val=0 → stay NORM (default). val=+1 → OFF.
    -- NORM=stay (chance: 90%, default) / OFF=+1 (chance: 10%)
    { dev=3,  cmd=3003, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},    label="Right Generator Switch" },

    -- CB LAUNCH BAR | default_CB_button | arg 384
    -- CB buttons use arg_value={1}, arg_lim={0,1}: val=+1 pulls CB out (OPEN), val=0 stays IN.
    -- IN=stay (chance: 90%, default) / OPEN=+1 (chance: 10%)
    { dev=3,  cmd=3020, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},    label="CB LAUNCH BAR" },

    -- CB SPD BRK | default_CB_button | arg 383
    -- IN=stay (chance: 90%, default) / OPEN=+1 (chance: 10%)
    { dev=3,  cmd=3019, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},    label="CB SPD BRK" },

    -- CB FCS CHAN 1 | default_CB_button | arg 381
    -- IN=stay (chance: 95%, default) / OPEN=+1 (chance: 5%)
    { dev=3,  cmd=3017, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="CB FCS CHAN 1" },

    -- CB FCS CHAN 2 | default_CB_button | arg 382
    -- IN=stay (chance: 95%, default) / OPEN=+1 (chance: 5%)
    { dev=3,  cmd=3018, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="CB FCS CHAN 2" },

    -- CB FCS CHAN 3 | default_CB_button | arg 454 | cmd=3021
    -- REMOVED: does not respond to performClickableAction in this context.

    -- CB FCS CHAN 4 | default_CB_button | arg 455 | cmd=3022
    -- REMOVED: does not respond to performClickableAction in this context.

    -- CB HOOK | default_CB_button | arg 456 | cmd=3023
    -- REMOVED: does not respond to performClickableAction in this context.

    -- CB LG | default_CB_button | arg 457 | cmd=3024
    -- REMOVED: does not respond to performClickableAction in this context.

    -- -------------------------------------------------------------------------
    -- COUNTERMEASURES   dev=54 (CMDS)
    -- -------------------------------------------------------------------------

    -- DISPENSER Switch | default_3_position_tumb | arg 517 | arg_value=0.1, arg_lim={0,0.2}
    -- Hint: BYPASS/ON/OFF. Cold start: OFF (arg=0.2, right end).
    -- val=0 → stay OFF (default). val=-0.1 → ON. Sending -0.1 twice → BYPASS.
    -- OFF=stay (chance: 88%, default) / ON=-0.1 (chance: 10%) / BYPASS=-0.2 (chance: 2%)
    { dev=54, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.2, -0.2, -0.2, -0.2},  label="DISPENSER Switch" },

    -- -------------------------------------------------------------------------
    -- ECM   dev=66 (ASPJ)
    -- -------------------------------------------------------------------------

    -- ECM Mode Switch | multiposition_switch, count=5, delta=0.1 | arg 248 | arg_lim={0,0.4}
    -- Hint: XMIT/REC/BIT/STBY/OFF (reversed order in arg). Cold start: OFF (arg=0).
    -- val=0 → stay OFF (default). val=+0.1 → STBY. val=+0.2 → BIT. val=+0.3 → REC. val=+0.4 → XMIT.
    -- OFF=stay (chance: 88%, default) / STBY=+0.1 (chance: 8%) / others ~1-2% each
    { dev=66, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.1, 0.1, 0.2, 0.3, 0.4, 0.4},  label="ECM Mode Switch" },

    -- -------------------------------------------------------------------------
    -- TGP   dev=62 (TGP_INTERFACE)
    -- -------------------------------------------------------------------------

    -- FLIR Switch | default_3_position_tumb | arg 439 | arg_lim={0,1}, arg_value=0.5
    -- Hint: ON/STBY/OFF. Cold start: OFF (arg=1). val=0 → stay OFF (default). val=-0.5 → STBY. val=-1 → ON (two steps).
    -- REMOVED: switch does not respond to performClickableAction in this context.

    -- LST/NFLR Switch | default_2_position_tumb | arg 442 | arg_lim={0,1}
    -- Hint: ON/OFF. Cold start: OFF (arg=1). val=0 → stay OFF (default). val=-1 → ON.
    -- REMOVED: switch does not respond to performClickableAction in this context.

    -- -------------------------------------------------------------------------
    -- RADAR   dev=42 (RADAR)
    -- -------------------------------------------------------------------------

    -- RADAR Switch | multiposition_switch_with_pull, count=4, delta=0.1 | arg 440 | arg_lim={0,0.3}
    -- OFF=0 / STBY=0.1 / OPR=0.2 / EMERG=0.3. Cold start: STBY (arg=0.1).
    -- val=0 → stay STBY (default). val=-0.1 → OFF. val=+0.1 → OPR. val=+0.2 → EMERG.
    -- STBY=stay (chance: 88%, default) / OFF=-0.1 (chance: 7%) / OPR=+0.1 (chance: 4%) / EMERG=+0.2 (chance: 1%)
    { dev=42, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.1, -0.1, -0.1, 0.1, 0.1, 0.2, 0.2},  label="RADAR Switch" },

    -- -------------------------------------------------------------------------
    -- INS   dev=44 (INS)
    -- -------------------------------------------------------------------------

    -- INS Switch | multiposition_switch_cl, count=8, delta=0.1 | arg 443 | arg_lim={0,0.7}
    -- OFF/CV/GND/NAV/IFA/GYRO/GB/TEST → 0/0.1/0.2/0.3/0.4/0.5/0.6/0.7
    -- Cold start: NAV (arg=0.3). val=0 → stay NAV (default).
    -- val=-0.1 → GND. val=-0.2 → CV. val=-0.3 → OFF.
    -- val=+0.1 → IFA. val=+0.2 → GYRO. val=+0.3 → GB. val=+0.4 → TEST.
    -- NAV=stay (chance: 87%, default) / OFF=-0.3 (chance: 3%) / GND=-0.2 (chance: 3%)
    -- CV=-0.1 (chance: 3%) / IFA=+0.1 (chance: 2%) / others ~1% each
    { dev=44, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.1, -0.1, -0.2, -0.2, -0.2, -0.3, 0.1, 0.1, 0.2, 0.3, 0.4},  label="INS Switch" },

    -- -------------------------------------------------------------------------
    -- FLIGHT CONTROLS   dev=2 (CONTROL_INTERFACE)
    -- -------------------------------------------------------------------------

    -- FLAP Switch | default_3_position_tumb | arg 234 | arg_lim={-1,1}
    -- Hint: AUTO/HALF/FULL. Cold start: AUTO (arg=0, center).
    -- val=0 → stay AUTO (default). val=-1 → FULL. val=+1 → HALF.
    -- AUTO=stay (chance: 87%, default) / FULL=-1 (chance: 7%) / HALF=+1 (chance: 6%)
    { dev=2,  cmd=3007, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, 1, 1, 1},  label="FLAP Switch" },

    -- -------------------------------------------------------------------------
    -- ECS   dev=11 (ECS_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Defog Handle | default_axis_limited, continuous | arg ~
    -- Exempt: continuous slider, no fixed default position
    { dev=11, cmd=3016, vals={-1, -0.5, 0, 0.5, 1.0},      label="Defog Handle" },

    -- Suit Temperature Knob | default_axis_limited, continuous | arg 406
    -- Exempt: continuous rotary, no fixed default position
    { dev=11, cmd=3007, vals={0, 0.25, 0.5, 0.75, 1.0},    label="Suit Temperature Knob" },

    -- Cabin Temperature Knob | default_axis_limited, continuous | arg 407
    -- Exempt: continuous rotary, no fixed default position
    { dev=11, cmd=3006, vals={0, 0.25, 0.5, 0.75, 1.0},    label="Cabin Temperature Knob" },

    -- -------------------------------------------------------------------------
    -- HYDRAULIC   dev=4 (HYDRAULIC_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Hydraulic Isolate Override Switch | default_2_position_tumb | arg 369 | arg_lim={0,1}
    -- Hint: NORM/ORIDE. Cold start: NORM (arg=0). val=0 → stay NORM (default). val=+1 → ORIDE.
    -- NORM=stay (chance: 90%, default) / ORIDE=+1 (chance: 10%)
    { dev=4,  cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},    label="Hydraulic Isolate Override Switch" },

    -- -------------------------------------------------------------------------
    -- FUEL   dev=6 (FUEL_INTERFACE)
    -- -------------------------------------------------------------------------

    -- External Wing Tanks Fuel Control Switch | default_3_position_tumb | arg 342 | arg_lim={-1,1}
    -- Hint: STOP/NORM/ORIDE. Cold start: NORM (arg=0, center).
    -- val=0 → stay NORM (default). val=-1 → STOP. val=+1 → ORIDE.
    -- NORM=stay (chance: 90%, default) / STOP=-1 (chance: 5%) / ORIDE=+1 (chance: 5%)
    { dev=6,  cmd=3005, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},  label="External Wing Tanks Fuel Control Switch" },

    -- External Centerline Tank Fuel Control Switch | default_3_position_tumb | arg 343 | arg_lim={-1,1}
    -- Hint: STOP/NORM/ORIDE. Cold start: NORM (arg=0, center).
    -- val=0 → stay NORM (default). val=-1 → STOP. val=+1 → ORIDE.
    -- NORM=stay (chance: 90%, default) / STOP=-1 (chance: 5%) / ORIDE=+1 (chance: 5%)
    { dev=6,  cmd=3004, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},  label="External Centerline Tank Fuel Control Switch" },

    -- -------------------------------------------------------------------------
    -- INTERCOM (continued)   dev=40 (INTERCOM)
    -- -------------------------------------------------------------------------

    -- ILS Channel Selector Switch | multiposition_switch, count=20, delta=0.05 | arg 352 | arg_lim={0,0.95}
    -- 20 positions equally spaced. Each step = delta 0.05. All 20 positions equally probable.
    -- Randomized via run() to pick a random absolute position (0..19 steps from min).
    {
        dev=40, cmd=3017, label="ILS Channel Selector Switch",
        run=function(device)
            local step = math.random(0, 19)
            -- Each click moves +0.05; send enough clicks to reach target from any position.
            -- Safest: drive to 0 first (send -1.0 as large negative delta to clamp to min),
            -- then step forward exactly 'step' times.
            device:performClickableAction(3017, -1.0)   -- clamp to min (arg=0, ch1)
            for _ = 1, step do
                device:performClickableAction(3017, 0.05)
            end
        end
    },

    -- ILS UFC/MAN Switch | default_2_position_tumb | arg 353 | arg_lim={0,1}
    -- Hint: UFC/MAN. Cold start: UFC (arg=0). val=0 → stay UFC (default). val=+1 → MAN.
    -- UFC=stay (chance: 90%, default) / MAN=+1 (chance: 10%)
    { dev=40, cmd=3016, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},    label="ILS UFC/MAN Switch" },

    -- IFF Master Switch | default_2_position_tumb | arg 356 | arg_lim={0,1}
    -- Hint: EMER/NORM. Cold start: NORM (arg=0). val=0 → stay NORM (default). val=+1 → EMER.
    -- NORM=stay (chance: 90%, default) / EMER=+1 (chance: 10%)
    { dev=40, cmd=3012, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},    label="IFF Master Switch" },

    -- IFF Mode 4 Switch | default_3_position_tumb | arg 355 | arg_lim={-1,1}
    -- Hint: DIS/AUD+DIS/OFF. Cold start: center (AUD+DIS, arg=0).
    -- val=0 → stay center (default). val=-1 → DIS (left). val=+1 → OFF (right).
    -- CENTER=stay (chance: 90%, default) / DIS=-1 (chance: 5%) / OFF=+1 (chance: 5%)
    { dev=40, cmd=3013, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},  label="IFF Mode 4 Switch" },

    -- RWR Volume Control Knob | default_axis_limited, continuous | arg 359
    -- Exempt: continuous volume knob, no fixed default position
    { dev=40, cmd=3004, vals={0, 0.25, 0.5, 0.75, 1.0},    label="RWR Volume Control Knob" },

    -- MIDS A Volume Control Knob | default_axis_limited, continuous | arg 362
    -- Exempt: continuous volume knob, no fixed default position
    { dev=40, cmd=3006, vals={0, 0.25, 0.5, 0.75, 1.0},    label="MIDS A Volume Control Knob" },

    -- MIDS B Volume Control Knob | default_axis_limited, continuous | arg 361
    -- Exempt: continuous volume knob, no fixed default position
    { dev=40, cmd=3007, vals={0, 0.25, 0.5, 0.75, 1.0},    label="MIDS B Volume Control Knob" },

    -- ICS Volume Control Knob | default_axis_limited, continuous | arg 358
    -- Exempt: continuous volume knob, no fixed default position
    { dev=40, cmd=3003, vals={0, 0.25, 0.5, 0.75, 1.0},    label="ICS Volume Control Knob" },

    -- VOX Volume Control Knob | default_axis_limited, continuous | arg 357
    -- Exempt: continuous volume knob, no fixed default position
    { dev=40, cmd=3002, vals={0, 0.25, 0.5, 0.75, 1.0},    label="VOX Volume Control Knob" },

    -- AUX Volume Control Knob | default_axis_limited, continuous | arg 364
    -- Exempt: continuous volume knob, no fixed default position
    { dev=40, cmd=3009, vals={0, 0.25, 0.5, 0.75, 1.0},    label="AUX Volume Control Knob" },

    -- TACAN Volume Knob is already registered above (dev=40, cmd=3008).

    -- -------------------------------------------------------------------------
    -- CPT MECHANICS   dev=7 (CPT_MECHANICS)
    -- -------------------------------------------------------------------------

    -- Shoulder Harness Control Handle | default_2_position_tumb | arg 513 | arg_lim={0,1}
    -- Hint: LOCK/UNLOCK. No fixed cold-start default; treat as continuous.
    -- Exempt from default bias: uniform random sampling across {-1, 0, 1}.
    { dev=7,  cmd=3009, vals={-1, 0, 1},                    label="Shoulder Harness Control Handle" },

    -- -------------------------------------------------------------------------
    -- FLIGHT CONTROLS (continued)   dev=2 (CONTROL_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Throttles Friction Adjusting Lever | default_movable_axis, continuous | arg 504
    -- Exempt: continuous lever, no fixed default position
    { dev=2,  cmd=3012, vals={-1, -0.5, 0, 0.5, 1.0},      label="Throttles Friction Adjusting Lever" },

}, 3.1)