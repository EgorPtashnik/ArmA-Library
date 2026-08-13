/**
 * Function docs — AI category.
 */
ArmADocs.register("AI", {

    "EP_fnc_addWaypoint": {
        description: "Adds a waypoint to a group and applies any waypoint properties passed after the destination. " +
                     "Strings are matched against EP_WP_TYPES, EP_BEHAVIOURS, EP_COMBAT_MODES, EP_FORMATIONS and EP_SPEED_MODES. " +
                     "A <code>[{cond}, {statement}]</code> code pair sets waypoint statements; a 3-element number array is treated as the timeout <code>[min, mid, max]</code>; a single number as the completion radius.",
        syntax: "[group, destination, ...properties] call EP_fnc_addWaypoint",
        params: [
            { name: "group",         type: "Group | Object",                   desc: "Group or unit (resolved via EP_fnc_getGroup)." },
            { name: "destination",   type: "Position | Object | Group | String", desc: "Any value accepted by EP_fnc_getPosition." },
            { name: "...properties", type: "String | Array | Number",          desc: "Any number of optional flags: waypoint type, behaviour, combat mode, formation, speed, statements <code>[{cond},{stmt}]</code>, timeout <code>[min,mid,max]</code>, or completion radius." }
        ],
        returns: "Waypoint — the newly created waypoint.",
        example: '[group player, "marker_1", "SAD", "AWARE", "RED", 50, [10, 20, 30]] call EP_fnc_addWaypoint;\n' +
                 '[group player, "marker_1", [{ (count units _this) < 3 }, { hint "Group thinned out" }]] call EP_fnc_addWaypoint;'
    },

    "EP_fnc_clearWaypoints": {
        description: "Removes all waypoints from a group using CBA_fnc_clearWaypoints under the hood.",
        syntax: "value call EP_fnc_clearWaypoints",
        params: [
            { name: "value", type: "Group | Object", desc: "Group or unit (resolved via EP_fnc_getGroup)." }
        ],
        returns: "Group — the cleared group.",
        example: "player call EP_fnc_clearWaypoints;"
    },

    "EP_fnc_setAIMode": {
        description: "Configures AI behaviour features on a group or on individual units. " +
                     "For groups: EP_BEHAVIOURS, EP_FORMATIONS, EP_SPEED_MODES, EP_COMBAT_MODES, and Array = group id. " +
                     "For units: EP_BEHAVIOURS, EP_COMBAT_MODES, EP_UNIT_POSITIONS, Number = limitSpeed, Array = <code>enableAIFeature [feature, enabled]</code>.",
        syntax: "[target, ...properties] call EP_fnc_setAIMode",
        params: [
            { name: "target",        type: "Group | Object | Array<Object>", desc: "Group / unit — treated as group. Array of units — each unit is configured individually." },
            { name: "...properties", type: "String | Number | Array",         desc: "Any number of behaviour flags. See description for accepted values per target type." }
        ],
        returns: "Group | Array — the configured target.",
        example: '[group player, "AWARE", "WEDGE", "RED", "LIMITED"] call EP_fnc_setAIMode;\n' +
                 '[units group player, "COMBAT", "DOWN", ["AUTOTARGET", false]] call EP_fnc_setAIMode;'
    },

    "EP_fnc_taskAttack": {
        description: "Assigns an attack task to a group. By default clears existing waypoints and re-enables PATH / MOVE on all units, then creates an SAD waypoint in COMBAT/RED at the destination. " +
                     "Pass <code>false</code> anywhere in the params to keep existing waypoints instead of overriding.",
        syntax: "[group, destination, ...properties, override?] call EP_fnc_taskAttack",
        params: [
            { name: "group",         type: "Group | Object",                   desc: "Group or unit (resolved via EP_fnc_getGroup)." },
            { name: "destination",   type: "Position | Object | Group | String", desc: "Any value accepted by EP_fnc_getPosition." },
            { name: "...properties", type: "String | Array | Number",          desc: "Extra waypoint properties appended to EP_fnc_addWaypoint. See EP_fnc_addWaypoint." },
            { name: "override",      type: "Boolean (optional)",               desc: "Default true. If false, existing waypoints are kept." }
        ],
        returns: "Waypoint — the created attack waypoint.",
        example: '[group player, "marker_enemy", 100] call EP_fnc_taskAttack;\n' +
                 '[myGroup, target, false] call EP_fnc_taskAttack;   // don\'t clear existing waypoints'
    },

    "EP_fnc_taskPatrol": {
        description: "Assigns a patrol task to a group. Two modes: " +
                     "(a) circular \u2014 default. Generates <code>count</code> waypoints on a randomised ring around <code>destination</code> (LIMITED / SAFE) and closes the loop with a CYCLE waypoint. " +
                     "(b) route \u2014 when <code>setOnRoute</code> is true. <code>destination</code> must be a marker prefix string (or an array of positions); the function walks the corresponding markers via EP_fnc_collectMarkers and creates a waypoint at each, then CYCLEs back to the first. " +
                     "By default clears existing waypoints and re-enables PATH / MOVE on all units; pass <code>false</code> anywhere in <code>...properties</code> to keep existing waypoints instead.",
        syntax: "[group, destination?, setOnRoute?, radius?, count?, ...properties, override?] call EP_fnc_taskPatrol",
        params: [
            { name: "group",         type: "Group | Object",                             desc: "Group or unit (resolved via EP_fnc_getGroup)." },
            { name: "destination",   type: "Position | Object | Group | String (optional)", desc: "Patrol centre in circular mode; marker prefix (or array of positions) in route mode. Default 0 \u2014 uses the group\u2019s current position (circular mode only)." },
            { name: "setOnRoute",    type: "Boolean (optional)",                         desc: "If true, switch to route mode. Default false." },
            { name: "radius",        type: "Number (optional)",                          desc: "Patrol ring radius in meters (circular mode). Default 100." },
            { name: "count",         type: "Number (optional)",                          desc: "Number of patrol waypoints excluding CYCLE (circular mode). Default 3." },
            { name: "...properties", type: "String | Array | Number",                    desc: "Extra waypoint properties appended to EP_fnc_addWaypoint (behaviour, combat mode, formation, speed, statements, timeout, completion radius)." },
            { name: "override",      type: "Boolean (optional)",                         desc: "Default true. If false, existing waypoints are kept." }
        ],
        returns: "Nothing.",
        example: '[group player, "marker_town", false, 150, 5] call EP_fnc_taskPatrol;                    // circular\n' +
                 '[group player, "patrol", true] call EP_fnc_taskPatrol;                                  // route via markers patrol_1, patrol_2, ...\n' +
                 '[myGroup, target, false, 200, 4, "AWARE", "WEDGE"] call EP_fnc_taskPatrol;\n' +
                 '[myGroup, target, false, 100, 3, false] call EP_fnc_taskPatrol;   // don\'t clear existing waypoints'
    },

    "EP_fnc_setAISkill": {
        description: "Applies AI skill values to a group, unit, or array of units. " +
                     "<code>skillParams</code> is a flat key/value array converted to a HashMap internally; " +
                     "missing keys fall back to the EP_MISSION_DEFAULT_* constants. " +
                     "Accepted keys: <code>SKILL</code>, <code>AIM</code>, <code>AIM_SHAKE</code>, <code>AIM_SPEED</code>, <code>SPOT</code>, <code>SPOT_TIME</code>, <code>COURAGE</code>, <code>RELOAD</code>, <code>COMMAND</code>, <code>FLEEING</code>.",
        syntax: "[target, skillParams?] call EP_fnc_setAISkill",
        params: [
            { name: "target",      type: "Group | Object | Array<Object>", desc: "Target(s) to configure. Group \u2192 all units in group; Object \u2192 single unit; Array \u2192 iterated as-is." },
            { name: "skillParams", type: "Array (optional)",                desc: "Flat key/value pairs. Any missing key uses its EP_MISSION_DEFAULT_* value. Default <code>[]</code> \u2192 pure defaults." }
        ],
        returns: "The input <code>target</code> unchanged.",
        example: '[group player, ["SKILL", 0.7, "AIM", 0.3, "COURAGE", 1]] call EP_fnc_setAISkill;\n' +
                 '[units group player] call EP_fnc_setAISkill;   // all defaults'
    },

    "EP_fnc_taskDefend": {
        description: "Assigns a defend task to a group via <code>CBA_fnc_taskDefend</code>. Sets up a defensive perimeter around the destination with configurable radius, threat threshold and patrol / hold ratios.",
        syntax: "[group, destination?, radius?, threshold?, patrol?, hold?] call EP_fnc_taskDefend",
        params: [
            { name: "group",       type: "Group | Object",                             desc: "Group or unit (resolved via EP_fnc_getGroup)." },
            { name: "destination", type: "Position | Object | Group | String (optional)", desc: "Defence centre. Any value accepted by EP_fnc_getPosition. Default 0 \u2014 uses the group\u2019s current position." },
            { name: "radius",      type: "Number (optional)",                          desc: "Defence perimeter radius in meters. Default 100." },
            { name: "threshold",   type: "Number (optional)",                          desc: "Enemy threat threshold that triggers combat mode. Default 3." },
            { name: "patrol",      type: "Number (optional)",                          desc: "Ratio (0..1) of the group that actively patrols the perimeter. Default 0.1." },
            { name: "hold",        type: "Number (optional)",                          desc: "Ratio (0..1) of the group that holds fixed positions. Default 0." }
        ],
        returns: "Nothing.",
        example: '[group player, "marker_base", 200] call EP_fnc_taskDefend;\n' +
                 '[myGroup, target, 150, 3, 0.5, 0.25] call EP_fnc_taskDefend;'
    },

    "EP_fnc_taskConvoy": {
        description: "Runs a convoy along a route of markers. Puts the group in COLUMN, sets convoy separation and speed on every vehicle, then keeps looping in the background to unstick stragglers (any sub-vehicle whose speed drops below 5 is ordered to <code>doFollow</code> the leader). " +
                     "When <code>pushThrough</code> is true, <code>enableAttack</code> is disabled and <code>setUnloadInCombat</code> is turned off so vehicles keep driving through contact; behaviour is inverted otherwise. " +
                     "Uses an internal <code>sleep 5</code> loop \u2014 must be launched with <code>spawn</code>, not <code>call</code>.",
        syntax: "[group, route, limitSpeed?, convoySeparation?, pushThrough?] spawn EP_fnc_taskConvoy",
        params: [
            { name: "group",            type: "Group | Object",     desc: "Group or unit (resolved via EP_fnc_getGroup)." },
            { name: "route",            type: "String",             desc: "Marker prefix passed to EP_fnc_collectMarkers \u2014 the ordered route the convoy will follow." },
            { name: "limitSpeed",       type: "Number (optional)",  desc: "Speed cap in km/h applied to every vehicle (leader uses the raw value, others 1.15x to help them catch up). Default 50." },
            { name: "convoySeparation", type: "Number (optional)",  desc: "Distance in meters between vehicles (<code>setConvoySeparation</code>). Default 50." },
            { name: "pushThrough",      type: "Boolean (optional)", desc: "If true, convoy pushes through contact without disembarking. Default true." }
        ],
        returns: "Nothing (background loop; script handle from <code>spawn</code>).",
        example: '[myGroup, "convoy_route"] spawn EP_fnc_taskConvoy;\n' +
                 '[myGroup, "convoy_route", 40, 30, false] spawn EP_fnc_taskConvoy;   // slower, tighter spacing, allow bailout'
    }

});
