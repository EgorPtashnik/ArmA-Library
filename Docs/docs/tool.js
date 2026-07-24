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
    }

});
