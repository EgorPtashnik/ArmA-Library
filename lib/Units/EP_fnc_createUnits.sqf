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
	if (_hasRelPositions && _forEachIndex > 0) then {
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
