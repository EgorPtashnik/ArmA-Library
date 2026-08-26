/* 
	EP_baseArty_1, EP_baseArty_2 - vehicles for action to be attached to
	EP_demoSpec_1, EP_demoSpec_2 - AI infantry units which will place IED
	
	Spawn position for IED is vehicle position (SEE - "DemoCharge_Remote_Ammo_Scripted" spawning code)

	After IED is placed => "Touch off explosives custom action s added to the player
 */

{
	_x addAction ["Command setup IED", {
		private _freeDemoSpecIndex = ([EP_demoSpec_1, EP_demoSpec_2] findIf { alive _x && (_x getVariable ["EP_free", true]) == true });
		if (_freeDemoSpecIndex == -1) exitWith {
			hint "Demo specialists are busy right now.";
		};

		(_this # 0) removeAction (_this # 2);
		private _demoSpec = ([EP_demoSpec_1, EP_demoSpec_2] # _freeDemoSpecIndex);
		_demoSpec setVariable ["EP_free", false];
		[[ ["Ten-2", "Plant this vehicle.", 0] ]] call EP_fnc_showSubtitles;

		_demoSpec setCombatBehaviour "CARELESS";
		_demoSpec doMove (getPos (_this # 0));
		 waitUntil { moveToCompleted _demoSpec };

		 sleep 1; 
  		_demoSpec playMove "AinvPknlMstpSrasWrflDnon_Putdown_AmovPknlMstpSrasWrflDnon";
		sleep 1.5;
		private _demoCharge = "DemoCharge_Remote_Ammo_Scripted" createVehicle getPos (_this # 0);
		EP_demoCharges pushBack _demoCharge;
		sleep 5;
		_demoSpec setCombatBehaviour "AWARE";
		_demoSpec setVariable ["EP_free", true];
	}, nil, 10, true, true, "", "alive EP_demoSpec_1 || alive EP_demoSpec_2", 30];
} forEach ("EP_baseArty" call EP_fnc_collectVariables);

player addAction ["Touch off explosives", {
	{ (EP_demoCharges deleteAt 0) setDamage 1 } forEach EP_demoCharges;
}, nil, 10, true, true, "", "(count EP_demoCharges) > 0"];