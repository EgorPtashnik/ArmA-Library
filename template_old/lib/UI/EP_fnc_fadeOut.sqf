/**
	Creates transition from normal screen to black/white screen

	PARAMETERS
		_duration	: Number (Default 5) - duration of transition
		_color		: ["BLACK","WHITE"] (Default "BLACK") - color of fade
		_blur			: [0,1] (Default 0) - 1 to blur, 0 to no blur

	RETURNS
		NUMBER - duration
	
	EXAMPLE
		[5, "BLACK", 1] call EP_fnc_fadeOut;
*/

params [
	["_duration", 5],
	["_color", "BLACK"],
	["_blur", 0]
];

[0, _color, _duration, _blur] spawn BIS_fnc_fadeEffect;
_duration fadeSound 0;

_duration;
