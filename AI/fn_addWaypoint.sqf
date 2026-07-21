private _group = _this # 0;
private _destination = _this # 1;
private _parameters = _this - [_group, _destinations];

private _WP_TYPE = ["MOVE", "DESTROY", "GETIN", "SAD", "JOIN", "LEADER", "GETOUT", "CYCLE", "LOAD", "UNLOAD", "TR UNLOAD", "HOLD", "SENTRY", "GUARD", "TALK", "SCRIPTED", "SUPPORT", "GETIN NEAREST", "DISMISS", "LOITER", "HOOK", "UNHOOK"];
private _WP_BEHAVIOUR = ["CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"];
private _WP_COMBAT_MODE = ["BLUE", "GREEN", "WHITE", "YELLOW", "RED"];
private _WP_FORMATION = ["COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
private _WP_SPEED = ["LIMITED", "NORMAL", "FULL", "UNCHANGED"];


_group 	= _group call ep_fnc_getGroup;
_destination = _destination call ep_fnc_getPosition;
private _waypoint = _group addWaypoint [_destination, -1];

{
	if (_x isEqualType "string") then {
		_x = toUpper _x;

		if (_x in _WP_TYPE) then { _waypoint setWaypointType _x; continue };
		if (_x in _WP_BEHAVIOUR) then { _waypoint setWaypointBehaviour _x; continue };
		if (_x in _WP_COMBAT_MODE) then { _waypoint setWaypointCombatMode _x; continue };
		if (_x in _WP_FORMATION) then { _waypoint setWaypointFormation _x; continue };
		if (_x in _WP_SPEED) then { _waypoint setWaypointSpeed _x; continue };
	};

	if (_x isEqualType []) then { _waypoint setWaypointTimeout _x; continue };
	if (_x isEqualType 1) then { _waypoint setWaypointCompletionRadius _x; continue };

	if (true) exitWith { systemChat (format ["ep_fnc_addWaypoint: %1 is not a valid parameter!", _x]) }; 

} forEach _parameters;

_waypoint
