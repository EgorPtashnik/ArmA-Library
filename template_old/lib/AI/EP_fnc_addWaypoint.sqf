/**
	Add waypoint to a group
 */

// [_group, _position, [["type", "MOVE"], ["combat", "AWARE"]] call EP_fnc_addWaypoint;

params [
    "_group",
    "_position",
		["_wpParams", []],
		["_setCurrent", false],
		["_syncWaypoints", []]
];

/*
  type:				 	MOVE, DESTROY, GETIN, SAD, JOIN, LEADER, GETOUT, CYCLE, LOAD, UNLOAD, TR UNLOAD, HOLD,
							 	SENTRY, GUARD, TALK, SCRIPTED, SUPPORT, GETIN NEAREST, DISMISS, LOITER, HOOK, UNHOOK
	behaviour: 	 	UNCHANGED, CARELESS, SAFE, AWARE, COMBAT, STEALTH
	combat:			 	NO CHANGE, BLUE, GREEN, WHITE, YELLOW, RED
	speed:			 	UNCHANGED, LIMITED, NORMAL, FULL
	formation:	 	NO CHANGE, COLUMN, STAG COLUMN, WEDGE, ECH LEFT, ECH RIGHT, VEE, LINE, FILE, DIAMOND
	onComplete:  	["true", "hint 'hello'; hint 'goodbuy'] [condition, "code"]
	timeout:		 	[min,mid,max]
	compRadious:	30
	syncWaypoint: [wp1, wp2],
	housePos,
	attachObject,
	attachVehicle
*/
private _wpParamsMap = createHashMapFromArray [
	["radius", -1],
	["type", "MOVE"], 
	["behaviour", "UNCHANGED"],
	["combat", "NO CHANGE"],
	["speed", "UNCHANGED"],
	["formation", "NO CHANGE"],
	["onComplete", ["true", ""]],
	["timeout", [0,0,0]],
	["compRadius", 0],
	["syncWaypoints", []],
	["housePos", -1],
	["attachObject", objNull],
	["attachVehicle", objNull]
];
 _group = _group call CBA_fnc_getGroup;
_position = _position call CBA_fnc_getPos;

// Adjust parameters of hash map if params are set
{ _wpParamsMap set [ (_x select 0), (_x select 1) ] } forEach _wpParams;

// addWaypoint expects ASL when a negative radius is provided for exact placement
// otherwise waypoints will be placed under the ground
if ( (_wpParamsMap get "radius") < 0) then {
    _position = AGLToASL _position;
};

private _waypoint = _group addWaypoint [_position, (_wpParamsMap get "radius")];

_waypoint setWaypointType (_wpParamsMap get "type");
_waypoint setWaypointBehaviour (_wpParamsMap get "behaviour");
_waypoint setWaypointCombatMode (_wpParamsMap get "combat");
_waypoint setWaypointSpeed (_wpParamsMap get "speed");
_waypoint setWaypointFormation (_wpParamsMap get "formation");
_waypoint setWaypointStatements (_wpParamsMap get "onComplete");
_waypoint setWaypointTimeout (_wpParamsMap get "timeout");
_waypoint setWaypointCompletionRadius (_wpParamsMap get "compRadius");

// process optionals
if (_setCurrent) then {
	_group setCurrentWaypoint _waypoint;
};

if ( count _syncWaypoints > 0 ) then {
	_waypoint synchronizeWaypoint _syncWaypoints;
};

if ( (_wpParamsMap get "housePos") != -1) then {
	_waypoint setWaypointHousePosition (_wpParamsMap get "housePos");
};

// can be used with object ID (like house ID) to attach waypoint to a house
if ( !(isNull(_wpParamsMap get "attachObject")) ) then {
	_waypoint waypointAttachObject (_wpParamsMap get "attachObject");
};

// for GETIN waypoint
if ( !(isNull(_wpParamsMap get "attachVehicle")) ) then {
	_waypoint waypointAttachVehicle (_wpParamsMap get "attachVehicle");
};
// process optionals === END

_waypoint