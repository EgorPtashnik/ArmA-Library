/*	
	"CREATED"
	"ASSIGNED"
	"SUCCEEDED"
	"FAILED"
	"CANCELED"
*/

case "Sample": {
	if (!(_taskID call BIS_fnc_taskExists)) then {
		[_taskID, "defend"] call BIS_fnc_taskSetType;
		[
			player,
			_taskID,
			[
				"Описание",
				"Название"
			],
			objNull,
			true
		] call BIS_fnc_taskCreate;
	} else {
		// Обработка для второго вызова
		[_taskID, "CANCELED"] call BIS_fnc_taskSetState;
	};	
};
