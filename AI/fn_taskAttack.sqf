private _group = _this # 0;
private _destination = _this # 1;
private _parameters = _this - [_group, _destination];
private _override = true;

_group = _group call ep_fnc_getGroup;
_destination = _destination call ep_fnc_getPosition;

private _overrideIndex = _parameters findIf { _x isEqualType true };
if (_overrideIndex != -1) then { _override = _parameters deleteAt _overrideIndex };

if (_override) {
	_group call ep_fnc_clearWaypoints;
	{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;
};

if (count _parameters == 0) then { _parameters = ["SAD", "COMBAT", "RED", -1] };

private _waypoint = [_group, _destination, _parameters] call ep_fnc_addWaypoint;

_waypoint
