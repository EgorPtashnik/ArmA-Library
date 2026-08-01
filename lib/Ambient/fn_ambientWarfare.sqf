params [
	["_includeAirSFX", false]
];

private _gSoundList = [ 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions1.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions2.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions3.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions4.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions5.wss", 
 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight1.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight2.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight3.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight4.wss"
];

private _gAirSoundList = [
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli1.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli2.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli3.wss", 
 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet1.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet2.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet3.wss"
];

if (_includeAirSFC) then { _gSoundList = _gSoundList + _gAirSoundList };
 
private _gTarget = player; 
private _gSoundObject = player; 
private _gVolume = 3; 
private _gSoundPitch = 1; 
private _gSoundDistance = 0; 
private _maxCountSleep = 45; 
private _gMinDistance = 350; 
private _gMaxDistance = 800; 
private _gMedDistance = 500; 
 
while {true} do { 
    _dir = round random 360;  
    _dis = round random [_gMinDistance,_gMedDistance,_gMaxDistance]; 
    private _gSoundPosition = _gTarget getRelPos [_dis, _dir]; 
    private _gSound = selectRandom _gSoundList; 
    playSound3D [_gSound, _gSoundObject, false, _gSoundPosition, _gVolume, _gSoundPitch, _gSoundDistance]; 
    private _sleepRandom = round random _maxCountSleep; 
    sleep _sleepRandom; 
};
