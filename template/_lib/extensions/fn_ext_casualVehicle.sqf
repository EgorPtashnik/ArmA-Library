/* ----------------------------------------------------------------------------
Function: EP_fnc_ext_casualVehicle

Description:
    Turns vehicles into "casualty transports": when a player gets in, they are
    moved to the gunner seat while an invulnerable AI agent drives, the camera
    optionally switches to external view, and a "Get Out" action is added.

Parameters:
    0: _vehicles (Object or Array) - Vehicle(s) to configure.
    1: _enableSentences (Boolean, optional) - Enable radio sentences while driving. Default false.
    2: _getOutText (String, optional) - Text of the added get-out action. Default "Get Out".
    3: _cameraExternal (Boolean, optional) - Switch to external camera on entry. Default true.

Example:
    [ambulance] call EP_fnc_ext_casualVehicle

Returns:
    Object or Array - The vehicle(s) passed in.
---------------------------------------------------------------------------- */

params [
	"_vehicles",
	["_enableSentences", false],
	["_getOutText", "Get Out"],
	["_cameraExternal", true]
];

if !(_vehicles isEqualType [] || _vehicles isEqualType objNull) exitWith {
	systemChat "EP_fnc_ext_casualVehicle: Invalid vehicles parameter!";
};

if !(_vehicles isEqualType []) then {
	_vehicles = [_vehicles];
};

{
	_x setVariable ["EP_casualVehicle_enableSentences", _enableSentences];
	_x setVariable ["EP_casualVehicle_cameraExternal", _cameraExternal];
	_x setVariable ["EP_casualVehicle_getOutText", _getOutText];

	_x addEventHandler ["GetIn", {
		params ["_vehicle", "_role", "_unit"];

		enableSentences ( _vehicle getVariable ["EP_casualVehicle_enableSentences", false] );
		_vehicle engineOn true;
		_vehicle lock true;

		if (_vehicle getVariable ["EP_casualVehicle_cameraExternal", false]) then {
			_vehicle switchCamera "EXTERNAL"
		};

		if (!isAgent (teamMember driver _vehicle)) then {
			
			_vehicle addAction [
				_vehicle getVariable "EP_casualVehicle_getOutText",
				{
					params ["_target", "_caller", "_actionID"];
					_target removeAction _actionID;
					_caller action ["GetOut", _target];
				},
				nil, 1.5, false
			];
		};

		_unit action ["MoveToGunner", _vehicle];

		// Create agent driver
		_vehicle spawn {
			waitUntil { !isNull gunner _this };
			private _agent = createAgent [typeOf gunner _this, [0,0,0], [], 0, "NONE"];
			_agent allowDamage false;
			_agent moveInDriver _this;
		};
	}];

	_x addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit"];
		deleteVehicle driver _vehicle;
		_unit action ["EngineOff", _vehicle];
		_vehicle lock false;
		enableSentences true;
	}];
} forEach _vehicles;

_vehicles
