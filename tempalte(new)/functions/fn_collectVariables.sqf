/* ----------------------------------------------------------------------------
Function: EP_fnc_collectVariables

Description:
    Collects sequentially numbered mission namespace variables sharing a
    common prefix ("prefix_1", "prefix_2", ...) until a nil value is found.

Parameters:
    0: _varPrefixes (String or Array of Strings) - Variable name prefix(es).
    1: _reversed (Boolean, optional) - Push values in reverse collection order. Default false.

Example:
    ["EP_wave"] call EP_fnc_collectVariables

Returns:
    Array - The collected variable values.
---------------------------------------------------------------------------- */

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

(_array select {!isNull _x})
