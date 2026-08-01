params [
	"_group",
	["_destination", 0],
	["_radius", 100],
	["_count", 3]
];

if !(_this isEqualType []) then {
	_this = [_this];
};

private _args = _this - [_group, _destination, _radius, _count];

_group = _group call ep_fnc_getGroup;

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
private _rad = nil;
private _theta = nil;
for "_i" from 1 to _count do {
    // Gaussian distribution avoids all waypoints ending up in the center
    _rad = _radius * random [0.1, 0.75, 1];
    // Alternate sides of circle & modulate offset
    _theta = (_i % 2) * 180 + sin (deg (_step * _i)) * _offset + _step * _i;

	([_group, (_destination getPos [_rad, _theta]), "LIMITED", "SAFE"] + _args) call ep_fnc_addWaypoint;
};
// Close the patrol loop
[_group, _destination, _radius, "CYCLE"] call ep_fnc_addWaypoint;
