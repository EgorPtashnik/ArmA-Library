/**
	Gets a state from a state machine by name
	
	PARAMETERS:
		_sm				: STATE MACHINE - the state machine
		_name 		: State name- the name of the state to get
	
	RETURNS:
		STATE - the found state, or objNull if not found

	EXAMPLE:
		private _state = [_sm, "Idle"] call EP_fsm_getState;
*/
params ["_sm", "_name"];

private _states = _sm get "states";
private _found = (_states select { _x select 0 == _name } ) select 0;
if (_found isEqualTo []) exitWith { objNull };
_found;
