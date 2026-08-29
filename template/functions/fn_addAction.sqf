params [
    "_attachTo",                    // Attach action to this object
    "_title",                       // Title of the action
    ["_condition", { true }],       // Condition to show action 
    ["_code", {}],                  // Action code to execute
    ["_args", []],                  // Arguments for code (_this select 3)
    ["_priority", 1.5],             // Priority of the action in action list
    ["_showWindow", true],          // Show action if condition is true
    ["_hideOnUse", true],           // Hide action after selection
    ["_shortcut", ""],              // Action shortcut
    ["_unconscious", false]         // Show unconscious
];

if !(_attachTo isEqualType objNull) exitWith {
    diag_log formatText ["[LOG] %1(%2): %3", __FILE__, __LINE__, "Cannot attach action to not an object"];
};


private _actionID = _attachTo addAction [
    _title,
    _code,
    _args,
    _priority,
    _showWindow,
    _hideOnUse,
    _shortcut,
    (toString _condition)
];

_actionID
