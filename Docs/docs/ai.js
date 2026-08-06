/**
 * Function docs — AI category.
 */
ArmADocs.register("AI", {

    "EP_fnc_addWaypoint": {
        description: "Adds a waypoint to a group and applies any waypoint properties passed after the destination. " +
                     "Strings are matched against EP_WP_TYPES, EP_BEHAVIOURS, EP_COMBAT_MODES, EP_FORMATIONS and EP_SPEED_MODES. " +
                     "An array is treated as the timeout <code>[min, mid, max]</code>; a number as the completion radius.",
        syntax: "[group, destination, ...properties] call EP_fnc_addWaypoint",
        params: [
            { name: "group",         type: "Group | Object",                   desc: "Group or unit (resolved via EP_fnc_getGroup)." },
            { name: "destination",   type: "Position | Object | Group | String", desc: "Any value accepted by EP_fnc_getPosition." },
            { name: "...properties", type: "String | Array | Number",          desc: "Any number of optional flags: waypoint type, behaviour, combat mode, formation, speed, timeout [min,mid,max], or completion radius." }
        ],
        returns: "Waypoint — the newly created waypoint.",
        example: '[group player, "marker_1", "SAD", "AWARE", "RED", 50, [10, 20, 30]] call EP_fnc_addWaypoint;'
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
        description: "Assigns a circular patrol task to a group. By default clears existing waypoints and re-enables PATH / MOVE on all units, then generates <code>count</code> waypoints on a randomised ring around the destination (LIMITED / SAFE) and closes the loop with a CYCLE waypoint. " +
                     "Pass <code>false</code> anywhere in the params to keep existing waypoints instead of overriding.",
        syntax: "[group, destination?, radius?, count?, ...properties, override?] call EP_fnc_taskPatrol",
        params: [
            { name: "group",         type: "Group | Object",                             desc: "Group or unit (resolved via EP_fnc_getGroup)." },
            { name: "destination",   type: "Position | Object | Group | String (optional)", desc: "Patrol centre. Any value accepted by EP_fnc_getPosition. Default 0 \u2014 uses the group\u2019s current position." },
            { name: "radius",        type: "Number (optional)",                          desc: "Patrol ring radius in meters. Default 100." },
            { name: "count",         type: "Number (optional)",                          desc: "Number of patrol waypoints (excluding CYCLE). Default 3." },
            { name: "...properties", type: "String | Array | Number",                    desc: "Extra waypoint properties appended to EP_fnc_addWaypoint (behaviour, combat mode, formation, speed, timeout, completion radius)." },
            { name: "override",      type: "Boolean (optional)",                         desc: "Default true. If false, existing waypoints are kept." }
        ],
        returns: "Nothing.",
        example: '[group player, "marker_town", 150, 5] call EP_fnc_taskPatrol;\n' +
                 '[myGroup, target, 200, 4, "AWARE", "WEDGE"] call EP_fnc_taskPatrol;\n' +
                 '[myGroup, target, 100, 3, false] call EP_fnc_taskPatrol;   // don\'t clear existing waypoints'
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
    }

});
