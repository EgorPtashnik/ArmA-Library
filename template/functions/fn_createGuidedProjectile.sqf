//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_start",
	"_target",
	["_muzzle", "Missile_AGM_01_F"],
	["_offset", [0, 0, 20]],
	["_speed", 200]
];

private _spawnPos = _start modelToWorld _offset;
[_spawnPos, _muzzle, _target, _speed] spawn BIS_fnc_EXP_camp_guidedProjectile;
