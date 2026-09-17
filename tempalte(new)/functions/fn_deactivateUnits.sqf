private _units = _this call EP_fnc_collectUnits;
{_x hideObject true; _x enableSimulation false; _x allowDamage false; _x setCaptive true} forEach _units;

true