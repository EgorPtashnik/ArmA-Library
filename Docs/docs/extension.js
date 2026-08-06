/**
 * Function docs — Extension category.
 * Optional gameplay extensions layered on top of the base library.
 */
ArmADocs.register("Extension", {

    "EP_fnc_ext_casualHealth": {
        description: "Installs a &laquo;casual&raquo; health model on the given units: each hit inflicts a small fixed damage (not the engine\u2019s raw damage), " +
                     "optionally with instant-kill headshots, and applies a slow regeneration back to a floor value if the unit is not damaged for a short period. " +
                     "Idempotent per unit (guarded by <code>EP_casualHealth_installed</code>).",
        syntax: "[units, damageOnHit?, headshotKill?, stopRegenAt?, regenValue?, regenInterval?] call EP_fnc_ext_casualHealth",
        params: [
            { name: "units",         type: "Group | Object | String | Array", desc: "Anything accepted by EP_fnc_collectUnits." },
            { name: "damageOnHit",   type: "Number (optional)",               desc: "Fixed damage applied per hit (0..1). Default 0.1." },
            { name: "headshotKill",  type: "Boolean (optional)",              desc: "If true, direct head hits kill instantly. Default true." },
            { name: "stopRegenAt",   type: "Number (optional)",               desc: "Regeneration floor (damage value below which regen stops). Default 0.2." },
            { name: "regenValue",    type: "Number (optional)",               desc: "Amount of damage removed per tick. Set to 0 to disable regen. Default 0.05." },
            { name: "regenInterval", type: "Number (optional)",               desc: "Seconds between regen ticks. Default 1." }
        ],
        returns: "Array<Object> \u2014 the affected units.",
        example: '[group player] call EP_fnc_ext_casualHealth;\n' +
                 '[units group player, 0.15, false, 0.3, 0.03, 2] call EP_fnc_ext_casualHealth;   // tougher, slower regen'
    },

    "EP_fnc_ext_casualVehicle": {
        description: "Installs a &laquo;casual&raquo; vehicle model on the given vehicles: on <code>GetIn</code>, the vehicle is auto-started and locked, " +
                     "the player is moved to the gunner seat, an invisible AI agent is spawned into the driver seat, and an in-vehicle <em>Get Out</em> action is added. " +
                     "On <code>GetOut</code>, the AI driver is deleted, the engine is turned off and the vehicle is unlocked.",
        syntax: "[vehicles, enableSentences?, getOutText?, cameraExternal?] call EP_fnc_ext_casualVehicle",
        params: [
            { name: "vehicles",        type: "Object | Array<Object>", desc: "Single vehicle or array of vehicles to configure." },
            { name: "enableSentences", type: "Boolean (optional)",     desc: "Controls <code>enableSentences</code> while embarked. Default false (radio chatter suppressed)." },
            { name: "getOutText",      type: "String (optional)",      desc: "Label for the in-vehicle exit action. Default <code>\"Get Out\"</code>." },
            { name: "cameraExternal",  type: "Boolean (optional)",     desc: "If true, switch to <code>EXTERNAL</code> camera on GetIn. Default true." }
        ],
        returns: "Array<Object> \u2014 the affected vehicles.",
        example: '[myCar] call EP_fnc_ext_casualVehicle;\n' +
                 '[[car1, car2], true, "Exit vehicle", false] call EP_fnc_ext_casualVehicle;'
    },

    "EP_fnc_ext_healthBar": {
        description: "Draws a text-based health bar for the target unit / vehicle in the corner of the HUD using <code>BIS_fnc_dynamicText</code>. " +
                     "Runs an internal update loop \u2014 must be launched with <code>spawn</code>. Removes the bar when the unit dies.",
        syntax: "[targetUnit?, layerId?, healthShowVehicle?, symbolsCount?, symbol?, mediumThreshold?, highThreshold?, posFromBottomPerc?, posFromRightPerc?, colorMap?, sleep?] spawn EP_fnc_ext_healthBar",
        params: [
            { name: "targetUnit",         type: "Object (optional)",         desc: "Unit to track. Default <code>player</code>." },
            { name: "layerId",            type: "Number (optional)",         desc: "Dynamic text layer id. Default 1." },
            { name: "healthShowVehicle",  type: "Boolean (optional)",        desc: "If true, show vehicle health while embarked. Default false." },
            { name: "symbolsCount",       type: "Number (optional)",         desc: "Total width of the bar in symbols. Default 66." },
            { name: "symbol",             type: "String (optional)",         desc: "Character used to fill the bar. Default <code>\"I\"</code>." },
            { name: "mediumThreshold",    type: "Number (optional)",         desc: "Health percentage above which the middle colour is used. Default 60." },
            { name: "highThreshold",      type: "Number (optional)",         desc: "Health percentage above which the highest colour is used. Default 30." },
            { name: "posFromBottomPerc",  type: "Number (optional)",         desc: "Vertical position (safe-zone based). Default 1.62." },
            { name: "posFromRightPerc",   type: "Number (optional)",         desc: "Horizontal position (safe-zone based). Default 1.616." },
            { name: "colorMap",           type: "Array<String> (optional)",  desc: "Three HTML colours [low, mid, high]. Default <code>[\"#ff6565\",\"#ffae8e\",\"#ffffff\"]</code>." },
            { name: "sleep",              type: "Number (optional)",         desc: "Update interval in seconds. Default 0.1." }
        ],
        returns: "Nothing (loop; script handle from <code>spawn</code>).",
        example: '[] spawn EP_fnc_ext_healthBar;\n' +
                 '[player, 1, true] spawn EP_fnc_ext_healthBar;   // also show vehicle health'
    }

});
