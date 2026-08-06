params [
	["_targetUnit", player],
	["_layerId", 1],
	["_healthShowVehicle", false],
	["_healthSymbolsCount", 66],
	["_healthSymbol", "I"],
	["_healthMediumThreshold", 60],
	["_healthHighThreshold", 30],
	["_healthPosFromBottomPerc", 1.62],
	["_healthPosFromRightPerc", 1.616],
	["_healthColorMap", ["#ff6565", "#ffae8e", "#ffffff"]],
	["_sleep", 0.1]
];

private _healthBarHandler = {
	params [
		"_unit",
		"_layer",
		"_symbolsCount",
		"_symbol",
		"_mediumThreshold",
		"_highThreshold",
		"_posFromBottomPerc",
		"_posFromRightPerc",
		"_colorMap"
	];
	
	private _health = damage _unit;
	private _savedHealth = _unit getVariable ["EP_healthBar_damage", -1];

	if ( _savedHealth == -1 || _savedHealth != _health) then {
		
		// Get total string for health
		private _displayString = "";
		private _counter = _symbolsCount - _health * _symbolsCount;
		for "_i" from 1 to _counter do {
			_displayString = _displayString + _symbol;	
		};

		private _color = _colorMap # 0;
		if (_counter > _highThreshold * _symbolsCount / 100) 	then { _color = _colorMap # 1 };
		if (_counter > _mediumThreshold * _symbolsCount / 100) 	then { _color = _colorMap # 2 };

		// Draw Health Bar
		[
			format ["<t font='PuristaBold' color='%1' align='left' shadow='2' size='0.5'>%2</t>", _color, _displayString],
			safeZoneW + safeZoneX * _posFromRightPerc,
			safeZoneH + safeZoneY * _posFromBottomPerc,
			999, 0, 0, _layer
		] call BIS_fnc_dynamicText;

		_unit setVariable ["EP_healthBar_damage", _health];
	};
};

while { alive _targetUnit } do {
if ( ( (vehicle _targetUnit) isEqualTo _targetUnit) || _healthShowVehicle) then {
		[
			vehicle _targetUnit,
			_layerId,
			_healthSymbolsCount,
			_healthSymbol,
			_healthMediumThreshold,
			_healthHighThreshold,
			_healthPosFromBottomPerc,
			_healthPosFromRightPerc,
			_healthColorMap
		] call _healthBarHandler;
	} else {
		["", -1, -1, 0, 0, 0, _layerId] call BIS_fnc_dynamicText;
		vehicle _targetUnit setVariable ["EP_healthBar_damage", -1];
	};
	sleep _sleep;
};

["", -1, -1, 0, 0, 0, _layerId] call BIS_fnc_dynamicText;