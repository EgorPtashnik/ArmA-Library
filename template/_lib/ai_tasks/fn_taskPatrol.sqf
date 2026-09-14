/* ----------------------------------------------------------------------------
Function: EP_fnc_taskPatrol

Description:
    Assigns a patrol to a group, either along a predefined marker route or as
    a circular patrol around a destination point. Existing waypoints are
    cleared by default; pass a Boolean trailing argument (false) to keep them.

Parameters:
    0: _group (Group or Object) - The group to patrol.
    1: _destination (Position, Object, Array, String or Number, optional)
        - When _setOnRoute is false: patrol centre. Defaults to the group's position.
        - When _setOnRoute is true: marker name (String) or array of positions defining the route.
    2: _setOnRoute (Boolean, optional) - Patrol along a predefined route when true. Default false.
    3: _radius (Number, optional) - Patrol radius around the destination. Default 100. Ignored when _setOnRoute is true.
    4: _count (Number, optional) - Number of patrol waypoints to generate. Default 3. Ignored when _setOnRoute is true.
    
    Optional (passed as trailing arguments, forwarded to EP_fnc_addWaypoint):
    - Boolean - Overrides the default "clear existing waypoints" behaviour (pass false to keep existing waypoints).
    - Any additional waypoint parameter supported by EP_fnc_addWaypoint.

Example:
    [patrolGroup, getMarkerPos "objPatrol", false, 150, 5] call EP_fnc_taskPatrol
    [patrolGroup, "mk_patrolRoute", true] call EP_fnc_taskPatrol

Returns:
    Nothing.
---------------------------------------------------------------------------- */

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

_group = _group call EP_fnc_getGroup;

// Patrol on predefined route by markers
if (_setOnRoute) then {

	if !(_destination isEqualType "" || _destination isEqualType []) exitWith { systemChat "EP_fnc_taskPatrol: Destination parameter must be marker name string!" };

	private _routePositions = [];
	if (_destination isEqualType "") then {
		_routePositions = [_destination, true] call EP_fnc_collectMarkers;
	} else {
		_routePositions = _destination;
	};

	private _override = true;
	private _overrideIndex = _args findIf { _x isEqualType true };

	if (_overrideIndex != -1) then { _override = _args deleteAt _overrideIndex };

	if (_override) then {
		_group call EP_fnc_clearWaypoints;
		{ _x enableAI "PATH"; _x enableAI "MOVE" } forEach units _group;
	};

	{
		private _pos = _x call EP_fnc_getPosition;
		([_group, _pos, "LIMITED", "SAFE"] + _args) call EP_fnc_addWaypoint
	} forEach _routePositions;

	// Close the patrol loop
	private _cyclePosition = (_routePositions # 0) call EP_fnc_getPosition;
	[_group, _cyclePosition, "CYCLE"] call EP_fnc_addWaypoint;

} else {

	if (_destination isEqualType 0) then {
		_destination = _group call EP_fnc_getPosition;
	} else {
		_destination = _destination call EP_fnc_getPosition;
	};

	private _override = true;
	private _overrideIndex = _args findIf { _x isEqualType true };

	if (_overrideIndex != -1) then { _override = _args deleteAt _overrideIndex };

	if (_override) then {
		_group call EP_fnc_clearWaypoints;
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

		([_group, (_destination getPos [_rad, _theta]), "LIMITED", "SAFE"] + _args) call EP_fnc_addWaypoint;
	};
	// Close the patrol loop
	[_group, _destination, _radius, "CYCLE"] call EP_fnc_addWaypoint;

};

