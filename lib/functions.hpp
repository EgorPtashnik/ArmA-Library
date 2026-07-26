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
		class collectMarkers {};
	}
}