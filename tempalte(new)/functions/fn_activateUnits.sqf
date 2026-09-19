private _units = _this call EP_fnc_collectUnits;
private "_veh";
{
    _veh = vehicle _x;
    _veh hideObject false; _veh enableSimulation true; _veh allowDamage true; _veh setCaptive false
} forEach _units;

_units