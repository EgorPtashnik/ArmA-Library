/* ----------------------------------------------------------------------------
Function: EP_fnc_setInsidePosition

Description:
    Positions an AI unit inside a nearby building. The unit will attempt to face windows (if possible) and kneel if on a roof.

Parameters:
    _unit (Object) - The unit to position.

Example:
    [myUnit] call EP_fnc_setInsidePosition

Returns:
    Boolean - True if executed.
---------------------------------------------------------------------------- */
private ["_u","_b","_udir","_inside","_facingwall","_dirtob","_dir"];

_u = _this;
_nb = (nearestObjects [_u,["BagBunker_base_F","HouseBase"],50]);

if (count _nb == 0) exitWith {};

_b = _nb select 0;

_inside = [_u,0,0,25] call EP_fnc_isFacingWall;
_facingwall = false;
_dirtob = [_u,_b] call BIS_fnc_RelativeDirTo;
_udir = _dirtob - 180;

// If unit is outside set to kneel and check for wall facing away from building
if !(_inside) then {
	_u setUnitPos "Middle";
	_facingwall = [_u,_udir] call EP_fnc_isFacingWall;
} else {
// Else if unit is inside set position to standing and check for wall from facing of unit
	_u setUnitPos "Up";
	_facingwall = [_u,getDir _u] call EP_fnc_isFacingWall;
};

if (_facingwall) then {

	// First check if there's a window nearby
	for [{_x=0},{_x<=360},{_x=_x+5}] do {
		_dir = _x;
		if !([_u,_dir] call EP_fnc_isFacingWall) exitWith {_udir = _dir;_facingwall = false};
	};

	// If still no good facing was good, simply set the unit to face inward
	if (_facingwall) then {
		_udir = _dirtob;
	};
};

_u doWatch ([_u, 20, _udir] call BIS_fnc_relPos);

true