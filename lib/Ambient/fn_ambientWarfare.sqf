#define EP_AMB_WARFARE_VOLUME 3
#define EP_AMB_WARFARE_SOUND_PITCH 1
#define EP_AMB_WARFARE_SOUND_DISTANCE 0
#define EP_AMB_WARFARE_MIN_DISTANCE 350
#define EP_AMB_WARFARE_MID_DISTANCE 500
#define EP_AMB_WARFARE_MAX_DISTANCE 800
#define EP_AMB_WARFARE_MAX_SLEEP 45

params [
	["_includeAirSFX", false]
];

// Default sounds
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

// Air extension sounds
private _gAirSoundList = [
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli1.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli2.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli3.wss", 
 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet1.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet2.wss", 
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet3.wss"
];

if (_includeAirSFC) then { _gSoundList append _gAirSoundList };
 
private _gTarget = player; 
private _gSoundObject = player;
 
while {true} do { 
    _dir = round random 360;  
    _dis = round random [EP_AMB_WARFARE_MIN_DISTANCE,EP_AMB_WARFARE_MID_DISTANCE,EP_AMB_WARFARE_MAX_DISTANCE]; 
    private _gSoundPosition = _gTarget getRelPos [_dis, _dir]; 
    private _gSound = selectRandom _gSoundList; 
    playSound3D [_gSound, _gSoundObject, false, _gSoundPosition, EP_AMB_WARFARE_VOLUME, EP_AMB_WARFARE_SOUND_PITCH, EP_AMB_WARFARE_SOUND_DISTANCE]; 
    private _sleepRandom = round random EP_AMB_WARFARE_MAX_SLEEP; 
    sleep _sleepRandom; 
};
