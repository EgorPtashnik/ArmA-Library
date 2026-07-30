/*
 *  Conversation dispatcher.
 *  Call as:  "Sample" call MY_fnc_conversation;
 *  Extend by adding new "case" branches.
 */

params ["_conversationID"];

switch (_conversationID) do {

    case "Sample": {
        [
            [
                ["Actor 1", "Line 1", 0],
                ["Actor 2", "Line 2", 4]
            ]
        ] call ep_fnc_showSubtitles;
    };

    default {
        systemChat format ["missionConversations: unknown id '%1'", _conversationID];
    };
};
