/* ----------------------------------------------------------------------------
Function: EP_fnc_taskGarrisonBuilding

Description:
    Garrisons infantry into building positions around a central point. Each
    unit is sent to a randomly selected position inside nearby buildings and
    then locked into place.

Parameters:
    0: _units (Group, Object, or Array) - Units to garrison. Passed through EP_fnc_collectUnits.
    1: _center (Position, Object, Array or Number, optional) - Centre of the garrison area.
        If a Number is provided it is interpreted as _radius and the centre defaults to the first unit's position.
        Default 50 (used as radius fallback).
    2: _radius (Number, optional) - Search radius for buildings. Default 50.
    3: _maxPositionsPerBuilding (Number, optional) - Max positions used per building. -1 for no limit. Default -1.
    4: _customPositionsOnly (Boolean, optional) - If true, only custom building positions are used. Default false.

Example:
    [garrisonGroup, getMarkerPos "objGarrison", 75] call EP_fnc_taskGarrisonBuilding

Returns:
    Nothing.
---------------------------------------------------------------------------- */

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


