/* 
	Simple intro with some music, fade in from black and cinema borders
 */

//************************************************************************************************************
// PARAMETERS
//************************************************************************************************************

// Music to player on mission start
private _music = "Track_R_09";

// Texts for SITREP
private _sitrepTexts = [
	groupID (group player),
	"GRID " + mapGridPosition player,
	[daytime, "HH:MM"] call BIS_fnc_timeToString
];

//************************************************************************************************************
// SCRIPT
//************************************************************************************************************

// Black screen on start + turn on cinema border
["EP_blackScreen", false] call BIS_fnc_blackOut;
[0, 0, false, true] call BIS_fnc_cinemaBorder;

// Fade in after a small delay
sleep 3;
playMusic _music;
["EP_blackScreen", false] spawn BIS_fnc_blackIn;
private _handle = [1, "BLACK", 5, 0] spawn BIS_fnc_fadeEffect;

// Remove cinema borders and show sitrep
waitUntil { scriptDone _handle };
[1, 1.5, false, true] call BIS_fnc_cinemaBorder;
_sitrepTexts spawn BIS_fnc_EXP_camp_SITREP;
