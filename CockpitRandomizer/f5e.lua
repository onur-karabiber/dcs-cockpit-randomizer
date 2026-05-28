-- =============================================================================
-- CockpitRandomizer — f5e.lua
-- F-5E Tiger II
-- Switch table for: F-5E-3
--
-- Device IDs: devices.lua (counter order)
--   CONTROL_INTERFACE  =  2    ELEC_INTERFACE   =  3  (note: named "electric_commands")
--   FUEL_INTERFACE     =  4    ENGINE_INTERFACE =  6
--   GEAR_INTERFACE     =  7    OXYGEN_INTERFACE =  8
--   ECS_INTERFACE      =  9    EXTLIGHTS_SYSTEM = 11
--   INTLIGHTS_SYSTEM   = 12    CMDS             = 13
--   WEAPONS_CONTROL    = 15    AHRS             = 16
--   AN_APQ159          = 17    AN_ASG31         = 18
--   RWR_IC             = 19    AN_ALR87         = 20
--   IFF                = 22    UHF_RADIO        = 23
--   TACAN_CTRL_PANEL   = 41    SIGHT_CAMERA     = 21
--
-- Landing Gear and Canopy excluded per request.
-- Momentary / spring-loaded positions excluded throughout.
-- CB (circuit breaker) buttons excluded — not meaningful for cold-start immersion.
-- =============================================================================

CR.register("F-5E-3", {

    -- =========================================================================
    -- FLIGHT CONTROL SYSTEM   dev=2  (CONTROL_INTERFACE)
    -- =========================================================================

    -- Yaw Damper Switch  (default_2_position_tumb2)  YAW=0 / OFF=1  |  arg 323
    { dev=2, cmd=3001, vals={0, 1},         label="Yaw Damper Switch" },

    -- Pitch Damper Switch  (default_2_position_tumb2)  PITCH=0 / OFF=1  |  arg 322
    { dev=2, cmd=3002, vals={0, 1},         label="Pitch Damper Switch" },

    -- Rudder Trim Knob  (default_axis_limited, continuous {-1,1})  |  arg 324
    { dev=2, cmd=3003, vals={-1, -0.5, 0, 0.5, 1},  label="Rudder Trim Knob" },

    -- Flaps Lever  (default_3_position_tumb)  EMER UP=-1 / THUMB SW=0 / FULL=1  |  arg 116
    { dev=2, cmd=3005, vals={-1, 0, 1},     label="Flaps Lever" },

    -- Auto Flap System Thumb Switch  (default_3_position_tumb)  UP=-1 / FIXED=0 / AUTO=1  |  arg 115
    { dev=2, cmd=3006, vals={-1, 0, 1},     label="Auto Flap System Thumb Switch" },

    -- Speed Brake Switch  (default_3_position_tumb)  OUT=-1 / OFF=0 / IN=1  |  arg 101
    { dev=2, cmd=3007, vals={-1, 0, 1},     label="Speed Brake Switch" },

    -- =========================================================================
    -- ELECTRICAL SYSTEM   dev=3  (ELEC_INTERFACE)
    -- =========================================================================

    -- Battery Switch  (default_2_position_tumb2)  BATT=0 / OFF=1  |  arg 387
    { dev=3, cmd=3001, vals={0, 1},         label="Battery Switch" },

    -- Left Generator Switch  (default_button_tumb: BTN=RESET momentary, TUMB=L GEN/OFF)
    -- TUMB side: L GEN=0 / OFF=1  |  arg 388
    { dev=3, cmd=3002, vals={0, 1},         label="Left Generator Switch" },

    -- Right Generator Switch  (default_button_tumb: BTN=RESET momentary, TUMB=R GEN/OFF)
    -- TUMB side: R GEN=0 / OFF=1  |  arg 389
    { dev=3, cmd=3004, vals={0, 1},         label="Right Generator Switch" },

    -- Pitot Anti-Ice Switch  (default_2_position_tumb2)  PITOT=0 / OFF=1  |  arg 375
    { dev=3, cmd=3006, vals={0, 1},         label="Pitot Anti-Ice Switch" },

    -- =========================================================================
    -- FUEL SYSTEM   dev=4  (FUEL_INTERFACE)
    -- =========================================================================

    -- Left Fuel Shutoff Switch Cover  (default_red_cover)  CLOSED=0 / OPEN=1  |  arg 359
    { dev=4, cmd=3010, vals={0, 1},         label="Left Fuel Shutoff Switch Cover" },

    -- Left Fuel Shutoff Switch  (default_2_position_tumb2)  OPEN=0 / CLOSED=1  |  arg 360
    { dev=4, cmd=3001, vals={0, 1},         label="Left Fuel Shutoff Switch" },

    -- Right Fuel Shutoff Switch Cover  (default_red_cover)  CLOSED=0 / OPEN=1  |  arg 361
    { dev=4, cmd=3011, vals={0, 1},         label="Right Fuel Shutoff Switch Cover" },

    -- Right Fuel Shutoff Switch  (default_2_position_tumb2)  OPEN=0 / CLOSED=1  |  arg 362
    { dev=4, cmd=3002, vals={0, 1},         label="Right Fuel Shutoff Switch" },

    -- Ext Fuel Cl Switch  (default_2_position_tumb2)  ON=0 / OFF=1  |  arg 377
    { dev=4, cmd=3004, vals={0, 1},         label="Ext Fuel Cl Switch" },

    -- Ext Fuel Pylons Switch  (default_2_position_tumb2)  ON=0 / OFF=1  |  arg 378
    { dev=4, cmd=3003, vals={0, 1},         label="Ext Fuel Pylons Switch" },

    -- Left Boost Pump Switch  (default_2_position_tumb)  ON=0 / OFF=1  |  arg 380
    { dev=4, cmd=3008, vals={0, 1},         label="Left Boost Pump Switch" },

    -- Crossfeed Switch  (default_2_position_tumb2)  OPEN=0 / CLOSED=1  |  arg 381
    { dev=4, cmd=3005, vals={0, 1},         label="Crossfeed Switch" },

    -- Right Boost Pump Switch  (default_2_position_tumb)  ON=0 / OFF=1  |  arg 382
    { dev=4, cmd=3009, vals={0, 1},         label="Right Boost Pump Switch" },

    -- =========================================================================
    -- ENGINE SYSTEM   dev=6  (ENGINE_INTERFACE)
    -- =========================================================================

    -- Engine Anti-Ice Switch  (default_2_position_tumb2)  ENGINE=0 / OFF=1  |  arg 376
    { dev=6, cmd=3003, vals={0, 1},         label="Engine Anti-Ice Switch" },

    -- =========================================================================
    -- OXYGEN SYSTEM   dev=8  (OXYGEN_INTERFACE)
    -- =========================================================================

    -- Oxygen Supply Lever  (default_2_position_tumb)  ON=0 / OFF=1  |  arg 603
    { dev=8, cmd=3001, vals={0, 1},         label="Oxygen Supply Lever" },

    -- Diluter Lever  (default_2_position_tumb)  |  arg 602
    -- 100%=0 / NORM=1
    { dev=8, cmd=3002, vals={0, 1},         label="Oxygen Diluter Lever" },

    -- Emergency Lever  (default_button_tumb: BTN=TEST MASK momentary, TUMB=EMERGENCY/NORMAL)
    -- TUMB side: EMERGENCY=1 / NORMAL=0  |  arg 601
    { dev=8, cmd=3003, vals={0, 1},         label="Oxygen Emergency Lever" },

    -- =========================================================================
    -- ECS   dev=9  (ECS_INTERFACE)
    -- =========================================================================

    -- Cabin Press Switch Cover  (default_red_cover)  CLOSED=0 / OPEN=1  |  arg 370
    { dev=9, cmd=3002, vals={0, 1},         label="Cabin Press Switch Cover" },

    -- Cabin Press Switch  (default_3_position_tumb2)  DEFOG ONLY=-1 / NORMAL=0 / RAM DUMP=1  |  arg 371
    -- arg_value uses 0.5 delta, lim {0,1}: DEFOG ONLY=0 / NORMAL=0.5 / RAM DUMP=1
    { dev=9, cmd=3001, vals={0, 0.5, 1},    label="Cabin Press Switch" },

    -- Cabin Temp Switch  (multiposition_switch, count=7, delta=0.1)
    -- AUTO=0 / positions up to MAN HOT=0.6  |  arg 372
    { dev=9, cmd=3003, vals={0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6},  label="Cabin Temp Switch" },

    -- Cabin Temperature Knob  (default_axis_limited, {-1,1})  |  arg 373
    { dev=9, cmd=3004, vals={-1, -0.5, 0, 0.5, 1},  label="Cabin Temperature Knob" },

    -- Canopy Defog Knob  (default_axis_limited)  |  arg 374
    { dev=9, cmd=3005, vals={0, 0.25, 0.5, 0.75, 1},  label="Canopy Defog Knob" },

    -- =========================================================================
    -- EXTERNAL LIGHTS   dev=11  (EXTLIGHTS_SYSTEM)
    -- =========================================================================

    -- Exterior Lights Nav Knob  (default_axis_limited)  |  arg 227
    { dev=11, cmd=3001, vals={0, 0.25, 0.5, 0.75, 1},  label="Exterior Lights Nav Knob" },

    -- Exterior Lights Formation Knob  (default_axis_limited)  |  arg 228
    { dev=11, cmd=3002, vals={0, 0.25, 0.5, 0.75, 1},  label="Exterior Lights Formation Knob" },

    -- Exterior Lights Beacon Switch  (default_2_position_tumb2)  BEACON=0 / OFF=1  |  arg 229
    { dev=11, cmd=3003, vals={0, 1},        label="Exterior Lights Beacon Switch" },

    -- Landing & Taxi Light Switch  (default_2_position_tumb)  ON=0 / OFF=1  |  arg 353
    { dev=11, cmd=3004, vals={0, 1},        label="Landing & Taxi Light Switch" },

    -- =========================================================================
    -- INTERNAL LIGHTS   dev=12  (INTLIGHTS_SYSTEM)
    -- =========================================================================

    -- Magnetic Compass Light Switch  (default_2_position_tumb)  LIGHT=0 / OFF=1  |  arg 613
    { dev=12, cmd=3002, vals={0, 1},        label="Magnetic Compass Light Switch" },

    -- Flood Lights Knob  (default_axis_limited)  |  arg 221
    { dev=12, cmd=3003, vals={0, 0.25, 0.5, 0.75, 1},  label="Flood Lights Knob" },

    -- Flight Instruments Lights Knob  (default_axis_limited)  |  arg 222
    { dev=12, cmd=3004, vals={0, 0.25, 0.5, 0.75, 1},  label="Flight Instruments Lights Knob" },

    -- Engine Instruments Lights Knob  (default_axis_limited)  |  arg 223
    { dev=12, cmd=3005, vals={0, 0.25, 0.5, 0.75, 1},  label="Engine Instruments Lights Knob" },

    -- Console Lights Knob  (default_axis_limited)  |  arg 224
    { dev=12, cmd=3006, vals={0, 0.25, 0.5, 0.75, 1},  label="Console Lights Knob" },

    -- Armament Panel Lights Knob  (default_axis_limited)  |  arg 363
    { dev=12, cmd=3007, vals={0, 0.25, 0.5, 0.75, 1},  label="Armament Panel Lights Knob" },

    -- =========================================================================
    -- COUNTERMEASURES (AN/ALE-40V)   dev=13  (CMDS)
    -- =========================================================================

    -- Chaff Mode Selector  (multiposition_switch, count=4, delta=0.1)
    -- OFF=0 / SINGLE=0.1 / PRGM=0.2 / MULT=0.3  |  arg 400
    { dev=13, cmd=3001, vals={0, 0.1, 0.2, 0.3},  label="Chaff Mode Selector" },

    -- Flare Mode Selector  (multiposition_switch, count=3, delta=0.1)
    -- OFF=0 / SINGLE=0.1 / PRGM=0.2  |  arg 404
    { dev=13, cmd=3002, vals={0, 0.1, 0.2},  label="Flare Mode Selector" },

    -- Flare Jettison Switch Cover  (default_red_cover)  CLOSED=0 / OPEN=1  |  arg 408
    { dev=13, cmd=3003, vals={0, 1},        label="Flare Jettison Switch Cover" },

    -- =========================================================================
    -- WEAPONS CONTROL   dev=15  (WEAPONS_CONTROL)
    -- =========================================================================

    -- Armament Position Selector — Left Wingtip  (default_2_position_tumb2)  ON=0 / OFF=1  |  arg 346
    { dev=15, cmd=3001, vals={0, 1},        label="Armament Selector - Left Wingtip" },

    -- Armament Position Selector — Left Outboard  (default_2_position_tumb2)  |  arg 347
    { dev=15, cmd=3002, vals={0, 1},        label="Armament Selector - Left Outbd" },

    -- Armament Position Selector — Left Inboard  (default_2_position_tumb2)  |  arg 348
    { dev=15, cmd=3003, vals={0, 1},        label="Armament Selector - Left Inbd" },

    -- Armament Position Selector — Centerline  (default_2_position_tumb2)  |  arg 349
    { dev=15, cmd=3004, vals={0, 1},        label="Armament Selector - Centerline" },

    -- Armament Position Selector — Right Inboard  (default_2_position_tumb2)  |  arg 350
    { dev=15, cmd=3005, vals={0, 1},        label="Armament Selector - Right Inbd" },

    -- Armament Position Selector — Right Outboard  (default_2_position_tumb2)  |  arg 351
    { dev=15, cmd=3006, vals={0, 1},        label="Armament Selector - Right Outbd" },

    -- Armament Position Selector — Right Wingtip  (default_2_position_tumb2)  |  arg 352
    { dev=15, cmd=3007, vals={0, 1},        label="Armament Selector - Right Wingtip" },

    -- Interval Switch  (default_3_position_tumb)  .06=-1 / .10=0 / .14=1  |  arg 340
    { dev=15, cmd=3008, vals={-1, 0, 1},    label="Interval Switch" },

    -- Bombs Arm Switch  (multiposition_switch, count=4, delta=0.2, min=0.2)
    -- SAFE=0.2 / TAIL=0.4 / NOSE & TAIL=0.6 / NOSE=0.8  |  arg 341
    { dev=15, cmd=3009, vals={0.2, 0.4, 0.6, 0.8},  label="Bombs Arm Switch" },

    -- Guns, Missile and Camera Switch Cover  (default_red_cover)  CLOSED=0 / OPEN=1  |  arg 342
    { dev=15, cmd=3010, vals={0, 1},        label="Guns/Missile/Camera Switch Cover" },

    -- Guns, Missile and Camera Switch  (default_3_position_tumb)
    -- GUNS MSL & CAMR=-1 / OFF=0 / CAMR ONLY=1  |  arg 343
    { dev=15, cmd=3011, vals={-1, 0, 1},    label="Guns/Missile/Camera Switch" },

    -- External Stores Selector  (multiposition_switch, count=4, delta=0.1)
    -- RIPL=0 / BOMB=0.1 / SAFE=0.2 / RKT DISP=0.3  |  arg 344
    { dev=15, cmd=3012, vals={0, 0.1, 0.2, 0.3},  label="External Stores Selector" },

    -- Missile Volume Knob  (default_axis)  |  arg 345
    { dev=15, cmd=3015, vals={0, 0.25, 0.5, 0.75, 1},  label="Missile Volume Knob" },

    -- =========================================================================
    -- AHRS   dev=16  (AHRS)
    -- =========================================================================

    -- Compass Switch  (default_button_tumb: BTN=FAST SLAVE momentary, TUMB=DIR GYRO/MAG)
    -- TUMB side: DIR GYRO=1 / MAG=0  |  arg 220
    { dev=16, cmd=3002, vals={0, 1},        label="Compass Switch" },

    -- Nav Mode Selector Switch  (default_2_position_tumb)  DF=0 / TACAN=0.1  |  arg 273
    { dev=16, cmd=3004, vals={0, 0.1},      label="Nav Mode Selector Switch" },

    -- =========================================================================
    -- AN/APQ-159 RADAR   dev=17  (AN_APQ159)
    -- =========================================================================

    -- Radar Range Selector  (multiposition_switch, count=4, delta=0.1)
    -- 5nm=0 / 10nm=0.1 / 20nm=0.2 / 40nm=0.3  |  arg 315
    { dev=17, cmd=3003, vals={0, 0.1, 0.2, 0.3},  label="Radar Range Selector" },

    -- Radar Mode Selector  (multiposition_switch, count=4, delta=0.1)
    -- OFF=0 / STBY=0.1 / OPER=0.2 / TEST=0.3  |  arg 316
    { dev=17, cmd=3004, vals={0, 0.1, 0.2, 0.3},  label="Radar Mode Selector" },

    -- Radar Bright Knob  (default_axis)  |  arg 70
    { dev=17, cmd=3006, vals={0, 0.25, 0.5, 0.75, 1},  label="Radar Bright Knob" },

    -- Radar Persistence Knob  (default_axis)  |  arg 69
    { dev=17, cmd=3007, vals={0, 0.25, 0.5, 0.75, 1},  label="Radar Persistence Knob" },

    -- Radar Video Knob  (default_axis)  |  arg 68
    { dev=17, cmd=3008, vals={0, 0.25, 0.5, 0.75, 1},  label="Radar Video Knob" },

    -- =========================================================================
    -- AN/ASG-31 SIGHT   dev=18  (AN_ASG31)
    -- =========================================================================

    -- Sight Mode Selector  (multiposition_switch, count=5, delta=0.1)
    -- OFF=0 / MSL=0.1 / A/A1 GUNS=0.2 / A/A2 GUNS=0.3 / MAN=0.4  |  arg 40
    { dev=18, cmd=3001, vals={0, 0.1, 0.2, 0.3, 0.4},  label="Sight Mode Selector" },

    -- Reticle Intensity Knob  (default_axis)  |  arg 41
    { dev=18, cmd=3003, vals={0, 0.25, 0.5, 0.75, 1},  label="Reticle Intensity Knob" },

    -- Sight BIT Switch  (default_3_position_tumb)  BIT 1=-1 / OFF=0 / BIT 2=1  |  arg 47
    { dev=18, cmd=3004, vals={-1, 0, 1},    label="Sight BIT Switch" },

    -- =========================================================================
    -- RWR INDICATOR CONTROL   dev=19  (RWR_IC)
    -- =========================================================================

    -- RWR ALTITUDE Button  (default_CB_button: latching ON/OFF)  |  arg 561
    { dev=19, cmd=3004, vals={0, 1},        label="RWR Altitude Button" },

    -- RWR POWER Button  (default_CB_button: latching ON/OFF)  |  arg 575
    { dev=19, cmd=3008, vals={0, 1},        label="RWR Power Button" },

    -- RWR Audio Knob  (default_axis_limited)  |  arg 577
    { dev=19, cmd=3012, vals={0, 0.25, 0.5, 0.75, 1},  label="RWR Audio Knob" },

    -- RWR DIM Knob  (default_axis_limited)  |  arg 578
    { dev=19, cmd=3011, vals={0, 0.25, 0.5, 0.75, 1},  label="RWR DIM Knob" },

    -- =========================================================================
    -- AN/ALR-87 RWR   dev=20  (AN_ALR87)
    -- =========================================================================

    -- RWR INT Knob  (default_axis_limited, {0.15, 0.85})  |  arg 140
    { dev=20, cmd=3001, vals={0.15, 0.35, 0.55, 0.75, 0.85},  label="RWR INT Knob" },

    -- =========================================================================
    -- IFF   dev=22  (IFF)
    -- =========================================================================

    -- IFF MASTER Control Selector  (multiposition: EMER/NORM/LOW/STBY/OFF)
    -- OFF=0 / STBY=0.1 / LOW=0.2 / NORM=0.3 / EMER=0.4  |  arg 200
    { dev=22, cmd=3008, vals={0, 0.1, 0.2, 0.3, 0.4},  label="IFF Master Control Selector" },

    -- IFF MODE 4 Monitor Control Switch  (default_3_position_tumb2)
    -- AUDIO=-1 / OUT=0 / LIGHT=1  |  arg 201
    { dev=22, cmd=3009, vals={-1, 0, 1},    label="IFF MODE 4 Monitor Switch" },

    -- IFF MODE 4 Control Switch  (default_2_position_tumb)  ON=0 / OUT=1  |  arg 208
    { dev=22, cmd=3016, vals={0, 1},        label="IFF MODE 4 Control Switch" },

    -- IFF MODE 1 Code Selector Wheel 1  (multiposition_switch3, count=8, delta=0.1)  |  arg 209
    { dev=22, cmd=3001, vals={0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7},  label="IFF MODE 1 Code Wheel 1" },

    -- IFF MODE 1 Code Selector Wheel 2  (multiposition_switch3, count=4, delta=0.1)  |  arg 210
    { dev=22, cmd=3002, vals={0, 0.1, 0.2, 0.3},  label="IFF MODE 1 Code Wheel 2" },

    -- IFF MODE 3/A Code Selector Wheel 1  (multiposition_switch3, count=8, delta=0.1)  |  arg 211
    { dev=22, cmd=3003, vals={0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7},  label="IFF MODE 3/A Code Wheel 1" },

    -- IFF MODE 3/A Code Selector Wheel 2  (multiposition_switch3, count=8, delta=0.1)  |  arg 212
    { dev=22, cmd=3004, vals={0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7},  label="IFF MODE 3/A Code Wheel 2" },

    -- IFF MODE 3/A Code Selector Wheel 3  (multiposition_switch3, count=8, delta=0.1)  |  arg 213
    { dev=22, cmd=3005, vals={0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7},  label="IFF MODE 3/A Code Wheel 3" },

    -- IFF MODE 3/A Code Selector Wheel 4  (multiposition_switch3, count=8, delta=0.1)  |  arg 214
    { dev=22, cmd=3006, vals={0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7},  label="IFF MODE 3/A Code Wheel 4" },

    -- =========================================================================
    -- UHF RADIO AN/ARC-164   dev=23  (UHF_RADIO)
    -- =========================================================================

    -- UHF Frequency Mode Selector  (multiposition_switch, count=3, delta=0.1)
    -- MANUAL=0 / PRESET=0.1 / GUARD=0.2  |  arg 307
    { dev=23, cmd=3007, vals={0, 0.1, 0.2},  label="UHF Frequency Mode Selector" },

    -- UHF Function Selector  (multiposition_switch, count=4, delta=0.1)
    -- OFF=0 / MAIN=0.1 / BOTH=0.2 / ADF=0.3  |  arg 311
    { dev=23, cmd=3008, vals={0, 0.1, 0.2, 0.3},  label="UHF Function Selector" },

    -- UHF Squelch Switch  (default_2_position_tumb)  ON=0 / OFF=1  |  arg 308
    { dev=23, cmd=3010, vals={0, 1},        label="UHF Squelch Switch" },

    -- UHF Volume Knob  (default_axis)  |  arg 309
    { dev=23, cmd=3011, vals={0, 0.25, 0.5, 0.75, 1},  label="UHF Volume Knob" },

    -- UHF Antenna Selector  (multiposition_switch, count=3, delta=0.5)
    -- UPPER=0 / AUTO=0.5 / LOWER=1  |  arg 336
    { dev=23, cmd=3016, vals={0, 0.5, 1},   label="UHF Antenna Selector" },

    -- =========================================================================
    -- TACAN   dev=41  (TACAN_CTRL_PANEL)
    -- =========================================================================

    -- TACAN Mode Selector  (multiposition_switch, count=5, delta=0.1)
    -- positions 0..0.4  |  arg 262
    { dev=41, cmd=3006, vals={0, 0.1, 0.2, 0.3, 0.4},  label="TACAN Mode Selector" },

    -- TACAN Signal Volume Knob  (default_axis_limited, {0,1})  |  arg 261
    { dev=41, cmd=3005, vals={0, 0.25, 0.5, 0.75, 1},  label="TACAN Volume Knob" },

    -- =========================================================================
    -- SIGHT CAMERA   dev=21  (SIGHT_CAMERA)
    -- =========================================================================

    -- Sight Camera FPS Select Switch  (default_2_position_tumb)  24fps=0 / 48fps=1  |  arg 80
    { dev=21, cmd=3001, vals={0, 1},        label="Sight Camera FPS Switch" },

    -- Sight Camera Overrun Selector  (multiposition_switch, count=4, delta=0.1, inversed)
    -- 0=0.3 / 3=0.2 / 10=0.1 / 20=0  |  arg 84
    { dev=21, cmd=3003, vals={0, 0.1, 0.2, 0.3},  label="Sight Camera Overrun Selector" },

}, 3.0)
