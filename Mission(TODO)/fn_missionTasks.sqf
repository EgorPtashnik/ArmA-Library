/**
	Handles task
	['task_id', 'created', getPos player, 'destroy'] call ep_fnc_missionTasks;
	'task_id' call ep_fnc_missionTasks
 */

private _taskIcons = [
	'airdrop', 'attack', 'danger', 'defend', 'destroy', 'download', 'exit', 'getin', 'getout', 'heal', 'interact', 'kill',
	'land', 'listen', 'meet', 'move', 'move1', 'move2', 'move3', 'move4', 'move5', 'navigate', 'rearm', 'refuel', 'repair',
	'run', 'scout', 'search', 'takeoff', 'talk', 'talk1', 'talk2', 'talk3', 'talk4', 'talk5', 'target', 'unknown', 'upload',
	'use', 'wait', 'walk', 'armor', 'backpack', 'boat', 'box', 'car', 'container', 'documents', 'heli', 'intel', 'map', 'mine',
	'plane', 'radio', 'rifle', 'truck', 'whiteboard','a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
	'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
];

private _taskStates = ['CREATED', 'ASSIGNED', 'SUCCEEDED', 'FAILED', 'CANCELED'];

if (_this isEqualType []) then {
	private _taskID = _this deleteAt 0;
	{

		if (_x isEqualType 'string') then {
			switch(_x) do {
				case (toLower _x) in _taskIcons	: [_taskID, (toLower _x)] call bis_fnc_taskSetType;
				case (toUpper _x) in _taskStates: [_taskID, (toUpper _X)] call bis_fnc_taskSetState;

				default	systemChat (format ['ep_fnc_missionTasks: %1 is not a valid parameter!', _x]);
			};
		};
		
		if (_x isEqualType []) then {
			[_taskID, _x] call BIS_fnc_taskSetDestination;
		};

	} forEach _this;
} else {
	_this call bis_fnc_missionTasks;
};
