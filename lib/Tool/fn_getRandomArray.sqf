params [
	"_initArray",
	"_resultCount",
	["_withoutDublication", false]
];

private _array = [];
private _initArrayCount = count _initArray;

if (_withoutDublication && _resultCount > _initArrayCount) exitWith {
	systemChat "ep_fnc_getRandomArray: result cannot be bigger than initial array for 'without dublication' scenario."
};

for "_i" from 1 to _resultCount do {

	if (_withoutDublication) then {
		_array pushBack (_initArray deleteAt (floor random _initArrayCount));
		_initArrayCount = _initArrayCount - 1;
	} else {
		_array pushBack (selectRandom _initArray);
	};
};

_array