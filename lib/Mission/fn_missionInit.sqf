#define EP_MISSION_DEFAULT_SKILL 0.5
#define EP_MISSION_DEFAULT_AIMING_ACCURACY 0.2
#define EP_MISSION_DEFAULT_AIMING_SHAKE 0.2
#define EP_MISSION_DEFAULT_AIMING_SPEED 0.2
#define EP_MISSION_DEFAULT_SPOT_DISTANCE 0.5
#define EP_MISSION_DEFAULT_SPOT_TIME 0.25
#define EP_MISSION_DEFAULT_COURAGE 1
#define EP_MISSION_DEFAULT_RELOAD_SPEED 0.5
#define EP_MISSION_DEFAULT_COMMANDING 0.5
#define EP_MISSION_DEFAULT_FLEEING 0

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
	_sideParams = createHashMapFromArray (_x # 1);

	{
		_x setSkill ( _sideParams getOrDefault ["SKILL", EP_MISSION_DEFAULT_SKILL] );
		_x setSkill ["aimingAccuracy", (_sideParams getOrDefault ["AIM", EP_MISSION_DEFAULT_AIMING_ACCURACY])];
		_x setSkill ["aimingShake", (_sideParams getOrDefault ["AIM_SHAKE", EP_MISSION_DEFAULT_AIMING_SHAKE])];
		_x setSkill ["aimingSpeed", (_sideParams getOrDefault ["AIM_SPEED", EP_MISSION_DEFAULT_AIMING_SPEED])];
		_x setSkill ["spotDistance", (_sideParams getOrDefault ["SPOT", EP_MISSION_DEFAULT_SPOT_DISTANCE])];
		_x setSkill ["spotTime", (_sideParams getOrDefault ["SPOT_TIME", EP_MISSION_DEFAULT_SPOT_TIME])];
		_x setSkill ["courage", (_sideParams getOrDefault ["COURAGE", EP_MISSION_DEFAULT_COURAGE])];
		_x setSkill ["reloadSpeed", (_sideParams getOrDefault ["RELOAD", EP_MISSION_DEFAULT_RELOAD_SPEED])];
		_x setSkill ["commanding", (_sideParams getOrDefault ["COMMAND", EP_MISSION_DEFAULT_COMMANDING])];
		_x allowFleeing (_sideParams getOrDefault ["FLEEING", EP_MISSION_DEFAULT_FLEEING]);
  
	} forEach (allUnits select {side _x isEqualTo _side});

} forEach _this;
