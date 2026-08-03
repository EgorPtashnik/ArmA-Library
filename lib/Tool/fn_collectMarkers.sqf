params [
	"_markerPrefix",
	["_returnPositionArray", false]
];

// private _MAX_MARKERS = 128;
private _array = [];
private ["_markerName", "_markerPos"];

for "_i" from 1 to 128 do {
	_markerName = format ["%1_%2", _markerPrefix, _i];
	_markerPos = _markerName call ep_fnc_getPosition;

	if ((_markerPos # 0) == 0) exitWith {};

	if (_returnPositionArray) then {
		_array append [_markerPos];
	} else {
		_array append [_markerName];
	};
};

_array
