#define EP_TASK_ICONS \
	["airdrop", "attack", "danger", "defend", "destroy", "download", "exit", "getin", "getout", "heal", "interact", "kill", \
	 "land", "listen", "meet", "move", "move1", "move2", "move3", "move4", "move5", "navigate", "rearm", "refuel", "repair", \
	"run", "scout", "search", "takeoff", "talk", "talk1", "talk2", "talk3", "talk4", "talk5", "target", "unknown", "upload", \
	"use", "wait", "walk", "armor", "backpack", "boat", "box", "car", "container", "documents", "heli", "intel", "map", "mine", \
	"plane", "radio", "rifle", "truck", "whiteboard","a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", \
	"p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
	
#define EP_TASK_STATES ["CREATED", "ASSIGNED", "SUCCEEDED", "FAILED", "CANCELED"]


private _taskID = nil;
if (_this isEqualType []) then {
	_taskID = _this deleteAt 0;
	{

		if (_x isEqualType "") then {
			if ((toLower _x) in EP_TASK_ICONS)	then { [_taskID, (toLower _x)] call BIS_fnc_taskSetType; continue };
			if ((toUpper _x) in EP_TASK_STATES) then { [_taskID, (toUpper _x)] call BIS_fnc_taskSetState; continue };

			if (true) exitWith { systemChat (format ["EP_fnc_missionTasks: %1 is not a valid parameter!", _x]) };
		};
		
		if (_x isEqualType []) then { [_taskID, _x] call BIS_fnc_taskSetDestination; continue };

	} forEach _this;
} else {
	_taskID = _this;
	_taskID call BIS_fnc_missionTasks;
};

_taskID