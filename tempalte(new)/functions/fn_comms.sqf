params [
	"_lines",
	["_isRadio", true],
	["_notRadioSound", "readoutClick"]
];

//Spawn missionConversations _this is just string
waitUntil {missionNamespace getVariable ["EP_commsRunning", false]};

//Set variable check to wait for current comms to complete
missionNamespace setVariable ["EP_commsRunning", true];

//Check default variables
if (isNil "EP_commsSoundIn") then {EP_commsSoundIn = ["epin1", "epin1b", "epin1c"]};
if (isNil "EP_commsSoundOut") then {EP_commsSoundOut = ["epout1", "epout2", "epout3"]};
if (isNil "EP_commsColor") then {EP_commsColor = 0};

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

//Loop through lines
private _log = [];
private ["_colorValue", "_char", "_characters", "_charArray", "_subtitles"];
{
	//Extract variables
	_x params [
		"_speaker",
		"_text",
		["_pause", 2],
		["_color", EP_commsColor],
		["_soundIn", EP_commsSoundIn],
		["_soundOut", EP_commsSoundOut]
	];
	private _unitSpeaking = objNull;
	if (_speaker isEqualType []) then {
		_unitSpeaking = _speaker # 1;
		_speaker = _speaker # 0;
	};

	//Handle color
	if (_color isEqualType 0) then {
		_colorValue = (_colorMap # _color);
	} else {
		_colorValue = _color;
	};

	if (_isRadio) then {
		playSoundUI [selectRandom _soundIn];

		EP_commsNoiseScript = ["noise5_1", "noise5_2", "noise5_3"] spawn {
			while {true} do {EP_commsNoise = playSoundUI [(selectRandom _this)]; sleep 5};
		};
		// spawn {sleep 0.4; EP_commsTyping = playSoundUI ["morseCode", 1, 1, false, random 0.9]};
	} else {
		playSoundUI [_notRadioSound];
	};

	_subtitles = parseText format [
		"<t color='%1' font='RobotoCondensedBold'>%2:<br/></t> <t font='RobotoCondensedBold' color='#FFFFFF'>%3</t>",
		_colorValue, _speaker, ""
	];

	_ctrl ctrlSetStructuredText _subtitles;

	sleep 0.5;

	_charArray = _text splitString "";
	_characters = "";

	if !(isNull _unitSpeaking) then {
		_unitSpeaking setRandomLip true;
	};

	for "_i" from 0 to (count _charArray - 1) do {
		_char = _charArray # _i;
		_characters = _characters + _char;

		playSoundUI ["typeSound", 0.8];
		
		_subtitles = parseText format [
			"<t color='%1' font='RobotoCondensedBold'>%2:<br/></t> <t font='RobotoCondensedBold' color='#FFFFFF'>%3</t>",
			_colorValue, _speaker, _characters
		];
		_ctrl ctrlSetStructuredText _subtitles;

		switch _char do {
			case " ": {sleep 0.1};

			case ",": {sleep 0.3};
			case ".": {
				private _nextChar = _charArray select (_i + 1);
				if (_nextChar != " ") then {sleep 0.06} else {sleep 0.5};
			};

			case "!";
			case "?": {
				private _nextChar = _charArray select (_i + 1);
				if (_nextChar != " ") then {sleep 0.06} else {sleep 0.5};
			};

			default {sleep 0.06};
		};
	};

	if (_isRadio) then {
		terminate EP_commsNoiseScript;
		stopSound EP_commsNoise;
		// stopSound EP_commsTyping;
		playSoundUI [selectRandom _soundOut];
	};

	if !(isNull _unitSpeaking) then {
		_unitSpeaking setRandomLip false;
	};

	_log pushBack format [
		"<t color='%1' font='RobotoCondensedBold'>%2:<br/></t><t font='RobotoCondensedBold' color='#D0D0D0'>%3</t><br/><br/>",
		_colorValue, toUpper _speaker, _characters
	];
	sleep _pause;

} forEach _lines;

//Add to LOG diary
if (!(player diarySubjectExists "log")) then {
	player createDiarySubject ["log", "LOG"];
};

private _logTypeText = "Радиопереговоры";
if !(_isRadio) then {_logTypeText = "Диалог"};
player createDiaryRecord [
	"log", 
	[
		format ["%1: %2", [dayTime, "HH:MM"] call BIS_fnc_timeToString, _logTypeText],
		_log joinString ""
	]
];

_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0.2;
missionNamespace setVariable ["EP_commsRunning", false];
