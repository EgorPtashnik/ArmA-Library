// SM call EP_fsm_handleUpdate;

params ["_sm"];

private ["_current", "_stateDef", "_transitions", "_next", "_cond"];

_current = _sm get "current";
if (_current isEqualTo "") exitWith {};

_stateDef = [_sm, _current] call EP_fsm_getState;
_transitions = _stateDef select 2;

{
	_next = _x select 0;
	_cond = _x select 1;
	if (call _cond) exitWith {
		[_sm, _next] call EP_fsm_setState;
	};
} forEach _transitions;
