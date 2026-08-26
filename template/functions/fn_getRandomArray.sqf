//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_initArray",
	"_resultCount",
	["_withoutDublication", false]
];

private _array = [];
private _count = count _initArray;

if (_withoutDublication && _resultCount > _count) exitWith {
	systemChat "EP_fnc_getRandomArray: result cannot be bigger than initial array for 'without dublication' scenario."
};

for "_i" from 1 to _resultCount do {

	if (_withoutDublication) then {
		_array pushBack (_initArray deleteAt (floor random _count));
		_count = _count - 1;
	} else {
		_array pushBack (selectRandom _initArray);
	};
};

_array