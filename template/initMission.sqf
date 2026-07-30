/*
 *  Mission bootstrap. Runs once at mission start.
 *  Configure AI skill defaults, post-process effects, kick off mission flow.
 */

[
    [east,       ["SKILL", 0.5, "AIM", 0.2, "COURAGE", 0.6]],
    [west,       ["SKILL", 0.6, "AIM", 0.3, "COURAGE", 0.8]],
    [resistance, ["SKILL", 0.4, "FLEEING", 0.5]]
] call ep_fnc_missionInit;

// Kick off the mission flow (spawned so it doesn't block init).
[] spawn {
    call compile preprocessFileLineNumbers "missionFlow\1_start.sqf";
};
