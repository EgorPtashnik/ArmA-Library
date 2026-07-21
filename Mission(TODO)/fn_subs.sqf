params [
	'_subtitles', //Array if array in format [ [Title, Subtitles, duration] ]
	['_lastTiming', 5],
	['_isRadio', true],
	['_radioSoundIn', 'myin1'],
	['_radioSoundOut', 'myin4']
];

private _noises = ['mynoise1', 'mynoise2', 'mynoise3'];
private _subsCount = (count _subtitles) - 1;
private _subsTiming = _subtitles apply {_x # 2};
private _soundsTiming = [];

private _nextIndex = 0;
for '_i' from 0 to _subsCount do {
	if (_i != _subsCount) then {
		_nextIndex = _i + 1;
		_timing = (_subsTiming # _nextIndex) - (_subsTiming # _i);
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

{
	if (_isRadio) then {
		playSoundUI [_radioSoundIn];

		[_x, _noises] spawn {
			private _time = time;
			while {time < (_time + _this # 0)} do {
				ep_subs_noise = playSoundUI [(selectRandom (_this # 1))];
				sleep 5;
			}
		};

		_x spawn {
			sleep 0.5;
			private _time = time;
			while {time < _time + _this - 1.5} do {
				playSoundUI [selectRandom ['gm_rtty_stroke_01','gm_rtty_stroke_02','gm_rtty_stroke_03']];
				sleep selectRandom [0.06, 0.06, 0.06, 0.1, 0.3, 0.5];
			};
		};

		sleep _x;

		stopSound ep_subs_noise;
		playSoundUI [_radioSoundOut];
		sleep 2;
	} else {
		playSoundUI ['mybeep'];
		sleep _x;
	}

} forEach _soundsTiming;