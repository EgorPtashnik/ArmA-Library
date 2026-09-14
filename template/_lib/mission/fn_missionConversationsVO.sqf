/* ----------------------------------------------------------------------------
Function: EP_fnc_missionConversationsVO

Description:
    Displays a sequence of voiced-over subtitles in the EP_Subtitles UI layer.
    For radio conversations, plays radio in/out sounds and looping background
    noise for the duration of each entry. If called with a non-array parameter
    it instead spawns BIS_fnc_missionConversations.

Parameters:
    0: _conversation (Array of Arrays) - Entries in the format [Speaker, Text, Duration, Color, VO],
        where Color (Number or String, optional) defaults to 0 and VO (String, optional) defaults to "readoutClick".
    1: _isRadio (Boolean, optional) - Play radio sounds and background noise. Default true.
    2: _radioSoundIn (String, optional) - Sound played when the radio starts. Default "myin1".
    3: _radioSoundOut (String, optional) - Sound played when the radio ends. Default "myin4".

Example:
    [[["Alpha1", "Move to the objective", 4, 1, "alpha1_move"]]] call EP_fnc_missionConversationsVO

Returns:
    Script Handle - When called with a non-array parameter, the spawned handle.
---------------------------------------------------------------------------- */

params [
	"_conversation", //Array ff arrays in format [ [Title, Subtitles, duration for previous] ]
	["_isRadio", true],
	["_radioSoundIn", "myin1"],
	["_radioSoundOut", "myin4"]
];

if !(_this isEqualType []) exitWith { _this spawn BIS_fnc_missionConversations };

//In case this is radio enhance timing for each with 2 seconds
if (_isRadio) then {
	_conversation apply { _x set [2, ((_x # 2) + 2)] };
};

private _display = (uiNamespace getVariable "EP_Subtitles");
if (isNil "_display") then {
	"EP_Subtitles" cutRsc ["EP_Subtitles", "PLAIN"]; 
	_display = (uiNamespace getVariable "EP_Subtitles");
};
private _ctrl = _display displayCtrl 101;
private _colorMap = [
	"#FFFFFF", 	//WHITE 		0
	"#3399FF", 	//BLUE			1
	"#33FF33", 	//GREEN			2
	"#FFFF0000", 	//RED			3
	"#EEEE00",  	//YELLOW		4
	"#FF004C99", 	//BLUFOR 		5
	"#FF800000", 	//OPFOR			7
	"#FF008000", 	//Independent	8
	"#FF660080" 	//Civilian		9
];

// Возможные цвета #0000cc - синий, #FF0000 – красный, #ffff00 – жёлтый цвет, #ffffff – белый, #00FF00 - зелёный

_ctrl ctrlSetFade 0;
_ctrl ctrlCommit 0.2;
{
	_x params [
		"_speaker",
		"_text",
		"_duration",
		["_color", 0],
		["_vo", "readoutClick"]
	];

	private _colorValue = nil;
	if (_color isEqualType 0) then {
		_colorValue = (_colorMap # _color);
	} else {
		_colorValue = _color;
	};

	private _subtitles = parseText format [
		"<t color='%1' font='RobotoCondensedBold'>%2:</t> <t font='RobotoCondensedBold' color='#FFFFFF'>%3</t>",
		_colorValue,
		_speaker, 
		_text
	];
	_ctrl ctrlSetStructuredText _subtitles;
	
	if (_isRadio) then {
		playSoundUI [_radioSoundIn];
		playSoundUI [_vo];

		[ _duration, ["mynoise1", "mynoise2", "mynoise3"] ] spawn {
			private _time = time;
			while {time < (_time + _this # 0)} do {
				ep_subs_noise = playSoundUI [(selectRandom (_this # 1))];
				sleep 5;
			}
		};

		sleep _duration;

		stopSound ep_subs_noise;
		playSoundUI [_radioSoundOut];
		sleep 2;
	} else {
		playSoundUI ["readoutClick"];
		playSoundUI [_vo];
		sleep _duration;
	};

} forEach _conversation;
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0.2;