if !(_this isEqualType []) then {
	_this = [_this];
};

private _units = [];
{
	switch (typeName _x) do {
		case "GROUP"	: { _units append (units _x) };
		case "OBJECT"	: { _units append [_x] };
		case "ARRAY"	: { _units append _x };
		case "STRING"	: { _units append (getMissionLayerEntities _x # 0) };
		default			  { systemChat "EP_fnc_collectUnits: Invalid incoming parameter!" };
	};
} forEach _this;

_units;
