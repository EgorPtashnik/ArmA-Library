/**
	Apply Simple Convoy system to a group
 */

params [
	"_convoyGroup",
	["_convoySpeed",50],
	["_convoySeparation",50],
	["_pushThrough", true]
];

private _group = _convoyGroup call CBA_fnc_getGroup;

_group setFormation "COLUMN";
if (_pushThrough) then {
	_group enableAttack !_pushThrough;
	{ (vehicle _x) setUnloadInCombat [false, false]; } forEach units _group;
};

{
	(vehicle _x) limitSpeed _convoySpeed * 1.15;
	(vehicle _x) setConvoySeparation _convoySeparation;
} forEach (units _group);

(vehicle leader _group) limitSpeed _convoySpeed;

while {sleep 5; !isNull _group} do {
	{
		if ( (speed vehicle _x < 5) && (_pushThrough || (behaviour _x != "COMBAT") ) ) then {
			(vehicle _x) doFollow (leader _group);
		};	
	} forEach (units _group) - (crew (vehicle (leader _group))) - allPlayers;
	{ (vehicle _x) setConvoySeparation _convoySeparation; } forEach (units _group);
};