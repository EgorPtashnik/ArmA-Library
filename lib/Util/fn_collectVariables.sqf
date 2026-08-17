params [
	"_varPrefixes",
	["_reversed", false]
];

// Params check
if !(_this isEqualType "" || _this isEqualType []) exitWith {
	systemChat "EP_fnc_collectVariables: Must give variable prefix as String or Array!";
};

if (_this isEqualType "") then {
	_this = [_this];
};


// Collect variable values
private _array = [];
{
	for "_i" from 1 to 128 do {
		private _varName = format["%1_%2", _x, _i];
		private _varValue = missionNamespace getVariable _varName;

		if (isNil "_varValue") exitWith {};

		if (_reversed) then {
			_array pushBack _varValue;
		} else {
			_array append [_varValue];
		};
	};
} forEach _this;

_array
