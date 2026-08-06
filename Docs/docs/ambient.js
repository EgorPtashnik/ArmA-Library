/**
 * Function docs — Ambient category.
 */
ArmADocs.register("Ambient", {

    "EP_fnc_ambientWarfare": {
        description: "Endless loop that plays random battlefield SFX (explosions, firefights, optionally helicopters and jets) " +
                     "at random positions around the local player. Must be launched with <code>spawn</code> — the function uses <code>sleep</code>.",
        syntax: "[includeAirSFX?] spawn EP_fnc_ambientWarfare",
        params: [
            { name: "includeAirSFX", type: "Boolean (optional)", desc: "If true, adds helicopter and jet flyby sounds to the pool. Default false." }
        ],
        returns: "Nothing (loop; script handle from <code>spawn</code>).",
        example: "[] spawn EP_fnc_ambientWarfare;\n" +
                 "[true] spawn EP_fnc_ambientWarfare;   // include heli / jet flybys"
    }

});
