params [
	"_condition",
	"_code",
	["_sleep", 1],
	["_handleArrayName", "EP_SimpleTriggers"]
	["_spawnCode", false]
];

if !(_condition isEqualType []) exitWith {
	_condition = [_condition, []];
};

if !(_condition isEqualType []) exitWith {
	_code = [_code, []];
};

if (isNil _handleArrayName) then {
	missionNamespace setVariable [_handleArrayName, []];
};

private _handle = [_condition, _code, _sleep, _spawnCode] spawn {
	params ["_condition", "_code", "_sleep"];
	private _condCode = _condition # 0;
	private _condArgs = _condition # 1;
	private _codeCode = _code # 0;
	private _codeArgs = _code # 1;

	waitUntil {
		sleep _sleep;
		_condArgs call _condCode;
	};

	if (_spawnCode) then {
		_codeArgs spawn _codeCode;
	} else {
		_codeArgs call _codeCode;
	};
};

(missionNamespace getVariable _handleArrayName) pushBack _handle;

_handle
