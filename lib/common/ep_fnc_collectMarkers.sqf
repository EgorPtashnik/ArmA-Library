/**
    ep_fnc_collectMarkers

    FEATURE
    Collects markers whose names contain specified strings

    RETURNS
    markers array

    USAGE
    "wp" call ep_fnc_collectMarkers

    PARAMETERS
	M|1. Array of strings to search for in marker names (or single string)
*/

private ["_arr"];
_arr = [];

if (typeName _this != "ARRAY") then { _this = [_this] };

{
	_marker = _x;
	{
		if ([_marker, _x] call BIS_fnc_inString) then {
			_arr pushBack _x;
		}
	} forEach allMapMarkers;
} forEach _this;

_arr
