/**
	Creates a new state machine

	RETURNS:
		STATE MACHINE - the created state machine

	EXAMPLE:
		private _sm = call EP_fsm_createStateMachine;
*/

private _sm = createHashMap;

_sm set ["states", []];
_sm set ["current", ""];
_sm set ["running", false];
_sm;
