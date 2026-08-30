//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

if !(_this isEqualType []) then {
	_this = [_this];
};

{
	_x addEventHandler ["VisionModeChanged", {
		private _person = _this # 0;
		if (_person == player) then {

			// Create PP effects if this is player or player is in this vehicle
			private _veh = vehicle _person;
			if ((currentVisionMode _veh) == 1) then {
				EPNvgEffectRadial = ppEffectCreate ["radialBlur",100]; 
				EPNvgEffectRadial ppEffectEnable true; 
				EPNvgEffectRadial ppEffectAdjust [0.02,0.13,0.21,0.36]; 
				EPNvgEffectRadial ppEffectCommit 0;  
				EPNvgEffectDynamic = ppEffectCreate ["DynamicBlur",100]; 
				EPNvgEffectDynamic ppEffectEnable true; 
				EPNvgEffectDynamic ppEffectAdjust [0.35]; 
				EPNvgEffectDynamic ppEffectCommit 0; 
				EPNvgEffectGrain = ppEffectCreate ["FilmGrain",2000]; 
				EPNvgEffectGrain ppEffectEnable true; 
				EPNvgEffectGrain ppEffectAdjust [0.14,1,1,0.5,0.5,true];
				EPNvgEffectGrain ppEffectCommit 0;
				EPNvgEffectColor = ppEffectCreate ["ColorCorrections", 1502];  
				EPNvgEffectColor ppEffectEnable true;
				EPNvgEffectColor ppEffectAdjust [1, 0.6, 0, [0, 0.1, 0.2, 0], [0, 1, 1.2, 0], [1, 1, 1, 0]];      
				EPNvgEffectColor ppEffectCommit 0;
				EPNvgEffectColor ppEffectForceInNVG true;
			};

			// Wait until NVG is off to remove PP effects
			_veh spawn {
				waitUntil { (currentVisionMode _this) != 1 };
				ppEffectDestroy EPNvgEffectRadial; 
				ppEffectDestroy EPNvgEffectDynamic;
				ppEffectDestroy EPNvgEffectGrain;
				ppEffectDestroy EPNvgEffectColor;
			};
		};
	}];
} forEach _this;

true