//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_units",
	["_damageOnHit", 0.1],
	["_headshotKill", true],
	["_stopRegenAt", 0.2],
	["_regenValue", 0.05],
	["_regenInterval", 1]
];

_units = _units call EP_fnc_collectUnits;

{
	if (_x getVariable ["EP_casualHealth_installed", false]) then { continue };

	_x setVariable ["EP_casualHealth_damageOnHit", _damageOnHit];
	_x setVariable ["EP_casualHealth_headshotKill", _headshotKill];
	_x setVariable ["EP_casualHealth_regenAt", time];
	_x setVariable ["EP_casualHealth_health", 0];
	_x setVariable ["EP_casualHealth_installed", true];

	_x addEventHandler ["HandleDamage", {
		private _unit 		= _this # 0;
		private _selection 	= _this # 1;
		private _damage 	= _this # 2;
		private _directHit 	= _this # 8;

		if (!_directHit) exitWith { _damage };
		if (_selection == "head" && { _unit getVariable ["EP_casualHealth_headshotKill", true] }) exitWith { _damage };

		0
	}];

	_x addEventHandler ["Hit", {
		private _unit = _this # 0;
		private _headDamage = 0;

		// If headshot is enabled => kill unit as soon as headshot is done
		if (_unit getVariable ["EP_casualHealth_headshotKill", false]) then {
			_headDamage = _unit getHit "head";
		};

		if (_headDamage >= 1) exitWith {
			_unit setDamage 1;
			_unit removeEventHandler [_thisEvent, _thisEventHandler];
		};

		// Apply damage
		private _damage = (_unit getVariable "EP_casualHealth_health") + (_unit getVariable "EP_casualHealth_damageOnHit");
		_unit setDamage _damage;

		// Update variables
		_unit setVariable ["EP_casualHealth_health", _damage];
		_unit setVariable ["EP_casualHealth_regenAt", (time + 5)];

		if (_damage >= 1) then {
			_unit removeEventHandler [_thisEvent, _thisEventHandler];
		};
	}];

} forEach _units;

// Loop to provide HP regeneration
if (_regenValue > 0) then {
	[_units, _stopRegenAt, _regenValue, _regenInterval] spawn {
		params ["_units", "_stopRegenAt", "_regenValue", "_regenInterval"];

		private _unitDamage = 0;
		private _regenAt = 0;
		while { (_units findIf { alive _x } != -1) } do {
			{
				if (alive _x) then {
					_unitDamage = _x getVariable ["EP_casualHealth_health", 0];
					_regenAt = _x getVariable ["EP_casualHealth_regenAt", time];
					if (_unitDamage > _stopRegenAt && { _regenAt <= time }) then {
						_unitDamage = (_unitDamage - _regenValue) max _stopRegenAt;
						_x setDamage _unitDamage;
						_x setVariable ["EP_casualHealth_health", _unitDamage];
					};
				};
			} forEach _units;

			sleep _regenInterval;
		};
	};
};

_units