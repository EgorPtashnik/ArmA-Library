//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	["_start", [0,0,0]],
	["_end", [100,100,100]],
	["_class", "B_Heli_Light_01_F"],
	["_height", 100],
	["_speed", "NORMAL"],
	["_side", blufor]
];

_start = _start call EP_fnc_getPosition;
_end = _end call EP_fnc_getPosition;

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
[_vehicle, ["TARGET", false], ["AUTOTARGET", false] ] call EP_fnc_setAIMode;
_vehicle setCaptive true;
_vehicleGroup allowFleeing 0;

//Fly height
_vehicle flyInHeight _height;

//Add waypoint
[_vehicle, _end, "MOVE", "CARELESS", "BLUE", _speed, [
	{ true },
	{
		private _group = group this;
		private _vehicle = vehicle this;
		deleteVehicleCrew _vehicle;
		deleteVehicle _vehicle;
		{ deleteVehicle _x } forEach units _group;
		deleteGroup _group;
	}
]] call EP_fnc_addWaypoint;

_vehicle
