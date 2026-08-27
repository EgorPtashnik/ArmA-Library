/* 
	Simple intro starting with Establishing shot and then showing SITREP
 */

//************************************************************************************************************
// PARAMETERS
//************************************************************************************************************

private _establishingShotPosition = [0, 0, 0];
private _stablishingShotParameters = [worldName, 500, 200, random 360];
private _sitrepTexts = [toUpper worldName, toUpper (groupId group player)];


_establishingShotPosition = _establishingShotPosition call ep_fnc_getPosition;
private _params = [_establishingShotPosition] + _stablishingShotParameters;

private _handle = _params spawn BIS_fnc_establishingShot;
waitUntil {scriptDone _handle};

sleep 3;

_handle = _sitrepTexts spawn BIS_fnc_EXP_camp_SITREP;
waitUntil {scriptDone _handle};
