//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_mrkPrefix",
	["_returnPositionArray", false]
];

// Params check
if !(_mrkPrefix isEqualType "") exitWith {
	systemChat "EP_fnc_collectMarkers: Must give marker prefix as parameter!";
};


// Collect resulting array of markers/positions
private _array = [];
for "_i" from 1 to 128 do {
	private _mrkName = format ["%1_%2", _mrkPrefix, _i];
	private _mrkPos = _mrkName call EP_fnc_getPosition;

	if ((_mrkPos # 0) == 0) exitWith {};

	if (_returnPositionArray) then {
		_array append [_mrkPos];
	} else {
		_array append [_mrkName];
	};
};

_array
