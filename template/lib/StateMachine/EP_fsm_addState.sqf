/**
	Adds state to a state machine

	PARAMETERS:
		_sm										: STATE MACHINE - to add the state
		_name									:	STRING - state name
		_onEnter							:	CODE - code to execute when entering the state
		_transitions					: ARRAY - array of transitions in format [ condition, targetStateName ]

	RETURNS:
		NONE
	
	EXAMPLE:
		[sm, "Hint", { hint "Entering Hint State" }, [ { time > 10 }, "Objective1" ]] call EP_fsm_addState;
*/
params ["_sm", "_name", "_onEnter", "_transitions"];

private _states = _sm get "states";
_states pushBack [_name, _onEnter, _transitions];
_sm set ["states", _states];
