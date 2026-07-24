#include "..\constants.hpp";

private _target = _this deleteAt 0;
private _isGroup = false;

switch (typeName _target) do {
	case "GROUP"	:
	case "OBJECT"	: { _target = _target call ep_fnc_getGroup; _isGroup = true };
	case "ARRAY"	: { _target = _target };
	default 		  { systemChat (format ["ep_fnc_setAIMode: %1 is not a valid parameter!", _position]) };
};

if (_isGroup) then {
	{
		if (_x isEqualType "string") then {
			_x = toUpper _x;

			if (_x in EP_BEHAVIOURS) 	then { _target setCombatBehaviour _x; continue };
			if (_x in EP_FORMATIONS) 	then { _target setFormation _x; continue };
			if (_x in EP_SPEED_MODES)	then { _target setSpeedMode _x; continue };
			if (_x in EP_COMBAT_MODES)	then { _target setCombatMode _x; continue };
		}

		if (_x isEqualType []) 			then { _target setGroupId _x; continue };

		if (true) exitWith { systemChat (format ["ep_fnc_setAIMode: %1 is not a valid parameter for group!", _x]) }; 

	} forEach _this;
} else {
	{
		private _val = toUpper _x;

		if (_x isEqualType "string") then {
			_val = toUpper _val;
			if (_val in EP_BEHAVIOURS)		then { {_x setBehaviour _val} forEach _target; continue };
			if (_val in EP_COMBAT_MODES)	then { {_x setUnitCombatMode _val} forEach _target; continue };
			if (_val in EP_UNIT_POSITIONS)	then { {_x setUnitPos _val} forEach _target; continue };
		}

		if (_val isEqualType 1) 			then { {_x limitSpeed _val} forEach _target; continue };
		if (_val isEqualType []) 			then { {_x enableAIFeature [_val # 0, _val # 1]} forEach _target; continue };

		if (true) exitWith { systemChat (format ["ep_fnc_setAIMode: %1 is not a valid parameter for unit!", _x]) };

	} forEach _this;
};

_target