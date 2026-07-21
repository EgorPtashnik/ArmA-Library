/**
	Inits mission configuration
	[ [blufor, []], [independent, []] ] call ep_fnc_missionInit;
 */

"filmGrain" ppEffectEnable true;
"filmGrain" ppEffectAdjust [0.5, 1.2, 2, 0.2, 0.2, true];
"filmGrain" ppEffectCommit 0;

"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1.1, 1.3, 1.1, 0.8], [0.299, 0.587, 0.114, 0]];
"colorcorrections" ppeffectcommit 0;

private _side = nil;
private _sideParams = nil;
{
	_side = _x # 0;
	_sideParams = _x # 1;
	if (count _sideParams == 0) then { _sideParams = [0.5, 0.2, 0.2, 0.2, 0.5, 0.25, 1, 0.5, 0.5, 0] };

	{
		_x setSkill (_sideParams # 0);
		_x setSkill ["aimingAccuracy", (_sideParams # 1)];
		_x setSkill ["aimingShake", (_sideParams # 2)];
		_x setSkill ["aimingSpeed", (_sideParams # 3)];
		_x setSkill ["spotDistance", (_sideParams # 4)];
		_x setSkill ["spotTime", (_sideParams # 5)];
		_x setSkill ["courage", (_sideParams # 6)];
		_x setSkill ["reloadSpeed", (_sideParams # 7)];
		_x setSkill ["commanding", (_sideParams # 8)];
		_x allowFleeing (_sideParams # 9);
  
	} forEach (allUnits select {side _x isEqualTo _side});

} forEach _this;
