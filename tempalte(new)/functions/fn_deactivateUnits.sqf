private _units = _this call EP_fnc_collectUnits;
private "_veh";
{
    _veh = vehicle _x;
    _veh hideObject true; _veh enableSimulation false; _veh allowDamage false; _veh setCaptive true
} forEach _units;

_units