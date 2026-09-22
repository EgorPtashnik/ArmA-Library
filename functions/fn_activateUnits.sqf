/*------------------------------------------------------------------------------------------
Function: EP_fnc_activateUnits

Description:
	Unhides units, enable their simulation and damage, disables their captivity state

Parameters:
	1. Units Reference: <GROUP>, <STRING>, [<OBJECT>...], <OBJECT>

Returns:
	[<OBJECT>...] : Affected units

Example:
	"LAYER_NAME" call EP_fnc_activateUnits;

	EP_Alpha call EP_fnc_activateUnits;

	[EP_ATSoldier, EP_Medic, EP_Bravo] call EP_fnc_activateUnits;

Author:
	EP
------------------------------------------------------------------------------------------*/
private _units = _this call EP_fnc_collectUnits;

private "_veh";
{
    _veh = vehicle _x;
    _veh hideObject false; _veh enableSimulation true; _veh allowDamage true; _veh setCaptive false
} forEach _units;

_units