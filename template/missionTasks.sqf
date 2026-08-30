case "taskID": {
	[_taskID, "move"] call EP_fnc_missionTasks;
    [
        player,
        _taskID,
        ["DESCRIPTION.", "TITLE"],
        objNull,
        true
    ] call BIS_fnc_taskCreate;
};
