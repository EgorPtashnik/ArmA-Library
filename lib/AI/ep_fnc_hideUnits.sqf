/**
    ep_fnc_hideUnits

    FEATURE
    Hides units and disables their simulation

    RETURNS
    units (array)

    USAGE
    [group] call ep_fnc_hideUnits

    PARAMETERS
    M|1. units or group to hide
*/

if (typeName _this == "GROUP") then {_this = units _this};

private ["_vehicle"];
{
  _vehicle = vehicle _x;
  _vehicle enableSimulation false;
  _vehicle hideObject true;
  _vehicle setCaptive true;
  _vehicle allowDamage false;
} forEach _this;

_this
