/* ----------------------------------------------------------------------------
Function: EP_fnc_createGuidedProjectile

Description:
    Spawns a guided projectile that flies from an offset above/around an
    object toward a target.

Parameters:
    0: _start (Object) - Object the projectile is launched from.
    1: _target (Position, Object, Array or Group) - Target of the projectile.
    2: _muzzle (String, optional) - Projectile/muzzle class. Default "Missile_AGM_01_F".
    3: _offset (Array, optional) - Model-space offset from _start used as the spawn point. Default [0, 0, 20].
    4: _speed (Number, optional) - Projectile speed. Default 200.

Example:
    [attackHeli, enemyTank] call EP_fnc_createGuidedProjectile

Returns:
    Nothing.
---------------------------------------------------------------------------- */

params [
	"_start",
	"_target",
	["_muzzle", "Missile_AGM_01_F"],
	["_offset", [0, 0, 20]],
	["_speed", 200]
];

private _spawnPos = _start modelToWorld _offset;
[_spawnPos, _muzzle, _target, _speed] spawn BIS_fnc_EXP_camp_guidedProjectile;
