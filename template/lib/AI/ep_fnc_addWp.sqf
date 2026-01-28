/**
	ep_fnc_addWp

	FEATURE
	Add waypoint to group's wps chain with various parameters

	RETURNS
	waypoint

	USAGE
	[group,markerName or object, "SAD", "RED", "COMBAT"] call ep_fnc_addWp

	PARAMETERS
	M|1. Group (group)
	M|2. Destination (position, object, group, marker)
	O|3..n WP parameters like behaviour, formation, etc (string, order does not matter)
*/

params ["_grp", "_dest"];
private ["_settings", "_wp"];
_settings = _this - [_grp, _dest];
_grp = _grp call ep_fnc_getGroup;
_dest = _dest call ep_fnc_getPos;
_wp = _grp addWaypoint [_dest, 0];

{
	_x = toUpper _x;
	switch (_x) do {

		//Type
		case "MOVE"				: {_wp setWaypointType _x};
		case "DESTROY"			: {_wp setWaypointType _x};
		case "GETIN"			: {_wp setWaypointType _x};
		case "SAD"				: {_wp setWaypointType _x};
		case "JOIN"				: {_wp setWaypointType _x};
		case "LEADER"			: {_wp setWaypointType _x};
		case "GETOUT"			: {_wp setWaypointType _x};
		case "CYCLE"			: {_wp setWaypointType _x};
		case "LOAD"				: {_wp setWaypointType _x};
		case "UNLOAD"			: {_wp setWaypointType _x};
		case "TR UNLOAD"		: {_wp setWaypointType _x};
		case "HOLD"				: {_wp setWaypointType _x};
		case "SENTRY"			: {_wp setWaypointType _x};
		case "GUARD"			: {_wp setWaypointType _x};
		case "TALK"				: {_wp setWaypointType _x};
		case "SCRIPTED"			: {_wp setWaypointType _x};
		case "SUPPORT"			: {_wp setWaypointType _x};
		case "GETIN NEAREST"	: {_wp setWaypointType _x};
		case "DISMISS"			: {_wp setWaypointType _x};
		case "LOITER"			: {_wp setWaypointType _x};
		case "HOOK"				: {_wp setWaypointType _x};
		case "UNHOOK"			: {_wp setWaypointType _x};

		//Behaviour
		case "CARELESS"			: {_wp setWaypointBehaviour _x};
		case "SAFE"				: {_wp setWaypointBehaviour _x};
		case "AWARE"			: {_wp setWaypointBehaviour _x};
		case "COMBAT"			: {_wp setWaypointBehaviour _x};
		case "STEALTH"			: {_wp setWaypointBehaviour _x};

		//Combat Mode
		case "BLUE"				: {_wp setWaypointCombatMode _x};
		case "GREEN"			: {_wp setWaypointCombatMode _x};
		case "WHITE"			: {_wp setWaypointCombatMode _x};
		case "YELLOW"			: {_wp setWaypointCombatMode _x};
		case "RED"				: {_wp setWaypointCombatMode _x};

		//Formation
		case "COLUMN"			: {_wp setWaypointFormation _x};
		case "STAG COLUMN"		: {_wp setWaypointFormation _x};
		case "WEDGE"			: {_wp setWaypointFormation _x};
		case "ECH LEFT"			: {_wp setWaypointFormation _x};
		case "ECH RIGHT"		: {_wp setWaypointFormation _x};
		case "VEE"				: {_wp setWaypointFormation _x};
		case "LINE"				: {_wp setWaypointFormation _x};
		case "FILE"				: {_wp setWaypointFormation _x};
		case "DIAMOND"			: {_wp setWaypointFormation _x};

		//Speed
		case "LIMITED"			: {_wp setWaypointSpeed _x};
		case "NORMAL"			: {_wp setWaypointSpeed _x};
		case "FULL"				: {_wp setWaypointSpeed _x};

		default {["ep_fnc_addWp DBG:", _x ,"is not a valid waypoint parameter!"] call ep_fnc_dbgLog};
	};
} forEach _settings;

_wp
