/* ----------------------------------------------------------------------------
Function: EP_fnc_getBuildingPositions

Description:
    Returns available positions inside a building, combining built-in
    building positions with nearby CBA custom building positions that fall
    within the building's bounding box.

Parameters:
    0: _building (Object) - The building to get positions from.
    1: _customPositionsOnly (Boolean, optional) - Skip built-in buildingPos positions. Default false.
    2: _max (Number, optional) - Maximum number of positions to return. -1 for no limit. Default -1.

Example:
    [nearestBuilding player] call EP_fnc_getBuildingPositions

Returns:
    Array of Positions - The available building positions.
---------------------------------------------------------------------------- */

params [
    "_building",
    ["_customPositionsOnly", false],
    ["_max", -1]
];

private _availablePositions = [];

if !(_customPositionsOnly) then {
    _availablePositions = _building buildingPos -1;
};

// add nearby custom building positions
(0 boundingBoxReal _building) params ["_pos1", "_pos2", "_diameter"];
_pos1 params ["_x1", "_y1", "_z1"];
_pos2 params ["_x2", "_y2", "_z2"];

private _polygonTop = [
    [_x1, _y1, 0],
    [_x2, _y1, 0],
    [_x2, _y2, 0],
    [_x1, _y2, 0]
];

private _polygonSide = [
    [_x1, _z1, 0],
    [_x2, _z1, 0],
    [_x2, _z2, 0],
    [_x1, _z2, 0]
];

private _customPositions = nearestObjects [_building, ["CBA_buildingPos"], _diameter, true] apply {
    _x buildingPos 0
} select {
    private _customPositionTop = _building worldToModel _x;
    private _customPositionSide = +_customPositionTop;
    _customPositionSide pushBack (_customPositionSide deleteAt 1); // swap y and z

    _customPositionTop inPolygon _polygonTop && _customPositionSide inPolygon _polygonSide
};

_availablePositions append _customPositions;

if (_max >= 0) then {
    _availablePositions resize (_max min count _availablePositions);
};

_availablePositions
