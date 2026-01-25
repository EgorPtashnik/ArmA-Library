params [
	"_grp", "_path",
	["_sleep", 1]
];
private ["_vehicles", "_leadVeh", "_prevVeh"];

//Sort vehicles by distance to lead vehicle
_vehicles = [assignedVehicles _grp, [], {leader _grp distance _x}, "ASCEND"] call BIS_fnc_sortBy;

_leadVeh = _vehicles # 0;

{[_grp, _x, "COLUMN"] call ep_fnc_addWp} forEach _path;

{_x limitSpeed 30; _x setConvoySeparation 15} forEach _vehicles;

_vehicles = _vehicles - [_leadVeh];
while {true} do {

	if ( !(alive _leadVeh) || {((count crew _leadVeh) == 0) || !(canMove _leadVeh)}) then {
		_leadVeh = _vehicles # 0;
		_vehicles = _vehicles - [_leadVeh];
		_grp selectLeader driver _leadVeh;
	};

	{
		if (_forEachIndex == 0) then {
			_x doFollow _leadVeh;
		} else {
			_x doFollow _prevVeh;
		};
		_prevVeh = _x;
	} forEach _vehicles;
	sleep _sleep;
};