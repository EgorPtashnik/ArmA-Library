//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_group",
	"_destination"
];

private _args = _this - [_group, _destination];

_group = _group call EP_fnc_getGroup;
_destination = _destination call EP_fnc_getPosition;

_group call EP_fnc_clearWaypoints;
{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;

private _waypoint = ([_group, _destination, "SAD", "COMBAT", "RED", -1] + _args) call EP_fnc_addWaypoint;

_waypoint
