// ═══════════════════════════════════════════════════════════
//  MODULE: Create
//  Functions for spawning units, groups, triggers, projectiles.
// ═══════════════════════════════════════════════════════════

EP_DATA.push(

  {
    id: "fn_createGroup",
    name: "EP_fnc_createGroup",
    module: "Create",
    desc: "Spawns a group using BIS_fnc_spawnGroup and optionally joins it to an existing group. Applies AI skill after spawning.",
    params: [
      { name: "_position",     type: "Any",          optional: false, default: "",        desc: "Spawn position. Pass [ref, radius] array for a random position within radius." },
      { name: "_spawnRef",     type: "Side | Group", optional: false, default: "",        desc: "Side to spawn for, or existing group to join." },
      { name: "_classes",      type: "Array",        optional: false, default: "",        desc: "Array of unit classnames to spawn." },
      { name: "_skillParams",  type: "Array",        optional: true,  default: "[]",      desc: "Skill params for EP_fnc_setAISkill." },
      { name: "_relPositions", type: "Array",        optional: true,  default: "[]",      desc: "Relative spawn positions per unit." },
      { name: "_direction",    type: "Number",       optional: true,  default: "0",       desc: "Initial facing direction." },
      { name: "_ranks",        type: "Array",        optional: true,  default: "[]",      desc: "Array of ranks." },
      { name: "_ammo",         type: "Array",        optional: true,  default: "[]",      desc: "Ammo range [min, max] (0–1)." },
      { name: "_randControls", type: "Array",        optional: true,  default: "[-1, 1]", desc: "Random controls [minUnits, spawnChance]." },
      { name: "_precisePos",   type: "Bool",         optional: true,  default: "true",    desc: "Use precise position placement." },
    ],
    returns: { type: "Group", desc: "The spawned or joined group." },
    example:
`private _grp = [
  "mkrSpawn",
  east,
  ["O_Soldier_F", "O_Soldier_AR_F", "O_medic_F"],
  [["AIM", 0.25], ["SKILL", 0.5]]
] call EP_fnc_createGroup;

// Spawn into existing group
["mkrSpawn", existingGrp, ["O_Soldier_F"]] call EP_fnc_createGroup;`,
    notes: "If _spawnRef is a group, spawned units join it silently and the group's vehicles are updated.",
  },

  {
    id: "fn_createUnit",
    name: "EP_fnc_createUnit",
    module: "Create",
    desc: "Creates a single unit in a group. Position can be overridden by passing a marker name, position, or radius. If _type is an array, a random class is picked.",
    params: [
      { name: "_group", type: "Group | Object | Array", optional: false, default: "", desc: "Group the unit joins." },
      { name: "_type",  type: "String | Array",         optional: false, default: "", desc: "Unit classname or array of classnames (random pick)." },
      { name: "...",    type: "Any",                    optional: true,  default: "", desc: "Marker name (String) for position override; radius (Number); special type (NONE, CAN_COLLIDE, CARGO)." },
    ],
    returns: { type: "Object", desc: "The created unit." },
    example:
`private _unit = [grp1, "O_Soldier_F", "mkrPos", 10] call EP_fnc_createUnit;

// Random class
private _unit = [grp1, ["O_Soldier_F","O_Soldier_AR_F"]] call EP_fnc_createUnit;`,
  },

  {
    id: "fn_createTrigger",
    name: "EP_fnc_createTrigger",
    module: "Create",
    desc: "Creates an EmptyDetector trigger at a position and configures it via positional arguments. Stores the handle in the named global array.",
    params: [
      { name: "_position",        type: "Any",    optional: false, default: "",            desc: "Trigger position." },
      { name: "_handleArrayName", type: "String", optional: true,  default: "EP_Triggers", desc: "Global array name to push the trigger handle into." },
      { name: "...",              type: "Any",    optional: true,  default: "",            desc: "Interval (Number); text (String); area [a,b,angle,isRect] (Array); activation [by,type,repeating] (Array); statements [{cond},{act},{deact}] (Array of Code)." },
    ],
    returns: { type: "Object", desc: "The created trigger." },
    example:
`[
  "mkrZone",
  "EP_Triggers",
  [50, 50, 0, true],
  ["WEST", "PRESENT", false],
  [{ this }, { hint "Player entered!"; }, {}]
] call EP_fnc_createTrigger;`,
  },

  {
    id: "fn_createSimpleTrigger",
    name: "EP_fnc_createSimpleTrigger",
    module: "Create",
    desc: "Script-based trigger. Waits until a condition is met, then executes code. No physical trigger object. Handles stored in EP_SimpleTriggers by default.",
    params: [
      { name: "_condition",       type: "Code | Array", optional: false, default: "",                  desc: "Condition code or [code, args] pair." },
      { name: "_code",            type: "Code | Array", optional: false, default: "",                  desc: "Code to execute or [code, args] pair." },
      { name: "_sleep",           type: "Number",       optional: true,  default: "1",                 desc: "Polling interval in seconds." },
      { name: "_spawnCode",       type: "Bool",         optional: true,  default: "false",             desc: "If true, execute code via spawn instead of call." },
      { name: "_handleArrayName", type: "String",       optional: true,  default: "EP_SimpleTriggers", desc: "Global array to store the script handle." },
    ],
    returns: { type: "Script Handle", desc: "The spawned monitoring script handle." },
    example:
`[
  { { alive _x } count (units grpEnemy) == 0 },
  { [] execVM "end.sqf"; },
  3
] call EP_fnc_createSimpleTrigger;`,
    notes: "Equivalent to a manual waitUntil + call, but centralised and tracked.",
  },

  {
    id: "fn_createGuidedProjectile",
    name: "EP_fnc_createGuidedProjectile",
    module: "Create",
    desc: "Spawns a guided missile from an offset above the start object, targeting a destination.",
    params: [
      { name: "_start",  type: "Object", optional: false, default: "",                 desc: "Launch object (missile spawns above it)." },
      { name: "_target", type: "Any",    optional: false, default: "",                 desc: "Target position or object." },
      { name: "_muzzle", type: "String", optional: true,  default: "Missile_AGM_01_F", desc: "Ammo classname." },
      { name: "_offset", type: "Array",  optional: true,  default: "[0, 0, 20]",       desc: "Model-space spawn offset [x, y, z]." },
      { name: "_speed",  type: "Number", optional: true,  default: "200",              desc: "Projectile speed." },
    ],
    returns: { type: "Nothing", desc: "" },
    example: `[myPlane, targetTank, "Missile_AGM_01_F", [0,0,5], 300] call EP_fnc_createGuidedProjectile;`,
  },

);
