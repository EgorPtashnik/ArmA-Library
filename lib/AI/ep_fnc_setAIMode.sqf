/**
    ep_fnc_setAIMode

    FEATURE
    Set a group to desired behaviour and combatmode

    RETURNS
    group

    USAGE
	[group, "COMBAT", "RED", "LINE", "LIMITED"] call ep_fnc_setAIMode

    PARAMETERS
    M|1. units or group to hide
	M|2. Combat mode, Behaviour, speed and/or formation to be set (all strings, order does not matter)

	Accepted Strings:
	"COLUMN" "STAG COLUMN" "WEDGE" "ECH LEFT" "ECH RIGHT" "VEE" "LINE" "FILE" "DIAMOND"

	"CARELESS" "SAFE" "AWARE" "COMBAT" "STEALTH".

	"BLUE"  "GREEN"  "WHITE"  "YELLOW" "RED"

	"FULL" "NORMAL" "LIMITED"
*/

private [ "_grp","_modes" ];
_grp = _this select 0;
_modes = _this - [_this select 0];

{
	_x = toUpper _x;
	switch (_x) do {

		//Behaviour
		case "CARELESS": {_grp setBehaviour _x;};
		case "SAFE": {_grp setBehaviour _x;};
		case "AWARE": {_grp setBehaviour _x;};
		case "COMBAT": {_grp setBehaviour _x;};
		case "STEALTH": {_grp setBehaviour _x;};

		//CombatMode
		case "BLUE": {_grp setCombatMode _x;};
		case "GREEN": {_grp setCombatMode _x;};
		case "WHITE": {_grp setCombatMode _x;};
		case "YELLOW": {_grp setCombatMode _x;};
		case "RED": {_grp setCombatMode _x;};

		//Formation
		case "COLUMN": {_grp setFormation _x;};
		case "STAG COLUMN": {_grp setFormation _x;};
		case "WEDGE": {_grp setFormation _x;};
		case "ECH LEFT": {_grp setFormation _x;};
		case "ECH RIGHT": {_grp setFormation _x;};
		case "VEE": {_grp setFormation _x;};
		case "LINE": {_grp setFormation _x;};
		case "FILE": {_grp setFormation _x;};
		case "DIAMOND": {_grp setFormation _x;};

		//Speed
		case "LIMITED": {_grp setSpeedMode _x;};
		case "NORMAL": {_grp setSpeedMode _x;};
		case "FULL": {_grp setSpeedMode _x;};

		default {["ep_fnc_setAIMode DBG:", _x ,"is not a valid parameter!"] call ep_fnc_dbgLog};
	};

} forEach _modes;

_grp
