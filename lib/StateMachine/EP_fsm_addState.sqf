// [SM, "stateName", {}, [ { time > 10 }, "Objective1" ]] call EP_fsm_addState;

params ["_sm", "_name", "_onEnter", "_transitions"];

private _states = _sm get "states";
_states pushBack [_name, _onEnter, _transitions];
_sm set ["states", _states];
