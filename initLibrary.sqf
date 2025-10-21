//Common Functions
EP_fnc_addAction 				= compile preprocessFileLineNumbers "lib\Common\EP_fnc_addAction.sqf";
EP_fnc_addHoldAction 				= compile preprocessFileLineNumbers "lib\Common\EP_fnc_addHoldAction.sqf";
EP_fnc_handleTasks 					= compile preprocessFileLineNumbers "lib\Common\EP_fnc_handleTasks.sqf";

//AI Functions
EP_fnc_doArtilleryFire 			= compile preprocessFileLineNumbers "lib\AI\EP_fnc_doArtilleryFire.sqf";
EP_fnc_addWaypoint 					= compile preprocessFileLineNumbers "lib\AI\EP_fnc_addWaypoint.sqf";
EP_fnc_clearWaypoints 			= compile preprocessFileLineNumbers "lib\AI\EP_fnc_clearWaypoints.sqf";

//UI Functions
EP_fnc_fadeIn 							= compile preprocessFileLineNumbers "lib\UI\EP_fnc_fadeIn.sqf";
EP_fnc_fadeOut 							= compile preprocessFileLineNumbers "lib\UI\EP_fnc_fadeOut.sqf";
EP_fnc_showSubs 						= compile preprocessFileLineNumbers "lib\UI\EP_fnc_showSubs.sqf";
EP_fnc_conversation 				= compile preprocessFileLineNumbers "lib\UI\EP_fnc_conversation.sqf";

//Units Functions
EP_fnc_hideUnits 						= compile preprocessFileLineNumbers "lib\Units\EP_fnc_hideUnits.sqf";
EP_fnc_showUnits 						= compile preprocessFileLineNumbers "lib\Units\EP_fnc_showUnits.sqf";
EP_fnc_showHideUnits 				= compile preprocessFileLineNumbers "lib\Units\EP_fnc_showHideUnits.sqf";
EP_fnc_getUnits							= compile preprocessFileLineNumbers "lib\Units\EP_fnc_getUnits.sqf";
EP_fnc_createUnits					= compile preprocessFileLineNumbers "lib\Units\EP_fnc_createUnits.sqf";

//Systems
EP_applySystem_OneManTank 	= compile preprocessFileLineNumbers "lib\Systems\EP_applySystem_OneManTank.sqf";
EP_applySystem_CasualHealth = compile preprocessFileLineNumbers "lib\Systems\EP_applySystem_CasualHealth.sqf";
EP_applySystem_HealthBar 		= compile preprocessFileLineNumbers "lib\Systems\EP_applySystem_HealthBar.sqf";
EP_applySystem_SimpleConvoy = compile preprocessFileLineNumbers "lib\Systems\EP_applySystem_SimpleConvoy.sqf";
EP_applySystem_RandomRadio 	= compile preprocessFileLineNumbers "lib\Systems\EP_applySystem_RandomRadio.sqf";

//State Machine Functions
EP_fsm_createStateMachine 	= compile preprocessFileLineNumbers "lib\StateMachine\EP_fsm_createStateMachine.sqf";
EP_fsm_addState 						= compile preprocessFileLineNumbers "lib\StateMachine\EP_fsm_addState.sqf";
EP_fsm_getState 						= compile preprocessFileLineNumbers "lib\StateMachine\EP_fsm_getState.sqf";
EP_fsm_handleUpdate 				= compile preprocessFileLineNumbers "lib\StateMachine\EP_fsm_handleUpdate.sqf";
EP_fsm_setState 						= compile preprocessFileLineNumbers "lib\StateMachine\EP_fsm_setState.sqf";
EP_fsm_startStateMachine 		= compile preprocessFileLineNumbers "lib\StateMachine\EP_fsm_startStateMachine.sqf";
