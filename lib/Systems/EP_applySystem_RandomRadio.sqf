/**
	Random radio sounds of WEST or EAST side
 */

// [west] spawn EP_applySystem_RandomRadio;
params [
	"_side",
	["_sleepBetween", 10],
	["_condition", { true }]
];

private _radioSoundsWest = [
	"rhs_usa_land_rc_1", "rhs_usa_land_rc_2", "rhs_usa_land_rc_3", "rhs_usa_land_rc_4", "rhs_usa_land_rc_5",
	"rhs_usa_land_rc_6", "rhs_usa_land_rc_7", "rhs_usa_land_rc_8", "rhs_usa_land_rc_9", "rhs_usa_land_rc_10",
	"rhs_usa_land_rc_11", "rhs_usa_land_rc_12", "rhs_usa_land_rc_13", "rhs_usa_land_rc_14", "rhs_usa_land_rc_15",
	"rhs_usa_land_rc_16", "rhs_usa_land_rc_17", "rhs_usa_land_rc_18", "rhs_usa_land_rc_19", "rhs_usa_land_rc_20",
	"rhs_usa_land_rc_21", "rhs_usa_land_rc_22", "rhs_usa_land_rc_23", "rhs_usa_land_rc_24", "rhs_usa_land_rc_25",
	"rhs_usa_land_rc_26", "rhs_usa_land_rc_27", "rhs_usa_land_rc_28", "rhs_usa_land_rc_29", "rhs_usa_land_rc_30",
	"rhs_usa_land_rc_31", "rhs_usa_land_rc_32", "rhs_usa_land_rc_33", "rhs_usa_land_rc_34", "rhs_usa_land_rc_35", "rhs_usa_land_rc_36"
];

private _radioSoundsEast = [
	"rhs_rus_land_rc_1", "rhs_rus_land_rc_2", "rhs_rus_land_rc_3", "rhs_rus_land_rc_4", "rhs_rus_land_rc_5",
	"rhs_rus_land_rc_6", "rhs_rus_land_rc_7", "rhs_rus_land_rc_8", "rhs_rus_land_rc_9", "rhs_rus_land_rc_10",
	"rhs_rus_land_rc_11", "rhs_rus_land_rc_12", "rhs_rus_land_rc_13", "rhs_rus_land_rc_14", "rhs_rus_land_rc_15",
	"rhs_rus_land_rc_16", "rhs_rus_land_rc_17", "rhs_rus_land_rc_18", "rhs_rus_land_rc_19", "rhs_rus_land_rc_20",
	"rhs_rus_land_rc_21", "rhs_rus_land_rc_22", "rhs_rus_land_rc_23", "rhs_rus_land_rc_24", "rhs_rus_land_rc_25",
	"rhs_rus_land_rc_26", "rhs_rus_land_rc_27", "rhs_rus_land_rc_28", "rhs_rus_land_rc_29", "rhs_rus_land_rc_30",
	"rhs_rus_land_rc_31", "rhs_rus_land_rc_32", "rhs_rus_land_rc_33", "rhs_rus_land_rc_34", "rhs_rus_land_rc_35", "rhs_rus_land_rc_36"
];

private ["_sounds", "_source"];
if (_side == west) then {
	_sounds = _radioSoundsWest;
} else {
	_sounds = _radioSoundsEast;
};

while { call _condition } do {
	_source = playSound [(selectRandom _sounds), 2];
	waitUntil { sleep 2; isNull _source; };
	sleep _sleepBetween;
};
