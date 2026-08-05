#include "..\constants.hpp";

private _taskID = nil;
if (_this isEqualType []) then {
	_taskID = _this deleteAt 0;
	{

		if (_x isEqualType "string") then {
			if ((toLower _x) in EP_TASK_ICONS)	then { [_taskID, (toLower _x)] call bis_fnc_taskSetType; continue };
			if ((toUpper _x) in EP_TASK_STATES) then { [_taskID, (toUpper _x)] call bis_fnc_taskSetState; continue };

			if (true) exitWith { systemChat (format ["ep_fnc_missionTasks: %1 is not a valid parameter!", _x]) };
		};
		
		if (_x isEqualType []) then { [_taskID, _x] call bis_fnc_taskSetDestination; continue };

	} forEach _this;
} else {
	_taskID = _this;
	_taskID call bis_fnc_missionTasks;
};

_taskID