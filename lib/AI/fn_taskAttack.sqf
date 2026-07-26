params [
	"_group",
	"_destination"
];

private _args = _this - [_group, _destination];

_group = _group call ep_fnc_getGroup;
_destination = _destination call ep_fnc_getPosition;

private _override = true;
private _overrideIndex = _args findIf { _x isEqualType true };

if (_overrideIndex != -1) then { _override = _args deleteAt _overrideIndex };

if (_override) then {
	_group call ep_fnc_clearWaypoints;
	{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;
};

private _waypoint = ([_group, _destination, "SAD", "COMBAT", "RED", -1] + _args) call ep_fnc_addWaypoint;

_waypoint
