/**
	Creates units and vehicles at a given position and side/group

	PARAMETERS:
		_spawnPosition				: POSITION/ARRAY/STRING - position to spawn units at, can be a position, an array of coordinates, or a marker name
		_sideOrGroup					: SIDE/GROUP - side or group to create the units in
		_units								: ARRAY - array of unit class names to create
		_vehicles						: ARRAY (OPTIONAL) - array of vehicle class names to create (default: empty array)
		_direction						: NUMBER (OPTIONAL) - direction to set for created units and vehicles (default: -1, no change)
		_relPositions				: ARRAY (OPTIONAL) - array of relative positions (arrays of [x,y]) to offset each created unit/vehicle (default: empty array)
		_createCrewForVehicles : BOOL (OPTIONAL) - whether to create crew for created vehicles (default: true)
		_deleteGroupWhenEmpty : BOOL (OPTIONAL) - whether to delete the group when it is empty (default: true)
		_vehicleSpecialParam : STRING (OPTIONAL) - special parameter for vehicle creation, e.g. "FLY" for aircraft (default: "NONE")
	
	RETURNS:
		GROUP - the group containing the created units and vehicles

	EXAMPLE:
		private _group = [ "marker_spawnPoint", west, 
			[ "B_Soldier_F", "B_Soldier_AR_F", "B_Soldier_TL_F" ], 
			[ "B_MRAP_01_F" ], 
			90, 
			[ [0,0], [2,2], [-2,2], [5,0] ], 
			true, 
			true, 
			"NONE" 
		] call EP_fnc_createUnits;
*/

params [
	"_spawnPosition",
	"_sideOrGroup",
	"_units",
	["_vehicles", []],
	["_direction", -1],
	["_relPositions", []],
	["_createCrewForVehicles", true],
	["_deleteGroupWhenEmpty", true],
	["_vehicleSpecialParam", "NONE"]
];

private ["_group", "_position", "_hasRelPositions", "_offset", "_unit", "_vehicle"];

// position TODO
switch (typeName _spawnPosition) do
{
	case "ARRAY": { _position = _spawnPosition; };
	case "STRING": { _position = markerPos _spawnPosition; };
	default { _position = getPos _spawnPosition; };
};

// group
if ((typeName _sideOrGroup) == "GROUP") then {
	_group = _sideOrGroup;
} else {
	_group = createGroup _sideOrGroup;
};
_group deleteGroupWhenEmpty _deleteGroupWhenEmpty;

// units
_hasRelPositions = (count _relPositions > 0);
{
	if (_hasRelPositions) then {
		_offset = _relPositions deleteAt 0;
		_position = _position getPos [ (_offset select 0), (_offset select 1) ];
	};

	_unit = _group createUnit [_x, _position, [], 0, "NONE"];

	if (_direction != -1) then {
		_unit setDir _direction;
	};

} forEach _units;

// vehicles
{
	if (_hasRelPositions && _vehicleSpecialParam != "FLY") then {
		_offset = _relPositions deleteAt 0;
		_position = _position getPos [ (_offset select 0), (_offset select 1) ];
	};
	_vehicle = createVehicle [_x, _position, [], 0, _vehicleSpecialParam];
	_group addVehicle _vehicle;
	if (_createCrewForVehicles) then {
		_group createVehicleCrew _vehicle;
	};

	if (_direction != -1) then {
		_vehicle setDir _direction;
	};
} forEach _vehicles;

_group;
