// ═══════════════════════════════════════════════════════════
//  MODULE: AI
//  Functions for AI behaviour, waypoints, and tasks.
//
//  To add a function: copy a block below and fill in fields.
//  Required: id, name, module, desc, params, returns
//  Optional: example, notes
// ═══════════════════════════════════════════════════════════

EP_DATA.push(

  {
    id: "fn_addWaypoint",
    name: "EP_fnc_addWaypoint",
    module: "AI",
    desc: "Creates a waypoint for a group. Accepts extra parameters as positional arguments — strings are matched against known constants (WP types, behaviours, formations, etc.) automatically. Returns the waypoint handle.",
    params: [
      { name: "_group",       type: "Group",  optional: false, default: "", desc: "Target group." },
      { name: "_destination", type: "Any",    optional: false, default: "", desc: "Position, marker name, object, or group." },
      { name: "...",          type: "Any",    optional: true,  default: "", desc: "Extra args: WP type string, behaviour string, formation string, combat mode string, speed mode string, completion radius (Number), visibility (Bool), timeout [min,mid,max], statements [{cond},{act},{deact}]." },
    ],
    returns: { type: "Waypoint", desc: "The created waypoint handle." },
    example:
`// Simple move waypoint
[grp1, "mkrBase", "MOVE", "SAFE", "COLUMN"] call EP_fnc_addWaypoint;

// With completion radius and statements
[grp1, myObj, "SAD", "COMBAT", 15, [
  { true },
  { hint "Waypoint reached!"; },
  {}
]] call EP_fnc_addWaypoint;`,
  },

  {
    id: "fn_clearWaypoints",
    name: "EP_fnc_clearWaypoints",
    module: "AI",
    desc: "Clears all waypoints from a group. Accepts group, unit, or array. Wrapper around CBA_fnc_clearWaypoints. Returns the group.",
    params: [
      { name: "_this", type: "Group | Object | Array", optional: false, default: "", desc: "Group or unit whose group waypoints will be cleared." },
    ],
    returns: { type: "Group", desc: "The group that was cleared." },
    example: `grp1 call EP_fnc_clearWaypoints;`,
  },

  {
    id: "fn_setAIMode",
    name: "EP_fnc_setAIMode",
    module: "AI",
    desc: "Sets behaviour, formation, speed mode, combat mode, unit positions, or speed limit on a group or units. Strings are matched against known constants. Accepts Group, Object, or Array.",
    params: [
      { name: "_target", type: "Group | Object | Array", optional: false, default: "", desc: "Target to configure." },
      { name: "...",     type: "Any",                    optional: true,  default: "", desc: "Behaviour, formation, speed mode, combat mode strings; speed limit (Number); AI feature pair ([featureName, bool]). For groups: also group ID array." },
    ],
    returns: { type: "Group | Array", desc: "The original target." },
    example:
`// Group: set formation and combat mode
[grp1, "COLUMN", "RED"] call EP_fnc_setAIMode;

// Unit: set position and disable targeting
[unit1, "DOWN", ["AUTOTARGET", false]] call EP_fnc_setAIMode;`,
    notes: "Pass string constants in any order — they are matched against EP_BEHAVIOURS, EP_FORMATIONS, EP_COMBAT_MODES, EP_SPEED_MODES, EP_UNIT_POSITIONS.",
  },

  {
    id: "fn_setAISkill",
    name: "EP_fnc_setAISkill",
    module: "AI",
    desc: "Sets skill values for units in a group, array, or single object. Accepts a key-value params array. Unspecified skills fall back to library defaults.",
    params: [
      { name: "_ref",         type: "Group | Array | Object", optional: false, default: "",   desc: "Target units." },
      { name: "_skillParams", type: "Array",                  optional: true,  default: "[]", desc: "Key-value pairs: [[\"AIM\",0.3],[\"COURAGE\",0.8]] etc." },
    ],
    returns: { type: "Group | Array | Object", desc: "The original reference." },
    example:
`[grp1, [["AIM", 0.3], ["COURAGE", 1], ["SKILL", 0.6]]] call EP_fnc_setAISkill;

// Defaults only
grp1 call EP_fnc_setAISkill;`,
    notes: "Available keys: SKILL, AIM, AIM_SHAKE, AIM_SPEED, SPOT, SPOT_TIME, COURAGE, RELOAD, COMMAND, FLEEING.",
  },

  {
    id: "fn_taskPatrol",
    name: "EP_fnc_taskPatrol",
    module: "AI",
    desc: "Assigns a patrol task to a group. Two modes: random patrol around a position, or a predefined route via named markers (prefix_1, prefix_2, ...).",
    params: [
      { name: "_group",       type: "Group | Object | Array", optional: false, default: "",      desc: "Target group." },
      { name: "_destination", type: "Any",                    optional: true,  default: "0",     desc: "0 = use group position. Marker prefix string for route mode. Position/object/group for random mode." },
      { name: "_setOnRoute",  type: "Bool",                   optional: true,  default: "false", desc: "true = predefined route mode." },
      { name: "_radius",      type: "Number",                 optional: true,  default: "100",   desc: "Patrol radius (random mode only)." },
      { name: "_count",       type: "Number",                 optional: true,  default: "3",     desc: "Number of waypoints to generate (random mode only)." },
    ],
    returns: { type: "Nothing", desc: "" },
    example:
`// Random patrol, radius 200
[grp1, 0, false, 200, 5] call EP_fnc_taskPatrol;

// Predefined route via markers patrol_1, patrol_2, ...
[grp1, "patrol", true] call EP_fnc_taskPatrol;`,
    notes: "In route mode, the first marker is used as the CYCLE waypoint to close the loop.",
  },

  {
    id: "fn_taskDefend",
    name: "EP_fnc_taskDefend",
    module: "AI",
    desc: "Assigns a defend task to a group. Wrapper around CBA_fnc_taskDefend.",
    params: [
      { name: "_group",       type: "Group | Object | Array", optional: false, default: "",    desc: "Target group." },
      { name: "_destination", type: "Any",                    optional: true,  default: "0",   desc: "Centre of the defence area. 0 = group position." },
      { name: "_radius",      type: "Number",                 optional: true,  default: "100", desc: "Defence radius." },
      { name: "_threshold",   type: "Number",                 optional: true,  default: "3",   desc: "Number of units to trigger active response." },
      { name: "_patrol",      type: "Number",                 optional: true,  default: "0.1", desc: "Chance to patrol (0–1)." },
      { name: "_hold",        type: "Number",                 optional: true,  default: "0",   desc: "Hold positions value." },
    ],
    returns: { type: "Nothing", desc: "" },
    example: `[grp1, "mkrDefend", 150, 2, 0.3] call EP_fnc_taskDefend;`,
  },

  {
    id: "fn_taskAttack",
    name: "EP_fnc_taskAttack",
    module: "AI",
    desc: "Sends a group to attack a destination. Clears existing waypoints and adds a SAD waypoint in COMBAT behaviour. Returns the created waypoint.",
    params: [
      { name: "_group",       type: "Group | Object | Array", optional: false, default: "", desc: "Attacking group." },
      { name: "_destination", type: "Any",                    optional: false, default: "", desc: "Target position, marker, object, or group." },
      { name: "...",          type: "Any",                    optional: true,  default: "", desc: "Extra waypoint args (see EP_fnc_addWaypoint)." },
    ],
    returns: { type: "Waypoint", desc: "The created SAD waypoint." },
    example: `[grp1, "mkrObjective"] call EP_fnc_taskAttack;`,
  },

  {
    id: "fn_taskConvoy",
    name: "EP_fnc_taskConvoy",
    module: "AI",
    desc: "Moves a group as a convoy along a marker route. Handles speed limiting, convoy separation, and stuck vehicle recovery.",
    params: [
      { name: "_group",            type: "Group | Object | Array", optional: false, default: "",      desc: "Convoy group." },
      { name: "_route",            type: "String",                 optional: false, default: "",      desc: "Marker prefix for the route (prefix_1, prefix_2, ...)." },
      { name: "_limitSpeed",       type: "Number",                 optional: true,  default: "50",    desc: "Max speed km/h for the lead vehicle." },
      { name: "_convoySeparation", type: "Number",                 optional: true,  default: "50",    desc: "Distance between vehicles in metres." },
      { name: "_pushThrough",      type: "Bool",                   optional: true,  default: "false", desc: "If true, the group ignores combat and pushes to the destination." },
    ],
    returns: { type: "Nothing", desc: "" },
    example: `[grpConvoy, "route", 40, 60, true] call EP_fnc_taskConvoy;`,
    notes: "Stuck vehicles are detected every 5 seconds and ordered to follow the leader.",
  },

);
