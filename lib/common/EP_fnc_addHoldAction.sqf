/**
	ep_fnc_addHoldAction

	FEATURE
	Adds a hold action to an object

	RETURNS
	action ID

	PARAMETERS
	M|1. Object to attach action to
	M|2. Title of the hold action
	M|3. Code to execute when hold action is completed
	M|4. Icon to show when hold action is visible
	O|5. Duration to hold the action (Default 3)
	O|6. Condition to show the hold action (Default "true")
	O|7. Arguments to pass to the code (Default [])
	O|8. Remove hold action after completed (Default true)
	O|9. Priority of the action (Default 1000)
	O|10. Icon to show for progressing (Default will be same as icon to show when visible)
	O|11. Condition for progression (Default "true")
	O|12. Code to execute when hold action starts (Default {})
	O|13. Code to execute while progressing (Default {})
	O|14. Code to execute if hold action is interrupted (Default {})
	O|15. Show hold action for unconscious (Default false)
	O|16. Show hold action window as soon as condition to show is met (Default true)
*/

params [
	"_attachTo", "_title", "_codeFinish", "_iconStart",
	["_duration", 3],
	["_conditionToShow", "true"],
	["_arguments", []],
	["_removeCompleted", true],
	["_priority", 1000],
	["_iconProgress", objNull],
	["_conditionToProgress", "true"],
	["_codeStart", {}],
	["_codeProgress", {}],
	["_codeInterupted", {}],
	["_showUnconsious", false],
	["_showWindow", true]
];
private ["_actionId"];

if (isNull _iconProgress) then { _iconProgress = _iconStart };

_actionId = [
	_attachTo,
	_title,
	_iconStart,
	_iconProgress,
	_conditionToShow,
	_conditionToProgress,
	_codeStart,
	_codeProgress,
	_codeFinish,
	_codeInterupted,
	_arguments,
	_duration,
	_priority,
	_removeCompleted,
	_showUnconsious,
	_showWindow
] call BIS_fnc_holdActionAdd;

_actionId
