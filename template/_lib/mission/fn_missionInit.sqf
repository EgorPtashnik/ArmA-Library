/* ----------------------------------------------------------------------------
Function: EP_fnc_missionInit

Description:
    Initial mission setup: applies default skill settings per side and makes
    every existing group delete itself once empty.

Parameters:
    0: _this (Array of Arrays) - [Side, SkillParams] pairs, where SkillParams is
        passed to EP_fnc_setAISkill for that side's units.

Example:
    [[west, [["AIM", 0.4]]], [east, [["AIM", 0.6]]]] call EP_fnc_missionInit

Returns:
    Nothing.
---------------------------------------------------------------------------- */

{
	private _side 		= _x # 0;
	private _sideParams = _x # 1;

	[(units _side), _sideParams] call EP_fnc_setAISkill;
} forEach _this;

{ _x deleteGroupWhenEmpty true } forEach allGroups;

EP_SimpleTriggers = [];
EP_Triggers = [];
