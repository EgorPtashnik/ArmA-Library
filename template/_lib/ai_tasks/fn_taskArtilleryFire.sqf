/* ----------------------------------------------------------------------------
Function: EP_fnc_taskArtilleryFire

Description:
    Orders one or more artillery pieces to fire a salvo at a target position,
    with a randomised delay between each shot.

Parameters:
    0: _arti (Group or Array of Objects) - Artillery group or list of artillery vehicles.
    1: _target (Position, Object, Array or Group) - Target location.
    2: _rounds (Number) - Number of rounds each artillery piece will fire.
    3: _magType (String, optional) - Magazine (shell) type. Defaults to the first magazine of the first artillery piece.
    4: _sleepRange (Array, optional) - [min, mid, max] random delay between shots. Defaults to [0.5, 1, 1.5].

Example:
    [artyGroup, getPos targetMarker, 3] call EP_fnc_taskArtilleryFire

Returns:
    Array of Objects - The artillery vehicles that fired, or false if the target is out of range.
---------------------------------------------------------------------------- */

params [
	"_arti",
	"_target",
	"_rounds",
	[ "_magType", objNull ],
	[ "_sleepRange", [0.5, 1, 1.5] ]
];

_target = _target call EP_fnc_getPosition;

// Get vehicles from group if group is passed
if (_arti isEqualType grpNull) then {
	_arti = [_arti, false] call BIS_fnc_groupVehicles;
};

// Get first magazine type if not specified
if (isNull _magType) then { 
	_magType = magazines (_arti # 0) # 0;
};

// Check if target is in range of artillery
private _isInRange = _target inRangeOfArtillery [_arti, _magType];
if (!_isInRange) exitWith { false };

// Fire!
{
	_x doArtilleryFire [ _target, _magType, _rounds ];
	sleep ( selectRandom _sleepRange );
} forEach _arti;

_arti
