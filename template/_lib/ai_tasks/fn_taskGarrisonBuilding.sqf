//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
    "_units",
    ["_center", 50],
    ["_radius", 50],
    ["_maxPositionsPerBuilding", -1],
    ["_customPositionsOnly", false]
];

_units = _units call EP_fnc_collectUnits;

if (_center isEqualType 0) then {
    _radius = _center;
    _center = (_units # 0) call EP_fnc_getPosition;
} else {
    _center = _center call EP_fnc_getPosition;
};

{ _x doMove _center } forEach _units;

private _infantry = _units select { vehicle _x == _x };
private _notInfantry = _units select { vehicle _x != _x };


private _buildings = (_center nearObjects ["Building", _radius]) call BIS_fnc_arrayShuffle;
private _availablePositions = [];
{
    private _positions = [_x, _customPositionsOnly, _maxPositionsPerBuilding] call EP_fnc_getBuildingPositions;
    if (count _positions == 0) then { continue };

    _positions = _positions call BIS_fnc_arrayShuffle;
    _availablePositions append _positions;
} forEach _buildings;

{
    if (count _availablePositions == 0) exitWith {};
    private _pos = _availablePositions deleteAt 0;
    [_x, _pos] spawn {
        params ["_unit", "_pos"];

        [_unit, "UP"] call EP_fnc_setAIMode;
        _unit doMove _pos;

        waitUntil {_unit distance _pos < 5};

        for "_i" from 0 to 30 do {
            if (unitReady _unit || _unit distance _pos < 1) exitWith {};
            sleep 1;
        };

        doStop _unit;
        _unit spawn EP_fnc_setInsidePosition;
    };
} forEach _infantry;


