private _units = _this call EP_fnc_collectUnits;
{_x hideObject false; _x enableSimulation true; _x allowDamage true; _x setCaptive false} forEach _units;

true