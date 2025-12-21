/**
	Adds hold action to an object

	PARAMETERS:
		_attachTo							: OBJECT - to whom attach the action
		_title								:	STRING - title action
		_codeFinish						:	CODE - code to execute after hold action is completed
		_iconStart						: STRING - path to icon to show when hold action is visible
		_duration							: NUMBER (Default 3) - how long to hold the space key
		_conditionToShow			: STRING (Default "true") - condition to show hold action
		_arguments						: ARRAY (Default []) - arguments to pass to functions
		_removeCompleted			: BOOLEN  (Default true) - remove hold action after completed
		_priority							: NUMBER (Default 1000) - action priority (for showing in the menu)
		_iconProgress					: STRING (Default objNull) - icon for progressing (default will be _iconStart)
		_conditionToProgress	: STRING (Default "true") - condition for progression
		_codeStart						: CODE (Default {}) - code for starting hold action
		_codeProgress					: CODE (Default {}) - code for progressing hold action
		_codeInterupted				: CODE (Default {}) - code for stopping holding key
		_showUnconsious				: BOOLEAN (Default false) - show for unconsious
		_showWindow						: BOOLEAN (Default true) - show hold action icon as soon as _conditionToShow is completed

	RETURNS
		NONE
	
	EXAMPLE
		[player, "HOLD ACTION", { hint "START" }, ""] call EP_fnc_addHoldAction;

*/

params [
	"_attachTo",
	"_title",
	"_codeFinish",
	"_iconStart",
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

if (isNull _iconProgress) then {
	_iconProgress = _iconStart;
};

[
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
