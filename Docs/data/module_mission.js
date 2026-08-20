// ═══════════════════════════════════════════════════════════
//  MODULE: Mission
//  Functions for mission setup, tasks, conversations,
//  subtitles, and object visibility.
// ═══════════════════════════════════════════════════════════

EP_DATA.push(

  {
    id: "fn_missionInit",
    name: "EP_fnc_missionInit",
    module: "Mission",
    desc: "Applies global post-processing (film grain + color grading) and sets AI skill for provided sides. Call once at mission start.",
    params: [
      { name: "_this", type: "Array", optional: false, default: "", desc: "Array of [side, skillParams] pairs." },
    ],
    returns: { type: "Nothing", desc: "" },
    example:
`[
  [east,  [["AIM", 0.25], ["SKILL", 0.5]]],
  [west,  [["AIM", 0.4],  ["SKILL", 0.7]]]
] call EP_fnc_missionInit;`,
  },

  {
    id: "fn_missionTasks",
    name: "EP_fnc_missionTasks",
    module: "Mission",
    desc: "Updates mission tasks. Pass a task ID alone to refresh via BIS_fnc_missionTasks, or pass [taskID, ...params] to set state, icon, destination, or success/fail.",
    params: [
      { name: "_taskID", type: "String", optional: false, default: "", desc: "Task ID from description.ext." },
      { name: "...",     type: "Any",    optional: true,  default: "", desc: "State string (CREATED/ASSIGNED/SUCCEEDED/FAILED/CANCELED); icon string; destination array; true = SUCCEEDED, false = FAILED." },
    ],
    returns: { type: "String", desc: "The task ID." },
    example:
`// Assign task with icon
["task_village", "ASSIGNED", "move"] call EP_fnc_missionTasks;

// Complete with destination marker
["task_village", true, [getMarkerPos "mkrVillage", true, false]] call EP_fnc_missionTasks;

// Fail task
["task_village", false] call EP_fnc_missionTasks;`,
  },

  {
    id: "fn_missionConversations",
    name: "EP_fnc_missionConversations",
    module: "Mission",
    desc: "Plays a radio conversation with speaker names, coloured text, and optional radio sound effects. Renders via a custom RSC display. Each entry: [speaker, text, duration, colorIndex?].",
    params: [
      { name: "_conversation", type: "Array",  optional: false, default: "",      desc: "Array of [speaker, text, duration, colorIndex?] entries." },
      { name: "_isRadio",      type: "Bool",   optional: true,  default: "true",  desc: "Play radio in/out sounds and typing noise." },
      { name: "_radioSoundIn", type: "String", optional: true,  default: "myin1", desc: "Sound classname for radio open." },
      { name: "_radioSoundOut",type: "String", optional: true,  default: "myin4", desc: "Sound classname for radio close." },
    ],
    returns: { type: "Nothing", desc: "" },
    example:
`[
  ["Alpha 1", "Contact, north side of the village!", 4, 2],
  ["Command", "Copy. Hold position.", 5, 5]
] spawn EP_fnc_missionConversations;`,
    notes: "Color index: 0=white, 1=blue, 2=green, 3=red, 4=yellow, 5=BLUFOR, 7=OPFOR, 8=Independent, 9=Civilian. Or pass a hex color string directly.",
  },

  {
    id: "fn_showSubtitles",
    name: "EP_fnc_showSubtitles",
    module: "Mission",
    desc: "Plays a sequence of subtitles using BIS_fnc_EXP_camp_playSubtitles with optional radio sound layering.",
    params: [
      { name: "_subtitles",     type: "Array",  optional: false, default: "",      desc: "Subtitle entries in BIS format [title, text, timing]." },
      { name: "_lastTiming",    type: "Number", optional: true,  default: "5",     desc: "Extra display time after the last subtitle." },
      { name: "_isRadio",       type: "Bool",   optional: true,  default: "true",  desc: "Enhance timings and play radio sounds." },
      { name: "_radioSoundIn",  type: "String", optional: true,  default: "myin1", desc: "Radio open sound." },
      { name: "_radioSoundOut", type: "String", optional: true,  default: "myin4", desc: "Radio close sound." },
    ],
    returns: { type: "Nothing", desc: "" },
    example:
`[
  ["Command", "All units advance.", 3],
  ["Alpha",   "Moving now.",        6]
] call EP_fnc_showSubtitles;`,
  },

  {
    id: "fn_showObjects",
    name: "EP_fnc_showObjects",
    module: "Mission",
    desc: "Shows or hides objects: toggles simulation, visibility, captive state, and damage allowance.",
    params: [
      { name: "_ref",  type: "String | Group | Array | Object", optional: false, default: "",     desc: "Layer name, group, array of objects, or single object." },
      { name: "_show", type: "Bool",                            optional: true,  default: "true", desc: "true = show, false = hide." },
    ],
    returns: { type: "Array", desc: "Array of affected objects." },
    example:
`// Hide reinforcements until needed
["ReinforcementsLayer", false] call EP_fnc_showObjects;

// Reveal on trigger
["ReinforcementsLayer", true] call EP_fnc_showObjects;`,
  },

);
