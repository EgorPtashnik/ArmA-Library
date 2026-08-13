/**
 * Function docs — Create category.
 */
ArmADocs.register("Create", {

    "EP_fnc_createGroup": {
        description: "Spawns a group via <code>BIS_fnc_spawnGroup</code> and applies AI skill settings on the result. " +
                     "When <code>position</code> is <code>[ref, radius]</code>, a random position is generated inside the radius via EP_fnc_getRandomPosition. " +
                     "If <code>spawnRef</code> is an existing group, the spawned units (and their vehicles) join it silently; " +
                     "if it is a side, a new group is created for that side and set to <code>deleteGroupWhenEmpty true</code>.",
        syntax: "[position, spawnRef, classes, skillParams?, relPositions?, direction?, ranks?, ammo?, randControls?, precisePos?] call EP_fnc_createGroup",
        params: [
            { name: "position",     type: "Position | Object | Group | String | [ref, radius]", desc: "Spawn location, or <code>[ref, radius]</code> for a random position." },
            { name: "spawnRef",     type: "Side | Group",                                       desc: "Target side (creates a new group) or existing group (units join it silently)." },
            { name: "classes",      type: "Array<String>",                                      desc: "Class names of units/vehicles to spawn (BIS_fnc_spawnGroup format)." },
            { name: "skillParams",  type: "Array (optional)",                                   desc: "AI skill key/value pairs forwarded to EP_fnc_setAISkill (SKILL, AIM, AIM_SHAKE, AIM_SPEED, SPOT, SPOT_TIME, COURAGE, RELOAD, COMMAND, FLEEING). Default <code>[]</code>." },
            { name: "relPositions", type: "Array (optional)",                                   desc: "Relative offsets per unit. Default <code>[]</code>." },
            { name: "direction",    type: "Number (optional)",                                  desc: "Facing direction in degrees. Default 0." },
            { name: "ranks",        type: "Array (optional)",                                   desc: "Rank per unit. Default <code>[]</code>." },
            { name: "ammo",         type: "Array (optional)",                                   desc: "Ammo range <code>[min, max]</code> in 0..1. Default <code>[]</code>." },
            { name: "randControls", type: "Array (optional)",                                   desc: "<code>[minUnits, chancePerAdditional]</code>. Default <code>[-1, 1]</code>." },
            { name: "precisePos",   type: "Boolean (optional)",                                 desc: "Precise position placement. Default true." }
        ],
        returns: "Group — the resulting group (either newly created or the one that was joined).",
        example: '[getMarkerPos "spawn_1", east, ["O_Soldier_F","O_Soldier_AR_F","O_Soldier_TL_F"]] call EP_fnc_createGroup;\n' +
                 '[["spawn_area", 100], east, ["O_Soldier_F"]] call EP_fnc_createGroup;   // random spawn in 100m radius'
    },

    "EP_fnc_createTrigger": {
        description: "Creates an <code>EmptyDetector</code> trigger at <code>position</code>. Following parameters are dispatched by type: " +
                     "number \u2192 <code>setTriggerInterval</code>; string \u2192 <code>setTriggerText</code>; " +
                     "<code>[a,b,c,rect]</code> or <code>[a,b,c,rect,angle]</code> \u2192 <code>setTriggerArea</code>; " +
                     "<code>[\"\", \"\", true]</code>-shape \u2192 <code>setTriggerActivation</code>; " +
                     "<code>[cond, act, deact]</code> code triple \u2192 <code>setTriggerStatements</code>.",
        syntax: "[position, ...properties] call EP_fnc_createTrigger",
        params: [
            { name: "position",      type: "Position",                    desc: "Trigger origin (world position array)." },
            { name: "...properties", type: "Number | String | Array | Code", desc: "Any mix of trigger properties. See description for supported shapes." }
        ],
        returns: "Object — the created trigger.",
        example: '[getPos player, [50, 50, 0, false], ["ANY", "PRESENT", true],\n' +
                 '                [{ this }, { hint "Entered!" }, { hint "Left!" }]] call EP_fnc_createTrigger;'
    },

    "EP_fnc_createUnit": {
        description: "Spawns a single unit in an existing group. Extra parameters are dispatched by type: " +
                     "special string from EP_CREATE_UNIT_SPECIAL_TYPES (\"NONE\", \"CAN_COLLIDE\", \"CARGO\") \u2192 special placement flag; " +
                     "number \u2192 placement radius; other string \u2192 marker prefix passed to EP_fnc_collectMarkers (first marker used as position, extras as fallback markers). " +
                     "If the group has a live unit, that unit's position is used as the default spawn position.",
        syntax: "[group, type, ...properties] call EP_fnc_createUnit",
        params: [
            { name: "group",         type: "Group | Object",                    desc: "Group or unit (resolved via EP_fnc_getGroup) to add the new unit to." },
            { name: "type",          type: "String | Array<String>",            desc: "Unit class name, or array of class names (random pick)." },
            { name: "...properties", type: "String | Number | Position | Object | Group", desc: "Any mix of: special flag, placement radius, marker prefix, or explicit position value." }
        ],
        returns: "Object — the spawned unit.",
        example: '[group player, "O_Soldier_F", "spawn_", 10] call EP_fnc_createUnit;\n' +
                 '[group player, ["O_Soldier_F","O_Soldier_AR_F"], getMarkerPos "spawn_1", "CAN_COLLIDE"] call EP_fnc_createUnit;'
    }

});
