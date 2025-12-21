/**
	Enable one man tank system to vehicles
 */
 // [assignedVehicles group player, false, "Выйти"] call EP_applySystem_OneManTank;

params [
	"_vehicles",
	["_enableSentences", false],
	["_getOutText", "Выйти"],
	["_cameraExternal", true]
];

private _addEventHandlers = {
	params [
		"_vehicle",
		["_enableSentences", false]
	];
	_vehicle setVariable ["EP_enableSentences", _enableSentences];
	_vehicle setVariable ["EP_cameraExternal", _cameraExternal];
	_vehicle setVariable ["EP_getOutText", _getOutText];

	_vehicle addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit"];
		enableSentences ( _vehicle getVariable ["EP_enableSentences", false] );

		_vehicle engineOn true;
		_vehicle lock true;
		if ( _vehicle getVariable ["EP_cameraExternal", false] ) then {
			_vehicle switchCamera "EXTERNAL";
		};

		if (!isAgent (teamMember driver _vehicle)) then {
			_vehicle addAction [_vehicle getVariable "EP_getOutText", {
				params ["_target", "_caller", "_actionId"];
				_target removeAction _actionId;
				_caller action ["GetOut", _target];
			}, [], 1.5, false];
		};

		_unit action ["MoveToGunner", _vehicle];
		// Create agent driver
		_vehicle spawn {
			waitUntil {!isNull gunner _this};
			private _agent = createAgent [ typeOf gunner _this, [0,0,0], [], 0, "NONE" ];
			_agent allowDamage false;
			_agent moveInDriver _this;
		};
	}];

	_vehicle addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit"];
		deleteVehicle driver _vehicle;
		_unit action ["EngineOff", _vehicle];
		_vehicle lock false;
		enableSentences true;
	}];
};

if ((typeName _vehicles) == "ARRAY") then {
	{ [_x, _enableSentences] call _addEventHandlers; } forEach _vehicles;
} else {
	[_vehicles, _enableSentences] call _addEventHandlers;
};
