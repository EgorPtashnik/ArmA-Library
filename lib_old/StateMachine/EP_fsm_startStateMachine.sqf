/**
	Starts a state machine, setting its initial state and beginning its update loop

	PARAMETERS:
		_sm										: STATE MACHINE - the state machine to start
		_initial							: STRING - name of the initial state to set

	RETURNS:
		NONE

	EXAMPLE:
		[sm, "init"] call EP_fsm_startStateMachine;
*/

params ["_sm", "_initial"];

[_sm, _initial] call EP_fsm_setState;
_sm set ["running", true];

[_sm] spawn {
	params ["_sm"];
	while { _sm get "running" } do {
		[_sm] call EP_fsm_handleUpdate;
		sleep 1;
	};
};
