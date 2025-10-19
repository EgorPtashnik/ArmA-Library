/**
  Shows or hides units
  
  PARAMETERS
    _units  : GROUP or ARRAY - group | array of groups | array of units
    _toHide : BOOLEAN - true to hide, false to show
  
  RETURNS
    ARRAY - array of units

  EXAMPLE
    [group player, true] call EP_fnc_showHideUnits;
 */
params [
  "_units",
  ["_toHide", true]
];

_units = (_units call EP_fnc_getUnits);

if (_toHide) then {
  _units call EP_fnc_hideUnits;
} else {
  _units call EP_fnc_showUnits;
};

_units
