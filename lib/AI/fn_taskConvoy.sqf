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