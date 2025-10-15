// [SM, "init"] call EP_fsm_startStateMachine;

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
