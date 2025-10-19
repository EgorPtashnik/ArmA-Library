/**
	Handle tasks base on EP_tasks global variable
	EP_tasks should be in format of task parameters

	PARAMETERS
		_taskId		: STRING - task id
		_newState	: ["CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED"] (Default "SUCCEEDED") - task state to update
		_showHits	: BOOLEAN (Default true) - show hint

	RETURNS
		STRING - task id
	
	EXAMPLE
		["taskMain", "CREATED", true] call EP_fnc_handleTasks;
*/

params [
	"_taskId",
	["_newState", "SUCCEEDED"],
	["_showHint", true]
];

private _taskExists = [_taskId] call BIS_fnc_taskExists;

if (_taskExists) then {
	[_taskId, _newState, _showHint] call BIS_fnc_taskSetState;
} else {
	(EP_tasks get _taskId) call BIS_fnc_taskCreate;
};

_taskId
