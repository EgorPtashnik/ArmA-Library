/**
	ep_system_casualHealth

	FEATURE
	Apply "Call Of Duty" health system to units

	RETURNS
	nothing

	USAGE
	[group player] call ep_system_casualHealth;

	PARAMETERS
	M|1. units (group or array of units)
	O|2. regenHealth (boolean to enable/disable health regeneration) (default: true)
	O|3. defaultDamage (amount of damage applied per hit) (default: 0.1)
	O|4. headshotKill (boolean to enable/disable instant kill on headshot) (default: true)
	O|5. threshold (health threshold below which regeneration stops) (default: 0.2)
	O|6. regenCoef (amount of health regenerated per second) (default: 0.05)
*/

params [
	"_units",
	["_regenHealth", true],
	["_defaultDamage", 0.1],
	["_headshotKill", true],
	["_threshold", 0.2],
	["_regenCoef", 0.05]
];

_units = _units call ep_fnc_collectUnits;

{
	_x setVariable ["ep_casualHealth_defaultDamage", _defaultDamage];
	_x setVariable ["ep_casualHealth_headshotKill", _headshotKill];
	_x setVariable ["ep_casualHealth_lastHitTime", time];
	_x setVariable ["ep_casualHealth_health", 0];

	_x addEventHandler ["HandleDamage", {
		private ["_selection", "_damage", "_directHit"];
		_selection = _this # 1;
		_damage = _this # 2;
		_directHit = _this # 8;
		
		if (_selection == "head" || !_directHit) exitWith { _damage };

		0
	}];

	_x addEventHandler ["Hit", {
		params ["_unit"];
		private ["_headDamage"];
		_headDamage = 0;
		
		if (_unit getVariable ["ep_casualHealth_headshotKill", false]) then {	_headDamage = _unit getHit "head" };
		
		if (_headDamage >= 1) exitWith {
			_unit setDamage 1;
			_unit removeEventHandler [_thisEvent, _thisEventHandler];
		};

		_damage = (_unit getVariable "ep_casualHealth_health") + (_unit getVariable "ep_casualHealth_defaultDamage");
		_unit setDamage _damage;
		_unit setVariable ["ep_casualHealth_health", _damage];

		_unit setVariable ["ep_casualHealth_lastHitTime", ( time + 5 ), true];	
	}];
} forEach _units;

// Loop to provide heal regeneration if needed
if (_regenHealth) then {
	[_units, _threshold] spawn {
		params ["_units", "_threshold"];
		private ["_unitDamage", "_lastHitTime"];

		while { (_units findIf { alive _x }) > -1 } do {
			{
				if (alive _x) then {
					_unitDamage = _x getVariable ["ep_casualHealth_health", 0];
					_lastHitTime = _x getVariable ["ep_casualHealth_lastHitTime", time];
					if (_unitDamage > _threshold && { _lastHitTime <= time }) then {
						_unitDamage = _unitDamage - _regenCoef;
						_x setDamage _unitDamage;
						_x setVariable ["ep_casualHealth_health", _unitDamage];
					};
				};
			}	forEach _units;
			sleep 1;
		};
	}
};