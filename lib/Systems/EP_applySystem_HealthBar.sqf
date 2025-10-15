/**
	Show health bar for target unit on the UI
 */

// [] spawn EP_applySystem_HealthBar;
params [
	["_targetUnit", player],
	["_layerId", 1],
	["_healthShowVehicle", false],
	["_healthCharNumber", 66],
	["_healthSymbol", "I"],
	["_healthMediumThreshold", 20],
	["_healthHighThreshold", 40],
	["_healthPosFromBottomPerc",1.62],
	["_healthPosFromRightPerc", 1.616],
	["_healthColorMap", ["#ff6565", "#ffae8e", "#ffffff"]],
	["_updateOnEach", 0.1]
];

private _healthBarHandler = {
	params [
		"_unit",
		"_layer",
		"_charNumber",
		"_symbol",
		"_mediumThreshold",
		"_highThreshold",
		"_posFromBottomPerc",
		"_posFromRightPerc",
		"_colorMap"
	];

	private _health = damage _unit;
	private _savedHealth = _unit getVariable ["EP_healthBarDamage", -1];

	if ( (_savedHealth == -1) || (_savedHealth != _health)  ) then {
		private _displayString = "";
		private _counter = _charNumber - _health * _charNumber;
		for "_i" from 1 to _counter do {
			_displayString = _displayString + _symbol;
		};

		private _color = _colorMap select 0;
		if (_counter > _mediumThreshold) then { _color = ( _colorMap select 1 ); };
		if (_counter > _highThreshold) then { _color = ( _colorMap select 2 ); };
		
		// Show Health Bar on GUI
		[
				format ["<t font='PuristaBold' color='%1' align='left' shadow='2' size='0.5'>%2</t>", _color, _displayString],
				safeZoneW + safeZoneX * _posFromRightPerc,
				safeZoneH + safeZoneY * _posFromBottomPerc,
				999, 0, 0, _layer
		] spawn BIS_fnc_dynamicText;

		_unit setVariable ["EP_healthBarDamage", _health];
	};
};

while { alive _targetUnit } do {
	if ( ( (vehicle _targetUnit) isEqualTo _targetUnit) || _healthShowVehicle) then {
		[
			vehicle _targetUnit,
			_layerId,
			_healthCharNumber,
			_healthSymbol,
			_healthMediumThreshold,
			_healthHighThreshold,
			_healthPosFromBottomPerc,
			_healthPosFromRightPerc,
			_healthColorMap
		] call _healthBarHandler;
	} else {
		["", -1, -1, 0, 0, 0, _layerId] spawn BIS_fnc_dynamicText;
		vehicle _targetUnit setVariable ["EP_healthBarDamage", objNull];
	};
	sleep _updateOnEach;
};

["", -1, -1, 0, 0, 0, _layerId] spawn BIS_fnc_dynamicText;
