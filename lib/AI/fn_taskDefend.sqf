params [
	"_group",
	["_destination", 0],
	["_radius", 100],
	["_threshold", 3],
	["_patrol", 0.1],
	["_hold", 0]
];

_group = _group call ep_fnc_getGroup;

if (_destination isEqualType 0) then {
	_destination = _group call ep_fnc_getPosition;
} else {
	_destination = _destination call ep_fnc_getPosition;
};

[_group, _destination, _radius, _threshold, _patrol, _hold] call cba_fnc_taskDefend;
