/*
	"colorCorrections" ppEffectEnable true; 
	"colorCorrections" ppEffectAdjust [0.85, 0.95, 0, [0.1, 0.15, 0.2, 0], [0.85, 0.85, 0.9, 0.6], [0.6, 0.7, 0.8, 0]]; 
	"colorCorrections" ppEffectCommit 0;
*/

{  
    _x setskill 0.25;
    _x setskill ["aimingAccuracy",0.05];
    _x setskill ["aimingShake",0.05];
    _x setskill ["aimingSpeed",0.05];
    _x setskill ["spotDistance",0.5];
    _x setskill ["spotTime",0.25];
    _x setskill ["courage",0.25];
    _x setskill ["reloadSpeed",0.5];
    _x setskill ["commanding",0.5];
    _x allowFleeing 0;
} forEach allUnits;

// { false } forEach getMissionLayerEntities "name" # 0;