/**
	Creates black/white screen with smooth transition to normal screen with sound fading

	PARAMETERS
		_duration	: Number (Default 5) - duration of transition
		_color		: ["BLACK","WHITE"] (Default "BLACK") - color of fade
		_blur			: [0,1] (Default 0) - 1 to blur, 0 to no blur

	RETURNS
		NUMBER - duration
	
	EXAMPLE
		[5, "BLACK", 1] call EP_fnc_fadeIn;
*/

params [
	["_duration", 5],
	["_color", "BLACK"],
	["_blur", 0]
];
0 fadeSound 0;
enableRadio false;
enableSentences false;
["EP_blackScreen", false] call BIS_fnc_blackOut;
sleep 5;
["EP_blackScreen", false] call BIS_fnc_blackIn;
_duration fadeSound 1;
enableRadio true;
enableSentences true;
[1, _color, _duration, _blur] spawn BIS_fnc_fadeEffect;

_duration;