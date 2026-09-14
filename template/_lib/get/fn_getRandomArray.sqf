/* ----------------------------------------------------------------------------
Function: EP_fnc_getRandomArray

Description:
    Selects a number of random elements from an array, optionally without
    duplication.

Parameters:
    0: _initArray (Array) - Source array to select from.
    1: _resultCount (Number) - Number of elements to select.
    2: _withoutDublication (Boolean, optional) - If true, selected elements are removed from
        consideration so they cannot be picked twice. Default false.

Example:
    [["A", "B", "C", "D"], 2, true] call EP_fnc_getRandomArray

Returns:
    Array - The selected elements.
---------------------------------------------------------------------------- */

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