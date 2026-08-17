/**
 * Function docs — Constants category.
 * Preprocessor macros defined in lib/constants.hpp. #include the header
 * at the top of any function file that needs them.
 *
 * Entries are grouped by the token following the `EP_` prefix so related
 * constants render together in the sidebar.
 */
ArmADocs.register("Constants", {

    // -----------------------------------------------------------------------
    // AI Mode
    // -----------------------------------------------------------------------
    "EP_BEHAVIOURS": {
        group: "AI Mode",
        description: "AI combat behaviour modes. Used by EP_fnc_setAIMode and EP_fnc_addWaypoint.",
        example: '["CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"]'
    },

    "EP_COMBAT_MODES": {
        group: "AI Mode",
        description: "Combat modes (rules of engagement) for <code>setCombatMode</code> / <code>setUnitCombatMode</code>.",
        example: '["BLUE", "GREEN", "WHITE", "YELLOW", "RED"]'
    },

    "EP_FORMATIONS": {
        group: "AI Mode",
        description: "Group formations for <code>setFormation</code> / <code>setWaypointFormation</code>.",
        example: '["COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"]'
    },

    "EP_SPEED_MODES": {
        group: "AI Mode",
        description: "Speed modes for <code>setSpeedMode</code> / <code>setWaypointSpeed</code>.",
        example: '["LIMITED", "NORMAL", "FULL", "UNCHANGED"]'
    },

    "EP_UNIT_POSITIONS": {
        group: "AI Mode",
        description: "Unit stance values for <code>setUnitPos</code>.",
        example: '["AUTO", "DOWN", "MIDDLE", "UP"]'
    },

    // -----------------------------------------------------------------------
    // Create
    // -----------------------------------------------------------------------
    "EP_CREATE_UNIT_SPECIAL_TYPES": {
        group: "Create",
        description: "Valid values for the <code>special</code> placement flag of <code>createUnit</code>. Consumed by EP_fnc_createUnit when a matching string is passed in <code>...properties</code>.",
        example: '["NONE", "CAN_COLLIDE", "CARGO"]'
    },

    // -----------------------------------------------------------------------
    // Task
    // -----------------------------------------------------------------------
    "EP_TASK_ICONS": {
        group: "Task",
        description: "All task icon names accepted by <code>EP_fnc_missionTasks</code>. Matched case-insensitively.",
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
        group: "Task",
        description: "Valid task states passed to <code>BIS_fnc_taskSetState</code>.",
        example: '["CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED"]'
    },

    // -----------------------------------------------------------------------
    // Subtitles — used by EP_fnc_showSubtitles for radio SFX.
    // -----------------------------------------------------------------------
    "EP_SUBTITLES_DEFAULT_SOUND_IN": {
        group: "Subtitles",
        description: "Default sound played when the radio opens (<code>radioSoundIn</code> parameter of EP_fnc_showSubtitles). Must be a class name defined in the mission's <code>description.ext</code> under <code>CfgSounds</code>.",
        example: '"myin1"'
    },

    "EP_SUBTITLES_DEFAULT_SOUND_OUT": {
        group: "Subtitles",
        description: "Default sound played when the radio closes (<code>radioSoundOut</code> parameter of EP_fnc_showSubtitles). Must be a class name defined in the mission's <code>description.ext</code> under <code>CfgSounds</code>.",
        example: '"myin4"'
    },

    "EP_SUBTITLES_SOUNDS_NOISES": {
        group: "Subtitles",
        description: "Class names of background radio-noise loops played between subtitle lines. A random entry is picked every 5 seconds while the radio is open.",
        example: '["mynoise1", "mynoise2", "mynoise3"]'
    },

    "EP_SUBTITLES_SOUNDS_TYPING": {
        group: "Subtitles",
        description: "Class names of teletype keystroke SFX played on top of each subtitle line to simulate typing.",
        example: '["gm_rtty_stroke_01", "gm_rtty_stroke_02", "gm_rtty_stroke_03"]'
    },

    "EP_SUBTITLES_SOUNDS_TYPING_TIMINGS": {
        group: "Subtitles",
        description: "Pool of inter-keystroke delays (in seconds) picked at random between each typing SFX. Larger values produce slower, more varied typing.",
        example: '[0.06, 0.06, 0.06, 0.1, 0.3, 0.5]'
    },

    // -----------------------------------------------------------------------
    // Trigger — accepted string sets for EP_fnc_createTrigger properties
    // (currently reference material only; the function itself does not yet
    // validate against these lists).
    // -----------------------------------------------------------------------
    "EP_TRIGGER_ACTIAVTION_BY_RADIO": {
        group: "Trigger",
        description: "Radio channel names accepted by <code>setTriggerActivation</code> when the trigger is activated by radio. " +
                     "Note: the macro name contains a typo (<code>ACTIAVTION</code> instead of <code>ACTIVATION</code>) preserved as-is in <code>constants.hpp</code>.",
        example: '["ALPHA", "BRAVO", "CHARLIE", "DELTA", "ECHO", "FOXTROT", "GOLD", "HOTEL", "INDIA", "JULIET"]'
    },

    "EP_TRIGGER_ACTIVATION_BY_OBJECT": {
        group: "Trigger",
        description: "Object-scope values accepted by <code>setTriggerActivation</code> (what kind of source triggers activation).",
        example: '["STATIC", "VEHICLE", "GROUP", "LEADER", "MEMBER"]'
    },

    "EP_TRIGGER_ACTIVATION_BY_SIDES": {
        group: "Trigger",
        description: "Side names accepted as the first argument of <code>setTriggerActivation</code>.",
        example: '["EAST", "WEST", "GUER", "CIV", "LOGIC", "ANY", "ANYPLAYER"]'
    },

    "EP_TRIGGER_ACTIVATION_BY_STATUS": {
        group: "Trigger",
        description: "Sector-status activation types accepted by <code>setTriggerActivation</code> (used by BIS sector modules).",
        example: '["WEST SEIZED", "EAST SEIZED", "GUER SEIZED"]'
    },

    "EP_TRIGGER_ACTIVATION_TYPES": {
        group: "Trigger",
        description: "Activation types accepted as the second argument of <code>setTriggerActivation</code>.",
        example: '["PRESENT", "NOT PRESENT", "WEST D", "EAST D", "GUER D", "CIV D"]'
    },

    // -----------------------------------------------------------------------
    // Waypoint
    // -----------------------------------------------------------------------
    "EP_WP_TYPES": {
        group: "Waypoint",
        description: "Valid waypoint types for <code>setWaypointType</code>. Used by EP_fnc_addWaypoint.",
        example:
            '["MOVE","DESTROY","GETIN","SAD","JOIN","LEADER","GETOUT","CYCLE",\n' +
            ' "LOAD","UNLOAD","TR UNLOAD","HOLD","SENTRY","GUARD","TALK","SCRIPTED",\n' +
            ' "SUPPORT","GETIN NEAREST","DISMISS","LOITER","HOOK","UNHOOK"]'
    }

});
