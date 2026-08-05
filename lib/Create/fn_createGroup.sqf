params [
	"_group",
	["_deleteWhenEmpty", true],
	["_position", []],
	["_units", []]
];

if (_group isEqualType sideUnknown) then {
	_group = createGroup [_side, _deleteWhenEmpty];
} else {
	_group = _group call EP_fnc_getGroup;
	_group deleteGroupWhenEmpty _deleteWhenEmpty;
};

// Create units
{
	if (_x isEqualType []) then {
		private _unitType = _x # 0;
		private _params = _x # 1;
		([_group, _unitType, _position] + _params) call EP_fnc_createUnit;
	} else {
		[_group, _x, _position] call EP_fnc_createUnit;
	};

} forEach _units;

_group
