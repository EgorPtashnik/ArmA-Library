private _group = _this deleteAt 0;
private _destination = _this deleteAt 0;
private _override = true;

_group = _group call ep_fnc_getGroup;
_destination = _destination call ep_fnc_getPosition;

private _overrideIndex = _this findIf { _x isEqualType true };
if (_overrideIndex != -1) then { _override = _this deleteAt _overrideIndex };

if (_override) then {
	_group call ep_fnc_clearWaypoints;
	{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;
};

private _waypoint = ([_group, _destination, "SAD", "COMBAT", "RED", -1] + _this) call ep_fnc_addWaypoint;

_waypoint
