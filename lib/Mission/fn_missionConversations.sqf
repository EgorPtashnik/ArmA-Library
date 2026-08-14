#include "..\constants.hpp";

params [
	"_conversation", //Array ff arrays in format [ [Title, Subtitles, duration for previous] ]
	["_isRadio", true],
	["_radioSoundIn", EP_SUBTITLES_DEFAULT_SOUND_IN],
	["_radioSoundOut", EP_SUBTITLES_DEFAULT_SOUND_OUT]
];

if !(_this isEqualType []) exitWith { _this spawn BIS_fnc_missionConversations };
if (missionNamespace getVariable ["EP_Subtitles_Init", true]) then {
		cutRsc ["EP_Subtitles", "PLAIN"];
		missionNamespace setVariable ["EP_Subtitles_Init", false];
	};

//In case this is radio enhance timing for each with 2 seconds
if (_isRadio) then {
	_conversation apply { _x set [2, ((_x # 2) + 2)] };
};

private _display = (uiNamespace getVariable "EP_Subtitles");
private _ctrl = _display displayCtrl 101;
private _colorMap = [
	"#FFF2F2F2",   //WHITE
	"#FF004C99", //BLUFOR
	"#FF800000", //OPFOR
	"#FF008000", //Independent
	"#FF660080", //Civilian
	"#FFFF0000", //RED
	"#FF0000FF", //BLUE
	"#FF427626", //GREEN
	"#FFCCCC00" //YELLOW
];

{
	_x params [
		"_speaker",
		"_text",
		"_duration",
		["_color", 0]
	];

	private _colorValue = nil;
	if (_color isEqualType 0) then {
		_colorValue = (_colorMap # _color);
	} else {
		_colorValue = _color;
	};

	private _subtitles = parseText format [
		"<t color='%1' font='PuristaSemibold'>%2:</t> <t font='PuristaMedium' color='#FFF2F2F2'>%3</t>",
		_colorValue,
		_speaker, 
		_text
	];
	_ctrl ctrlSetStructuredText _subtitles;
	
	if (_isRadio) then {
		playSoundUI [_radioSoundIn];

		[_duration, EP_SUBTITLES_SOUNDS_NOISES] spawn {
			private _time = time;
			while {time < (_time + _this # 0)} do {
				ep_subs_noise = playSoundUI [(selectRandom (_this # 1))];
				sleep 5;
			}
		};

		_duration spawn {
			sleep 0.5;
			private _time = time;
			while {time < _time + _this - 1.5} do {
				playSoundUI [selectRandom EP_SUBTITLES_SOUNDS_TYPING];
				sleep selectRandom EP_SUBTITLES_SOUNDS_TYPING_TIMINGS;
			};
		};

		sleep _duration;

		stopSound ep_subs_noise;
		playSoundUI [_radioSoundOut];
		sleep 2;
	} else {
		playSoundUI ["readoutClick"];
		sleep _duration;
	};

} forEach _conversation;