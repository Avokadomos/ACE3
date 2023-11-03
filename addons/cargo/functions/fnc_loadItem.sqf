#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Loads an object into a vehicle.
 * Objects loaded via classname remain virtual until unloaded.
 *
 * Arguments:
 * 0: Item to be loaded <STRING> or <OBJECT> (default: "")
 * 1: Holder object (vehicle) <OBJECT> (default: objNull)
 * 2: Ignore interaction distance and stability checks <BOOL> (default: false)
 *
 * Return Value:
 * Object loaded <BOOL>
 *
 * Example:
 * ["ACE_Wheel", cursorObject] call ace_cargo_fnc_loadItem
 *
 * Public: Yes
 */

params [["_item", "", [objNull, ""]], ["_vehicle", objNull, [objNull]], ["_ignoreInteraction", false, [false]]];
TRACE_3("params",_item,_vehicle,_ignoreInteraction);

// Get config sensitive case name
if (_item isEqualType "") then {
    _item = _item call EFUNC(common,getConfigName);
};

if !([_item, _vehicle, _ignoreInteraction] call FUNC(canLoadItemIn)) exitWith {
    TRACE_3("cannot load",_item,_vehicle,_ignoreInteraction);

    false // return
};

private _loaded = _vehicle getVariable [QGVAR(loaded), []];
_loaded pushBack _item;
_vehicle setVariable [QGVAR(loaded), _loaded, true];

TRACE_1("added to loaded array",_loaded);

// Update cargo space remaining
private _cargoSpace = _vehicle call FUNC(getCargoSpaceLeft);
private _itemSize = (_item call FUNC(getSizeItem)) max 0; // don't let negative size items increase space
_vehicle setVariable [QGVAR(space), _cargoSpace - _itemSize, true];

// Attach object 100m below vehicle
if (_item isEqualType objNull) then {
    detach _item;
    _item attachTo [_vehicle, [0, 0, -100]];
    [QEGVAR(common,hideObjectGlobal), [_item, true]] call CBA_fnc_serverEvent;

    // Some objects below water will take damage over time, eventually becoming "water logged" and unfixable (because of negative z attach)
    [_item, "blockDamage", "ACE_cargo", true] call EFUNC(common,statusEffect_set);
};

// Invoke listenable event
["ace_cargoLoaded", [_item, _vehicle]] call CBA_fnc_globalEvent;

true // return
