// [SM, "init"] call EP_fsm_getState;

params ["_sm", "_name"];

private _states = _sm get "states";
private _found = (_states select { _x select 0 == _name } ) select 0;
if (_found isEqualTo []) exitWith { objNull };
_found;
