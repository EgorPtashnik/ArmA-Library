/* ----------------------------------------------------------------------------
Function: EP_fnc_missionTasks

Description:
    Wrapper around the BIS task functions. Given an array, updates an existing
    task's type/state/destination based on the type of each trailing argument.
    Given anything else, forwards the parameter directly to BIS_fnc_missionTasks.

Parameters:
    0: _this (Array or Anything) - When an Array: [TaskID, ...updates], where each
        trailing update is one of:
        - Task icon (String) - Must be a valid task icon name, via BIS_fnc_taskSetType.
        - Task state (String) - "CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED", via BIS_fnc_taskSetState.
        - Destination (Array/Position) - via BIS_fnc_taskSetDestination.
        - Success flag (Boolean) - Sets state to "SUCCEEDED" or "FAILED".
        When not an Array: forwarded as-is to BIS_fnc_missionTasks.

Example:
    ["task1", "attack", getMarkerPos "mk_obj", true] call EP_fnc_missionTasks

Returns:
    String - The task ID.
---------------------------------------------------------------------------- */

//Constats
private _taskIcons = [
	"airdrop", "attack", "danger", "defend", "destroy", "download", "exit", "getin", "getout", "heal", "interact", "kill",
	"land", "listen", "meet", "move", "move1", "move2", "move3", "move4", "move5", "navigate", "rearm", "refuel", "repair",
	"run", "scout", "search", "takeoff", "talk", "talk1", "talk2", "talk3", "talk4", "talk5", "target", "unknown", "upload",
	"use", "wait", "walk", "armor", "backpack", "boat", "box", "car", "container", "documents", "heli", "intel", "map", "mine",
	"plane", "radio", "rifle", "truck", "whiteboard","a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
	"p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
];
private _taskStates = ["CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED"];

//Function
private _taskID = nil;
if (_this isEqualType []) then {
	_taskID = _this deleteAt 0;
	{

		if (_x isEqualType "") then {
			if ((toLower _x) in _taskIcons)	then { [_taskID, (toLower _x)] call BIS_fnc_taskSetType; continue };
			if ((toUpper _x) in _taskStates) then { [_taskID, (toUpper _x)] call BIS_fnc_taskSetState; continue };

		};
		
		if (_x isEqualType []) 		then { [_taskID, _x] call BIS_fnc_taskSetDestination; continue };
		if (_x isEqualType true) 	then {
			private _state = "FAILED";
			if (_x) then {
				_state = "SUCCEEDED";
			};
			[_taskID, _state] call BIS_fnc_taskSetState;
			continue
		};

		if (true) exitWith { systemChat (format ["EP_fnc_missionTasks: %1 is not a valid parameter!", _x]) };

	} forEach _this;
} else {
	_taskID = _this;
	_taskID call BIS_fnc_missionTasks;
};

_taskID