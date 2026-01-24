params [
	"_subtitles", //Array if array in format [ [Title, Subtitles, duration] ]
	["_lastTiming", 5],
	["_isRadio", true],
	["_radioSoundIn", "myin1"],
	["_radioSoundOut", "mynoise4"]
];

private ["_noises", "_subtitlesCount", "_subtitlesTimings", "_soundsTiming", "_timing"];

_noises = ["mynoise1", "mynoise2", "mynoise3"];
_subtitlesCount = (count _subtitles) - 1;
_subtitlesTimings = _subtitles apply {_x # 2};
_soundsTiming = [];

private ["_nextIndex"];
for "_i" from 0 to _subtitlesCount do {
	if !(_i == _subtitlesCount) then {
		_nextIndex = _i + 1;
		_timing = (_subtitlesTimings # _nextIndex) - (_subtitlesTimings # _i);
		_soundsTiming pushBack _timing;
	} else {
		_soundsTiming pushBack _lastTiming;
	};
};


//In case this is radio enhance timing for each with 2 seconds
if (_isRadio) then {
	{
		if (_forEachIndex != 0) then {
			_timing = (_x # 2) + (2 * _forEachIndex);
			_x set [2, _timing];
		}
	} forEach _subtitles;
};
_subtitles spawn BIS_fnc_EXP_camp_playSubtitles;

private ["_time", "_soundId"];
{
	if (_isRadio) then {
		playSoundUI [_radioSoundIn];
		_time = time;
		while {time < (_time + _x)} do {
			_soundId = playSoundUI [(selectRandom _noises)];
			sleep 5;
		};
		stopSound _soundId;
		playSoundUI [_radioSoundOut];
		sleep 2;
	} else {
		playSoundUI ["mybeep"];
		sleep _x;
	}
} forEach _soundsTiming;
