//************************************************************************************************************
// FUNCTION
//************************************************************************************************************

params [
	"_conversation", //Array ff arrays in format [ [Title, Subtitles, duration for previous] ]
	["_isRadio", true]
];

if !(_this isEqualType []) exitWith {
    // Wait if some conversation is still running
    if (!isNil "EP_missionConversationsHandle") then {
        waitUntil { scriptDone EP_missionConversationsHandle };
    }; 

    EP_missionConversationsHandle = _this spawn BIS_fnc_missionConversations;
    EP_missionConversationsHandle
};

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
	"#FF800000", 	//OPFOR			6
	"#FF008000", 	//Independent	7
	"#FF660080" 	//Civilian		8
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
        ["_sound", "myin1"]
	];

	private _colorValue = nil;
	if (_color isEqualType 0) then {
		_colorValue = (_colorMap # _color);
	} else {
		_colorValue = _color;
	};

	private _subtitles = parseText format [
		"<t color='%1' font='RobotoCondensedBold'>%2:<br/></t> <t font='RobotoCondensedBold' color='#FFFFFF'>%3</t>",
		_colorValue,
		_speaker, 
		_text
	];
	_ctrl ctrlSetStructuredText _subtitles;
	
	if (_isRadio) then {
		playSoundUI [_sound];
		sleep _duration;
	} else {
		playSoundUI ["readoutClick"];
		sleep _duration;
	};

} forEach _conversation;
_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 0.2;