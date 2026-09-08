class EP
{
    class AI {
        file = "_lib\ai";
        class addWaypoint            {};
        class clearWaypoints         {};
        class setAIMode              {};
        class setAISkill             {};
    };

    class Tasks {
        file = "_lib\ai_tasks";
        class taskArtilleryFire      {};
        class taskAttack             {};
        class taskConvoy             {};
        class taskDefend             {};
        class taskPatrol             {};
    };

    class Mission {
        file = "_lib\mission";
        class missionInit            {};
        class missionTasks           {};
        class missionConversations    {};
        class missionConversationsVO {};
        class cleanupArea            {};
        class showObjects            {};
        class addHoldAction          {};
        class addAction              {};
    };

    class Extensions {
        file = "_lib\extensions";
        class ext_casualVehicle      {};
        class ext_healthBar          {};
        class ext_healthRegen        {};
        class ext_nvg                {};
    };

    class Ambient {
        file = "_lib\ambient";
        class ambientFlyBy           {};
        class ambientWarfare         {};
    };

    class Create {
        file = "_lib\create";
        class createGroup            {};
        class createGuidedProjectile {};
        class createTrigger          {};
        class createUnit             {};
    };

    class Get {
        file = "_lib\get";
        class getGroup               {};
        class getPosition            {};
        class getRandomArray         {};
        class getRandomPosition      {};
        class getRandomPositionArea  {};
        class collectMarkers         {};
        class collectUnits           {};
        class collectVariables       {};
    };
};