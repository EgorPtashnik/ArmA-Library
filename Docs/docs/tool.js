/**
 * Function docs — Tool category.
 */
ArmADocs.register("Tool", {

    "ep_fnc_getGroup": {
        description: "Resolves a Group from a Group, a unit belonging to a group, or a single-element array containing either. " +
                     "Thin wrapper around <code>CBA_fnc_getGroup</code>.",
        syntax: "value call ep_fnc_getGroup",
        params: [
            { name: "value", type: "Group | Object | Array", desc: "The value to normalise into a Group." }
        ],
        returns: "Group",
        example: "player call ep_fnc_getGroup;\n[myUnit] call ep_fnc_getGroup;"
    },

    "ep_fnc_getPosition": {
        description: "Resolves an AGL/ATL position from many input types.",
        syntax: "value call ep_fnc_getPosition",
        params: [
            { name: "value", type: "String | Group | Object | Array", desc: "Marker name (<code>getMarkerPos</code>), group (leader pos), object (<code>getPos</code>), or position array (returned as-is)." }
        ],
        returns: "Position (Array [x, y, z])",
        example: '"marker_1"        call ep_fnc_getPosition;\n' +
                 'group player      call ep_fnc_getPosition;\n' +
                 'player            call ep_fnc_getPosition;\n' +
                 '[1000, 2000, 0]   call ep_fnc_getPosition;'
    },

    "ep_fnc_getRandomArray": {
        description: "Builds a new array of <code>resultCount</code> elements picked randomly from <code>initArray</code>. " +
                     "With <code>withoutDuplication = true</code>, each source element is picked at most once (uses <code>deleteAt</code> on the input array \u2014 pass a copy if you need to preserve it). " +
                     "If <code>withoutDuplication</code> is true and <code>resultCount</code> exceeds the input size, the function logs a systemChat warning and exits.",
        syntax: "[initArray, resultCount, withoutDuplication?] call ep_fnc_getRandomArray",
        params: [
            { name: "initArray",          type: "Array",              desc: "Source array to pick from." },
            { name: "resultCount",        type: "Number",             desc: "How many elements to return." },
            { name: "withoutDuplication", type: "Boolean (optional)", desc: "If true, no element is picked twice. Default false." }
        ],
        returns: "Array \u2014 the randomised selection.",
        example: '[["alpha","bravo","charlie","delta"], 2] call ep_fnc_getRandomArray;\n' +
                 '[+aMarkers, 5, true] call ep_fnc_getRandomArray;   // no duplicates, input preserved via +copy'
    },

    "ep_fnc_collectMarkers": {
        description: "Collects sequentially numbered markers named <code>prefix1</code>, <code>prefix2</code>, \u2026 up to 128. " +
                     "Iteration stops at the first missing marker (detected by <code>getMarkerPos</code> returning <code>[0, 0, 0]</code>).",
        syntax: "[markerPrefix, returnPositionArray?] call ep_fnc_collectMarkers",
        params: [
            { name: "markerPrefix",        type: "String",             desc: "Common prefix. Function reads <code>prefix1</code> \u2026 <code>prefix128</code>." },
            { name: "returnPositionArray", type: "Boolean (optional)", desc: "If true, returns marker positions instead of marker names. Default false." }
        ],
        returns: "Array \u2014 marker names, or marker positions when <code>returnPositionArray</code> is true.",
        example: '"patrol_" call ep_fnc_collectMarkers;\n' +
                 '["spawn_", true] call ep_fnc_collectMarkers;   // positions'
    }

});
