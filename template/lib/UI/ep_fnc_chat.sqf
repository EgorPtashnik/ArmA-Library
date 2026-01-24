params [
	"_queue",
	["_type", 0] //0 - sideChat, 1 - groupChat, 2 - vehicleChat
];

private ["_speaker", "_text", "_sleep"];
{
	_speaker 	= _x # 0;
	_text 		= _x # 1;
	_sleep 		= _x # 2;
	playSoundUI [(selectRandom ["myin1", "myin4"])];
	sleep 0.02;
	playSoundUI ["mynoise4"];
	switch (_type) do {
		case 0: {_speaker sideChat _text};
		case 1: {_speaker groupChat _text};
		case 2: {_speaker vehicleChat _text};
	};
	sleep _sleep;
} forEach _queue;

