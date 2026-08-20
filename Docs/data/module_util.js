// ═══════════════════════════════════════════════════════════
//  MODULE: Util
//  Utility functions: position resolvers, collectors,
//  random helpers, cleanup.
// ═══════════════════════════════════════════════════════════

EP_DATA.push(

  {
    id: "fn_getPosition",
    name: "EP_fnc_getPosition",
    module: "Util",
    desc: "Universal position resolver. Accepts marker name, group (returns leader position), object, or position array.",
    params: [
      { name: "_this", type: "String | Group | Object | Array", optional: false, default: "", desc: "Input to resolve." },
    ],
    returns: { type: "Array", desc: "Position [x, y, z]." },
    example:
`"mkrBase" call EP_fnc_getPosition;   // marker
grp1      call EP_fnc_getPosition;   // group leader
myVeh     call EP_fnc_getPosition;   // object`,
  },

  {
    id: "fn_getGroup",
    name: "EP_fnc_getGroup",
    module: "Util",
    desc: "Returns the group of a unit, group, or first element of an array. Wrapper around CBA_fnc_getGroup.",
    params: [
      { name: "_this", type: "Group | Object | Array", optional: false, default: "", desc: "Input." },
    ],
    returns: { type: "Group", desc: "The resolved group." },
    example: `unit1 call EP_fnc_getGroup;`,
  },

  {
    id: "fn_collectMarkers",
    name: "EP_fnc_collectMarkers",
    module: "Util",
    desc: "Collects a numbered sequence of markers with a shared prefix: prefix_1, prefix_2, ... up to 128. Stops at the first missing marker.",
    params: [
      { name: "_mrkPrefix",           type: "String", optional: false, default: "",      desc: "Marker name prefix." },
      { name: "_returnPositionArray", type: "Bool",   optional: true,  default: "false", desc: "If true, returns positions instead of marker name strings." },
    ],
    returns: { type: "Array", desc: "Array of marker names or positions." },
    example:
`private _route = "patrol" call EP_fnc_collectMarkers;

// As positions
private _positions = ["patrol", true] call EP_fnc_collectMarkers;`,
  },

  {
    id: "fn_collectUnits",
    name: "EP_fnc_collectUnits",
    module: "Util",
    desc: "Flattens mixed input (groups, objects, arrays, layer name strings) into a flat array of units.",
    params: [
      { name: "_this", type: "Group | Object | Array | String", optional: false, default: "", desc: "Any combination of groups, objects, arrays, or mission layer name strings." },
    ],
    returns: { type: "Array", desc: "Flat array of units." },
    example: `private _all = [grp1, grp2, someUnit, "LayerName"] call EP_fnc_collectUnits;`,
  },

  {
    id: "fn_collectVariables",
    name: "EP_fnc_collectVariables",
    module: "Util",
    desc: "Collects a numbered sequence of mission namespace variables with a shared prefix: prefix_1, prefix_2, ... Stops at the first nil value.",
    params: [
      { name: "_varPrefixes", type: "String | Array", optional: false, default: "",      desc: "Prefix string or array of prefixes." },
      { name: "_reversed",    type: "Bool",           optional: true,  default: "false", desc: "If true, uses pushBack instead of append (preserves arrays as single elements)." },
    ],
    returns: { type: "Array", desc: "Collected variable values." },
    example:
`// Variables named grpWave_1, grpWave_2, grpWave_3
private _waves = "grpWave" call EP_fnc_collectVariables;`,
  },

  {
    id: "fn_getRandomArray",
    name: "EP_fnc_getRandomArray",
    module: "Util",
    desc: "Returns an array of N random elements picked from an input array. Optionally without duplication.",
    params: [
      { name: "_initArray",          type: "Array",  optional: false, default: "",      desc: "Source array." },
      { name: "_resultCount",        type: "Number", optional: false, default: "",      desc: "How many elements to pick." },
      { name: "_withoutDublication", type: "Bool",   optional: true,  default: "false", desc: "If true, each element is picked at most once." },
    ],
    returns: { type: "Array", desc: "Array of randomly picked elements." },
    example: `private _selected = [allObjectives, 3, true] call EP_fnc_getRandomArray;`,
  },

  {
    id: "fn_getRandomPosition",
    name: "EP_fnc_getRandomPosition",
    module: "Util",
    desc: "Returns a random position within a radius around a reference, with optional directional constraint.",
    params: [
      { name: "_ref",       type: "Any",    optional: false, default: "",    desc: "Reference: position, marker, object, or group." },
      { name: "_radius",    type: "Number", optional: true,  default: "0",   desc: "Max distance from the reference." },
      { name: "_direction", type: "Number", optional: true,  default: "0",   desc: "Centre direction of the angular sector." },
      { name: "_angle",     type: "Number", optional: true,  default: "360", desc: "Width of the angular sector in degrees." },
    ],
    returns: { type: "Array", desc: "Random position." },
    example: `private _pos = ["mkrCenter", 200, 0, 90] call EP_fnc_getRandomPosition;`,
  },

  {
    id: "fn_getRandomPositionArea",
    name: "EP_fnc_getRandomPositionArea",
    module: "Util",
    desc: "Returns a random position inside a trigger or marker area (ellipse or rectangle). Optionally on the perimeter.",
    params: [
      { name: "_zoneReference", type: "Object | String | Array", optional: true, default: "[]",    desc: "Trigger, marker, or BIS area array." },
      { name: "_perimeter",     type: "Bool",                    optional: true, default: "false", desc: "If true, position is on the boundary of the area." },
    ],
    returns: { type: "Array", desc: "Random position [x, y, z]." },
    example:
`private _pos = [triggerZone1] call EP_fnc_getRandomPositionArea;

// On the perimeter
private _pos = [triggerZone1, true] call EP_fnc_getRandomPositionArea;`,
  },

  {
    id: "fn_cleanupArea",
    name: "EP_fnc_cleanupArea",
    module: "Util",
    desc: "Deletes all objects within a radius. Recursively re-runs if any deleted object had crew. Safety limit: 10 recursions.",
    params: [
      { name: "_position", type: "Any",    optional: false, default: "", desc: "Centre position." },
      { name: "_radius",   type: "Number", optional: false, default: "", desc: "Cleanup radius in metres." },
    ],
    returns: { type: "Nothing", desc: "" },
    example: `["mkrOldBase", 300] call EP_fnc_cleanupArea;`,
  },

);
