-- =============================================================================
-- CockpitRandomizer — fa18c.lua
-- F/A-18C Hornet | Pilot seat
-- Switch table for: FA-18C_hornet
--
-- Device IDs from: DCSWorld\Mods\aircraft\FA-18C\Cockpit\Scripts\devices.lua
-- Command IDs from: command_defs.lua  (each device table resets to 3001)
-- Arg numbers from: clickabledata.lua  (4th integer argument of each element)
--
-- Notes:
--   - LTD/R Switch and HOOK BYPASS Switch are spring-loaded; only their
--     stable (non-momentary) positions are included in vals.
--   - Controls marked "visual only" are not yet simulated in DCS.
-- =============================================================================

-- Relies on CR global table loaded by core.lua via Export.lua dofile chain.

CR.register("FA-18C_hornet", {

    -- -------------------------------------------------------------------------
    -- OXYGEN SYSTEM   dev=7 (OXYGEN_INTERFACE)
    -- -------------------------------------------------------------------------

    -- OXY Flow Knob  (axis, 0–1)
    -- No fixed default; sampled at 5 steps
    { dev=7,  cmd=3002, vals={0,0.25,0.5,0.75,1.0},   label="OXY Flow Knob" },

    -- OBOGS Control Switch, ON/OFF
    -- 0 = OFF (default / lower), 1 = ON
    { dev=7,  cmd=3001, vals={0,1},                    label="OBOGS Control Switch" },

    -- -------------------------------------------------------------------------
    -- INTERCOM   dev=28 (INTERCOM)
    -- -------------------------------------------------------------------------

    -- TACAN Volume Control Knob  (axis, 0–1)
    { dev=28, cmd=3008, vals={0,0.25,0.5,0.75,1.0},   label="TACAN Volume Knob" },

    -- -------------------------------------------------------------------------
    -- EXTERIOR LIGHTS   dev=26 (EXT_LIGHTS)
    -- -------------------------------------------------------------------------

    -- POSITION Lights Dimmer Control  (axis, 0–1)
    { dev=26, cmd=3001, vals={0,0.25,0.5,0.75,1.0},   label="POSITION Lights Dimmer" },

    -- FORMATION Lights Dimmer Control  (axis, 0–1)
    { dev=26, cmd=3002, vals={0,0.25,0.5,0.75,1.0},   label="FORMATION Lights Dimmer" },

    -- LDG/TAXI LIGHT Switch, ON/OFF
    -- 0 = OFF (default / lower), 1 = ON
    { dev=26, cmd=3004, vals={0,1},                    label="LDG/TAXI LIGHT Switch" },

    -- -------------------------------------------------------------------------
    -- COCKPIT LIGHTS   dev=27 (CPT_LIGHTS)
    -- -------------------------------------------------------------------------

    -- HOOK BYPASS Switch, FIELD/CARRIER  (spring-loaded; stable positions only)
    -- 0 = CARRIER (default / lower), 1 = FIELD (upper)
    { dev=27, cmd=3009, vals={0,1},                    label="HOOK BYPASS Switch" },

    -- CONSOLES Lights Dimmer Control  (axis, 0–1; default = 0 / fully CCW)
    { dev=27, cmd=3001, vals={0,0.25,0.5,0.75,1.0},   label="CONSOLES Dimmer" },

    -- INST PNL Dimmer Control  (axis, 0–1; default = 0 / fully CCW)
    { dev=27, cmd=3002, vals={0,0.25,0.5,0.75,1.0},   label="INST PNL Dimmer" },

    -- FLOOD Light Dimmer Control  (axis, 0–1; default = 0 / fully CCW)
    { dev=27, cmd=3003, vals={0,0.25,0.5,0.75,1.0},   label="FLOOD Dimmer" },

    -- MODE Switch, NVG/NITE/DAY  (3-position)
    -- 0 = NVG (upper), 0.5 = NITE (middle), 1 = DAY (default / lower)
    -- DAY appears twice → 40% probability of staying at default
    { dev=27, cmd=3004, vals={0,0.5,1.0,1.0},         label="MODE Switch" },

    -- WARN/CAUTION Dimmer Control  (axis, 0–1)
    { dev=27, cmd=3006, vals={0,0.25,0.5,0.75,1.0},   label="WARN/CAUTION Dimmer" },

    -- CHART Light Dimmer Control  (axis, 0–1; default = 0 / fully CCW)
    { dev=27, cmd=3005, vals={0,0.25,0.5,0.75,1.0},   label="CHART Dimmer" },

    -- -------------------------------------------------------------------------
    -- LANDING GEAR   dev=5 (GEAR_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Anti Skid Switch, ON/OFF
    -- 0 = OFF (lower), 1 = ON (default / upper)
    -- ON appears twice → 40% probability of staying at default
    { dev=5,  cmd=3004, vals={0,1,1},                  label="Anti Skid Switch" },

    -- -------------------------------------------------------------------------
    -- HUD   dev=17 (HUD)
    -- -------------------------------------------------------------------------

    -- Altitude Switch, BARO/RDR
    -- 0 = RDR (lower), 1 = BARO (default / upper)
    -- BARO appears twice → 40% probability
    { dev=17, cmd=3008, vals={0,1,1},                  label="Altitude Switch" },

    -- HUD Symbology Brightness Selector Knob, DAY/NIGHT
    -- 0 = NIGHT (lower), 1 = DAY (default / upper)
    { dev=17, cmd=3003, vals={0,1},                    label="HUD Symbology Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- UFC   dev=12 (UFC)
    -- -------------------------------------------------------------------------

    -- UFC COMM 1 Volume Control Knob  (axis, 0–1)
    { dev=12, cmd=3030, vals={0,0.25,0.5,0.75,1.0},   label="UFC COMM 1 Volume" },

    -- UFC COMM 2 Volume Control Knob  (axis, 0–1)
    { dev=12, cmd=3031, vals={0,0.25,0.5,0.75,1.0},   label="UFC COMM 2 Volume" },

    -- -------------------------------------------------------------------------
    -- MDI LEFT   dev=14 (MDI_LEFT)
    -- -------------------------------------------------------------------------

    -- Left MDI Brightness Selector Knob, OFF/NIGHT/DAY  (3-position)
    -- 0 = OFF (default / leftmost), 0.1 = NIGHT, 0.2 = DAY
    { dev=14, cmd=3001, vals={0,0,0.1,0.2},            label="Left MDI Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- MDI RIGHT   dev=15 (MDI_RIGHT)
    -- -------------------------------------------------------------------------

    -- Right MDI Brightness Selector Knob, OFF/NIGHT/DAY  (3-position)
    -- 0 = OFF (default / leftmost), 0.1 = NIGHT, 0.2 = DAY
    { dev=15, cmd=3001, vals={0,0,0.1,0.2},            label="Right MDI Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- AMPCD   dev=16 (AMPCD)
    -- -------------------------------------------------------------------------

    -- AMPCD Off/Brightness Control Knob  (axis, 0–1; default = 0 / OFF)
    { dev=16, cmd=3001, vals={0,0,0.25,0.5,0.75,1.0}, label="AMPCD Off/Brightness Knob" },

    -- -------------------------------------------------------------------------
    -- WEAPONS   dev=18 (SMS)
    -- -------------------------------------------------------------------------

    -- Master Arm Switch, ARM/SAFE
    -- 0 = SAFE (default / lower), 1 = ARM
    -- SAFE appears twice → 40% probability of staying safe
    { dev=18, cmd=3003, vals={0,0,1},                  label="Master Arm Switch" },

    -- -------------------------------------------------------------------------
    -- ELECTRICAL   dev=3 (ELEC_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Left Generator Control Switch, NORM/OFF
    -- 0 = OFF (lower), 1 = NORM (default / upper)
    -- NORM appears twice → 40% probability
    { dev=3,  cmd=3002, vals={0,1,1},                  label="Left Generator Switch" },

    -- Right Generator Control Switch, NORM/OFF
    -- 0 = OFF (lower), 1 = NORM (default / upper)
    { dev=3,  cmd=3003, vals={0,1,1},                  label="Right Generator Switch" },

    -- CB LAUNCH BAR, ON/OFF  (circuit breaker button)
    -- 0 = pushed in / ON (default), 1 = pulled out / OFF
    { dev=3,  cmd=3020, vals={0,1},                    label="CB LAUNCH BAR" },

    -- CB SPD BRK, ON/OFF  (circuit breaker button)
    -- 0 = pushed in / ON (default), 1 = pulled out / OFF
    { dev=3,  cmd=3019, vals={0,1},                    label="CB SPD BRK" },

    -- CB FCS CHAN 1, ON/OFF  (circuit breaker button)
    -- 0 = pushed in / ON (default), 1 = pulled out / OFF
    { dev=3,  cmd=3017, vals={0,1},                    label="CB FCS CHAN 1" },

    -- CB FCS CHAN 2, ON/OFF  (circuit breaker button)
    -- 0 = pushed in / ON (default), 1 = pulled out / OFF
    { dev=3,  cmd=3018, vals={0,1},                    label="CB FCS CHAN 2" },

    -- -------------------------------------------------------------------------
    -- COUNTERMEASURES   dev=29 (CMDS)
    -- -------------------------------------------------------------------------

    -- DISPENSER Switch, BYPASS/ON/OFF  (3-position, 0.1 step)
    -- 0 = BYPASS (upper), 0.1 = ON (middle), 0.2 = OFF (default / lower)
    -- OFF appears twice → 40% probability
    { dev=29, cmd=3001, vals={0,0.1,0.2,0.2},          label="DISPENSER Switch" },

    -- -------------------------------------------------------------------------
    -- ECM   dev=24 (ASPJ)
    -- -------------------------------------------------------------------------

    -- ECM Mode Switch, XMIT/REC/BIT/STBY/OFF  (5-position, 0.1 step)
    -- 0=XMIT, 0.1=REC, 0.2=BIT, 0.3=STBY, 0.4=OFF (default / lower)
    -- OFF appears twice → ~33% probability
    { dev=24, cmd=3001, vals={0,0.1,0.2,0.3,0.4,0.4}, label="ECM Mode Switch" },

    -- -------------------------------------------------------------------------
    -- TGP   dev=25 (TGP_INTERFACE)
    -- -------------------------------------------------------------------------

    -- LTD/R Switch, ARM/SAFE  (spring-loaded ARM; stable position = SAFE only)
    -- 0 = SAFE (default / lower)  — ARM is momentary, excluded
    { dev=25, cmd=3002, vals={0},                      label="LTD/R Switch" },

    -- LST/NFLR Switch, ON/OFF
    -- 0 = OFF (default / lower), 1 = ON
    { dev=25, cmd=3003, vals={0,1},                    label="LST/NFLR Switch" },

    -- -------------------------------------------------------------------------
    -- RADAR   dev=19 (RADAR)
    -- -------------------------------------------------------------------------

    -- RADAR Switch, OFF/STBY/OPR/EMERG  (4-position, 0.1 step)
    -- 0=OFF(default), 0.1=STBY, 0.2=OPR, 0.3=EMERG(pull — excluded)
    -- OFF appears twice → 40% probability
    { dev=19, cmd=3001, vals={0,0,0.1,0.2},            label="RADAR Switch" },

    -- -------------------------------------------------------------------------
    -- INS   dev=23 (INS)
    -- -------------------------------------------------------------------------

    -- INS Switch, OFF/CV/GND/NAV/IFA/GYRO/GB/TEST  (8-position, 0.1 step)
    -- 0=OFF(default), 0.1=CV, 0.2=GND, 0.3=NAV, 0.4=IFA, 0.5=GYRO,
    -- 0.6=GB, 0.7=TEST
    -- OFF appears twice → ~22% probability
    { dev=23, cmd=3001,
      vals={0,0,0.1,0.2,0.3,0.4,0.5,0.6,0.7},
      label="INS Switch" },

    -- -------------------------------------------------------------------------
    -- FLIGHT CONTROLS   dev=2 (CONTROL_INTERFACE)
    -- -------------------------------------------------------------------------

    -- FLAP Switch, AUTO/HALF/FULL  (3-position)
    -- 0=AUTO(upper), 0.5=HALF(middle), 1=FULL(default/lower)
    -- FULL appears twice → 40% probability
    { dev=2,  cmd=3007, vals={0,0.5,1.0,1.0},          label="FLAP Switch" },

    -- -------------------------------------------------------------------------
    -- ECS   dev=8 (ECS_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Defog Handle  (movable axis, -1 to 1; visual only)
    -- Sampled symmetrically around center
    { dev=8,  cmd=3005, vals={-1,-0.5,0,0.5,1.0},      label="Defog Handle" },
})
