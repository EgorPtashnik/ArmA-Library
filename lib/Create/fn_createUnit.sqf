#define EP_CREATE_UNIT_SPECIAL_TYPES ["NONE", "CAN_COLLIDE", "CARGO"]

params [
	"_group",
	"_type"
];


private _args = _this - [_group, _type];

_group = _group call ep_fnc_getGroup;
if (_type isEqualType []) {
	_type = selectRandom _type;
};

private _position = [];
private _radius = 0;
private _markers = [];
private _special = "NONE";

if ( (units _group) findIf { alive _x } != -1 ) then {
	_position = _group call ep_fnc_getPosition;
};

{

	if (_x in EP_CREATE_UNIT_SPECIAL_TYPES )	then { _special = _x; continue };
	if (_x isEqualType 0) 						then { _radius = _x; continue };

	if (_x isEqualType "") 						then {
		_markers = _x call ep_fnc_collectMarkers;
		_position = (_markers # 0) call ep_fnc_getPosition;
		if (count _markers == 1) then {	_markers = [] };
		continue
	} else {
		_position = _x call ep_fnc_getPosition;
		continue
	};

} forEach _args;


private _unit = _group createUnit [_type, _position, _markers, _radius, _special];

_unit
