/* ----------------------------------------------------------------------------
Function: EP_fnc_addWaypoint

Description:
    Adds a waypoint to a group with extended configuration options.

Parameters:
    0: _group (Group or Objecto or Array [GroupReference, wpPlacementRadius]) - The group to add the waypoint to.
    1: _destination (Position, Object, Array or Group) - Target location for the waypoint.
    
    Optional (passed as trailing arguments in any order):
    - Waypoint Type (String) - e.g., "MOVE", "SAD", "HOLD"
    - Behaviour (String) - e.g., "COMBAT", "SAFE"
    - Combat Mode (String) - e.g., "YELLOW", "RED"
    - Speed Mode (String) - e.g., "FULL", "LIMITED"
    - Formation (String) - e.g., "WEDGE", "COLUMN"
    - Code (Array of Strings) - [condition, statement] to execute at waypoint
    - Timeout (Array of 3 Numbers) - [min, mid, max]
    - Completion Radius (Numbers) - Distance to trigger waypoint completion
    - Visible (Boolean) - Whether the waypoint is visible on the map

Example:
    [group player, getPos myMarker, "MOVE", "AWARE", "YELLOW", "NORMAL", "WEDGE"] call EP_fnc_addWaypoint

Returns:
    Waypoint (Array) - [Group, Waypoint Index]
---------------------------------------------------------------------------- */

//Constants
private _waypointTypes = [
	"MOVE", "HOLD", "CYCLE",
	"DESTROY", "SAD",
	"GUARD", "SENTRY",
	"LOAD", "UNLOAD", "TR UNLOAD",
	"GETIN", "GETIN NEAREST", "GETOUT",
	"LOITER", "HOOK", "UNHOOK",

	"JOIN", "LEADER", "TALK", "SCRIPTED", "SUPPORT", "DISMISS"
];
private _behaviours 	= [ "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH" ];
private _combatModes 	= [ "BLUE", "GREEN", "WHITE", "YELLOW", "RED" ];
private _formations		= [ "COLUMN", "STAG COLUMNS", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND" ];
private _speedModes		= [ "LIMITED", "NORMAL", "FULL", "UNCHANGED" ];

//Function
params [
	"_group",
	"_destination"
];

//Retreive waypoint args from function parameters
private _placementRadius = -1;
private _args = _this - [_group, _destination];

//Check for waypoint placement radius in first parameter
if (_group isEqualType []) then {
	_placementRadius = (_group # 1);
	_group = (_group # 0) call EP_fnc_getGroup;
} else {
	_group 	= _group call EP_fnc_getGroup;
}
_destination = _destination call EP_fnc_getPosition;

private _waypoint = _group addWaypoint [_destination, -1];
_waypoint setWaypointVisible false;

//Handle additional waypoint parameters
{
	if (_x isEqualType "string") then {
		_x = toUpper _x;

		if (_x in _waypointTypes) 		then { _waypoint setWaypointType _x; continue };
		if (_x in _behaviours) 			then { _waypoint setWaypointBehaviour _x; continue };
		if (_x in _combatModes) 		then { _waypoint setWaypointCombatMode _x; continue };
		if (_x in _formations) 			then { _waypoint setWaypointFormation _x; continue };
		if (_x in _speedModes) 			then { _waypoint setWaypointSpeed _x; continue };
	};

	if (_x isEqualTypeArray [{}, {}]) 	then { _waypoint setWaypointStatements [toString (_x # 0), toString (_x # 1)]; continue };
	if (_x isEqualTypeArray [0,0,0]) 	then { _waypoint setWaypointTimeout _x; continue };
	if (_x isEqualType 1) 				then { _waypoint setWaypointCompletionRadius _x; continue };
	if (_x isEqualType true) 			then { _waypoint setWaypointVisible _x; continue };

	if (true) exitWith { systemChat (format ["EP_fnc_addWaypoint: %1 is not a valid parameter!", _x]) }; 

} forEach _args;

_waypoint
