/* ----------------------------------------------------------------------------
Function: EP_fnc_ambientWarfare

Description:
    Loops around the player, playing randomised distant battle sounds
    (firefights, explosions, helicopters, jets) at random intervals and
    directions until the given condition becomes false.

Parameters:
    0: _condition (Code, optional) - Loop continues while this returns true. Default { true }.
    1: _firefight (Boolean, optional) - Include firefight sounds. Default true.
    2: _explosions (Boolean, optional) - Include explosion sounds. Default true.
    3: _helis (Boolean, optional) - Include helicopter sounds. Default false.
    4: _jets (Boolean, optional) - Include jet sounds. Default false.

Example:
    [{ true }, true, true, true] call EP_fnc_ambientWarfare

Returns:
    Nothing. The spawned handle is stored in EP_AmbientWarfareHandle.
---------------------------------------------------------------------------- */

//Constants
private _soundsFF = [
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight1.wss",
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight2.wss",
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight3.wss",
	"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight4.wss"
];
private _soundsExpl = [
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions1.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions2.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions3.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions4.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions5.wss"
];
private _soundsHeli = [
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli1.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli2.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Heli3.wss"
];
private _soundsJet = [
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet1.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet2.wss",
    "A3\Sounds_F\environment\ambient\battlefield\battlefield_Jet3.wss"
];

//Function
params [
	["_condition", { true }],
	["_firefight", true],
	["_explosions", true],
	["_helis", false],
	["_jets", false]
];

private _soundList = [];

if (_firefight) 	then { _soundList append _soundsFF };
if (_explosions) 	then { _soundList append _soundsExpl };
if (_helis) 		then { _soundList append _soundsHeli };
if (_jets) 			then { _soundList append _soundsJet };

if (count _soundList == 0) exitWith {
	systemChat "EP_fnc_ambientWarfase: at least one sound parameter must be true!";
};

private _handle = [_soundList, _condition] spawn {
	params ["_soundList", "_condition"];
	private _target = player;
	private _soundObject = player;
	private _volume = 3;
	private _soundPitch = 1;
	private _soundDistance = 0;
	private _minDistance = 350;
	private _midDistance = 500;
	private _maxDistance = 800;
	private _maxSleep = 45;
	while { call _condition } do {
		private _dir = round random 360;  
		private _dis = round random [_minDistance, _midDistance, _maxDistance]; 
		private _soundPos = _target getRelPos [_dis, _dir]; 
		private _sound = selectRandom _soundList; 
		playSound3D [_sound, _soundObject, false, _soundPos, _volume, _soundPitch, _soundDistance]; 
		private _sleepRandom = round random _maxSleep; 
		sleep _sleepRandom; 
	};
};

missionNamespace setVariable ["EP_AmbientWarfareHandle", _handle];
 
