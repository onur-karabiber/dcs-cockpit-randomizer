-- =============================================================================
-- CockpitRandomizer — f14b.lua
-- F-14B Tomcat | Pilot seat
-- Switch table for: F-14B
--
-- Device IDs: DCSWorld\Mods\aircraft\F14\Cockpit\Scripts\devices.lua
-- Command IDs: command_defs.lua
--
-- Notes:
--   Navigation Steer Commands are momentary buttons (default_displaybutton).
--   Only one can be active at a time — script picks one randomly.
--   HUD mode buttons are also momentary — same logic.
--   Master Arm Cover is a lever (0=closed, 1=open).
--   Hydraulic Transfer Pump Switch Cover must be opened before pump switch.
--   Temperature and light intensity knobs are 9-position (0, 0.125 … 1.0).
--   ACP Panel Light not found in clickabledata — omitted.
-- =============================================================================

CR.register("F-14B", {

    -- -------------------------------------------------------------------------
    -- TACAN   dev=47 (TACAN)
    -- TACAN Mode Selector: 5-position (OFF/REC/T-R/A/A TR/BCN), step=0.25
    -- 0=OFF(default), 0.25=REC, 0.5=T-R, 0.75=A/A TR, 1.0=BCN
    -- OFF appears twice → 40% probability
    -- -------------------------------------------------------------------------
    { dev=47, cmd=3329, vals={0,0,0.25,0.5,0.75,1.0},  label="TACAN Mode Selector" },

    -- -------------------------------------------------------------------------
    -- OXYGEN   dev=12 (COCKPITMECHANICS)
    -- Pilot Oxygen On, ON/OFF  (0=OFF, 1=ON)
    -- ON appears twice → 40% probability of staying off (safer default)
    -- -------------------------------------------------------------------------
    { dev=12, cmd=3190, vals={0,1,1},                   label="Pilot Oxygen On" },

    -- -------------------------------------------------------------------------
    -- ICS VOLUMES   dev=2 (ICS)
    -- Sidewinder Volume and ALR-67 Volume are axis knobs on the ICS panel.
    -- -------------------------------------------------------------------------
    { dev=2,  cmd=3400, vals={0,0.25,0.5,0.75,1.0},    label="Sidewinder Volume" },
    { dev=2,  cmd=3398, vals={0,0.25,0.5,0.75,1.0},    label="ALR-67 Volume" },

    -- -------------------------------------------------------------------------
    -- RADIO VOLUMES
    -- VHF/UHF ARC-182   dev=4 (ARC182)
    -- UHF ARC-159       dev=3 (ARC159)
    -- -------------------------------------------------------------------------
    { dev=4,  cmd=3406, vals={0,0.25,0.5,0.75,1.0},    label="VHF/UHF ARC-182 Volume Pilot" },
    { dev=3,  cmd=3362, vals={0,0.25,0.5,0.75,1.0},    label="UHF ARC-159 Volume Pilot" },

    -- UHF ARC-159 Freq Mode: 3-position (GUARD/MAN/PRESET), step=0.5
    -- 0=GUARD, 0.5=MAN, 1.0=PRESET(default)
    -- PRESET appears twice → 40% probability
    { dev=3,  cmd=3378, vals={0,0.5,1.0,1.0},           label="UHF ARC-159 Freq Mode" },

    -- UHF ARC-159 Function: 4-position (OFF/MAIN/BOTH/ADF), step=0.333
    -- 0=OFF(default), 0.333=MAIN, 0.666=BOTH, 1.0=ADF
    -- OFF appears twice → 40% probability
    { dev=3,  cmd=3374, vals={0,0,0.333,0.666,1.0},     label="UHF ARC-159 Function" },

    -- -------------------------------------------------------------------------
    -- AFCS   dev=22 (AFCS)
    -- Stability Augmentation switches (0=OFF, 1=ON)
    -- ON appears twice on pitch/roll/yaw → 67% probability of being engaged
    -- -------------------------------------------------------------------------
    { dev=22, cmd=3036, vals={0,1,1},                   label="AFCS Stability Augmentation - Yaw" },
    { dev=22, cmd=3035, vals={0,1,1},                   label="AFCS Stability Augmentation - Roll" },
    { dev=22, cmd=3034, vals={0,1,1},                   label="AFCS Stability Augmentation - Pitch" },

    -- Autopilot Engage (0=OFF, 1=ON) — OFF weighted
    { dev=22, cmd=3040, vals={0,0,1},                   label="Autopilot - Engage" },

    -- Autopilot Altitude Hold (0=OFF, 1=ON)
    { dev=22, cmd=3038, vals={0,1},                     label="Autopilot - Altitude Hold" },

    -- Autopilot Heading/Ground Track: 3-position (HDG/OFF/GT)
    -- 0=HDG, 0.5=OFF(default), 1.0=GT
    -- OFF appears twice → 40% probability
    { dev=22, cmd=3039, vals={0,0.5,0.5,1.0},           label="Autopilot - Heading / Ground Track" },

    -- Autopilot Vector/ACL: 3-position (VEC/OFF/ACL)
    -- 0=VEC, 0.5=OFF(default), 1.0=ACL
    -- OFF appears twice → 40% probability
    { dev=22, cmd=3037, vals={0,0.5,0.5,1.0},           label="Autopilot - Vector / Automatic Carrier Landing" },

    -- -------------------------------------------------------------------------
    -- ENGINE   dev=20 (ENGINE)
    -- Left/Right Engine Mode (0=OFF/IDLE, 1=NORM)
    -- NORM appears twice → 67% probability
    -- -------------------------------------------------------------------------
    { dev=20, cmd=3052, vals={0,1,1},                   label="Left Engine Mode" },
    { dev=20, cmd=3053, vals={0,1,1},                   label="Right Engine Mode" },

    -- -------------------------------------------------------------------------
    -- GEAR/BRAKES   dev=18 (GEARHOOK)
    -- Anti-Skid Spoiler BK Switch: 3-position (BOTH/OFF/SPOILER BK)
    -- 0=BOTH(default/upper), 0.5=OFF(middle), 1.0=SPOILER BK(lower)
    -- BOTH appears twice → 40% probability
    -- -------------------------------------------------------------------------
    { dev=18, cmd=3014, vals={0,0,0.5,1.0},             label="Anti-Skid Spoiler BK Switch" },

    -- -------------------------------------------------------------------------
    -- FUEL   dev=21 (FUELSYSTEM)
    -- Wing/Ext Trans: 3-position (WING/OFF/EXT)
    -- 0=WING, 0.5=NORM(default), 1.0=EXT
    -- NORM appears twice → 40% probability
    -- -------------------------------------------------------------------------
    { dev=21, cmd=3066, vals={0,0.5,0.5,1.0},           label="Wing/Ext Trans" },

    -- -------------------------------------------------------------------------
    -- WEAPONS   dev=55 (WEAPONS)
    -- Master Arm Cover: lever (0=closed/default, 1=open)
    -- Closed appears twice → 67% probability safe
    -- -------------------------------------------------------------------------
    { dev=55, cmd=3135, vals={0,0,1},                   label="Master Arm Cover" },

    -- -------------------------------------------------------------------------
    -- HUD MODES   dev=40 (HUD)
    -- Momentary buttons — script picks one to activate.
    -- -------------------------------------------------------------------------
    { dev=40, cmd=3216, vals={1},                       label="HUD Take-off Mode" },
    { dev=40, cmd=3217, vals={1},                       label="HUD Cruise Mode" },
    { dev=40, cmd=3218, vals={1},                       label="HUD Air-to-Air Mode" },
    { dev=40, cmd=3219, vals={1},                       label="HUD Air-to-Ground Mode" },
    { dev=40, cmd=3220, vals={1},                       label="HUD Landing Mode" },

    -- -------------------------------------------------------------------------
    -- NAVIGATION STEER COMMANDS   dev=46 (NAV_INTERFACE)
    -- Momentary buttons — script picks one to activate.
    -- -------------------------------------------------------------------------
    { dev=46, cmd=3317, vals={1},                       label="Navigation Steer Commands: TACAN" },
    { dev=46, cmd=3318, vals={1},                       label="Navigation Steer Commands: Destination" },
    { dev=46, cmd=3321, vals={1},                       label="Navigation Steer Commands: AWL PCD" },
    { dev=46, cmd=3319, vals={1},                       label="Navigation Steer Commands: Vector" },
    { dev=46, cmd=3320, vals={1},                       label="Navigation Steer Commands: Manual" },

    -- -------------------------------------------------------------------------
    -- HUD / VDI / HSD   dev=40/42/41
    -- -------------------------------------------------------------------------
    { dev=40, cmd=3227, vals={0,1},                     label="HUD AWL Mode" },
    { dev=42, cmd=3225, vals={0,1},                     label="VDI Landing Mode" },
    { dev=41, cmd=3235, vals={0,0.5,1.0},               label="HSD Display Mode" },
    { dev=42, cmd=3214, vals={0,1,1},                   label="VDI Power On/Off" },
    { dev=40, cmd=3213, vals={0,1,1},                   label="HUD Power On/Off" },
    { dev=41, cmd=3215, vals={0,1,1},                   label="HSD/ECM Power On/Off" },

    -- -------------------------------------------------------------------------
    -- ANA/ARA-63   dev=50 (ILS)
    -- -------------------------------------------------------------------------
    { dev=50, cmd=3322, vals={0,1},                     label="ANA/ARA-63 Power Switch" },

    -- -------------------------------------------------------------------------
    -- COCKPIT MECHANICS   dev=12 (COCKPITMECHANICS)
    -- -------------------------------------------------------------------------
    { dev=12, cmd=3211, vals={0,1},                     label="Hook Bypass" },
    { dev=12, cmd=3171, vals={0,1},                     label="Taxi Light" },
    { dev=12, cmd=3173, vals={0,0.5,1.0},               label="White Flood Light" },
    { dev=12, cmd=3172, vals={0,0.5,1.0},               label="Red Flood Light" },

    -- Position Lights Wing: 3-position (OFF/DIM/BRT), step=0.5
    { dev=12, cmd=3174, vals={0,0.5,1.0},               label="Position Lights Wing" },
    -- Position Lights Tail: 3-position
    { dev=12, cmd=3175, vals={0,0.5,1.0},               label="Position Lights Tail" },
    -- Position Lights Flash: 2-position
    { dev=12, cmd=3176, vals={0,1},                     label="Position Lights Flash" },
    -- Anti-Collision: 2-position
    { dev=12, cmd=3177, vals={0,1},                     label="Anti-Collision Lights" },

    -- Instrument Light Intensity: 9-position (0 … 1.0, step=0.125)
    { dev=12, cmd=3179, vals={0,0.125,0.25,0.375,0.5,0.625,0.75,0.875,1.0}, label="Instrument Light Intensity" },
    -- Console Light Intensity: 9-position
    { dev=12, cmd=3180, vals={0,0.125,0.25,0.375,0.5,0.625,0.75,0.875,1.0}, label="Console Light Intensity" },
    -- Formation Light Intensity: 9-position
    { dev=12, cmd=3181, vals={0,0.125,0.25,0.375,0.5,0.625,0.75,0.875,1.0}, label="Formation Light Intensity" },

    -- Temperature: 9-position knob
    { dev=12, cmd=3651, vals={0,0.125,0.25,0.375,0.5,0.625,0.75,0.875,1.0}, label="Temperature" },

    -- -------------------------------------------------------------------------
    -- HYDRAULICS   dev=13 (HYDRAULICS)
    -- Transfer Pump Switch Cover must open before pump switch matters.
    -- Cover: 0=closed(default), 1=open
    -- -------------------------------------------------------------------------
    { dev=13, cmd=3002, vals={0,1},                     label="Hydraulic Transfer Pump Switch Cover" },

}, 10.0)
-- Note: F-14B uses a 10s delay to allow avionics initialization to complete.