#include "..\constants.hpp";

params [
	"_position"
];

if !(_this isEqualType []) then {
	_this = [_this];
};

private _args = _this - [_position];

private _pos = _position call EP_fnc_getPosition;
private _trigger = createTrigger ["EmptyDetector", _pos];

{

	if (_x isEqualType 0) then {
		_trigger setTriggerInterval _x;
		continue
	};

	if (_x isEqualType "") then {
		_trigger setTriggerText _x;
		continue
	};

	if ( (_x isEqualTypeArray [0,0,0,true]) || (_x isEqualTypeArray [0,0,0,true,0]) ) then {
		_trigger setTriggerArea _x;
		continue
	};

	if (_x isEqualTypeArray ["", "", true]) then {
		_trigger setTriggerActivation _x;
		continue
	};

	if (_x isEqualTypeArray [ {}, {}, {} ]) then {
		private _condition = toString (_x # 0);
		private _activation = toString (_x # 1);
		private _deactivation = toString (_x # 2);
		_trigger setTriggerStatements [_condition, _activation, _deactivation];
		continue
	};

} forEach _args;

_trigger
