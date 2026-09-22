/* ----------------------------------------------------------------------------
Function: EP_fnc_setInsidePosition

Description:
    Positions an AI unit inside a nearby building. The unit will attempt to face windows (if possible) and kneel if on a roof.

Parameters:
    1. Unit to position: <OBJECT>

Returns:
    <BOOL> : TRUE if executed

Example:
    EP_Unit call EP_fnc_setInsidePosition

---------------------------------------------------------------------------- */
params ["_unit"];

private _nearBuildings = nearestObjects [_unit, ["BagBunker_base_F", "HouseBase"], 50];
if (count _nearBuildings) exitWith {false};

private _targetBuilding = _nearBuildings # 0;
private _inside = [_unit, 0, 0, 25] call EP_fnc_isFacingWall;
private _isFacingWall = false;
private _dirToBuilding = _unit getRelDir _targetBuilding;
private _unitDir = _dirToBuilding - 180;

if !(_inside) then {
	_unit setUnitPos "MIDDLE";
	_isFacingWall = [_unit, _unitDir] call EP_fnc_isFacingWall;
} else {
	_unit setUnitPos "UP";
	_isFacingWall = [_unit, getDir _unit] call EP_fnc_isFacingWall;
};

if (_isFacingWall) then {

	// First check if there's a window nearby
	for "_i" from 0 to 360 step 5 do {
		if !([_unit, _i] call EP_fnc_isFacingWall) exitWith {
			_unitDir = _i;
			_isFacingWall = false;
		};
	};

	// If still no good facing was good, simply set the unit to face inward
	if (_isFacingWall) then {
		_unitDir = _dirToBuilding;
	};
};

_unit doWatch (_unit getPos [20, _unitDir]);

true