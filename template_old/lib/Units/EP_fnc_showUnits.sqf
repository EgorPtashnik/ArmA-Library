/**
	Shows units and enables their simulation
	
	PARAMETERS
		_this	: ARRAY - array of units
	
	RETURNS
		ARRAY - units

	EXAMPLE
	(units group player) call EP_fnc_showUnits;
*/


private ["_vehicle"];
{
  _vehicle = vehicle _x;
  _vehicle enableSimulation true;
  _vehicle hideObject false;
  _vehicle setCaptive false;
  _vehicle allowDamage true;
} forEach _this;

_this
