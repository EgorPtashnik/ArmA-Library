params [
	"_ref",
	["_show", true]
];

private _objects = [];
switch (typeName _ref) do {
	case "STRING"	: { _objects = (getMissionLayerEntities _ref # 0) };
	case "GROUP"	: { _objects = units _ref };
	case "ARRAY"	: { _objects = _ref };
	case "OBJECT"	: { _objects = [_ref] };
	default			  { systemChat (format ["EP_fnc_showObjects: %1 is not a valid parameter!", typeName _ref]) };
};

{
	private _veh = vehicle _x;
	_veh enableSimulation _show;
	_veh hideObject !_show;
	_veh setCaptive !_show;
	_veh allowDamage _show;
} forEach _objects;

_objects
