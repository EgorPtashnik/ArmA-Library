/**
 * Function docs — Constants category.
 * Preprocessor macros defined in lib/constants.hpp. #include the header
 * at the top of any function file that needs them.
 */
ArmADocs.register("Constants", {

    "EP_TASK_ICONS": {
        description: "All task icon names accepted by <code>ep_fnc_missionTasks</code>. Matched case-insensitively.",
        syntax: '#include "..\\constants.hpp"',
        example:
            '["airdrop","attack","danger","defend","destroy","download","exit","getin","getout",\n' +
            ' "heal","interact","kill","land","listen","meet","move","move1"..."move5",\n' +
            ' "navigate","rearm","refuel","repair","run","scout","search","takeoff",\n' +
            ' "talk","talk1"..."talk5","target","unknown","upload","use","wait","walk",\n' +
            ' "armor","backpack","boat","box","car","container","documents","heli","intel",\n' +
            ' "map","mine","plane","radio","rifle","truck","whiteboard","a".."z"]'
    },

    "EP_TASK_STATES": {
        description: "Valid task states passed to <code>BIS_fnc_taskSetState</code>.",
        example: '["CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED"]'
    },

    "EP_WP_TYPES": {
        description: "Valid waypoint types for <code>setWaypointType</code>. Used by ep_fnc_addWaypoint.",
        example:
            '["MOVE","DESTROY","GETIN","SAD","JOIN","LEADER","GETOUT","CYCLE",\n' +
            ' "LOAD","UNLOAD","TR UNLOAD","HOLD","SENTRY","GUARD","TALK","SCRIPTED",\n' +
            ' "SUPPORT","GETIN NEAREST","DISMISS","LOITER","HOOK","UNHOOK"]'
    },

    "EP_BEHAVIOURS": {
        description: "AI combat behaviour modes. Used by ep_fnc_setAIMode and ep_fnc_addWaypoint.",
        example: '["CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"]'
    },

    "EP_FORMATIONS": {
        description: "Group formations for <code>setFormation</code> / <code>setWaypointFormation</code>.",
        example: '["COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"]'
    },

    "EP_SPEED_MODES": {
        description: "Speed modes for <code>setSpeedMode</code> / <code>setWaypointSpeed</code>.",
        example: '["LIMITED", "NORMAL", "FULL", "UNCHANGED"]'
    },

    "EP_COMBAT_MODES": {
        description: "Combat modes (rules of engagement) for <code>setCombatMode</code> / <code>setUnitCombatMode</code>.",
        example: '["BLUE", "GREEN", "WHITE", "YELLOW", "RED"]'
    },

    "EP_UNIT_POSITIONS": {
        description: "Unit stance values for <code>setUnitPos</code>.",
        example: '["AUTO", "DOWN", "MIDDLE", "UP"]'
    }

});
