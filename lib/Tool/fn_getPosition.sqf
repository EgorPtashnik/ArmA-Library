switch (typeName _this) do {
	case "STRING"	: { _this = getMarkerPos _this };
	case "GROUP"	: { _this = getPos leader _this };
	case "OBJECT"	: { _this = getPos _this };
	case "ARRAY"	: { _this = _this };

	default 		  { systemChat (format ["EP_fnc_getPosition: %1 is not a valid parameter!", _this]) };
};

_this
