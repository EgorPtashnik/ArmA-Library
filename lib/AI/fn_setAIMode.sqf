#include "..\constants.hpp";

params [
	"_target"
];

private _args = _this - [_target];
private _isGroup = false;

switch (typeName _target) do {
	case "GROUP"	: { _target = _target call EP_fnc_getGroup; _isGroup = true };
	case "OBJECT"	: { _target = [_target] };
	case "ARRAY"	: { _target = _target };
	default 		  { _target = nil; };
};

if (isNil "_target") exitWith {
	systemChat "EP_fnc_setAIMode: Reference object is not a valid parameter!";
};

if (_isGroup) then {
	{
		if (_x isEqualType "") then {
			_x = toUpper _x;

			if (_x in EP_BEHAVIOURS) 	then { _target setCombatBehaviour _x; continue };
			if (_x in EP_FORMATIONS) 	then { _target setFormation _x; continue };
			if (_x in EP_SPEED_MODES)	then { _target setSpeedMode _x; continue };
			if (_x in EP_COMBAT_MODES)	then { _target setCombatMode _x; continue };
		};

		if (_x isEqualType []) 			then { _target setGroupId _x; continue };

		if (true) exitWith { systemChat (format ["EP_fnc_setAIMode: %1 is not a valid parameter for group!", _x]) };

	} forEach _args;
} else {
	{
		private _val = _x;

		if (_val isEqualType "") then {
			_val = toUpper _val;
			if (_val in EP_BEHAVIOURS)		then { {_x setBehaviour _val} forEach _target; continue };
			if (_val in EP_COMBAT_MODES)	then { {_x setUnitCombatMode _val} forEach _target; continue };
			if (_val in EP_UNIT_POSITIONS)	then { {_x setUnitPos _val} forEach _target; continue };
		};

		if (_val isEqualType 1) 			then { {_x limitSpeed _val} forEach _target; continue };
		if (_val isEqualType []) 			then { {_x enableAIFeature [_val # 0, _val # 1]} forEach _target; continue };

		if (true) exitWith { systemChat (format ["EP_fnc_setAIMode: %1 is not a valid parameter for unit!", _x]) };

	} forEach _args;
};

_target
