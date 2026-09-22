/*------------------------------------------------------------------------------------------
Function: EP_fnc_collectMarkers

Description:
    Collects sequentially markers by their previx (e.g. "mrk_Pos_1", "mrk_Pos_2", "mrk_Pos_3").
	Can return markers positions instead of markers name
	Can return reversed array

Parameters:
	1. Marker prefixes: <STRING>, [<STRING...]

Optional:
	2. (false) Return reversed array: <BOOL>
	3. (false) Return marker positions <BOOL>

Returns:
	[<STRING>... or <POSITION>...] : Collected markers or marker positions

Example:
	"mrk_Pos" call EP_fnc_collectMarkers;

	[["mrk_Camp01Pos", "mrk_Camp01Pos"]] call EP_fnc_collectMarkers;

	[["mrk_Camp01Pos", "mrk_Camp01Pos"], true, true] call EP_fnc_collectMarkers;

Author:
	EP
------------------------------------------------------------------------------------------*/
params [
	"_markersPrefixes",
	["_reversed", false]
	["_markersPositions", false]
];

if !(_mrkPrefix isEqualType "") exitWith {
    systemChat format ["[LOG] %1(%2): %3", __FILE__, __LINE__, "EP_fnc_collectMarkers: Cannot get markers! Parameter must be <STRING> or [<STRING>...]!"];
};

//Collect data
private ["_array", "_mrkName", "_mrkPos"];
_array = [];
{
	for "_i" from 1 to 128 do {
		_mrkName = format ["%1_%2", _mrkPrefix, _i];
		_mrkPos = _mrkName call EP_fnc_getPosition;

		if ((_mrkPos # 0) == 0) exitWith {};

		if (_markersPositions) then {
			_array append [_mrkPos];
		} else {
			_array pushBack _mrkName;
		};
	};
} forEach _markersPrefixes;

if (_reversed) then {
	reverse _array;
};

_array
