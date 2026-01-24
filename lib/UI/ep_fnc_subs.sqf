params [
	"_subtitles", //Array if array in format [ [Title, Subtitles, duration] ]
	["_lastTiming", 5],
	["_isRadio", true]
];

private ["_subtitlesCount", "_subtitlesTimings", "_soundsTiming", "_timing"];

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

_subtitles spawn BIS_fnc_EXP_camp_playSubtitles;

{
	if (_isRadio) then {
		playSoundUI [(selectRandom ["myin1", "myin4"])];
		sleep 0.02;
		playSoundUI ["mynoise4"];
		sleep _x;
	} else {
		playSoundUI ["myneep"];
		sleep _x;
	}
} forEach _soundsTiming;
