//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

{
	private _side 		= _x # 0;
	private _sideParams = _x # 1;

	[(units _side), _sideParams] call EP_fnc_setAISkill;
} forEach _this;

{ _x deleteGroupWhenEmpty true } forEach allGroups;

EP_SimpleTriggers = [];
EP_Triggers = [];
