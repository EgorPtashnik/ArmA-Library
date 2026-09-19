params [
	"_lines",
	["_isRadio", true],
	["_notRadioSound", "readoutClick"]
];

//Spawn missionConversations _this is just string
if !(_this isEqualType []) exitWith {
	if !(isNil "EP_commsHandler") then {
		waitUntil {scriptDone EP_commsHandler};
	};

	EP_commsHandler = _this spawn BIS_fnc_missionConversations;
	EP_commsHandler
};

//Check default variables
if (isNil "EP_commsSoundIn") then {EP_commsSoundIn = ["epin1", "epin1b", "epin1c"]};
if (isNil "EP_commsSoundOut") then {EP_commsSoundOut = ["epout1", "epout2", "epout3"]};
if (isNil "EP_commsColor") then {EP_commsColor = 0};

//for radio transmition increase timing for each line with 2 seconds
if (_isRadio) then {
	_lines apply {_x set [2, (_x # 2) + 2]};
};

private _display = (uiNamespace getVariable "EP_Subtitles");
if (isNil "_display") then {
	"EP_Subtitles" cutRsc ["EP_Subtitles", "PLAIN"]; 
	_display = (uiNamespace getVariable "EP_Subtitles");
};
private _ctrl = _display displayCtrl 101;

//Example colors: #0000cc - синий, #FF0000 – красный, #ffff00 – жёлтый цвет, #ffffff – белый, #00FF00 - зелёный
private _colorMap = [
	"#FFFFFF", 	//WHITE 		0
	"#3399FF", 	//BLUE			1
	"#33FF33", 	//GREEN			2
	"#FFFF0000", 	//RED			3
	"#EEEE00",  	//YELLOW		4
	"#FF004C99", 	//BLUFOR 		5
	"#FF800000", 	//OPFOR			6
	"#FF008000", 	//Independent	7
	"#FF660080" 	//Civilian		8
];

//Show subtitles
_ctrl ctrlSetFade 0;
_ctrl ctrlCommit 0.2;
{
	//Extract variables
	_x params ["_speaker", "_text", "_duration", ["_color", EP_commsColor], ["_soundIn", EP_commsSoundIn], ["_soundOut", EP_commsSoundOut]];

	//Handle color
	private ["_colorValue"];
	if (_color isEqualType 0) then {
		_colorValue = (_colorMap # _color);
	} else {
		_colorValue = _color;
	};

	//Set subtitles
	private _subtitles = parseText format [
		"<t color='%1' font='RobotoCondensedBold'>%2:<br/></t> <t font='RobotoCondensedBold' color='#FFFFFF'>%3</t>",
		_colorValue, _speaker, _text
	];
	_ctrl ctrlSetStructuredText _subtitles;

	if (_isRadio) then {
		playSoundUI [selectRandom _soundIn];

		[_duration, ["noise5_1", "noise5_2", "noise5_3"]] spawn {
			params ["_duration", "_noises"];
			private _time = time;
			while {time < ((_time + _duration))} do {
				EP_commsNoise = playSoundUI [(selectRandom _noises)];
				sleep 5;
			};
		};

		sleep 0.4;
		EP_commsTyping = playSoundUI ["morseCode", 1, 1, false, random 0.9];

		sleep _duration;

		stopSound EP_commsNoise;
		stopSound EP_commsTyping;

		playSoundUI [selectRandom _soundOut];
		sleep 2;
	} else {
		playSoundUI ["_notRadioSound"];
		sleep _duration;
	};

} forEach _lines;

_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0.2;
