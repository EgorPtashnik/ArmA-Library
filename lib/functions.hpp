class EP
{
	class AI
	{
		file = "lib\AI";
		class addWaypoint {};
		class clearWaypoints {};
		class setAIMode {};
		class setAISkill {};
		class taskAttack {};
		class taskConvoy {};
		class taskDefend {};
		class taskPatrol {};
	};

	class Ambient
	{
		file = "lib\Ambient";
		class ambientWarfare {};
	};

	class Create
	{
		file = "lib\Create";
		class createGroup {};
		class createTrigger {};
		class createUnit {};
	};

	class Mission
	{
		file = "lib\Mission";
		class missionInit {};
		class missionIntro {};
		class missionTasks {};
		class showObjects {};
		class showSubtitles {};
	};

	class Tool
	{
		file = "lib\Tool";
		class collectMarkers {};
		class collectUnits {};
		class collectVariables {};
		class getGroup {};
		class getPosition {};
		class getRandomArray {};
		class getRandomPosition {};
		class getRandomPositionArea {};
	};

	class Extension
	{
		file="lib\Extension";
		class ext_casualVehicle {};
		class ext_healthBar {};
		class ext_healthRegen {};
	};
};