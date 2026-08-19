#include "..\constants.hpp";

params [
	"_group",
	"_destination"
];

private _args = _this - [_group, _destination];

_group 	= _group call EP_fnc_getGroup;
_destination = _destination call EP_fnc_getPosition;

private _waypoint = _group addWaypoint [_destination, -1];
_waypoint setWaypointVisible false;

{
	if (_x isEqualType "string") then {
		_x = toUpper _x;

		if (_x in EP_WP_TYPES) 			then { _waypoint setWaypointType _x; continue };
		if (_x in EP_BEHAVIOURS) 		then { _waypoint setWaypointBehaviour _x; continue };
		if (_x in EP_COMBAT_MODES) 		then { _waypoint setWaypointCombatMode _x; continue };
		if (_x in EP_FORMATIONS) 		then { _waypoint setWaypointFormation _x; continue };
		if (_x in EP_SPEED_MODES) 		then { _waypoint setWaypointSpeed _x; continue };
	};

	if (_x isEqualTypeArray [{}, {}]) 	then { _waypoint setWaypointStatements [toString (_x # 0), toString (_x # 1)]; continue };
	if (_x isEqualTypeArray [0,0,0]) 	then { _waypoint setWaypointTimeout _x; continue };
	if (_x isEqualType 1) 				then { _waypoint setWaypointCompletionRadius _x; continue };
	if (_x isEqualType true) 			then { _waypoint setWaypointVisible _x; continue };

	if (true) exitWith { systemChat (format ["EP_fnc_addWaypoint: %1 is not a valid parameter!", _x]) }; 

} forEach _args;

_waypoint
