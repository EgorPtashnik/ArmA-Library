/* ----------------------------------------------------------------------------
Function: EP_fnc_setAIMode

Description:
    Sets various AI behaviours, formations, and combat modes for a group or unit.

Parameters:
    0: _target (Group, Object, or Array) - Group or unit(s) to configure.
    
    Optional (trailing arguments):
    - Behaviour (String) - "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"
    - Formation (String) - "COLUMN", "WEDGE", etc.
    - Speed (String) - "LIMITED", "NORMAL", "FULL"
    - Combat Mode (String) - "BLUE", "RED", etc.
    - Unit Position (String) - "AUTO", "DOWN", "MIDDLE", "UP" (Units only)
    - Group ID (Array) - [String] (Groups only)
    - Delete When Empty (Boolean) - true/false (Groups only)
    - Limit Speed (Scalar) - Max speed (Units only)
    - AI Feature (Array) - [String, Boolean] e.g., ["ANIM", false]

Example:
    [group player, "COMBAT", "WEDGE", "RED"] call EP_fnc_setAIMode

Returns:
    Array of Objects or Group - Target which received update.
---------------------------------------------------------------------------- */

//************************************************************************************************************
// CONSTANTS
//************************************************************************************************************

private _behaviours 	= [ "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH" ];
private _formations		= [ "COLUMN", "STAG COLUMNS", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND" ];
private _speedModes		= [ "LIMITED", "NORMAL", "FULL", "UNCHANGED" ];
private _combatModes 	= [ "BLUE", "GREEN", "WHITE", "YELLOW", "RED" ];
private _unitPositions	= ["AUTO", "DOWN", "MIDDLE", "UP"];

//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

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

			if (_x in _behaviours) 	then { _target setCombatBehaviour _x; continue };
			if (_x in _formations) 	then { _target setFormation _x; continue };
			if (_x in _speedModes)	then { _target setSpeedMode _x; continue };
			if (_x in _combatModes)	then { _target setCombatMode _x; continue };
		};

		if (_x isEqualType []) 		then { _target setGroupId _x; continue };
		if (_x isEqualType true)	then { _target deleteGroupWhenEmpty true; continue };

		if (true) exitWith { systemChat (format ["EP_fnc_setAIMode: %1 is not a valid parameter for group!", _x]) };

	} forEach _args;
} else {
	{
		private _val = _x;

		if (_val isEqualType "") then {
			_val = toUpper _val;
			if (_val in _behaviours)	then { {_x setBehaviour _val} forEach _target; continue };
			if (_val in _combatModes)	then { {_x setUnitCombatMode _val} forEach _target; continue };
			if (_val in _unitPositions)	then { {_x setUnitPos _val} forEach _target; continue };
		};

		if (_val isEqualType 1) 		then { {_x limitSpeed _val} forEach _target; continue };
		if (_val isEqualType []) 		then { {_x enableAIFeature [_val # 0, _val # 1]} forEach _target; continue };

		if (true) exitWith { systemChat (format ["EP_fnc_setAIMode: %1 is not a valid parameter for unit!", _x]) };

	} forEach _args;
};

_target
