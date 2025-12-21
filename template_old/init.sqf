#include "initLibrary.sqf";

SM = call EP_fsm_createStateMachine;
#include "mission\StateHandlers.sqf";
#include "mission\States.sqf";

[SM, "Intro"] call EP_fsm_startStateMachine;
