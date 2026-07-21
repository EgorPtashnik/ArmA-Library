/**
	Creates intro for the mission

	RETURNS
	BOOLEAN

	USAGE
	[] call ep_fnc_missionIntro;

	PARAMETERS
	M|1. Establishing shot position
*/
params [
	'_estShotPos',
	[ '_estShotParams', [worldName /*Text*/, 500 /*Height*/, 200 /*Radius*/, random 360/*Angle*/] ],
	[ '_texts', [worldName, groupId group player] ]
];

private _params = [_estShotPos] + _estShotParams;

private _handle = _params spawn BIS_fnc_establishingShot;
waitUntil {scriptDone _handle};

sleep 3;

_handle = _texts spawn BIS_fnc_EXP_camp_SITREP;
waitUntil {scriptDone _handle};
