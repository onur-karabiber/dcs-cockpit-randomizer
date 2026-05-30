-- =============================================================================
-- CockpitRandomizer — f16c.lua
-- F-16C Viper | Block 50
-- Switch table for: F-16C_50
--
-- Device IDs: Mods/aircraft/F-16C/Cockpit/Scripts/devices.lua (counter order)
-- Argument numbers: clickabledata.lua
-- Command numbers: command_defs.lua (each device resets count = start_command = 3000)
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
-- EXCEPTION — RDR ALT Switch:
--   Cold start is STBY (arg=0). Positions: OFF(arg=-1), STBY(arg=0), RDR ALT(arg=+1).
--   Target dominant position is OFF → val=-1 is dominant.
--   val=-1 = OFF (90%), val=0 = stay STBY (10%), val=+1 = RDR ALT (not used).
--
-- DEFAULT WEIGHT POLICY:
--   All fixed-position switches have their dominant delta weighted at 85–95%
--   of the vals pool. Continuous axis/brightness/volume knobs are exempt and
--   retain uniform sampling.
-- =============================================================================

CR.register("F-16C_50", {

    -- =========================================================================
    -- ELECTRICAL / TEST PANEL   dev=3  (ELEC_INTERFACE)
    -- elec_commands counter (start=3000):
    --   MainPwrSw=3001, CautionResetBtn=3002, FlcsPwrTestSwMAINT=3003,
    --   FlcsPwrTestSwTEST=3004, EPU_GEN_TestSw=3005, ProbeHeatSw=3006, ProbeHeatSwTEST=3007
    -- =========================================================================

    -- PROBE HEAT Switch | default_button_tumb | arg 578 | arg_lim BTN={-1,0} TUMB={0,1}
    -- Cold start: OFF (arg=0). TUMB cmd = ProbeHeatSw=3006. val=0 → stay OFF. val=+1 → PROBE HEAT.
    -- OFF=stay (chance: 90%) / PROBE HEAT=+1 (chance: 10%)
    { dev=3,  cmd=3006, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                       label="PROBE HEAT Switch" },

    -- FLCS PWR TEST Switch | default_tumb_button | arg 585 | arg_lim TUMB={-1,0} BTN={0,1}
    -- Cold start: NORM (arg=0, upper limit of TUMB side). TUMB cmd = FlcsPwrTestSwMAINT=3003.
    -- val=0 → stay NORM. val=-1 → MAINT.
    -- NORM=stay (chance: 90%) / MAINT=-1 (chance: 10%)
    { dev=3,  cmd=3003, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -1},                      label="FLCS POWER Switch" },

    -- =========================================================================
    -- FLIGHT CONTROL PANEL   dev=2  (CONTROL_INTERFACE)
    -- control_commands counter (start=3000):
    --   DigitalBackup=3001, AltFlaps=3002, BitSw=3003, FlcsReset=3004,
    --   LeFlaps=3005, TrimApDisc=3006, RollTrim=3007, PitchTrim=3008,
    --   YawTrim=3009, ManualPitchOverride=3010, StoresConfig=3011,
    --   ApPitchAtt=3012, ApPitchAlt=3013, ApRoll=3014, AdvMode=3015,
    --   ManualTfFlyup=3016, ...
    -- =========================================================================

    -- TRIM/AP DISC Switch | default_2_position_tumb | arg 564 | arg_lim={0,1}
    -- Cold start: DISC (arg=0). val=+1 → NORM (dominant). val=0 → stay DISC.
    -- NORM=+1 (chance: 90%) / DISC=stay (chance: 10%)
    { dev=2,  cmd=3006, vals={1, 1, 1, 1, 1, 1, 1, 1, 1, 0},                       label="TRIM/AP DISC Switch" },

    -- DIGITAL BACKUP Switch | default_2_position_tumb | arg 566 | arg_lim={0,1}
    -- Cold start: OFF (arg=1). val=0 → stay OFF. val=-1 → BACKUP.
    -- OFF=stay (chance: 90%) / BACKUP=-1 (chance: 10%)
    { dev=2,  cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -1},                      label="DIGITAL BACKUP Switch" },

    -- ALT FLAPS Switch | default_2_position_tumb | arg 567 | arg_lim={0,1}
    -- Cold start: NORM (arg=0). val=0 → stay NORM. val=+1 → EXTEND.
    -- NORM=stay (chance: 95%) / EXTEND=+1 (chance: 5%)
    { dev=2,  cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="ALT FLAPS Switch" },

    -- MANUAL TF FLYUP Switch | default_2_position_tumb | arg 568 | arg_lim={0,1}
    -- Cold start: DISABLE (arg=1). val=0 → stay DISABLE. val=-1 → ENABLE.
    -- DISABLE=stay (chance: 90%) / ENABLE=-1 (chance: 10%)
    { dev=2,  cmd=3016, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -1},                      label="MANUAL TF FLYUP Switch" },

    -- Autopilot ROLL Switch | default_3_position_tumb_small | arg 108 | arg_lim={-1,1}
    -- Cold start: ATT HOLD (arg=0, center). val=0 → stay ATT HOLD.
    -- val=-1 → STRG SEL. val=+1 → HDG SEL.
    -- ATT HOLD=stay (chance: 86%) / STRG SEL=-1 (chance: 7%) / HDG SEL=+1 (chance: 7%)
    { dev=2,  cmd=3014, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="Autopilot Roll Switch" },

    -- STORES CONFIG Switch | default_2_position_tumb_small | arg 358 | arg_lim={0,1}
    -- Cold start: CAT III (arg=0). val=+1 → CAT I (dominant). val=0 → stay CAT III.
    -- CAT I=+1 (chance: 60%) / CAT III=stay (chance: 40%)
    { dev=2,  cmd=3011, vals={1, 1, 1, 0, 0},                       label="STORES CONFIG Switch" },

    -- =========================================================================
    -- FUEL SYSTEM   dev=4  (FUEL_INTERFACE)
    -- fuel_commands counter (start=3000):
    --   FuelMasterSw=3001, FuelMasterSwCvr=3002, ExtFuelTransferSw=3003,
    --   EngineFeedSw=3004, FuelQtySelSw=3005, FuelQtySelSwTEST=3006,
    --   TankInertingSw=3007, AirRefuelSw=3008
    -- =========================================================================

    -- FUEL MASTER Switch Cover | default_red_cover | arg=558
    -- FuelMasterSwCvr = 3002  cold=CLOSE(arg=0) / OPEN=+1
    -- Switch (FuelMasterSw) is sim-controlled and cannot be randomized.
    -- CLOSE=stay (90%) / OPEN=+1 (10%)
    { dev=4, cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},   label="FUEL MASTER Switch Cover" },

    -- External Fuel Transfer Switch | default_2_position_tumb | arg=159
    -- fuel_commands: ExtFuelTransferSw=3003  cold=NORM(arg=0) / WING FIRST=+1
    -- NORM=stay (90%) / WING FIRST=+1 (10%)
    { dev=4, cmd=3003, vals={1, 1, 1, 1, 1, 1, 1, 1, 0, 1},   label="External Fuel Transfer Switch" },

    -- ENGINE FEED Knob | multiposition_switch, count=4, delta=0.1 | arg 556 | arg_lim={0,0.3}
    -- Cold start: NORM (arg=0.1). val=0 → stay NORM.
    -- val=-0.1 → OFF. val=+0.1 → AFT. val=+0.2 → FWD.
    -- NORM=stay (chance: 90%) / OFF=-0.1 (chance: 7%) / AFT=+0.1 (chance: 2%) / FWD=+0.2 (chance: 1%)
    { dev=4,  cmd=3004, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, 0.1, 0.1, 0.2, 0.2},  label="Engine Feed Knob" },

    -- FUEL QTY SEL Knob | multiposition, delta=0.1 | arg 158 | arg_lim={0.1,0.5}
    -- Cold start: NORM (arg=0.1). val=0 → stay NORM.
    -- val=+0.1 → RSVR, +0.2 → INT WING, +0.3 → EXT WING, +0.4 → EXT CTR.
    -- NORM=stay (chance: 90%) / others ~2–3% each
    { dev=4,  cmd=3005, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0.2, 0.3, 0.4},  label="FUEL QTY SEL Knob" },

    -- AIR REFUEL Switch | default_2_position_tumb | arg 555 | arg_lim={0,1}
    -- Cold start: CLOSE (arg=0). val=0 → stay CLOSE. val=+1 → OPEN.
    -- CLOSE=stay (chance: 90%) / OPEN=+1 (chance: 10%)
    { dev=4,  cmd=3008, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                       label="AIR REFUELING Switch" },

    -- =========================================================================
    -- OXYGEN   dev=8  (OXYGEN_INTERFACE)
    -- oxygen_commands counter (start=3000): SupplyLever=3001
    -- =========================================================================

    -- Supply Lever | default_3_position_tumb_small | arg=728
    -- arg_value_=0.5, arg_limit_={0,1} → arg_value={-0.5,+0.5}, arg_lim={0,1}
    -- Positions: PBG=arg=0 / ON=arg=0.5 (cold) / OFF=arg=1
    -- delta=-0.5 → PBG, delta=0 → stay ON, delta=+0.5 → OFF
    -- ON=stay (80%) / OFF=+0.5 (20%) / PBG: never
    { dev=8, cmd=3001, vals={0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0, 0, 0.5, 0.5},   label="Supply Lever" },

    -- =========================================================================
    -- GEAR / BRAKES   dev=7  (GEAR_INTERFACE)
    -- gear_commands counter (start=3000):
    --   LGHandle=3001, DownLockRelBtn=3002, ParkingSw=3003, AntiSkidSw=3004
    -- =========================================================================

    -- ANTI-SKID Switch | default_tumb_button | arg 357 | arg_lim TUMB={-1,0} BTN={0,1}
    -- Cold start: PARKING BRAKE (arg=-1, lower bound of TUMB range). TUMB cmd = AntiSkidSw=3004.
    -- val=+1 → ANTI-SKID (arg=0, dominant). val=0 → stay PARKING BRAKE.
    -- ANTI-SKID=+1 (chance: 90%) / PARKING BRAKE=stay (chance: 10%)
    { dev=7,  cmd=3004, vals={1, 1, 1, 1, 1, 1, 1, 1, 1, 0},                       label="ANTI-SKID Switch" },

    -- =========================================================================
    -- EXTERIOR LIGHTS   dev=11  (EXTLIGHTS_SYSTEM)
    -- extlights_commands counter (start=3000):
    --   AntiCollKn=3001, PosFlash=3002, PosWingTail=3003, PosFus=3004,
    --   FormKn=3005, Master=3006, AerialRefuel=3007, LandingTaxi=3008
    -- =========================================================================

    -- ANTI-COLL Knob | multiposition_switch, count=8, delta=0.1 | arg 531
    -- Exempt: no fixed operationally default position, uniform sampling
    { dev=11, cmd=3001, vals={0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7},              label="ANTI-COLL Knob" },

    -- FORM Knob | default_axis_limited, continuous | arg 535
    -- Exempt: continuous brightness knob, no fixed default position
    { dev=11, cmd=3005, vals={0, 0.25, 0.5, 0.75, 1.0},                            label="FORM Knob" },

    -- MASTER Switch | multiposition_switch, count=5, delta=0.1 | arg 536 | arg_lim={0,0.4}
    -- Cold start: NORM (arg=0.4). val=0 → stay NORM.
    -- val=-0.1 → FORM, -0.2 → A-C, -0.3 → ALL, -0.4 → OFF.
    -- NORM=stay (chance: 85%) / others ~5% each
    { dev=11, cmd=3006, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.2, -0.3, -0.4},  label="MASTER Switch" },

    -- WING/TAIL Switch | default_3_position_tumb_small | arg 533 | arg_lim={-1,1}
    -- Cold start: OFF (arg=0, center). val=0 → stay OFF.
    -- val=-1 → BRT. val=+1 → DIM.
    -- OFF=stay (chance: 86%) / BRT=-1 (chance: 7%) / DIM=+1 (chance: 7%)
    { dev=11, cmd=3003, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="WING/TAIL Switch" },

    -- FUSELAGE Switch | default_3_position_tumb_small | arg 534 | arg_lim={-1,1}
    -- Cold start: OFF (arg=0, center). val=0 → stay OFF.
    -- val=-1 → BRT. val=+1 → DIM.
    -- OFF=stay (chance: 86%) / BRT=-1 (chance: 7%) / DIM=+1 (chance: 7%)
    { dev=11, cmd=3004, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="FUSELAGE Switch" },

    -- FLASH STEADY Switch | default_2_position_tumb_small | arg 532 | arg_lim={0,1}
    -- Cold start: STEADY (arg=1). val=0 → stay STEADY. val=-1 → FLASH.
    -- STEADY=stay (chance: 85%) / FLASH=-1 (chance: 15%)
    { dev=11, cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1},  label="FLASH STEADY Switch" },

    -- LANDING TAXI LIGHTS Switch | default_3_position_tumb_small | arg 360 | arg_lim={-1,1}
    -- Cold start: OFF (arg=0, center). val=0 → stay OFF.
    -- val=-1 → LANDING. val=+1 → TAXI.
    -- OFF=stay (chance: 86%) / LANDING=-1 (chance: 7%) / TAXI=+1 (chance: 7%)
    { dev=11, cmd=3008, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="LANDING TAXI LIGHTS Switch" },

    -- =========================================================================
    -- INTERIOR LIGHTS   dev=12  (CPTLIGHTS_SYSTEM)
    -- All exempt: continuous brightness knobs, no fixed default position
    -- =========================================================================

    { dev=12, cmd=3003, vals={0, 0.25, 0.5, 0.75, 1.0},  label="PRIMARY CONSOLES BRT Knob" },
    { dev=12, cmd=3004, vals={0, 0.25, 0.5, 0.75, 1.0},  label="PRIMARY INST PNL Knob" },
    { dev=12, cmd=3005, vals={0, 0.25, 0.5, 0.75, 1.0},  label="PRIMARY DATA ENTRY DISPLAY BRT Knob" },
    { dev=12, cmd=3006, vals={0, 0.25, 0.5, 0.75, 1.0},  label="FLOOD CONSOLES BRT Knob" },
    { dev=12, cmd=3007, vals={0, 0.25, 0.5, 0.75, 1.0},  label="FLOOD INST PNL Knob" },

    -- =========================================================================
    -- ECS   dev=13  (ECS_INTERFACE)
    -- ecs_commands counter (start=3000):
    --   AirSourceKnob=3001, TempKnob=3002, DefogLever=3003
    -- =========================================================================

    -- AIR SOURCE Knob | multiposition_switch, count=4, delta=0.1 | arg 693 | arg_lim={0,0.3}
    -- Positions: OFF(arg=0.0), NORM(arg=0.1), DUMP(arg=0.2), RAM(arg=0.3)
    -- Cold start: NORM (arg=0.1). val=0 → stay NORM.
    -- val=-0.1 → OFF. val=+0.1 → DUMP. val=+0.2 → RAM.
    -- Target: NORM=30%, OFF=60%, DUMP=5%, RAM=5%
    { dev=13, cmd=3001, vals={0, 0, 0, 0, 0, 0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, 0.1, 0.2},  label="AIR SOURCE Knob" },

    -- =========================================================================
    -- INS   dev=14  (INS)
    -- ins_commands counter (start=3000): ModeKnob=3001
    -- =========================================================================

    -- INS Knob | multiposition_switch, count=7, delta=0.1 | arg 719 | arg_lim={0,0.6}
    -- Cold start: NAV (arg=0.3). val=0 → stay NAV.
    -- val=-0.1 → NORM, -0.2 → STOR HDG, -0.3 → OFF.
    -- val=+0.1 → CAL, +0.2 → INFLT ALIGN, +0.3 → ATT.
    -- NAV=stay (chance: 85%) / others ~2–3% each
    { dev=14, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.2, -0.3, 0.1, 0.2, 0.3},  label="INS Knob" },

    -- =========================================================================
    -- RALT   dev=15  (RALT)
    -- ralt_commands counter (start=3000): PwrSw=3001
    -- =========================================================================

    -- RDR ALT Switch | default_3_position_tumb | arg 673 | arg_lim={-1,1}
    -- Positions: OFF(arg=-1), STBY(arg=0), RDR ALT(arg=+1)
    -- Cold start: STBY (arg=0). val=-1 → OFF (dominant). val=0 → stay STBY.
    -- OFF=-1 (chance: 90%) / STBY=stay (chance: 10%) / RDR ALT not used
    { dev=15, cmd=3001, vals={-1, -1, -1, -1, -1, -1, -1, -1, -1, 0},              label="RDR ALT Switch" },

    -- =========================================================================
    -- UFC   dev=17  (UFC)
    -- ufc_commands counter (start=3000): UFC_Sw=3001
    -- =========================================================================

    -- UFC Switch | default_2_position_tumb | arg 718 | arg_lim={0,1}
    -- Cold start: ON (arg=0). val=0 → stay ON. val=+1 → OFF.
    -- ON=stay (chance: 85%) / OFF=+1 (chance: 15%)
    { dev=17, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="UFC Switch" },

    -- =========================================================================
    -- MMC   dev=19  (MMC)
    -- mmc_commands counter (start=3000):
    --   MmcPwr=3001, MasterArmSw=3002, EmerStoresJett=3003, GroundJett=3004,
    --   AltRel=3005, VvVah=3006, AttFpm=3007, DedData=3008, DeprRet=3009,
    --   Spd=3010, Alt=3011, Brt=3012, Test=3013, MFD=3014
    -- =========================================================================

    -- MMC Switch | default_2_position_tumb | arg 715 | arg_lim={0,1}
    -- Cold start: ON (arg=0). val=0 → stay ON. val=+1 → OFF.
    -- ON=stay (chance: 85%) / OFF=+1 (chance: 15%)
    { dev=19, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="MMC Switch" },

    -- MFD Switch | default_2_position_tumb | arg 717 | arg_lim={0,1}
    -- Cold start: ON (arg=0). val=0 → stay ON. val=+1 → OFF.
    -- ON=stay (chance: 85%) / OFF=+1 (chance: 15%)
    { dev=19, cmd=3014, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="MFD Switch" },

    -- MASTER ARM Switch | default_3_position_tumb | arg 105 | arg_lim={-1,1}
    -- Cold start: OFF (arg=0, center). val=0 → stay OFF.
    -- val=-1 → MASTER ARM. val=+1 → SIMULATE.
    -- OFF=stay (chance: 90%) / MASTER ARM=-1 (chance: 5%) / SIMULATE=+1 (chance: 5%)
    { dev=19, cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},  label="MASTER ARM Switch" },

    -- GND JETT ENABLE Switch | default_2_position_tumb | arg 355 | arg_lim={0,1}
    -- Cold start: ENABLE (arg=0). val=+1 → OFF (dominant). val=0 → stay ENABLE.
    -- OFF=+1 (chance: 90%) / ENABLE=stay (chance: 10%)
    { dev=19, cmd=3004, vals={1, 0, 0, 0, 0, 0, 0, 0, 0, 0},                       label="GND JETT ENABLE Switch" },

    -- HUD Scales Switch | default_3_position_tumb_small | arg 675 | arg_lim={-1,1}
    -- Cold start: VAH (arg=0, center). val=0 → stay VAH.
    -- val=-1 → VV/VAH. val=+1 → OFF.
    -- VAH=stay (chance: 86%) / VV/VAH=-1 (chance: 7%) / OFF=+1 (chance: 7%)
    { dev=19, cmd=3006, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="HUD Scales Switch" },

    -- HUD Flightpath Marker Switch | default_3_position_tumb_small | arg 676 | arg_lim={-1,1}
    -- Cold start: ATT/FPM (arg=-1, leftmost). val=0 → stay ATT/FPM.
    -- val=+1 → FPM (center, one step). No single-step to OFF from ATT/FPM.
    -- ATT/FPM=stay (chance: 90%) / FPM=+1 (chance: 10%)
    { dev=19, cmd=3007, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                       label="HUD Flightpath Marker Switch" },

    -- HUD DED/PFLD Data Switch | default_3_position_tumb_small | arg 677 | arg_lim={-1,1}
    -- Cold start: PFL (arg=0, center). val=0 → stay PFL.
    -- val=-1 → DED. val=+1 → OFF.
    -- PFL=stay (chance: 86%) / DED=-1 (chance: 7%) / OFF=+1 (chance: 7%)
    { dev=19, cmd=3008, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="HUD DED/PFLD Data Switch" },

    -- HUD Altitude Switch | default_3_position_tumb_small | arg 680 | arg_lim={-1,1}
    -- Cold start: BARO (arg=0, center). val=0 → stay BARO.
    -- val=-1 → RADAR. val=+1 → AUTO.
    -- BARO=stay (chance: 86%) / RADAR=-1 (chance: 7%) / AUTO=+1 (chance: 7%)
    { dev=19, cmd=3011, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="HUD Altitude Switch" },

    -- HUD Brightness Control Switch | default_3_position_tumb_small | arg 681 | arg_lim={-1,1}
    -- Cold start: AUTO BRT (arg=0, center). val=0 → stay AUTO BRT.
    -- val=-1 → DAY. val=+1 → NIGHT.
    -- AUTO BRT=stay (chance: 86%) / DAY=-1 (chance: 7%) / NIGHT=+1 (chance: 7%)
    { dev=19, cmd=3012, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 1},          label="HUD Brightness Control Switch" },

    -- =========================================================================
    -- SMS   dev=22  (SMS)
    -- sms_commands counter (start=3000):
    --   StStaSw=3001, LeftHDPT=3002, RightHDPT=3003, LaserSw=3004
    -- =========================================================================

    -- ST STA Switch | default_2_position_tumb | arg 716 | arg_lim={0,1}
    -- Cold start: ST STA (arg=0). val=0 → stay ST STA (dominant). val=+1 → OFF.
    -- ST STA=stay (chance: 90%) / OFF=+1 (chance: 10%)
    { dev=22, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="ST STA Switch" },

    -- LEFT HDPT Switch | default_2_position_tumb | arg 670 | arg_lim={0,1}
    -- Cold start: ON (arg=0). val=0 → stay ON (dominant). val=+1 → OFF.
    -- ON=stay (chance: 90%) / OFF=+1 (chance: 10%)
    { dev=22, cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="LEFT HDPT Switch" },

    -- RIGHT HDPT Switch | default_2_position_tumb | arg 671 | arg_lim={0,1}
    -- Cold start: ON (arg=0). val=0 → stay ON (dominant). val=+1 → OFF.
    -- ON=stay (chance: 90%) / OFF=+1 (chance: 10%)
    { dev=22, cmd=3003, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="RIGHT HDPT Switch" },

    -- LASER ARM Switch | default_2_position_tumb | arg 103 | arg_lim={0,1}
    -- Cold start: ARM (arg=0). val=+1 → OFF (dominant). val=0 → stay ARM.
    -- OFF=+1 (chance: 70%) / ARM=stay (chance: 30%)
    { dev=22, cmd=3004, vals={1, 1, 1, 0, 0, 0, 0, 0, 0, 0},                       label="LASER ARM Switch" },

    -- =========================================================================
    -- HMCS   dev=30  (HMCS)
    -- hmcs_commands counter (start=3000): IntKnob=3001
    -- =========================================================================

    -- HMCS SYMBOLOGY INT Knob | default_axis_limited | arg 392
    -- Exempt: continuous brightness knob, no fixed default position
    { dev=30, cmd=3001, vals={0, 0.25, 0.5, 0.75, 1.0},                            label="HMCS SYMBOLOGY INT Knob" },

    -- =========================================================================
    -- FCR   dev=31  (FCR)
    -- fcr_commands counter (start=3000): PwrSw=3001
    -- =========================================================================

    -- FCR Switch | default_2_position_tumb | arg 672 | arg_lim={0,1}
    -- Cold start: ON (arg=0). val=0 → stay ON. val=+1 → OFF.
    -- ON=stay (chance: 70%) / OFF=+1 (chance: 30%)
    { dev=31, cmd=3001, vals={1, 1, 1, 0, 0, 0, 0, 0, 0, 0},  label="FCR Switch" },

    -- =========================================================================
    -- CMDS   dev=32  (CMDS)
    -- cmds_commands counter (start=3000):
    --   RwrSrc=3001, JmrSrc=3002, MwsSrc=3003, Jett=3004,
    --   O1Exp=3005, O2Exp=3006, ChExp=3007, FlExp=3008, Prgm=3009, Mode=3010
    -- =========================================================================

    -- RWR Source Switch | default_2_position_tumb_small | arg 375 | arg_lim={0,1}
    { dev=32, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="RWR Source Switch" },

    -- Jammer Source Switch | default_2_position_tumb_small | arg 374 | arg_lim={0,1}
    { dev=32, cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="Jammer Source Switch" },

    -- MWS Source Switch | default_2_position_tumb_small | arg 373 | arg_lim={0,1}
    { dev=32, cmd=3003, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="MWS Source Switch" },

    -- O1 Expendable Category Switch | default_2_position_tumb_small | arg 365 | arg_lim={0,1}
    { dev=32, cmd=3005, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="O1 Expendable Category Switch" },

    -- O2 Expendable Category Switch | default_2_position_tumb_small | arg 366 | arg_lim={0,1}
    { dev=32, cmd=3006, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="O2 Expendable Category Switch" },

    -- CH Expendable Category Switch | default_2_position_tumb_small | arg 367 | arg_lim={0,1}
    { dev=32, cmd=3007, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="CH Expendable Category Switch" },

    -- FL Expendable Category Switch | default_2_position_tumb_small | arg 368 | arg_lim={0,1}
    { dev=32, cmd=3008, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                        label="FL Expendable Category Switch" },

    -- PROGRAM Knob | multiposition_switch, count=5, delta=0.1 | arg 377 | arg_lim={0,0.4}
    { dev=32, cmd=3009, vals={0, 0.1, 0.2, 0.3, 0.4},                              label="PROGRAM Knob" },

    -- MODE Knob | multiposition_switch, count=6, delta=0.1 | arg 378 | arg_lim={0,0.5}
    -- Cold start: STBY (arg=0.1). STBY=stay (90%) / OFF=-0.1 (5%) / others ~1–2% each
    { dev=32, cmd=3010, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.1, 0.1, 0.2, 0.3, 0.4},  label="MODE Knob" },

    -- =========================================================================
    -- IFF CONTROL PANEL   dev=35  (IFF_CONTROL_PANEL)
    -- iff_commands counter (start=3000):
    --   CNI_Knob=3001, MasterKnob=3002, M4CodeSw=3003, M4ReplySw=3004,
    --   M4MonitorSw=3005, EnableSw=3006
    -- =========================================================================

    -- IFF MASTER Knob | multiposition_switch, count=5, delta=0.1 | arg 539 | arg_lim={0,0.4}
    -- Cold start: STBY (arg=0.1). STBY=stay (90%) / OFF=-0.1 (5%) / others ~2% each
    { dev=35, cmd=3002, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, -0.1, 0.1, 0.1, 0.2, 0.3},  label="IFF Master Knob" },

    -- C & I Knob | multiposition_switch, count=2, delta=1 | arg 542 | arg_lim={0,1}
    -- Cold start: UFC (arg=0). UFC=stay (90%) / BACKUP=+1 (10%)
    { dev=35, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 1},                       label="C & I Knob" },

    -- =========================================================================
    -- INTERCOM   dev=39  (INTERCOM)
    -- =========================================================================

    -- COMM 1 Power Knob | default_axis_limited | arg 430 — Exempt
    { dev=39, cmd=3001, vals={0, 0.25, 0.5, 0.75, 1.0},                            label="COMM 1 Power Knob" },

    -- COMM 2 Power Knob | default_axis_limited | arg 431 — Exempt
    { dev=39, cmd=3003, vals={0, 0.25, 0.5, 0.75, 1.0},                            label="COMM 2 Power Knob" },

    -- =========================================================================
    -- MIDS   dev=41  (MIDS)
    -- mids_commands counter (start=3000): PwrSw=3001
    -- =========================================================================

    -- MIDS LVT Knob | multiposition_switch, count=3, delta=0.1 | arg 723 | arg_lim={0,0.2}
    -- Cold start: OFF (arg=0.1). OFF=stay (90%) / ZERO=-0.1 (5%) / ON=+0.1 (5%)
    { dev=41, cmd=3001, vals={0, 0, 0, 0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, -0.1, 0.1},  label="MIDS LVT Knob" },

    -- =========================================================================
    -- GPS   dev=59  (GPS)
    -- =========================================================================

    -- GPS Switch | default_2_position_tumb | arg 720 | cold=ON. ON=stay (85%) / OFF=+1 (15%)
    { dev=59, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="GPS Switch" },

    -- =========================================================================
    -- IDM   dev=60  (IDM)
    -- =========================================================================

    -- DL Switch | default_2_position_tumb | arg 721 | cold=ON. ON=stay (85%) / OFF=+1 (15%)
    { dev=60, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="DL Switch" },

    -- =========================================================================
    -- EPU SYSTEM   dev=6  (ENGINE_INTERFACE)
    -- engine_commands counter (start=3000):
    --   EpuSwCvrOn=3001  arg=527  default_red_cover         CLOSE=0 / OPEN=+1
    --   EpuSwCvrOff=3002 arg=529  default_red_cover         CLOSE=0 / OPEN=+1
    --   EpuSw=3003       arg=528  default_3_pos_tumb_small  NORM=0  / ON=+0.5 / OFF=-0.5
    --
    -- Reset strategy: delta=-1 drives an open cover (arg=1) to arg=0 (CLOSE).
    -- If already closed (arg=0), delta=-1 clamps to arg=0 — safe no-op.
    -- With both covers closed the mechanical interlock prevents switch movement.
    --
    -- Scenarios (r = math.random(10)):
    --   r=1     : ON OPEN,  OFF OPEN,  NORM  (10%)
    --   r=2     : ON OPEN,  OFF OPEN,  OFF   (10%)
    --   r=3     : ON CLOSE, OFF OPEN,  NORM  (10%)
    --   r=4     : ON CLOSE, OFF OPEN,  OFF   (10%)
    --   r=5     : ON OPEN,  OFF CLOSE, NORM  (10%)
    --   r=6..10 : ON CLOSE, OFF CLOSE, NORM  (50%)
    -- =========================================================================
    {
        label = "EPU SYSTEM",
        dev   = 6,
        run   = function(dev)
            local r = math.random(10)
            local function click(cmd, val) dev:performClickableAction(cmd, val) end

            -- Force both covers CLOSED before anything else.
            click(3001, -1)  -- ON  cover → CLOSE
            click(3002, -1)  -- OFF cover → CLOSE

            if r == 1 then          -- ON OPEN, OFF OPEN, NORM (10%)
                click(3001, 1)
                click(3002, 1)
            elseif r == 2 then      -- ON OPEN, OFF OPEN, OFF (10%)
                click(3001, 1)
                click(3002, 1)
                click(3003, -0.5)
            elseif r == 3 then      -- ON CLOSE, OFF OPEN, NORM (10%)
                click(3002, 1)
            elseif r == 4 then      -- ON CLOSE, OFF OPEN, OFF (10%)
                click(3002, 1)
                click(3003, -0.5)
            elseif r == 5 then      -- ON OPEN, OFF CLOSE, NORM (10%)
                click(3001, 1)
            end
            -- r=6..10: ON CLOSE, OFF CLOSE, NORM (50%) — covers already forced closed.
        end
    },

    -- =========================================================================
    -- MAP   dev=61  (MAP)
    -- map_commands counter (start=3000): PwrSw=3001
    -- =========================================================================

    -- MAP Switch | default_2_position_tumb | arg 722 | cold=ON. ON=stay (85%) / OFF=+1 (15%)
    { dev=61, cmd=3001, vals={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},  label="MAP Switch" },

}, 3.0)
