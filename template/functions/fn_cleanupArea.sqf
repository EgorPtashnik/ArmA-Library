//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_position",
	"_radius",
	["_execCounter", 0]
];

if (_execCounter > 10) exitWith {
	systemChat "EP_fnc_cleanupArea: Too many executions";
};

_execCounter = _execCounter + 1;

if !(_radius isEqualType 0) exitWith {};

_position = _position call EP_fnc_getPosition;

private _toDelete = nearestObjects [_position, [], _radius, true];
private _repeat = (_toDelete findIf { count crew _x > 0 } != -1);
{ deleteVehicle _x } forEach _toDelete;

if (_repeat) then {
	[_position, _radius, _execCounter] call EP_fnc_cleanupArea;
};