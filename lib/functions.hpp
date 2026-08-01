class EP
{
	
	class AI
	{
		file = "lib\Ambient";
		class ambientWarfare {};
	};

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

	class Mission
	{
		file = "lib\Mission";
		class missionInit {};
		class missionTasks {};
		class missionIntro {};
		class showSubtitles {};
	};

	class Tool
	{
		file = "lib\Tool";
		class getGroup {};
		class getPosition {};
		class getRandomArray {};
		class getRandomPosition {};
		class getRandomPositionArea {};
		class collectMarkers {};
	}
}