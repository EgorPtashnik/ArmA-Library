/**
	ep_system_oneManVehicle

	FEATURE
	Enable one man vehicle system to vehicles

	RETURNS
	nothing

	USAGE
	[assignedVehicles group player, false, "Get Out"] call ep_system_oneManVehicle

	PARAMETERS
	M|1. vehicles (array of vehicles or single vehicle to apply the system to)
	O|2. enableSentences (boolean to enable/disable vehicle crew sentences) (default: false)
	O|3. getOutText (text for the get out action) (default: "Get Out")
	O|4. cameraExternal (boolean to set camera to external on entering vehicle) (default: true)
 */
 // [assignedVehicles group player, false, "Выйти"] call EP_applySystem_OneManTank;

params [
	"_vehicles",
	["_enableSentences", false],
	["_getOutText", "Get Out"],
	["_cameraExternal", true]
];
private ["_addEventHandlers"];

_addEventHandlers = {

	_this addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit"];

		enableSentences ( _vehicle getVariable ["ep_oneManVehicle_enableSentences", false] );
		_vehicle engineOn true;
		_vehicle lock true;

		if (_vehicle getVariable ["ep_oneManVehicle_cameraExternal", false]) then { _vehicle switchCamera "EXTERNAL" };

		if (!isAgent (teamMember driver _vehicle)) then {
			[
				_vehicle,
				_vehicle getVariable "ep_oneManVehicle_getOutText",
				{
					params ["_target", "_caller", "_actionId"];

					_target removeAction _actionId;
					_caller action ["GetOut", _target];
				},
				"true",
				nil,
				1.5,
				false
			] call ep_fnc_addAction;
		};

		_unit action ["MoveToGunner", _vehicle];
		// Create agent driver
		_vehicle spawn {
			private ["_agent"];
			waitUntil {!isNull gunner _this};
			_agent = createAgent [ typeOf gunner _this, [0,0,0], [], 0, "NONE" ];
			_agent allowDamage false;
			_agent moveInDriver _this;
		};
	}];

	_this addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit"];
		deleteVehicle driver _vehicle;
		_unit action ["EngineOff", _vehicle];
		_vehicle lock false;
		enableSentences true;
	}];

};

if (typeName _vehicles != "ARRAY") then { _vehicles = [_vehicles] };

{
	_x setVariable ["ep_oneManVehicle_enableSentences", _enableSentences];
	_x setVariable ["ep_oneManVehicle_cameraExternal", _cameraExternal];
	_x setVariable ["ep_oneManVehicle_getOutText", _getOutText];
	_x call _addEventHandlers;
} forEach _vehicles;
