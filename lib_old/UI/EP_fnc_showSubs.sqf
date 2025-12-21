/**
	Show text at the bottom center screen part

	PARAMETERS
		_title			: STRING - speaker name
		_subtitles	: STRING - speaker subtitles
		_duration		: NUMBER (Default 5) - duration of subtitles to be visible on screen
		_chatType		: [0,1,2] (Default 2) - chat type (0 - sideChat, 1 - groupChat, 2 - globalChat)
		_toUpper		: BOOLEAN (Default true) - make speaker name UPPERCASE
	
	RETURNS
		NONE
	
	EXAMPLE
		["NAME", "SUBTITLES", 5] call EP_fnc_showSubs;
 */
 

params [
	"_title",
	"_subtitles",
	["_duration", 5],
	["_chatType", 2],
  ["_toUpper", true]
];

private _colorMap = ["#40d2fb", "#b5f961", "#ffffff"];
private _color = "";
private _message = "<br/><br/><br/><br/><br/><t align='center' shadow='2' color='%1' size='1.5' font='RobotoCondensedBold'>%2:</t><br/><t color='#ffffff' size='1.5' shadow='2' font='RobotoCondensedBold'>%3</t>";

if ((typeName _chatType) != "STRING") then {
    _color = _colorMap select _chatType;
} else {
	_color = _chatType;
};

if (_toUpper) then {
    _title = toUpper _title;
};

_message = formatText [_message, _color, _title, _subtitles];

cutText [str _message, "PLAIN DOWN", (_duration / 5), true, true];
