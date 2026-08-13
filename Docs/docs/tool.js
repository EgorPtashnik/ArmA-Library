/**
 * Function docs — Tool category.
 */
ArmADocs.register("Tool", {

    "EP_fnc_cleanupArea": {
        description: "Deletes every object within <code>radius</code> meters of <code>position</code> using <code>nearestObjects</code> (deep search). " +
                     "If any deleted vehicle still had crew at the moment of removal, the function calls itself again to sweep newly-ejected units \u2014 " +
                     "recursion is capped at 10 passes to avoid runaway loops. Position input is resolved via <code>EP_fnc_getPosition</code>, " +
                     "so markers, objects, groups and position arrays are all accepted. Radius must be a Number; otherwise a systemChat warning is printed and the call exits.",
        syntax: "[position, radius] call EP_fnc_cleanupArea",
        params: [
            { name: "position", type: "Position | Object | Group | String", desc: "Any value accepted by EP_fnc_getPosition \u2014 the sweep centre." },
            { name: "radius",   type: "Number",                             desc: "Sweep radius in meters. Must be a Number." }
        ],
        returns: "Nothing.",
        example: '[player, 50] call EP_fnc_cleanupArea;\n' +
                 '["cleanupZone", 200] call EP_fnc_cleanupArea;'
    },

    "EP_fnc_getGroup": {
        description: "Resolves a Group from a Group, a unit belonging to a group, or a single-element array containing either. " +
                     "Thin wrapper around <code>CBA_fnc_getGroup</code>.",
        syntax: "value call EP_fnc_getGroup",
        params: [
            { name: "value", type: "Group | Object | Array", desc: "The value to normalise into a Group." }
        ],
        returns: "Group",
        example: "player call EP_fnc_getGroup;\n[myUnit] call EP_fnc_getGroup;"
    },

    "EP_fnc_getPosition": {
        description: "Resolves an AGL/ATL position from many input types.",
        syntax: "value call EP_fnc_getPosition",
        params: [
            { name: "value", type: "String | Group | Object | Array", desc: "Marker name (<code>getMarkerPos</code>), group (leader pos), object (<code>getPos</code>), or position array (returned as-is)." }
        ],
        returns: "Position (Array [x, y, z])",
        example: '"marker_1"        call EP_fnc_getPosition;\n' +
                 'group player      call EP_fnc_getPosition;\n' +
                 'player            call EP_fnc_getPosition;\n' +
                 '[1000, 2000, 0]   call EP_fnc_getPosition;'
    },

    "EP_fnc_getRandomArray": {
        description: "Builds a new array of <code>resultCount</code> elements picked randomly from <code>initArray</code>. " +
                     "With <code>withoutDuplication = true</code>, each source element is picked at most once (uses <code>deleteAt</code> on the input array \u2014 pass a copy if you need to preserve it). " +
                     "If <code>withoutDuplication</code> is true and <code>resultCount</code> exceeds the input size, the function logs a systemChat warning and exits.",
        syntax: "[initArray, resultCount, withoutDuplication?] call EP_fnc_getRandomArray",
        params: [
            { name: "initArray",          type: "Array",              desc: "Source array to pick from." },
            { name: "resultCount",        type: "Number",             desc: "How many elements to return." },
            { name: "withoutDuplication", type: "Boolean (optional)", desc: "If true, no element is picked twice. Default false." }
        ],
        returns: "Array \u2014 the randomised selection.",
        example: '[["alpha","bravo","charlie","delta"], 2] call EP_fnc_getRandomArray;\n' +
                 '[+aMarkers, 5, true] call EP_fnc_getRandomArray;   // no duplicates, input preserved via +copy'
    },

    "EP_fnc_collectMarkers": {
        description: "Collects sequentially numbered markers named <code>prefix_1</code>, <code>prefix_2</code>, \u2026 up to 128 (the underscore is inserted by the function \u2014 pass the bare prefix, without a trailing underscore). " +
                     "Iteration stops at the first missing marker (detected by <code>getMarkerPos</code> returning <code>[0, 0, 0]</code>).",
        syntax: "[markerPrefix, returnPositionArray?] call EP_fnc_collectMarkers",
        params: [
            { name: "markerPrefix",        type: "String",             desc: "Common prefix without a trailing underscore. Function reads <code>prefix_1</code> \u2026 <code>prefix_128</code>." },
            { name: "returnPositionArray", type: "Boolean (optional)", desc: "If true, returns marker positions instead of marker names. Default false." }
        ],
        returns: "Array \u2014 marker names, or marker positions when <code>returnPositionArray</code> is true.",
        example: '"patrol" call EP_fnc_collectMarkers;                 // -> ["patrol_1", "patrol_2", ...]\n' +
                 '["spawn", true] call EP_fnc_collectMarkers;          // positions'
    },

    "EP_fnc_collectUnits": {
        description: "Normalises a heterogeneous list of references into a flat array of units. Accepts groups, single objects, arrays of any of the above, or a mission-layer name.",
        syntax: "value call EP_fnc_collectUnits",
        params: [
            { name: "value", type: "Group | Object | String | Array", desc: "Any mix of groups (units expanded), objects (kept), mission-layer name (its objects), or arrays of the same." }
        ],
        returns: "Array<Object> \u2014 the flattened list of units.",
        example: '[group player, cursorObject, "AmbientLayer"] call EP_fnc_collectUnits;'
    },

    "EP_fnc_collectVariables": {
        description: "Reads sequentially numbered mission-namespace variables named <code>prefix_1</code>, <code>prefix_2</code>, \u2026 up to 128. Iteration stops at the first missing variable. Accepts one prefix (pass as string) or several prefixes (pass as an array of strings \u2014 note that in the multi-prefix form the <code>reversed</code> parameter is unavailable).",
        syntax: "prefix call EP_fnc_collectVariables\n" +
                "[prefix, reversed?] call EP_fnc_collectVariables\n" +
                "[prefix1, prefix2, \u2026] call EP_fnc_collectVariables",
        params: [
            { name: "varPrefixes", type: "String | Array<String>", desc: "Single prefix, or an array of prefixes. Reads <code>prefix_1</code> \u2026 <code>prefix_128</code> for each prefix." },
            { name: "reversed",   type: "Boolean (optional)",     desc: "Single-prefix form only. If true, entries are pushBack\u2019ed one-by-one; otherwise append\u2019ed. Default false." }
        ],
        returns: "Array \u2014 the collected variable values in order of discovery.",
        example: '"trigger" call EP_fnc_collectVariables;\n' +
                 '["trigger", true] call EP_fnc_collectVariables;         // single prefix, reversed\n' +
                 '["trigger", "marker"] call EP_fnc_collectVariables;     // two prefixes, both scanned'
    },

    "EP_fnc_getRandomPosition": {
        description: "Returns a random position uniformly distributed inside a disc / annular sector around a reference position. " +
                     "Uses <code>sqrt(random 1)</code> so the resulting points are area-uniform (no clustering at the centre). " +
                     "If the input reference is a 2D array (<code>[x, y]</code>) the returned position is resized back to 2 elements.",
        syntax: "[ref, radius?, direction?, angle?] call EP_fnc_getRandomPosition",
        params: [
            { name: "ref",       type: "Position | Object | Group | String", desc: "Any value accepted by EP_fnc_getPosition \u2014 the sector centre." },
            { name: "radius",    type: "Number (optional)",                  desc: "Max distance in meters. Default 0 (returns the centre)." },
            { name: "direction", type: "Number (optional)",                  desc: "Sector centre bearing in degrees. Default 0 (north)." },
            { name: "angle",     type: "Number (optional)",                  desc: "Sector opening angle in degrees, centred on <code>direction</code>. Default 360 (full disc)." }
        ],
        returns: "Position \u2014 same dimensionality (2D/3D) as the resolved reference.",
        example: '[player, 150] call EP_fnc_getRandomPosition;                   // anywhere within 150m\n' +
                 '["marker_spawn", 200, 90, 60] call EP_fnc_getRandomPosition;   // 60\u00b0 wedge to the east'
    },

    "EP_fnc_getRandomPositionArea": {
        description: "Returns a random position inside or on the perimeter of a Zone / Trigger / Marker area (rectangle or ellipse). Uses <code>BIS_fnc_getArea</code> to resolve the shape.",
        syntax: "[zoneReference, perimeter?] call EP_fnc_getRandomPositionArea",
        params: [
            { name: "zoneReference", type: "Marker | Trigger | Location | Array", desc: "Any value accepted by <code>BIS_fnc_getArea</code>." },
            { name: "perimeter",     type: "Boolean (optional)",                  desc: "If true, sample on the perimeter of the area instead of inside it. Default false." }
        ],
        returns: "Position \u2014 world position inside/on the area, or <code>[]</code> if the reference is invalid.",
        example: '"triggerZone" call EP_fnc_getRandomPositionArea;\n' +
                 '["triggerZone", true] call EP_fnc_getRandomPositionArea;   // on perimeter'
    }

});
