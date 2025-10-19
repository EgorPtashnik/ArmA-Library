// [SM, "postInits"] call EP_fsm_setState;
/**
	Sets the current state of a state machine

	PARAMETERS:
		_sm										: STATE MACHINE - the state machine
		_newStateName					:	STRING - name of the new state to set

	RETURNS
		NONE

	EXAMPLE:
			[sm, "Idle"] call EP_fsm_setState;
*/

params ["_sm", "_newStateName"];


_sm set ["current", _newStateName];

private _stateDef = [_sm, _newStateName] call EP_fsm_getState;
private _onEnter = _stateDef select 1;
call _onEnter;
