
//- - - Environment Setup - Cinematic tint and little grain
"colorCorrections" ppEffectEnable true; 
"colorCorrections" ppEffectAdjust [1, 1, -0.003, [0.0, 0.0, 0.0, 0.0], [1.0, 0.8, 0.6, 0.6],  [0.199, 0.587, 0.114, 0.0]];   
"colorcorrections" ppeffectcommit 0;

"filmGrain" ppEffectEnable true;  
"filmGrain" ppEffectAdjust [0.05, 1, 1, 0.1, 1, false]; 
"filmGrain" ppEffectCommit 0;


//Custom Postprocess
"colorCorrections" ppEffectEnable true; 
"colorCorrections" ppEffectAdjust [0.9, 1, 0, [0.1, 0.1, 0.1, -0.1], [1, 1, 0.8, 0.528],  [1, 0.2, 0, 0]]; 
"colorCorrections" ppEffectCommit 0; 

//- - - Skills Setup - Blufor
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
  
} forEach (allUnits select {side _x isEqualTo BluFor});

//- - - Skills Setup - Indfor
{  
    _x setskill 0.5;  
    _x setskill ["aimingAccuracy",0.25];  
    _x setskill ["aimingShake",0.25];  
    _x setskill ["aimingSpeed",0.25];  
    _x setskill ["spotDistance",0.5];  
    _x setskill ["spotTime",0.5];  
    _x setskill ["courage",0.5];  
    _x setskill ["reloadSpeed",0.5];  
    _x setskill ["commanding",0.5];  
    _x allowFleeing 0;  
  
} forEach (allUnits select {side _x isEqualTo independent});