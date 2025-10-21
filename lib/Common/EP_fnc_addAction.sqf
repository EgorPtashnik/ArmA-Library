params [
	"_attachTo",
	"_title",
	"_code",
	["_condition", "true"],
	["_args", nil],
	["_priority", 1.5],
	["_showWindow", true],
	["_hideOnUse", true],
	["_shortcut", ""],
	["_radius", 50],
	["_unconcious", false]
];

private _actionId = _attachTo addAction [
	_title,
	_code,
	_args,
	_priority,
	_showWindow,
	_hideOnUse,
	_shortcut,
	_condition,
	_radius,
	_unconcious
];

_actionId
