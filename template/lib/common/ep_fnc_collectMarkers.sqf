private ["_arr"];

_arr = [];

if (typeName _this != typeName []) then {
	_this = [_this];
};

{
	_marker = _x;
	{
	    if ([_marker, _x] call BIS_fnc_inString) then {
	       _arr pushBack _x;
	    };
	} forEach allMapMarkers;
} forEach _this;

_arr
