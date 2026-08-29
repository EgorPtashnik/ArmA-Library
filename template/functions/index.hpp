class EP
{
    class Functions {
        file = "functions";
        // AI Functions
        class addWaypoint               {};
        class clearWaypoints            {};
        class setAIMode                 {};
        class setAISkill                {};

        // AI Task Functions
        class taskArtilleryFire         {};
        class taskAttack                {};
        class taskConvoy                {};
        class taskDefend                {};
        class taskPatrol                {};

        // Mission Specific Functions
        class missionInit               {};
        class missionTasks              {};
        class missionConversations      {};
        class cleanupArea               {};
        class showObjects               {};
        class addHoldAction             {};
        class addAction                 {};

        // Extension Functions
        class ext_casualVehicle         {};
        class ext_healthBar             {};
        class ext_healthRegen           {};
        class ext_nvg                   {};

        // Ambient Functions
        class ambientFlyBy              {};
        class ambientWarfare            {};

        // Create Functions
        class createGroup               {};
        class createGuidedProjectile    {};
        class createTrigger             {};
        class createUnit                {};

        // Get Functiins
        class getGroup                  {};
        class getPosition               {};
        class getRandomArray            {};
        class getRandomPosition         {};
        class getRandomPositionArea     {};
        class collectMarkers            {};
        class collectUnits              {};
        class collectVariables          {};
    }
};