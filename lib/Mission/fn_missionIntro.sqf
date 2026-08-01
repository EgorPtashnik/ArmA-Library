#define EP_DEFAULT_EST_SHOW_PARAMS [worldName, 500, 200, random 360]
#define EP_DEFAULT_INTRO_TEXTS [toUpper worldName, toUpper (groupId group player)]
#define EP_MISSION_INTRO_TYPES ["EST_SHOT", "INFO", "TYPE", "TYPE_ALT", "TILES"]

params [
	"_estShotPos",
	[ "_estShotParams", EP_DEFAULT_EST_SHOW_PARAMS ],
	[ "_introTexts", EP_DEFAULT_INTRO_TEXTS ]
];

_estShotPos = _estShotPos call ep_fnc_getPosition;
private _params = [_estShotPos] + _estShotParams;

private _handle = _params spawn BIS_fnc_establishingShot;
waitUntil {scriptDone _handle};

sleep 3;

_handle = _introTexts spawn BIS_fnc_EXP_camp_SITREP;
waitUntil {scriptDone _handle};
