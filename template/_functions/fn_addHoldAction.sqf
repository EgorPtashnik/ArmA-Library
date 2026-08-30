//************************************************************************************************************
// FUNCTION - Add Gold action to 
//************************************************************************************************************

params [
	"_attachTo",
	"_title",
	"_codeFinish",
	"_iconStart",
	["_duration", 3],
	["_conditionToShow", { true }],
	["_arguments", []],
	["_removeCompleted", true],
	["_priority", 1000],
	["_iconProgress", objNull],
	["_conditionToProgress", { true }],
	["_codeStart", {}],
	["_codeProgress", {}],
	["_codeInterupted", {}],
	["_showUnconsious", false],
	["_showWindow", true]
];

if (isNull _iconProgress) then {
	_iconProgress = _iconStart;
};

_conditionToShow 		= toString _conditionToShow;
_conditionToProgress 	= toString _conditionToProgress;

private _actionId = [
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
