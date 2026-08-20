// ═══════════════════════════════════════════════════════════
//  MODULE: Extension
//  Gameplay extensions: casual vehicle, health bar, health
//  regen, NVG post-processing.
// ═══════════════════════════════════════════════════════════

EP_DATA.push(

  {
    id: "fn_ext_casualVehicle",
    name: "EP_fnc_ext_casualVehicle",
    module: "Extension",
    desc: "Turns a vehicle into a player-driveable 'casual' vehicle: auto-spawns an AI driver when the player gets in as gunner, locks the vehicle during use, optionally switches to external camera.",
    params: [
      { name: "_vehicles",        type: "Object | Array", optional: false, default: "",            desc: "Vehicle or array of vehicles." },
      { name: "_enableSentences", type: "Bool",           optional: true,  default: "false",       desc: "Enable radio sentences while in vehicle." },
      { name: "_getOutText",      type: "String",         optional: true,  default: "\"Get Out\"", desc: "Text for the get-out action." },
      { name: "_cameraExternal",  type: "Bool",           optional: true,  default: "true",        desc: "Switch to external camera on entry." },
    ],
    returns: { type: "Array", desc: "The vehicles array." },
    example: `[myAPC, false, "Exit Vehicle", true] call EP_fnc_ext_casualVehicle;`,
    notes: "The AI driver is an invincible agent deleted when the player exits. Vehicle is unlocked on exit.",
  },

  {
    id: "fn_ext_healthBar",
    name: "EP_fnc_ext_healthBar",
    module: "Extension",
    desc: "Displays an on-screen health bar for a unit using dynamic text. Updates only when damage changes. Hides when player is in a vehicle (unless _healthShowVehicle is true).",
    params: [
      { name: "_targetUnit",            type: "Object", optional: true, default: "player",                                 desc: "Unit to track." },
      { name: "_layerId",               type: "Number", optional: true, default: "1",                                      desc: "Dynamic text layer ID." },
      { name: "_healthShowVehicle",     type: "Bool",   optional: true, default: "false",                                  desc: "Show bar while in a vehicle." },
      { name: "_healthSymbolsCount",    type: "Number", optional: true, default: "66",                                     desc: "Total number of characters in the bar." },
      { name: "_healthSymbol",          type: "String", optional: true, default: "\"I\"",                                  desc: "Character to use for the bar." },
      { name: "_healthMediumThreshold", type: "Number", optional: true, default: "60",                                     desc: "HP% below which medium color is used." },
      { name: "_healthHighThreshold",   type: "Number", optional: true, default: "30",                                     desc: "HP% below which high-damage color is used." },
      { name: "_healthColorMap",        type: "Array",  optional: true, default: "[\"#ff6565\",\"#ffae8e\",\"#ffffff\"]",  desc: "Colors for [full, medium, damaged]." },
      { name: "_sleep",                 type: "Number", optional: true, default: "0.1",                                    desc: "Update interval in seconds." },
    ],
    returns: { type: "Nothing", desc: "Runs until the unit is dead." },
    example: `[] spawn { [] call EP_fnc_ext_healthBar; };`,
  },

  {
    id: "fn_ext_healthRegen",
    name: "EP_fnc_ext_healthRegen",
    module: "Extension",
    desc: "Replaces vanilla damage model with a hit-count system. Each direct hit applies a fixed damage value. Headshots can be instant kill. HP regenerates after 5 seconds of not taking damage.",
    params: [
      { name: "_units",         type: "Group | Array | Object", optional: false, default: "",      desc: "Units to apply the system to." },
      { name: "_damageOnHit",   type: "Number",                 optional: true,  default: "0.1",   desc: "Damage applied per direct hit (0–1)." },
      { name: "_headshotKill",  type: "Bool",                   optional: true,  default: "true",  desc: "Instant kill on headshot." },
      { name: "_stopRegenAt",   type: "Number",                 optional: true,  default: "0.2",   desc: "Regeneration stops at this damage value." },
      { name: "_regenValue",    type: "Number",                 optional: true,  default: "0.05",  desc: "HP restored per regen tick." },
      { name: "_regenInterval", type: "Number",                 optional: true,  default: "1",     desc: "Regen tick interval in seconds." },
    ],
    returns: { type: "Array", desc: "The processed units array." },
    example: `[[player], 0.2, true, 0.2, 0.05, 1] call EP_fnc_ext_healthRegen;`,
    notes: "Splash damage is ignored — only direct hits count. Guarded by EP_casualHealth_installed, safe to call multiple times.",
  },

  {
    id: "fn_ext_nvg",
    name: "EP_fnc_ext_nvg",
    module: "Extension",
    desc: "Adds post-processing effects (radial blur, dynamic blur, film grain, color correction) when NVG is active. Effects are removed automatically when NVG is switched off.",
    params: [
      { name: "_this", type: "Object | Array", optional: false, default: "", desc: "Unit or array of units to apply the effect handler to." },
    ],
    returns: { type: "Bool", desc: "true" },
    example: `[player] call EP_fnc_ext_nvg;`,
  },

);
