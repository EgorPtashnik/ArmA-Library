/**
	Get group units or all units of array of groups
	If array of units is provided - just return them

	PARAMETER
		_this 	: GROUP or ARRAY - group | array of groups | array of units
	
	RETURNS
		ARRAY - array of units
	
	EXAMPLE
		(group player) call EP_fnc_getUnits;

	IMPORT
	EP_fnc_getUnits = compile preprocessFileLineNumbers "functions\EP_fnc_getUnits.sqf";
*/

private ["_units"];
switch (typeName _this) do {

	case "GROUP": {
		_units = units _this;
	};

	case "ARRAY": {
		if (typeName (_this select 0) == "GROUP") then {
			_units = [];
			{ _units = _units + (units _x) } forEach _this;
		} else {
			_units = _this;
		};
	};

	default {
		_units = [];
	};

};

_units