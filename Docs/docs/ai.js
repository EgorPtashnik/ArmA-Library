/**
 * Function docs — AI category.
 */
ArmADocs.register("AI", {

    "ep_fnc_addWaypoint": {
        description: "Adds a waypoint to a group and applies any waypoint properties passed after the destination. " +
                     "Strings are matched against EP_WP_TYPES, EP_BEHAVIOURS, EP_COMBAT_MODES, EP_FORMATIONS and EP_SPEED_MODES. " +
                     "An array is treated as the timeout <code>[min, mid, max]</code>; a number as the completion radius.",
        syntax: "[group, destination, ...properties] call ep_fnc_addWaypoint",
        params: [
            { name: "group",         type: "Group | Object",                   desc: "Group or unit (resolved via ep_fnc_getGroup)." },
            { name: "destination",   type: "Position | Object | Group | String", desc: "Any value accepted by ep_fnc_getPosition." },
            { name: "...properties", type: "String | Array | Number",          desc: "Any number of optional flags: waypoint type, behaviour, combat mode, formation, speed, timeout [min,mid,max], or completion radius." }
        ],
        returns: "Waypoint — the newly created waypoint.",
        example: '[group player, "marker_1", "SAD", "AWARE", "RED", 50, [10, 20, 30]] call ep_fnc_addWaypoint;'
    },

    "ep_fnc_clearWaypoints": {
        description: "Removes all waypoints from a group using CBA_fnc_clearWaypoints under the hood.",
        syntax: "value call ep_fnc_clearWaypoints",
        params: [
            { name: "value", type: "Group | Object", desc: "Group or unit (resolved via ep_fnc_getGroup)." }
        ],
        returns: "Group — the cleared group.",
        example: "player call ep_fnc_clearWaypoints;"
    },

    "ep_fnc_setAIMode": {
        description: "Configures AI behaviour features on a group or on individual units. " +
                     "For groups: EP_BEHAVIOURS, EP_FORMATIONS, EP_SPEED_MODES, EP_COMBAT_MODES, and Array = group id. " +
                     "For units: EP_BEHAVIOURS, EP_COMBAT_MODES, EP_UNIT_POSITIONS, Number = limitSpeed, Array = <code>enableAIFeature [feature, enabled]</code>.",
        syntax: "[target, ...properties] call ep_fnc_setAIMode",
        params: [
            { name: "target",        type: "Group | Object | Array<Object>", desc: "Group / unit — treated as group. Array of units — each unit is configured individually." },
            { name: "...properties", type: "String | Number | Array",         desc: "Any number of behaviour flags. See description for accepted values per target type." }
        ],
        returns: "Group | Array — the configured target.",
        example: '[group player, "AWARE", "WEDGE", "RED", "LIMITED"] call ep_fnc_setAIMode;\n' +
                 '[units group player, "COMBAT", "DOWN", ["AUTOTARGET", false]] call ep_fnc_setAIMode;'
    },

    "ep_fnc_taskAttack": {
        description: "Assigns an attack task to a group. By default clears existing waypoints and re-enables PATH / MOVE on all units, then creates an SAD waypoint in COMBAT/RED at the destination. " +
                     "Pass <code>false</code> anywhere in the params to keep existing waypoints instead of overriding.",
        syntax: "[group, destination, ...properties, override?] call ep_fnc_taskAttack",
        params: [
            { name: "group",         type: "Group | Object",                   desc: "Group or unit (resolved via ep_fnc_getGroup)." },
            { name: "destination",   type: "Position | Object | Group | String", desc: "Any value accepted by ep_fnc_getPosition." },
            { name: "...properties", type: "String | Array | Number",          desc: "Extra waypoint properties appended to ep_fnc_addWaypoint. See ep_fnc_addWaypoint." },
            { name: "override",      type: "Boolean (optional)",               desc: "Default true. If false, existing waypoints are kept." }
        ],
        returns: "Waypoint — the created attack waypoint.",
        example: '[group player, "marker_enemy", 100] call ep_fnc_taskAttack;\n' +
                 '[myGroup, target, false] call ep_fnc_taskAttack;   // don\'t clear existing waypoints'
    }

});
