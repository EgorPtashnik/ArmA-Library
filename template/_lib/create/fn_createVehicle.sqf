/* ----------------------------------------------------------------------------
Function: EP_fnc_createVehicle

Description:
    Creates a vehicle (or soldier/plane/helicopter, based on its simulation
    type) at a position, then crews it either automatically or with specific
    unit classes assigned to cargo/commander/driver/gunner/turret roles.

Parameters:
    0: _position (Position, Object, Array or Group, or [Reference, Radius]) - Spawn location, or a
        [reference, radius] pair to spawn at a random position around the reference.
    1: _spawnRef (Group or Side) - Group to add the vehicle to, or a side to create a new group for.
    2: _vehSetting (String or Array) - Vehicle class, or [class, crew] where crew is an array of
        ["CARGO"/"TURRET"/"COMMANDER"/"DRIVER"/"GUNNER", classes] pairs.
    3: _direction (Number, optional) - Spawn direction. Default 0.
    4: _precisePosition (Boolean, optional) - Force exact position placement. Default false.

Example:
    [getMarkerPos "mk_spawn", west, "B_MRAP_01_F"] call EP_fnc_createVehicle

Returns:
    Object - The created vehicle.
---------------------------------------------------------------------------- */

params [
	"_position",
	"_spawnRef",
	"_vehSetting",
	["_direction", 0],
	["_precisePosition", false]
];

//Validate parameter count
if ((count _this) < 3) exitWith { debugLog "EP_fnc_createVehicle: Function requires at least 3 parameters!"; [] };
if !(_spawnRef isEqualType grpNull || _spawnRef isEqualType sideUnknown) exitWith { debugLog "EP_fnc_createGroup: Spawn reference (1) must be a side or a group."; grpNull };

private _pos = [];
private _side = sideUnknown;
private _grp = grpNull;

//Get position
if (_pos isEqualType [] && { (count _position) == 2 }) then {
	private _ref = _position # 0;
	private _radius = _position # 1;
	_pos = [_ref, _radius] call EP_fnc_getRandomPosition;
} else {
	_pos = _position call EP_fnc_getPosition;
};

//Determine to join group or create a new one
if (_spawnRef isEqualType grpNull) then {
	_grp = _spawnRef;
} else {
	_grp = createGroup _spawnRef;
};

//Create vehicle
private _veh = objNull;
private _class = _vehSetting;
private _sim = getText(configFile >> "CfgVehicles" >> _class >> "simulation");
private _crew = [];

//Get special settings if vehSetting is array (1 - vehicle class, 2 - crew settings)
if (_vehSetting isEqualType []) then {
	_class = _vehSetting # 0;
	_crew = _vehSetting # 1;
};

switch (toLower _sim) do {
	case "soldier": {
		_veh = _grp createUnit [_class, _pos, [], 0, "none"];
	};
	
	case "airplanex";
	case "helicopterrtd";
	case "helicopterx": {
		if (count _pos == 2) then { _pos set [2, 0] };
		_pos set [2, (_pos # 2) max 50];
		_veh = createVehicle [_class, _pos, [], 0, "FLY"];
	};

	default {
		_veh = createVehicle [_class, _pos, [], 0, "NONE"];
	};
};

//Set direction
_veh setDir _direction;

//Make sure the vehicle is where it should be.
if (_precisePosition) then {
	_veh setPos _pos;
};

//Set a good velocity in the correct direction for plane.
if (_sim == "airplanex") then {
	_veh setVelocity [100 * (sin _direction), 100 * (cos _direction), 0];
};

//Spawn the crew and add the vehicle to the group.
if ((count _crew) == 0) then {
	createVehicleCrew _veh;
	(crew _veh) joinSilent _grp;
} else {
	
	{
		//If vehicle position is specified - move in this exact position
		if (_x isEqualTypeArray ["", []]) then {
			private _posType = _x # 0;
			private _classes = _x # 1;
			private _unit = objNull;
			switch(toLower _posType) do {
				case "cargo": {
					{
						_unit = _grp createUnit [_x, getPos _veh, [], 0, "NONE"];
						_unit moveInCargo _veh;
					} forEach _classes;
				};

				case "commander": {
					{
						_unit = _grp createUnit [_x, getPos _veh, [], 0, "NONE"];
						_unit moveInCommander _veh;
					} forEach _classes;
				};

				case "driver": {
					{
						_unit = _grp createUnit [_x, getPos _veh, [], 0, "NONE"];
						_unit moveInDriver _veh;
					} forEach _classes;
				};

				case "gunner": {
					{
						_unit = _grp createUnit [_x, getPos _veh, [], 0, "NONE"];
						_unit moveInGunner _veh;
					} forEach _classes
				};

				case "turret": {
					//Get empty turrets
					private _turretPaths = (((_veh call BIS_fnc_vehicleRoles) select { (_x # 0) == "Turret" }) apply { _x # 1 });
					_turretPaths = _turretPaths select { isNull (_veh turretUnit _x) };

					{
						if ((count _turretPaths) == 0) exitWith {};
						private _path = _turretPaths deleteAt 0;
						private _unit = _grp createUnit [_x, getPos _veh, [], 0, "NONE"];
						_unit moveInTurret [_veh, _path];
					} forEach _classes;
				};

				default {
					{ _x moveInAny _veh } forEach _classes;
				};
			};

		} else {
			//If vehicle position is not specified move in any position
			{_x moveInAny _veh} forEach _x;
		};
	} forEach [	["CARGO", []], ["TURRET", []], ["DRIVER", []] ];
};

_grp addVehicle _veh;

//If this is a new group, select a leader.
if (_spawnRef isEqualType sideUnknown) then {
	_grp selectLeader (effectiveCommander _veh);
};

_veh