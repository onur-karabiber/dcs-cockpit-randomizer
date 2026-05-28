-- =============================================================================
-- CockpitRandomizer — fa18c.lua
-- F/A-18C Hornet | Pilot seat
-- Switch table for: FA-18C_hornet
--
-- Device IDs: DCSWorld\Mods\aircraft\FA-18C\Cockpit\Scripts\devices.lua
-- Command IDs: command_defs.lua (each device table resets to 3001)
--   Axis/knob controls use the _AXIS variant of the command (performClickableAction
--   with an _AXIS command accepts a continuous 0–1 value directly).
--   Switch/button controls use the base command.
--
-- Notes:
--   LTD/R Switch is spring-loaded; only the stable SAFE position is included.
--   HOOK BYPASS Switch is spring-loaded; both stable positions are included.
--   Controls marked "visual only" are not yet simulated in DCS.
-- =============================================================================

-- Relies on CR global table loaded by core.lua via Export.lua dofile chain.

CR.register("FA-18C_hornet", {

    -- -------------------------------------------------------------------------
    -- OXYGEN SYSTEM   dev=7 (OXYGEN_INTERFACE)
    -- -------------------------------------------------------------------------

    -- OXY Flow Knob  (axis — cmd = OxyFlowControlValve_AXIS = 3005)
    { dev=7,  cmd=3005, vals={0,0.25,0.5,0.75,1.0},    label="OXY Flow Knob" },

    -- OBOGS Control Switch, ON/OFF  (cmd = OBOGS_ControlSw = 3001)
    -- 0 = OFF (default / lower), 1 = ON
    { dev=7,  cmd=3001, vals={0,1},                     label="OBOGS Control Switch" },

    -- -------------------------------------------------------------------------
    -- INTERCOM   dev=28 (INTERCOM)
    -- -------------------------------------------------------------------------

    -- TACAN Volume Control Knob  (axis — cmd = TCN_Volume_AXIS = 3032)
    { dev=28, cmd=3032, vals={0,0.25,0.5,0.75,1.0},    label="TACAN Volume Knob" },

    -- -------------------------------------------------------------------------
    -- EXTERIOR LIGHTS   dev=26 (EXT_LIGHTS)
    -- -------------------------------------------------------------------------

    -- POSITION Lights Dimmer Control  (axis — cmd = Position_AXIS = 3006)
    { dev=26, cmd=3006, vals={0,0.25,0.5,0.75,1.0},    label="POSITION Lights Dimmer" },

    -- FORMATION Lights Dimmer Control  (axis — cmd = Formation_AXIS = 3008)
    { dev=26, cmd=3008, vals={0,0.25,0.5,0.75,1.0},    label="FORMATION Lights Dimmer" },

    -- LDG/TAXI LIGHT Switch, ON/OFF  (cmd = LdgTaxi = 3004)
    -- 0 = OFF (default / lower), 1 = ON
    { dev=26, cmd=3004, vals={0,1},                     label="LDG/TAXI LIGHT Switch" },

    -- -------------------------------------------------------------------------
    -- COCKPIT LIGHTS   dev=27 (CPT_LIGHTS)
    -- -------------------------------------------------------------------------

    -- HOOK BYPASS Switch, FIELD/CARRIER  (cmd = HookBypass = 3009)
    -- 0 = CARRIER (default / lower), 1 = FIELD (upper)
    { dev=27, cmd=3009, vals={0,1},                     label="HOOK BYPASS Switch" },

    -- CONSOLES Lights Dimmer Control  (axis — cmd = Consoles_AXIS = 3011)
    { dev=27, cmd=3011, vals={0,0.25,0.5,0.75,1.0},    label="CONSOLES Dimmer" },

    -- INST PNL Dimmer Control  (axis — cmd = InstPnl_AXIS = 3013)
    { dev=27, cmd=3013, vals={0,0.25,0.5,0.75,1.0},    label="INST PNL Dimmer" },

    -- FLOOD Light Dimmer Control  (axis — cmd = Flood_AXIS = 3015)
    { dev=27, cmd=3015, vals={0,0.25,0.5,0.75,1.0},    label="FLOOD Dimmer" },

    -- MODE Switch, NVG/NITE/DAY  (3-position — cmd = ModeSw = 3004)
    -- 0 = NVG (upper), 0.5 = NITE (middle), 1 = DAY (default / lower)
    -- DAY appears twice → 40% probability of staying at default
    { dev=27, cmd=3004, vals={0,0.5,1.0,1.0},          label="MODE Switch" },

    -- WARN/CAUTION Dimmer Control  (axis — cmd = WarnCaution_AXIS = 3023)
    { dev=27, cmd=3023, vals={0,0.25,0.5,0.75,1.0},    label="WARN/CAUTION Dimmer" },

    -- CHART Light Dimmer Control  (axis — cmd = Chart_AXIS = 3018)
    { dev=27, cmd=3018, vals={0,0.25,0.5,0.75,1.0},    label="CHART Dimmer" },

    -- -------------------------------------------------------------------------
    -- LANDING GEAR   dev=5 (GEAR_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Anti Skid Switch, ON/OFF  (cmd = AntiSkidSw = 3004)
    -- 0 = OFF (lower), 1 = ON (default / upper)
    -- ON appears twice → 40% probability of staying at default
    { dev=5,  cmd=3004, vals={0,1,1},                   label="Anti Skid Switch" },

    -- -------------------------------------------------------------------------
    -- HUD   dev=17 (HUD)
    -- -------------------------------------------------------------------------

    -- Altitude Switch, BARO/RDR  (cmd = HUD_AltitudeSw = 3008)
    -- 0 = RDR (lower), 1 = BARO (default / upper)
    -- BARO appears twice → 40% probability
    { dev=17, cmd=3008, vals={0,1,1},                   label="Altitude Switch" },

    -- HUD Symbology Brightness Selector Knob, DAY/NIGHT  (cmd = HUD_SymbBrightSelKnob = 3003)
    -- 0 = NIGHT (lower), 1 = DAY (default / upper)
    { dev=17, cmd=3003, vals={0,1},                     label="HUD Symbology Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- UFC   dev=12 (UFC)
    -- -------------------------------------------------------------------------

    -- UFC COMM 1 Volume Control Knob  (axis — cmd = Comm1Vol_AXIS = 3037)
    { dev=12, cmd=3037, vals={0,0.25,0.5,0.75,1.0},    label="UFC COMM 1 Volume" },

    -- UFC COMM 2 Volume Control Knob  (axis — cmd = Comm2Vol_AXIS = 3039)
    { dev=12, cmd=3039, vals={0,0.25,0.5,0.75,1.0},    label="UFC COMM 2 Volume" },

    -- -------------------------------------------------------------------------
    -- MDI LEFT   dev=14 (MDI_LEFT)
    -- -------------------------------------------------------------------------

    -- Left MDI Brightness Selector Knob, OFF/NIGHT/DAY  (3-position, 0.1 step)
    -- cmd = MDI_off_night_day = 3001
    -- 0 = OFF (default / leftmost), 0.1 = NIGHT, 0.2 = DAY
    -- OFF appears twice → 40% probability
    { dev=14, cmd=3001, vals={0,0,0.1,0.2},             label="Left MDI Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- MDI RIGHT   dev=15 (MDI_RIGHT)
    -- -------------------------------------------------------------------------

    -- Right MDI Brightness Selector Knob, OFF/NIGHT/DAY  (3-position, 0.1 step)
    -- cmd = MDI_off_night_day = 3001
    -- 0 = OFF (default / leftmost), 0.1 = NIGHT, 0.2 = DAY
    { dev=15, cmd=3001, vals={0,0,0.1,0.2},             label="Right MDI Brightness Selector" },

    -- -------------------------------------------------------------------------
    -- AMPCD   dev=16 (AMPCD)
    -- -------------------------------------------------------------------------

    -- AMPCD Off/Brightness Control Knob  (axis — cmd = AMPCD_off_brightness_AXIS = 3002)
    -- 0 = OFF (default), sampled; OFF appears twice → ~33% probability
    { dev=16, cmd=3002, vals={0,0,0.25,0.5,0.75,1.0},  label="AMPCD Off/Brightness Knob" },

    -- -------------------------------------------------------------------------
    -- WEAPONS   dev=18 (SMS)
    -- -------------------------------------------------------------------------

    -- Master Arm Switch, ARM/SAFE  (cmd = MasterArmSw = 3003)
    -- 0 = SAFE (default / lower), 1 = ARM
    -- SAFE appears twice → ~67% probability of staying safe
    { dev=18, cmd=3003, vals={0,0,1},                   label="Master Arm Switch" },

    -- -------------------------------------------------------------------------
    -- ELECTRICAL   dev=3 (ELEC_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Left Generator Control Switch, NORM/OFF  (cmd = LGenSw = 3002)
    -- 0 = OFF (lower), 1 = NORM (default / upper)
    -- NORM appears twice → 40% probability
    { dev=3,  cmd=3002, vals={0,1,1},                   label="Left Generator Switch" },

    -- Right Generator Control Switch, NORM/OFF  (cmd = RGenSw = 3003)
    -- 0 = OFF (lower), 1 = NORM (default / upper)
    { dev=3,  cmd=3003, vals={0,1,1},                   label="Right Generator Switch" },

    -- CB LAUNCH BAR, ON/OFF  (circuit breaker — cmd = CB_LAUNCH_BAR = 3020)
    -- 0 = pushed in / ON (default), 1 = pulled out / OFF
    { dev=3,  cmd=3020, vals={0,1},                     label="CB LAUNCH BAR" },

    -- CB SPD BRK, ON/OFF  (circuit breaker — cmd = CB_SPD_BRK = 3019)
    { dev=3,  cmd=3019, vals={0,1},                     label="CB SPD BRK" },

    -- CB FCS CHAN 1, ON/OFF  (circuit breaker — cmd = CB_FCS_CHAN1 = 3017)
    { dev=3,  cmd=3017, vals={0,1},                     label="CB FCS CHAN 1" },

    -- CB FCS CHAN 2, ON/OFF  (circuit breaker — cmd = CB_FCS_CHAN2 = 3018)
    { dev=3,  cmd=3018, vals={0,1},                     label="CB FCS CHAN 2" },

    -- -------------------------------------------------------------------------
    -- COUNTERMEASURES   dev=29 (CMDS)
    -- -------------------------------------------------------------------------

    -- DISPENSER Switch, BYPASS/ON/OFF  (3-position, 0.1 step — cmd = Dispenser = 3001)
    -- 0 = BYPASS (upper), 0.1 = ON (middle), 0.2 = OFF (default / lower)
    -- OFF appears twice → 40% probability
    { dev=29, cmd=3001, vals={0,0.1,0.2,0.2},           label="DISPENSER Switch" },

    -- -------------------------------------------------------------------------
    -- ECM   dev=24 (ASPJ)
    -- -------------------------------------------------------------------------

    -- ECM Mode Switch, XMIT/REC/BIT/STBY/OFF  (5-position, 0.1 step)
    -- cmd = ASPJ_SwitchChange = 3001
    -- 0=XMIT, 0.1=REC, 0.2=BIT, 0.3=STBY, 0.4=OFF (default / lower)
    -- OFF appears twice → ~33% probability
    { dev=24, cmd=3001, vals={0,0.1,0.2,0.3,0.4,0.4},  label="ECM Mode Switch" },

    -- -------------------------------------------------------------------------
    -- TGP   dev=25 (TGP_INTERFACE)
    -- -------------------------------------------------------------------------

    -- LTD/R Switch, ARM/SAFE  (spring-loaded ARM; stable position = SAFE only)
    -- cmd = LtdrArm = 3002
    -- 0 = SAFE (default / lower) — ARM is momentary, excluded
    { dev=25, cmd=3002, vals={0},                       label="LTD/R Switch" },

    -- LST/NFLR Switch, ON/OFF  (cmd = Lst = 3003)
    -- 0 = OFF (default / lower), 1 = ON
    { dev=25, cmd=3003, vals={0,1},                     label="LST/NFLR Switch" },

    -- -------------------------------------------------------------------------
    -- RADAR   dev=19 (RADAR)
    -- -------------------------------------------------------------------------

    -- RADAR Switch, OFF/STBY/OPR/EMERG  (4-position, 0.1 step)
    -- cmd = RADAR_SwitchChange = 3001
    -- 0=OFF(default), 0.1=STBY, 0.2=OPR — EMERG(pull) excluded
    -- OFF appears twice → 40% probability
    { dev=19, cmd=3001, vals={0,0,0.1,0.2},             label="RADAR Switch" },

    -- -------------------------------------------------------------------------
    -- INS   dev=23 (INS)
    -- -------------------------------------------------------------------------

    -- INS Switch, OFF/CV/GND/NAV/IFA/GYRO/GB/TEST  (8-position, 0.1 step)
    -- cmd = INS_SwitchChange = 3001
    -- 0=OFF(default), 0.1=CV, 0.2=GND, 0.3=NAV, 0.4=IFA,
    -- 0.5=GYRO, 0.6=GB, 0.7=TEST
    -- OFF appears twice → ~22% probability
    { dev=23, cmd=3001,
      vals={0,0,0.1,0.2,0.3,0.4,0.5,0.6,0.7},
      label="INS Switch" },

    -- -------------------------------------------------------------------------
    -- FLIGHT CONTROLS   dev=2 (CONTROL_INTERFACE)
    -- -------------------------------------------------------------------------

    -- FLAP Switch, AUTO/HALF/FULL  (3-position — cmd = FlapSw = 3007)
    -- 0=AUTO(upper), 0.5=HALF(middle), 1=FULL(default/lower)
    -- FULL appears twice → 40% probability
    { dev=2,  cmd=3007, vals={0,0.5,1.0,1.0},           label="FLAP Switch" },

    -- -------------------------------------------------------------------------
    -- ECS   dev=8 (ECS_INTERFACE)
    -- -------------------------------------------------------------------------

    -- Defog Handle  (axis — cmd = DefogHandle_AXIS = 3016; range -1 to 1)
    -- visual only; not yet simulated in DCS
    { dev=8,  cmd=3016, vals={-1,-0.5,0,0.5,1.0},       label="Defog Handle" },

}, 10.0)
-- Note: FA-18C requires a longer delay (10s) because the avionics
-- initialization sequence resets switches after the cockpit loads.
