#define EP_SOUNDS_NOISES ["mynoise1", "mynoise2", "mynoise3"];
#define EP_SOUNDS_TYPING ["gm_rtty_stroke_01", "gm_rtty_stroke_02", "gm_rtty_stroke_03"];
#define EP_SOUNDS_TYPING_TIMINGS [0.06, 0.06, 0.06, 0.1, 0.3, 0.5];
#define EP_DEFAULT_SOUND_IN "myin1";
#define EP_DEFAULT_SOUND_OUT "myin4";

params [
	'_subtitles', //Array if array in format [ [Title, Subtitles, duration] ]
	['_lastTiming', 5],
	['_isRadio', true],
	['_radioSoundIn', EP_DEFAULT_SOUND_IN],
	['_radioSoundOut', EP_DEFAULT_SOUND_OUT]
];

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

		[_x, EP_SOUNDS_NOISES] spawn {
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
				playSoundUI [selectRandom EP_SOUNDS_TYPING];
				sleep selectRandom EP_SOUNDS_TYPING_TIMINGS;
			};
		};

		sleep _x;

		stopSound ep_subs_noise;
		playSoundUI [_radioSoundOut];
		sleep 2;
	} else {
		playSoundUI ["mybeep"];
		sleep _x;
	}

} forEach _soundsTiming;