/*
 *  Task dispatcher.
 *  Call as:  ["task_id"] call MY_fnc_task;   or   ["task_id", "SUCCEEDED"] call MY_fnc_task;
 *
 *  Task states: "CREATED" | "ASSIGNED" | "SUCCEEDED" | "FAILED" | "CANCELED"
 */

params ["_taskID"];

switch (_taskID) do {

    case "Sample": {
        if (!(_taskID call BIS_fnc_taskExists)) then {
            [
                player,
                _taskID,
                ["<Task description>", "<Task title>"],
                objNull,
                true
            ] call BIS_fnc_taskCreate;

            [_taskID, "defend", getPos player] call ep_fnc_missionTasks;
        } else {
            [_taskID, "SUCCEEDED"] call ep_fnc_missionTasks;
        };
    };

    default {
        systemChat format ["missionTasks: unknown id '%1'", _taskID];
    };
};
