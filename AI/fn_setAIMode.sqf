private _target = _this deleteAt 0;
private _isGroup = false;

private _BEHAVIOUR = ["CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"];
private _FORMATION = ["COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
private _SPEED = ["LIMITED", "NORMAL", "FULL", "UNCHANGED"];
private _COMBAT_MODE = ["BLUE", "GREEN", "WHITE", "YELLOW", "RED"];
private _UNIT_POS = ["AUTO", "DOWN", "MIDDLE", "UP"];

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

			if (_x in _BEHAVIOUR) 	then { _target setCombatBehaviour _x; continue };
			if (_x in _FORMATION) 	then { _target setFormation _x; continue };
			if (_x in _SPEED)		then { _target setSpeedMode _x; continue };
			if (_x in _COMBAT_MODE)	then { _target setCombatMode _x; continue };
		}

		if (_x isEqualType []) 		then { _target setGroupId _x; continue };

		if (true) exitWith { systemChat (format ["ep_fnc_setAIMode: %1 is not a valid parameter for group!", _x]) }; 

	} forEach _this;
} else {
	{
		private _val = toUpper _x;

		if (_x isEqualType "string") then {
			_val = toUpper _val;
			if (_val in _BEHAVIOUR)		then { {_x setBehaviour _val} forEach _target; continue };
			if (_val in _COMBAT_MODE)	then { {_x setUnitCombatMode _val} forEach _target; continue };
			if (_val in _UNIT_POS)		then { {_x setUnitPos _val} forEach _target; continue };
		}

		if (_val isEqualType 1) 		then { {_x limitSpeed _val} forEach _target; continue };
		if (_val isEqualType []) 		then { {_x enableAIFeature [_val # 0, _val # 1]} forEach _target; continue };

		if (true) exitWith { systemChat (format ["ep_fnc_setAIMode: %1 is not a valid parameter for unit!", _x]) };

	} forEach _this;
};
