#define EP_TRIGGER_ACTIVATION_TYPES ["PRESENT", "NOT PRESENT", "WEST D", "EAST D", "GUER D", "CIV D"]
#define EP_TRIGGER_ACTIVATION_BY_SIDES ["EAST", "WEST", "GUER", "CIV", "LOGIC", "ANY", "ANYPLAYER"]
#define EP_TRIGGER_ACTIAVTION_BY_RADIO ["ALPHA", "BRAVO", "CHARLIE", "DELTA", "ECHO", "FOXTROT", "GOLD", "HOTEL", "INDIA", "JULIET"]
#define EP_TRIGGER_ACTIVATION_BY_OBJECT ["STATIC", "VEHICLE", "GROUP", "LEADER", "MEMBER"]
#define EP_TRIGGER_ACTIVATION_BY_STATUS ["WEST SEIZED", "EAST SEIZED", "GUER SEIZED"]


params [
	"_position"
];

if !(_this isEqualType []) then {
	_this = [_this];
};

private _args = _this - [_position];

private _pos = _position call EP_fnc_getPosition;
private _trigger = createTrigger ["EmptyDetector", _position];

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
		private _condition = str (_x # 0);
		private _activation = str (_x # 1);
		private _deactivation = str (_x # 2);
		_trigger setTriggerStatements [_condition, _activation, _deactivation];
		continue
	};

} forEach _args;

_trigger
