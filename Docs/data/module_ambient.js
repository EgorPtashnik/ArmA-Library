// ═══════════════════════════════════════════════════════════
//  MODULE: Ambient
//  Functions for ambient atmosphere (sounds, fly-bys).
// ═══════════════════════════════════════════════════════════

EP_DATA.push(

  {
    id: "fn_ambientWarfare",
    name: "EP_fnc_ambientWarfare",
    module: "Ambient",
    desc: "Plays distant battlefield ambient sounds around the player in a loop. Sounds are randomised in direction and distance. Stores the script handle in EP_AmbientWarfareHandle.",
    params: [
      { name: "_condition",  type: "Code",  optional: true, default: "{ true }", desc: "Loop continues while this condition returns true." },
      { name: "_firefight",  type: "Bool",  optional: true, default: "true",     desc: "Include firefight sounds." },
      { name: "_explosions", type: "Bool",  optional: true, default: "true",     desc: "Include explosion sounds." },
      { name: "_helis",      type: "Bool",  optional: true, default: "false",    desc: "Include helicopter sounds." },
      { name: "_jets",       type: "Bool",  optional: true, default: "false",    desc: "Include jet sounds." },
    ],
    returns: { type: "Script Handle", desc: "Stored in EP_AmbientWarfareHandle." },
    example:
`// Basic — firefights and explosions only
[] call EP_fnc_ambientWarfare;

// Stop when phase ends
[{ !phase1_done }, true, true, true, false] call EP_fnc_ambientWarfare;`,
    notes: "Requires at least one sound category to be enabled.",
  },

  {
    id: "fn_ambientFlyBy",
    name: "EP_fnc_ambientFlyBy",
    module: "Ambient",
    desc: "Spawns a vehicle that flies from start to end position and deletes itself on arrival.",
    params: [
      { name: "_start",  type: "Any",    optional: true, default: "[0,0,0]",           desc: "Start position (position, marker, or object)." },
      { name: "_end",    type: "Any",    optional: true, default: "[100,100,100]",      desc: "End position." },
      { name: "_class",  type: "String", optional: true, default: "B_Heli_Light_01_F", desc: "Vehicle classname." },
      { name: "_height", type: "Number", optional: true, default: "100",               desc: "Flight height in metres." },
      { name: "_speed",  type: "String", optional: true, default: "NORMAL",            desc: "Speed mode: LIMITED, NORMAL, FULL." },
      { name: "_side",   type: "Side",   optional: true, default: "blufor",            desc: "Side of the spawned vehicle." },
    ],
    returns: { type: "Object", desc: "The spawned vehicle." },
    example: `["mkrFlyStart", "mkrFlyEnd", "B_Heli_Transport_01_F", 80, "FULL"] call EP_fnc_ambientFlyBy;`,
    notes: "The vehicle is set captive and ignores all targets. It deletes itself and its crew on arrival.",
  },

);
