"filmGrain" ppEffectEnable true;
"filmGrain" ppEffectAdjust [0.5, 1.2, 2, 0.2, 0.2, true];
"filmGrain" ppEffectCommit 0;

"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1.1, 1.3, 1.1, 0.8], [0.299, 0.587, 0.114, 0]];
"colorcorrections" ppeffectcommit 0;

{
	private _side = _x # 0;
	private _sideParams = (_x # 1);
	[(units _side), _sideParams] call EP_fnc_setAISkill;
} forEach _this;

{ _x deleteGroupWhenEmpty true } forEach allGroups;
