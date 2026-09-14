/* ----------------------------------------------------------------------------
Function: EP_fnc_addHoldAction

Description:
    Wrapper around BIS_fnc_holdActionAdd that stringifies the show/progress
    conditions and defaults the progress icon to the start icon.

Parameters:
    0: _attachTo (Object) - Object to attach the hold action to.
    1: _title (String) - Action title.
    2: _codeFinish (Code) - Code executed when the hold action completes.
    3: _iconStart (String) - Icon shown before the action starts.
    4: _duration (Number, optional) - Time required to hold the action. Default 3.
    5: _conditionToShow (Code, optional) - Condition for showing the action. Default { true }.
    6: _arguments (Array, optional) - Arguments passed to the action's code. Default [].
    7: _removeCompleted (Boolean, optional) - Remove the action once completed. Default true.
    8: _priority (Number, optional) - Action priority. Default 1000.
    9: _iconProgress (String, optional) - Icon shown while holding. Defaults to _iconStart.
    10: _conditionToProgress (Code, optional) - Condition to keep progressing. Default { true }.
    11: _codeStart (Code, optional) - Code executed when the hold starts. Default {}.
    12: _codeProgress (Code, optional) - Code executed each frame while holding. Default {}.
    13: _codeInterupted (Code, optional) - Code executed if the hold is interrupted. Default {}.
    14: _showUnconsious (Boolean, optional) - Show the action while unconscious. Default false.
    15: _showWindow (Boolean, optional) - Show the action's info window. Default true.

Example:
    [myCrate, "Disarm", { hint "Disarmed!" }, "\a3\ui_f\data\IGUI\Cfg\Actions\repair_ca.paa", 5] call EP_fnc_addHoldAction

Returns:
    Number - The added hold action's ID.
---------------------------------------------------------------------------- */

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
