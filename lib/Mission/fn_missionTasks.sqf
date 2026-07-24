#include "..\constants.hpp";

if (_this isEqualType []) then {
	private _taskID = _this deleteAt 0;
	{

		if (_x isEqualType 'string') then {
			switch(_x) do {
				case (toLower _x) in EP_TASK_ICONS	: [_taskID, (toLower _x)] call bis_fnc_taskSetType;
				case (toUpper _x) in EP_TASK_STATES	: [_taskID, (toUpper _X)] call bis_fnc_taskSetState;

				default	{ systemChat (format ['ep_fnc_missionTasks: %1 is not a valid parameter!', _x]) };
			};
		};
		
		if (_x isEqualType []) then {
			[_taskID, _x] call bis_fnc_taskSetDestination;
		};

	} forEach _this;
} else {
	_this call bis_fnc_missionTasks;
};

_taskID