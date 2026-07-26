params [
	"_markerPrefix",
	["_returnPositionArray", false]
];

// private _MAX_MARKERS = 128;
private _array = [];
private _markerName = nil;
private _markerPos = nil;
for "_i" from 1 to 128 do {
	_markerName = format ["%1%2", _markerPrefix, _i];
	_markerPos = getMarkerPos _markerName;

	if ((_markerPos # 0) == 0) exitWith {};

	if (_returnPositionArray) then {
		_array append _markerPos;
	} else {
		_array append _markerName;
	};
};

_array
