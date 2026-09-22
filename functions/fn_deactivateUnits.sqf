/*------------------------------------------------------------------------------------------
Function: EP_fnc_deactivateUnits

Description:
	Hides units, disable their simulation and damage, enables their captivity state

Parameters:
	1. Units Reference: <GROUP>, <STRING>, [<OBJECT>...], <OBJECT>

Returns:
	[<OBJECT>...] : Affected units

Example:
	"LAYER_NAME" call EP_fnc_deactivateUnits;
	EP_Alpha call EP_fnc_deactivateUnits;
	[EP_ATSoldier, EP_Medic, EP_Bravo] call EP_fnc_deactivateUnits;

Author:
	EP
------------------------------------------------------------------------------------------*/
private _units = _this call EP_fnc_collectUnits;
private "_veh";
{
    _veh = vehicle _x;
    _veh hideObject true; _veh enableSimulation false; _veh allowDamage false; _veh setCaptive true
} forEach _units;

_units