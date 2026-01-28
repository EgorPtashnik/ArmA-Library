/**
	ep_system_healthBar

	FEATURE
	Show health bar for target unit on the UI

	RETURNS
	nothing

	USAGE
	[] spawn ep_system_healthBar

	PARAMETERS
	M|1. targetUnit (unit to show health bar for) (default: player)
	O|2. layerId (UI layer ID to draw the health bar on) (default: 1)
	O|3. healthShowVehicle (boolean to show health bar for vehicle if target unit is in a vehicle) (default: false)
	O|4. healthCharNumber (number of characters to represent full health) (default: 66)
	O|5. healthSymbol (character to use for health representation) (default: "I")
	O|6. healthMediumThreshold (threshold for medium health color change) (default: 20)
	O|7. healthHighThreshold (threshold for high health color change) (default: 40)
	O|8. healthPosFromBottomPerc (position from bottom of the screen as a percentage) (default: 1.62)
	O|9. healthPosFromRightPerc (position from right of the screen as a percentage) (default: 1.616)
	O|10. healthColorMap (array of colors for different health levels) (default: ["#ff6565", "#ffae8e", "#ffffff"])
	O|11. updateOnEach (time interval to update the health bar) (default: 0.1)
*/

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
private ["_healthBarHandler"];

_healthBarHandler = {
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
	private ["_health", "_savedHealth", "_displayString", "_counter", "_color"];
	_health = damage _unit;
	_savedHealth = _unit getVariable ["ep_healthBar_damage", -1];

	if ( (_savedHealth == -1) || (_savedHealth != _health)  ) then {
		_displayString = "";
		_counter = _charNumber - _health * _charNumber;
		for "_i" from 1 to _counter do {
			_displayString = _displayString + _symbol;
		};

		_color = _colorMap # 0;
		if (_counter > _mediumThreshold) then {_color = ( _colorMap # 1 )};
		if (_counter > _highThreshold) then {_color = ( _colorMap # 2 )};
		
		// Show Health Bar on GUI
		[
			format ["<t font='PuristaBold' color='%1' align='left' shadow='2' size='0.5'>%2</t>", _color, _displayString],
			safeZoneW + safeZoneX * _posFromRightPerc,
			safeZoneH + safeZoneY * _posFromBottomPerc,
			999, 0, 0, _layer
		] spawn BIS_fnc_dynamicText;

		_unit setVariable ["ep_healthBar_damage", _health];
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
		vehicle _targetUnit setVariable ["ep_healthBar_damage", objNull];
	};
	sleep _updateOnEach;
};

["", -1, -1, 0, 0, 0, _layerId] spawn BIS_fnc_dynamicText;
