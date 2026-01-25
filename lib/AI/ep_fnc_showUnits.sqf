/** ep_fnc_showUnits

FEATURE
Shows units and enables their simulation

RETURNS
units (array)

USAGE
[group] call ep_fnc_showUnits

PARAMETERS
1. units or group to show
*/

if (typeName _this == "GROUP") then {_this = units _this};

private ["_vehicle"];
{
  _vehicle = vehicle _x;
  _vehicle enableSimulation true;
  _vehicle hideObject false;
  _vehicle setCaptive false;
  _vehicle allowDamage true;
} forEach _this;

_this
	