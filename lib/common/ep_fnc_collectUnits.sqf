/**
    ep_fnc_collectUnits

    FEATURE
    Collects units from a group or array of groups

    RETURNS
    units (array)

    USAGE
    (group player) call ep_fnc_collectUnits

    PARAMETERS
    M|1. group or array of groups and units
*/

private ["_units"];
_units = [];

if (typeName _this != "ARRAY") then { _this = [_this] };

{
	switch (typeName _x) do {

		case "GROUP": 	{_units append (units _x)};
	
		case "OBJECT": 	{_units pushBack _x};
	
		case "ARRAY": 	{_units append _x};
	
	};
} forEach _this;

_units