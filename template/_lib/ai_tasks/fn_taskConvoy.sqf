/* ----------------------------------------------------------------------------
Function: EP_fnc_taskConvoy

Description:
    Configures a group as a vehicle convoy: sets column formation, speed and
    separation, adds waypoints along a marker route, and continuously monitors
    the convoy to keep stuck vehicles moving.

Parameters:
    0: _group (Group or Object) - The convoy group.
    1: _route (Array or String) - Marker name(s) or positions defining the route. Passed through EP_fnc_collectMarkers.
    2: _limitSpeed (Number, optional) - Max speed for the convoy. Default 50.
    3: _convoySeparation (Number, optional) - Distance between vehicles. Default 50.
    4: _pushThrough (Boolean, optional) - If true, convoy will not stop for combat. Default false.

Example:
    [convoyGroup, ["mk_route1", "mk_route2", "mk_route3"]] call EP_fnc_taskConvoy

Returns:
    Nothing.
---------------------------------------------------------------------------- */

params [
	"_group",
	"_route",
	["_limitSpeed", 50],
	["_convoySeparation", 50],
	["_pushThrough", false]
];

_group = _group call EP_fnc_getGroup;
_route = _route call EP_fnc_collectMarkers;
[_group, "COLUMN"] call EP_fnc_setAIMode;
_group deleteGroupWhenEmpty true;

// Push through settings
_group enableAttack !_pushThrough;
{
	private _veh = vehicle _x;
	_veh setUnloadInCombat [!_pushThrough, false];
	_veh limitSpeed _limitSpeed * 1.15;
	_veh setConvoySeparation _convoySeparation;
} forEach units _group;

(vehicle leader _group) limitSpeed _limitSpeed;

{ [_group, _x] call EP_fnc_addWaypoint } forEach _route;

private _convoySubVehicles = (units _group) - (crew (vehicle (leader _group))) - [player];
while { sleep 5; !isNull _group } do {

	// Check for stuck vehicle
	{
		private _veh = vehicle _x;
		if (speed _veh < 5) then {
			private _shouldMove = _pushThrough || (behaviour _x != "COMBAT");
			if (_shouldMove) then {
				_veh doFollow (leader _group);
			};
		};
	} forEach _convoySubVehicles;
	{ (vehicle _x) setConvoySeparation _convoySeparation } forEach (units _group);
};