class EP
{
	class AI
	{
		file = "lib\AI";
		class addWaypoint {};
		class clearWaypoints {};
		class setAIMode {};
		class taskAttack {};
		class taskPatrol {};
		class taskDefend {};
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
}