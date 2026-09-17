private _units = [];

if !(_this isEqualType []) then {
    _this = [_this];
};

{
    switch true do {
        case (_x isEqualType ""): {_units append (getMissionLayerEntities _x # 0)};
        case (_x isEqualType grpNull): {_units append (units _x)};
        case (_x isEqualType []): {_units append _x};
        case (_x isEqualType objNull): {_units append [_x]};
        default {diag_log formatText ["[LOG] %1(%2): %3", __FILE__, __LINE__, "Cannot get units! Wrong parameter type!"]}
    };
} forEach _this;

_units