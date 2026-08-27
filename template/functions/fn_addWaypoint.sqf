//************************************************************************************************************
// CONSTANTS
//************************************************************************************************************

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
private _formations		= [ "COLUMN", "STAG COLUMNS", "WEDGE"< "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND" ];
private _speedModes		= [ "LIMITED", "NORMAL", "FULL", "UNCHANGED" ];

//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

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
