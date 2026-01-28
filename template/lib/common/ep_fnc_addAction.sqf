/**
    ep_fnc_addAction

    FEATURE
    Attaches action to object with various parameters

    RETURNS
    action ID

    USAGE
    [_attachTo, _title, _code] call ep_fnc_addAction

    PARAMETERS
    M|1. Object to attach action to
    M|2. Title of the action
    M|3. Code to execute when action is selected
	O|4. Condition for action to be available (Default: "true")
	O|5. Arguments to pass to code (Default: nil)
	O|6. Priority of the action (Default: 1.5)
	O|7. Show action window (Default: true)
	O|8. Hide action after use (Default: true)
	O|9. Shortcut key (Default: "")
	O|10. Radius for action (Default: 50)
	O|11. Allow action when unconscious (Default: false)
*/

params [
	"_attachTo", "_title", "_code",
	["_condition", "true"],
	["_args", nil],
	["_priority", 1.5],
	["_showWindow", true],
	["_hideOnUse", true],
	["_shortcut", ""],
	["_radius", 50],
	["_unconscious", false]
];
private ["_actionId"];

_actionId = _attachTo addAction [
	_title,
	_code,
	_args,
	_priority,
	_showWindow,
	_hideOnUse,
	_shortcut,
	_condition,
	_radius,
	_unconscious
];

_actionId
