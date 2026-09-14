/* ----------------------------------------------------------------------------
Function: EP_fnc_addAction

Description:
    Wrapper around addAction that stringifies the condition code and safely
    validates the target object.

Parameters:
    0: _attachTo (Object) - Object to attach the action to.
    1: _title (String) - Action title.
    2: _condition (Code, optional) - Condition for showing the action. Default { true }.
    3: _code (Code, optional) - Code executed when the action is used. Default {}.
    4: _args (Anything, optional) - Arguments passed to _code as _this select 3. Default [].
    5: _priority (Number, optional) - Action priority in the action list. Default 1.5.
    6: _showWindow (Boolean, optional) - Show the action's info window. Default true.
    7: _hideOnUse (Boolean, optional) - Hide the action after use. Default true.
    8: _shortcut (String, optional) - Custom user action shortcut. Default "".
    9: _unconscious (Boolean, optional) - Show the action while unconscious. Default false.

Example:
    [myTruck, "Repair", { true }, { hint "Repaired!" }] call EP_fnc_addAction

Returns:
    Number - The added action's ID, or nothing if _attachTo is invalid.
---------------------------------------------------------------------------- */

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
