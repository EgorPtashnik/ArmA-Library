/**
 * Function docs — Mission category.
 */
ArmADocs.register("Mission", {

    "ep_fnc_missionInit": {
        description: "Applies default AI skill settings per side. Input is an array of <code>[side, params]</code> pairs, " +
                     "where <code>params</code> is a flat key/value array (converted to a HashMap internally). " +
                     "Missing keys fall back to the EP_MISSION_DEFAULT_* constants. Also enables filmGrain and " +
                     "a colorCorrections post-process effect.",
        syntax: "[[side, params], ...] call ep_fnc_missionInit",
        params: [
            { name: "side",   type: "Side",  desc: "Side to configure (west, east, resistance, civilian)." },
            { name: "params", type: "Array", desc: "Flat key/value pairs. Keys: SKILL, AIM, AIM_SHAKE, AIM_SPEED, SPOT, SPOT_TIME, COURAGE, RELOAD, COMMAND, FLEEING." }
        ],
        example:
            '[\n' +
            '    [east,       ["SKILL", 0.7, "AIM", 0.3, "COURAGE", 1]],\n' +
            '    [resistance, ["SKILL", 0.4, "FLEEING", 0.5]]\n' +
            '] call ep_fnc_missionInit;'
    },

    "ep_fnc_missionIntro": {
        description: "Plays a cinematic intro: <code>BIS_fnc_establishingShot</code> at the given position followed by " +
                     "<code>BIS_fnc_EXP_camp_SITREP</code>. Blocking — waits for both to finish.",
        syntax: "[estShotPos, estShotParams?, introTexts?] call ep_fnc_missionIntro",
        params: [
            { name: "estShotPos",    type: "Position | Object | Group | String", desc: "Any value accepted by ep_fnc_getPosition — the camera target." },
            { name: "estShotParams", type: "Array (optional)",                   desc: "Extra arguments appended after the position. Default <code>[worldName, 500, 200, random 360]</code>." },
            { name: "introTexts",    type: "Array (optional)",                   desc: "Passed to BIS_fnc_EXP_camp_SITREP. Default <code>[worldName, groupId group player]</code>." }
        ],
        example: '"marker_intro" call ep_fnc_missionIntro;\n' +
                 '["marker_intro", [worldName, 800, 250, 45], ["Chernarus 2035", "Task Force Yankee"]] call ep_fnc_missionIntro;'
    },

    "ep_fnc_missionTasks": {
        description: "Task manager wrapper. In array form applies task metadata to an existing task; in single-value form " +
                     "delegates to <code>BIS_fnc_missionTasks</code>. Strings matching EP_TASK_ICONS set the task type, " +
                     "strings matching EP_TASK_STATES set the state, arrays are treated as destinations.",
        syntax: "[taskID, ...properties] call ep_fnc_missionTasks\n" +
                "value call ep_fnc_missionTasks   // passthrough to BIS_fnc_missionTasks",
        params: [
            { name: "taskID",        type: "String",                 desc: "Existing task id." },
            { name: "...properties", type: "String | Array",         desc: "Icon name (from EP_TASK_ICONS), state (from EP_TASK_STATES), or a position array." }
        ],
        example: '["task_1", "created", getPos player, "destroy"] call ep_fnc_missionTasks;\n' +
                 '["task_1", "succeeded"] call ep_fnc_missionTasks;'
    },

    "ep_fnc_showSubtitles": {
        description: "Plays a list of subtitles with optional radio SFX (open/close beeps, background noise, teletype typing). " +
                     "Non-blocking — spawns internally.",
        syntax: "[subtitles, lastTiming?, isRadio?, radioSoundIn?, radioSoundOut?] call ep_fnc_showSubtitles",
        params: [
            { name: "subtitles",     type: "Array",              desc: "Array of <code>[title, subtitle, duration]</code> entries." },
            { name: "lastTiming",    type: "Number (optional)",  desc: "Extra hold time after the last subtitle. Default 5." },
            { name: "isRadio",       type: "Boolean (optional)", desc: "Enables radio SFX (beeps, noise, typing). Default true." },
            { name: "radioSoundIn",  type: "String (optional)",  desc: "Sound played at radio open. Default EP_DEFAULT_SOUND_IN." },
            { name: "radioSoundOut", type: "String (optional)",  desc: "Sound played at radio close. Default EP_DEFAULT_SOUND_OUT." }
        ],
        example:
            '[\n' +
            '    [["HQ", "Move to the extraction point.", 4]],\n' +
            '    3, true\n' +
            '] call ep_fnc_showSubtitles;'
    }

});
