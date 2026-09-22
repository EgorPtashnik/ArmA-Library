/* ----------------------------------------------------------------------------
Function: EP_fnc_ambientFlyBy

Description:
    Spawns an ambient aircraft that flies from a start to an end position at a
    fixed height, ignoring its surroundings, and deletes itself on arrival.

Parameters:
    1. ([0,0,0]) Spawn location: <POSITION>
    2. ([100, 100, 100]) End location: <POSITION>.
    3. (BLUFOR) Aircraft side: <SIDE>
    4. ("B_Heli_Light_01_F") Aircraft class: <STRING>
    5. (100) Flying height: <NUMBER>
    6. ("NORMAL") Waypoint speed mode: <STRING>

Returns:
    <OBJECT> : Spawned aircraft

Example:
    [markerA, markerB, "B_Plane_CAS_01_F", 300] call EP_fnc_ambientFlyBy

---------------------------------------------------------------------------- */

params [
	["_start", [0,0,0]],
	["_end", [100,100,100]],,
	["_side", BLUFOR],
	["_class", "B_Heli_Light_01_F"],
	["_height", 100],
	["_speed", "NORMAL"]
];

//Set spawn height
_start set [2, _height];

//The starting direction of the vehicle
private _direction = _start getDir _end;

//Spawn the vehicle
private _vehicleContainer	= [_start, _direction, _class, _side] call BIS_fnc_spawnVehicle;
private _vehicle 			= _vehicleContainer # 0;
private _vehicleCrew		= _vehicleContainer # 1;
private _vehicleGroup		= _vehicleContainer # 2;

//The vehicle/group should ignore it's surroundings
_vehicle disableAI "TARGET";
_vehicle disableAI "AUTOTARGET"
_vehicle setCaptive true;
_vehicleGroup allowFleeing 0;

//Fly height
_vehicle flyInHeight _height;

//Add waypoint
private _wp = _vehicleGroup addWaypoint [_end, 0];
_wp setWaypointBehaviour "CARELESS";
_wp setWaypointCombatMode "BLUE";
_wp setWaypointSpeed _speed;
_wp setWaypointStatements [
	"true",
	toString {
		private _group = group _this;
		private _vehicle = vehicle _this;
		deleteVehicleCrew _vehicle;
		deleteVehicle _vehicle;
		{deleteVehicle _x} forEach units _group;
	}
];

_vehicle
