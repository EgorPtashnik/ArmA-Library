params [
	"_group",
	["_destination", 0],
	["_setOnRoute", false],
	["_radius", 100],
	["_count", 3]
];

if !(_this isEqualType []) then {
	_this = [_this];
};

private _args = _this - [_group, _destination, _setOnRoute, _radius, _count];
_group = _group call ep_fnc_getGroup;

if (_setOnRoute) then {

	if !(_destination isEqualType "") exitWith { systemChat "ep_fnc_taskPatrol: Destination parameter must be marker name string!" };

	private _routePositions = [_destination, true] call ep_fnc_collectMarkers;
	private _override = true;
	private _overrideIndex = _args findIf { _x isEqualType true };

	if (_overrideIndex != -1) then { _override = _args deleteAt _overrideIndex };

	if (_override) then {
		_group call ep_fnc_clearWaypoints;
		{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;
	};

	{ ([_group, _x, "LIMITED", "SAFE"] + _args) call ep_fnc_addWaypoint } forEach _routePositions;
	// Close the patrol loop
	private _cyclePosition = _routePositions # 0;
	[_group, _cyclePosition, "CYCLE"] call ep_fnc_addWaypoint;

} else {

	if (_destination isEqualType 0) then {
		_destination = _group call ep_fnc_getPosition;
	} else {
		_destination = _destination call ep_fnc_getPosition;
	};

	private _override = true;
	private _overrideIndex = _args findIf { _x isEqualType true };

	if (_overrideIndex != -1) then { _override = _args deleteAt _overrideIndex };

	if (_override) then {
		_group call ep_fnc_clearWaypoints;
		{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;
	};

	// Using angles create better patrol patterns
	// Also fixes weird editor bug where all WP are on same position
	private _step = 360 / _count;
	private _offset = random _step;

	private ["_rad", "_theta"];
	for "_i" from 1 to _count do {
		// Gaussian distribution avoids all waypoints ending up in the center
		_rad = _radius * random [0.1, 0.75, 1];
		// Alternate sides of circle & modulate offset
		_theta = (_i % 2) * 180 + sin (deg (_step * _i)) * _offset + _step * _i;

		([_group, (_destination getPos [_rad, _theta]), "LIMITED", "SAFE"] + _args) call ep_fnc_addWaypoint;
	};
	// Close the patrol loop
	[_group, _destination, _radius, "CYCLE"] call ep_fnc_addWaypoint;

};

