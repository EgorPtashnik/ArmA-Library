/**
	ep_fnc_dbgLog

	FEATURE
	Log debug text to system chat and diag log

	RETURNS
	Nothing

	USAGE
	["Start processing", var1, "End processing"] call ep_fnc_dbgLog;

	PARAMETERS
	M|1. Target (marker, group, object, position)
*/
params ["_string1", "_variables", "_string2"];
private ["_text"];

_text = _string1 + format [" %1 ",_variables] + _string2 + format [" - Time: %1 ms",diag_tickTime];

systemChat _text;
diag_log _text;