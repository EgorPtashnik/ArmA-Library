# ArmA-Library — Project Context

This file gives an AI assistant (or any new contributor) the knowledge needed to work on this
repository without re-reading every file. In a new session, open this file first.

## What is this?

`ArmA-Library` is a personal Arma 3 mission template plus a custom SQF function library.
Library functions are prefixed `EP_` (author "EP"). The `template/` folder is meant to be
copied into a new Arma 3 mission folder and filled in.

## Repository layout

```
ArmA-Library/
├── scripts/          # Standalone gameplay scripts (drop into any mission)
│   ├── Ambient/            # Scene_PlayerWalking.sqf
│   ├── Intro/              # Intro_EstablishingShot.sqf, Intro_SImple.sqf
│   ├── Mechanics/          # Command_AISetupIED.sqf
│   └── _Show Icons Dialog/ # script.sqf
└── template/         # Mission template (copy into a mission folder)
    ├── description.ext
    ├── init.sqf
    ├── initBriefing.sqf
    ├── initMission.sqf
    ├── missionConversations.sqf   # switch-case fragment, paste into triggers
    ├── missionTasks.sqf           # switch-case fragment, paste into triggers
    ├── README.txt
    ├── _lib/          # EP function library (CfgFunctions source)
    └── _sounds/       # .ogg sound files used by conversations
```

## The `_lib` function library

Located in `template/_lib/`, organized by category. Each function is a file named
`fn_<name>.sqf` and is exposed as `EP_fnc_<name>`.

| Folder        | Functions |
|---------------|-----------|
| `ai/`         | addWaypoint, clearWaypoints, setAIMode, setAISkill |
| `ai_tasks/`   | taskArtilleryFire, taskAttack, taskConvoy, taskDefend, taskPatrol |
| `ambient/`    | ambientFlyBy, ambientWarfare |
| `create/`     | createGroup, createGuidedProjectile, createTrigger, createUnit |
| `extensions/` | ext_casualVehicle, ext_healthBar, ext_healthRegen, ext_nvg |
| `get/`        | collectMarkers, collectUnits, collectVariables, getGroup, getPosition, getRandomArray, getRandomPosition, getRandomPositionArea |
| `mission/`    | addAction, addHoldAction, cleanupArea, missionConversations, missionConversationsVO, missionInit, missionTasks, showObjects |

`template/_lib/index.hpp` defines `class EP` inside `CfgFunctions`; each category is a nested
class with `file = "_lib\<category>"` and one empty class per function. `template/_lib/rsc.hpp`
defines the `EP_Subtitles` RscTitle (used by `EP_fnc_missionConversations`).

### Registering a new function
1. Create `template/_lib/<category>/fn_<name>.sqf`.
2. Add `class <name> {};` to the matching category class in `template/_lib/index.hpp`.
3. Call it as `EP_fnc_<name>`.

## Template wiring

- `description.ext` — mission metadata, `CfgDebriefing`, `CfgIdentities`, `CfgFunctions`
  (`#include "_lib\index.hpp"`), `RscTitles` (`#include "_lib\rsc.hpp"`), `CfgSounds`.
- `init.sqf` — includes `initBriefing.sqf` and `initMission.sqf`.
- `initBriefing.sqf` — creates Diary records (Callsigns, Execution, Situation, Mission).
- `initMission.sqf` — optional PP effects (commented out) and mission init
  (`[[east, []], [west, []], [resistance, []]] call EP_fnc_missionInit;`).
- `missionConversations.sqf` — a `case "C_1": { ... }` fragment for the conversation trigger;
  calls `EP_fnc_missionConversations` with `[ [speaker, text, duration, color, sound], ... ]`.
- `missionTasks.sqf` — a `case "taskID": { ... }` fragment; calls `EP_fnc_missionTasks` to
  update a task and `BIS_fnc_taskCreate` to create it.

### Key functions
- `EP_fnc_missionInit` — applies AI skill per side, sets `deleteGroupWhenEmpty`, initializes
  `EP_SimpleTriggers` / `EP_Triggers`.
- `EP_fnc_missionConversations` — plays subtitled conversations. Params:
  `[ [speaker, text, duration, color(0-8 or hex), sound], ... ]`, `[isRadio]`.
  Uses `EP_Subtitles` display (idc 101) and `playSoundUI`. When called with a non-array it
  spawns `BIS_fnc_missionConversations` and returns the script handle.
- `EP_fnc_missionTasks` — wraps `BIS_fnc_taskCreate/SetType/SetState`. Params:
  `[taskID, "icon", "STATE", [destination], bool]` — strings matching task icon names or
  CREATED/ASSIGNED/SUCCEEDED/FAILED/CANCELED, arrays become destination, bool sets
  SUCCEEDED/FAILED. Returns taskID.
- `EP_fnc_addAction` — wrapper around `addAction` with sane defaults.
- `EP_fnc_addWaypoint` — wrapper around group waypoints; extra args set
  type/behaviour/combat mode/formation/speed/statements/timeout/completionRadius/visible.

## Sounds

`template/_sounds/` contains `beep.ogg`, `in1..6.ogg`, `noise1..4.ogg`. Registered in
`description.ext` → `CfgSounds` as `mybeep`, `myin1`..`myin6`, `mynoise1`..`mynoise4`.
Used by `EP_fnc_missionConversations` via `playSoundUI`.

## Conventions & gotchas

- Function naming: `EP_fnc_<name>`; files `fn_<name>.sqf`; registered in `index.hpp`.
- Errors are reported with `systemChat (format ["EP_fnc_<name>: ...", _x])` and `exitWith`.
- `EP_fnc_showSubtitles` is **deprecated/removed** — use `EP_fnc_missionConversations`.
- The library lives in `_lib` (not the old `_functions`); `description.ext` must include
  `_lib\index.hpp` and `_lib\rsc.hpp`.
- Header comments in each fn file use `//****...` blocks (CONSTANTS / FUNCTION sections).
- Indentation: tabs inside function bodies, spaces in `description.ext`.
