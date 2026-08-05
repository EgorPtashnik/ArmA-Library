case "Sample": {
    [_taskID, "defend", getPos player] call ep_fnc_missionTasks;

    [
        player,
        _taskID,
        ["<Task description>", "<Task title>"],
        objNull,
        true
    ] call BIS_fnc_taskCreate;
};
