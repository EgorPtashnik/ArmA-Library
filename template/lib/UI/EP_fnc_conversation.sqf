/**
	Display subtitles with sound depending on params value

	PARAMETERS
		_title					: STRING - speaker name
		_subtitles			: STRING - speaker subtitles
		_duraion				: NUMBER (Default 5) - duration while subtitles are visible
		_isRadio				: BOOLEAN (Default true) - true to have radio sounds, false to have "mybeep" sound played
		_radioInSound		: STRING (Default "myin1") - radio in sound name
		_radioOutSound	: STRING (Default "myin4") - radio Out sound name
		_chatType				: [0,1,2] - chat type (0 - sideChat, 1 - groupChat, 2 - globalChat)
		_toUpper				: BOOLEAN (Default true) - show speaker name in UPPERCASE

	RETURNS
		NONE
	
	EXAMPLE
		["SPEAKER", "Subtitltes", 10] call EP_fnc_converstation;
*/

params [
	"_title",
	"_subtitles",
	["_duration", 5],
	["_isRadio", true],
	["_radioSoundIn", "myin1"],
	["_radioSoundOut", "myin4"],
	["_chatType", 2],
	["_toUpper", true]
];

private _noises = ["mynoise1", "mynoise2", "mynoise3"];
private _colorMap = ["#40d2fb", "#b5f961", "#ffffff"];
private _message = "<br/><br/><br/><br/><br/><t align='center' shadow='2' color='%1' size='1.5' font='RobotoCondensedBold'>%2:</t><br/><t color='#ffffff' size='1.5' shadow='2' font='RobotoCondensedBold'>%3</t>";
private ["_color", "_soundId"];

if ((typeName _chatType) != "STRING") then {
    _color = _colorMap select _chatType;
} else {
	_color = _chatType;
};

if (_toUpper) then {
    _title = toUpper _title;
};

_message = formatText [_message, _color, _title, _subtitles];

cutText [str _message, "PLAIN DOWN", _duration/10, true, true];

if (_isRadio) then {
	playSoundUI [ _radioSoundIn ];
	private _time = time;
	while { time < ( _time + _duration ) } do {
		_soundId = playSoundUI [ ( selectRandom _noises ) ];
		sleep 5;
	};
	stopSound _soundId;
	playSoundUI [ _radioSoundOut ];
	sleep 2;
} else {
	playSoundUI [ "mybeep" ];
	sleep ( _duration );
};
