/*------------------------------------------------------------------------------------------
Function: EP_fnc_collectUnits

Description:
	Collects units according to incoming parameter

Parameters:
	1. Units reference: <GROUP>, <STRING>, [<OBJECT>...], <OBJECT>

Returns:
	[<OBJECT>...] : Collected units 

Example:
	"LAYER_NAME" call EP_fnc_collectUnits;

	EP_Alpha call EP_fnc_collectUnits;

	[EP_ATSoldier, EP_Medic, EP_Bravo] call EP_fnc_collectUnits;

Author:
	EP
------------------------------------------------------------------------------------------*/

if !(_this isEqualType []) then {
    _this = [_this];
};

//Collect units
private _units = [];
{
    switch true do {
        case (_x isEqualType ""): {_units append (getMissionLayerEntities _x # 0)};
        case (_x isEqualType grpNull): {_units append (units _x)};
        case (_x isEqualType []): {_units append _x};
        case (_x isEqualType objNull): {_units append [_x]};
        default {systemChat format ["[LOG] %1(%2): %3", __FILE__, __LINE__, "EP_fnc_collectUnits: Cannot get units! Parameter must be <GROUP>, <STRING>, [<OBJECT>...], <OBJECT>"]}
    };
} forEach _this;

_units