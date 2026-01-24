/**
	Hides units and disables their simulation
	
	PARAMETERS
		_this	: ARRAY - array of units
	
	RETURNS
		ARRAY - units

	EXAMPLE
	(units group player) call EP_fnc_hideUnits;
*/


private ["_vehicle"];
{
  _vehicle = vehicle _x;
  _vehicle enableSimulation false;
  _vehicle hideObject true;
  _vehicle setCaptive true;
  _vehicle allowDamage false;
} forEach _this;

_this;
