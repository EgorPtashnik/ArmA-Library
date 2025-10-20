# MENU
## EP Library
#### Common
1. [EP_fnc_addAction](#ep_fnc_addaction-menu)
2. [EP_fnc_addHoldAction](#ep_fnc_addholdaction-menu)
3. [EP_fnc_handleTasks](#ep_fnc_handletasks-menu)
#### AI
1. [EP_fnc_addWaypoint](#ep_fnc_addwaypoint-menu)
2. [EP_fnc_clearWaypoints](#ep_fnc_clearwaypoints-menu)
3. [EP_fnc_doArtilleryFire](#ep_fnc_doartilleryfire-menu)
#### Units
1. [EP_fnc_createUnits](#ep_fnc_createunits-menu)
2. [EP_fnc_getUnits](#ep_fnc_getunits-menu)
3. [EP_fnc_showHideUnits](#ep_fnc_showhideunits-menu)
4. [EP_fnc_showUnits](#ep_fnc_showunits-menu)
5. [EP_fnc_hideUnits](#ep_fnc_hideunits-menu)
#### UI
1. [EP_fnc_conversation](#ep_fnc_conversation-menu)
2. [EP_fnc_fadeIn](#ep_fnc_fadein-menu)
3. [EP_fnc_fadeOut](#ep_fnc_fadeout-menu)
4. [EP_fnc_showSubs](#ep_fnc_showsubs-menu)
#### Systems
1. [EP_applySystem_CasualHealth](#ep_applysystem_casualhealth-menu)
2. [EP_applySystem_HealthBar](#ep_applysystem_healthbar-menu)
3. [EP_applySystem_OneManTank](#ep_applysystem_onemantank-menu)
4. [EP_applySystem_RandomRadio](#ep_applysystem_randomradio-menu)
5. [EP_applySystem_SimpleConvoy](#ep_applysystem_simpleconvoy-menu)
#### State Machine
1. [EP_fsm_createStateMachine](#ep_fsm_createstatemachine-menu)
2. [EP_fsm_addState](#ep_fsm_addstate-menu)
3. [EP_fsm_getState](#ep_fsm_getstate-menu)
4. [EP_fsm_setState](#ep_fsm_setstate-menu)
5. [EP_fsm_handleUpdate](#ep_fsm_handleupdate-menu)
6. [EP_fsm_startStateMachine](#ep_fsm_startstatemachine-menu)

# EP_fnc_addAction [Menu](#menu)
```
TODO
```

# EP_fnc_addHoldAction [Menu](#menu)
Добавляет HoldAction объекту
```
[_attachTo, _title, _codeFinish, _iconStart, _duration*, _conditionToShow*, _arguments*, _removeCompleted*, _priority*, _iconProgress*, _conditionToProgress*, _codeStart*] call EP_fnc_addHoldAction;
```
Params:
- _attachTo : OBJECT
- _title : STRING
- _codeFinish : CODE
- _iconStart ; STRING
- _duration : NUMBER (default: 3)
- _conditionToShow : STRING CODE (default: "true")
- _arguments : ARRAY (default: [])
- _removeCompleted : BOOLEAN (default: true)
- _priority : NUMBER (default: 1000)
- _iconProgress : STRING (default: objNull)
- _conditionToProgress : STRING CODE (default: "true")
- _codeStart : CODE (default: {})
- _codeProgress : CODE (default: {})
- _codeInterupted : CODE (default: {})
- _showUnconsious : BOOLEAN (default: false)
- _showWindow : BOOLEAN (default: true)

Returns: NONE

# EP_fnc_showSubs [Menu](#menu)
Показывает субтитры
```
[_title, _subtitles, _duration*, _chatType*, _toUpper*] call EP_fnc_showSubs;
```
Params:
- _title : STRING
- _subtitles : STRING
- _duration : NUMBER (default: 5)
- _chatType : NUMBER(0,1,2) (default: 2)
- _toUpper : BOOLEAN (default: true)

Returns: NONE

# EP_fnc_conversation [Menu](#menu)
Показывает субтитры со звуком рации \ бипом
```
[_title, _subtitles, _duration*, _isRadio*, _radioSoundIn*, _radioSoundOut*, _chatType*, _toUpper*] call EP_fnc_conversation;
```
Params:
- _title : STRING
- _subtitles : STRING
- _duration : NUMBER (default: 5)
- _isRadio : BOOLEAN (default: true)
- _radioSoundIn : STRING (default: "myin1")
- _radioSoundOut : STRING (default: "myin4")
- _chatType : NUMBER (default: 2)
- _toUpper : BOOLEAN (default: true)

Returns: NONE

# EP_fnc_fadeIn [Menu](#menu)
Эффект проявления экрана
```
[_duration*, _color*, _blur*] call EP_fnc_fadeIn;
```
Params:
- _duration : NUMBER (default: 5)
- _color : STRING("BLACK","WHITE") (default: "BLACK")
- _blur : NUMBER (default: 0)

Returns: _duration : NUMBER

# EP_fnc_fadeOut [Menu](#menu)
Эффект затухания экрана
```
[_duration*, _color*, _blur*] call EP_fnc_fadeOut;
```
Params:
- _duration : NUMBER (default: 5)
- _color : STRING("BLACK","WHITE") (default: "BLACK")
- _blur : NUMBER (default: 0)

Returns: _duration : NUMBER

# EP_fnc_showHideUnits [Menu](#menu)
Скрывает \ Возвращает юнитов
```
[_units, _toHide*] call EP_fnc_showHideUnits;
```
Params:
- _units : GROUP | ARRAY\<Units> | ARRAY\<Groups>
- _toHide : BOOLEAN (default: true)

Returns: _units : ARRAY\<Units>

# EP_fnc_showUnits [Menu](#menu)
Возвращает юнитов
```
[_units] call EP_fnc_showUnits;
```
Params:
- _units : GROUP | ARRAY\<Units> | ARRAY\<Groups>

Returns: _units : ARRAY\<Units>

# EP_fnc_hideUnits [Menu](#menu)
Скрывает юнитов
```
[_units] call EP_fnc_hideUnits;
```
Params:
- _units : GROUP | ARRAY\<Units> | ARRAY\<Groups>

Returns: _units : ARRAY\<Units>

# EP_fnc_doArtilleryFire [Menu](#menu)
Залп артиллерией по позиции
```
[_artillery, _targetPosition, _roundsNumber, _magazineType*, _sleepRange*] call EP_fnc_doArtilleryFire;
```
Params:
- _artillery : ARRAY\<Vehicles> | GROUP
- _targetPosition : ARRAY\<Position>
- _roundsNumber : NUMBER
- _magazineType : STRING (default: objNull)
- _sleepRange : ARRAY\<min,mid,max> (default: [0.5, 1, 1.5])

Returns: _artillery : ARRAY\<Vehicles>

# EP_fnc_addWaypoint [Menu](#menu)
Добавить вейпоинт группе
```
[_group, _position, _wpParams*, _setCurrent*, _syncWaypoints*] call EP_fnc_addWaypoint;
```
Params:
- _group : GROUP | UNIT
- _position : ARRAY\<Position>
- _wpParams : ARRAY\<[["type": "MOVE"]]> (default: [])
- _setCurrent : BOOLEAN (default: false)
- _syncWaypoints : ARRAY (default: [])

Returns: _waypoint : WAYPOINT

# EP_fnc_clearWaypoints [Menu](#menu)
Удалить все вейпоинты группы
```
[_group] call EP_fnc_clearWaypoints;
```
Params:
- _group : GROUP | UNIT

Returns: NONE

# EP_fnc_createUnits [Menu](#menu)
Создать группу с техникой
```
[_spawnPosition, _sideOrGroup, _units, _vehicles*, direction*, _relPositions*, _createCrewForVehicles*, _deleteGroupWhenEmpty*, _vehicleSpecialParam* ] call EP_fnc_createUnits;
```
Params:
- _spawnPosition : ARRAY\<Position>
- _sideOrGroup : SIDE
- _units : ARRAY\<Unit Classes>
- _vehicles : ARRAY\<Vehicle Classes> (default: [])
- direction : NUMBER (default: -1)
- _relPositions : ARRAY (default: []; format: [distance, direction])
- _createCrewForVehicles : BOOLEAN (default: true)
- _deleteGroupWhenEmpty : BOOLEAN (default: true)
- _vehicleSpecialParam : STRING (default: "NONE")

Returns: _group : GROUP

# EP_fnc_handleTasks [Menu](#menu)
Процесс задачи. Задачи перечисляются в переменной EP_tasks.
```
EP_tasks = createHashMapFromArray [
  [ "TaskCaptureCity_1", [ player, "TaskCaptureCity_1",
    ["Join an attack on position Alpha and secure the area.", "Position Alpha"],
    markerPos "o_1", true, -1, true, "a", false]
  ],
  [ "TaskCaptureCity_2", [ player, "TaskCaptureCity_2",
    ["Keep advancing and capture position Beta.", "Position Beta"],
    markerPos "o_2", true, -1, true, "b", false]
  ],
  [ "TaskCaptureCity_3", [ player, "TaskCaptureCity_3",
    ["It's time to end thid. Knock out the enemy from his last line of defence at position Gamma.", "Gamma"],
    markerPos "o_3", true, -1, true, "g", false]
  ]
];
```
```
[_taskId, _newState*, _showHint*] call EP_fnc_handleTasks;
```
Params:
- _taskId : STRING
- _newState : STRING (default: "SUCCEEDED")
- _showHint : BOOLEAN (default: true)

Returns: _taskId : STRING

# EP_fsm_createStateMachine [Menu](#menu)
Создать FSM
```
[] call EP_fsm_createStateMachine;
```

Returns: _sm : STATE MACHINE

# EP_fsm_addState [Menu](#menu)
Добавить в FSM новый State
```
[_sm, _name, _onEnter, _transitions] call EP_fsm_addState;
```
Params:
- _sm : STATE MACHINE
- _name : STRING
- _onEnter : CODE
- _transitions : ARRAY\<[ [StateName, {condition}] ]>

Returns: NONE

# EP_fsm_getState [Menu](#menu)
Получить FSM State
```
[_sm, _name] call EP_fsm_getState;
```
Params:
- _sm : STATE MACHINE
- _name : STRING

Returns: _state : STATE MAP OBJECT

# EP_fsm_handleUpdate [Menu](#menu)
Обработчик обновления State в FSM
```
[_sm] call EP_fsm_handleUpdate;
```
Params:
- _sm : STATE MACHINE

Returns: NONE

# EP_fsm_setState [Menu](#menu)
Задать в FSM новый state
```
[_sm, _newStateName] call EP_fsm_setState;
```
Params:
- _sm : STATE MACHINE
- _newStateName : STRING

Returns: None

# EP_fsm_startStateMachine [Menu](#menu)
Запустить FSM
```
[_sm, _initial] call EP_fsm_startStateMachine;
```
Params:
- _sm : STATE MACHINE
- _initial : STRING

Returns: None

# EP_applySystem_OneManTank [Menu](#menu)
Применить систему упраления техникой одним игроком к списку техники
```
[_vehicles, _enableSentences*, _getOutText*, _cameraExternal*] call EP_applySystem_OneManTank;
```
Params:
- _vehicles : ARRAY\<Vehicles>
- _enableSentences : BOOLEAN (default: false)
- _getOutText : STRING (default: "Выйти")
- _cameraExternal : BOOLEAN (default: true)

Returns: None

# EP_applySystem_CasualHealth [Menu](#menu)
Применить систему казуального здоровья к списку юнитов
```
[_units, _regenHealth*, _defaultDamage*, _headshotKill*, _threshold*, _regenCoef*] call EP_applySystem_CasualHealth;
```
Params:
- _units : ARRAY\<Units> | ARRAY\<Groups> | GROUP
- _regenHealth : BOOLEAN (default: true)
- _defaultDamage : NUMBER (default: 0.1)
- _headshotKill : BOOLEAN (default: true)
- _threshold : NUMBER (default: 0.2)
- _regenCoef : NUMBER (default: 0.05)

Returns: None

# EP_applySystem_HealthBar [Menu](#menu)
Показать полоску здоровья игроку
```
[_targetUnit*, _layerId*, _healthShowVehicle*, _healthCharNumber*, _healthSymbol*, _healthMediumThreshold*, _healthHighThreshold*, _healthPosFromBottomPerc*, _healthPosFromRightPerc*, _healthColorMap*, _updateOnEach*] spawn EP_applySystem_HealthBar;
```
Params:
- _targetUnit : UNIT (default: player)
- _layerId : NUMBER (default: 1)
- _healthShowVehicle : BOOLEAN (default: false)
- _healthCharNumber : NUMBER (default: 66)
- _healthSymbol : STRING (default: "I")
- _healthMediumThreshold : NUMBER (default: 20)
- _healthHighThreshold : NUMBER (default: 40)
- _healthPosFromBottomPerc : NUMBER (default: 1.62)
- _healthPosFromRightPerc : NUMBER (default: 1.616)
- _healthColorMap : STRING (default: ["#ff6565", "#ffae8e", "#ffffff"])
- _updateOnEach : NUMBER (default: 0.1)

Returns: None

# EP_applySystem_SimpleConvoy [Menu](#menu)
Применить систему конвоя к группе
```
[_convoyGroup, _convoySpeed*, _convoySeparation*, _pushThrough*] spawn EP_applySystem_SimpleConvoy;
```
Params:
- _convoyGroup : GROUP
- _convoySpeed : NUMBER (default: 50)
- _convoySeparation : NUMBER (default: 50)
- _pushThrough : BOOLEAN (default: true)

Returns: None

# EP_applySystem_RandomRadio [Menu](#menu)
Применить систему рандомного радио
```
[_side, _sleepBetween*, _condition*] spawn EP_applySystem_RandomRadio;
```
Params:
- _side : SIDE
- _sleepBetween : NUMBER (default: 10)
- _condition : CODE

Returns: None

# EP_fnc_getUnits [Menu](#menu)
Применить систему рандомного радио
```
(group player) call EP_fnc_getUnits;
```
Params:
- _this : ARRAY\<Units> | ARRAY\<Groups> | GROUP

Returns: _units : ARRAY\<Units>