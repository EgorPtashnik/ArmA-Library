#include "..\constants.hpp";

private _group = _this deleteAt 0;
private _destination = _this deleteAt 0;

_group 	= _group call ep_fnc_getGroup;
_destination = _destination call ep_fnc_getPosition;

private _waypoint = _group addWaypoint [_destination, -1];

{
	if (_x isEqualType "string") then {
		_x = toUpper _x;

		if (_x in EP_WP_TYPES) 		then { _waypoint setWaypointType _x; continue };
		if (_x in EP_BEHAVIOURS) 	then { _waypoint setWaypointBehaviour _x; continue };
		if (_x in EP_COMBAT_MODES) 	then { _waypoint setWaypointCombatMode _x; continue };
		if (_x in EP_FORMATIONS) 	then { _waypoint setWaypointFormation _x; continue };
		if (_x in EP_SPEED_MODES) 	then { _waypoint setWaypointSpeed _x; continue };
	};

	if (_x isEqualType []) 			then { _waypoint setWaypointTimeout _x; continue };
	if (_x isEqualType 1) 			then { _waypoint setWaypointCompletionRadius _x; continue };

	if (true) exitWith { systemChat (format ["ep_fnc_addWaypoint: %1 is not a valid parameter!", _x]) }; 

} forEach _this;

_waypoint
