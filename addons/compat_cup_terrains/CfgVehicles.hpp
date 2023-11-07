class CfgVehicles {
    class House;
    class Strategic;
    class House_EP1: House {};

    class Land_Benzina_schnell: House {
        transportFuel = 0;
        EGVAR(refuel,hooks)[] = {{-1.5,-3.93,-1.25}, {2.35,-3.93,-1.25}};
        EGVAR(refuel,fuelCargo) = -10;
        class ACE_Actions {
            class ACE_MainActions {
                displayName = ECSTRING(interaction,MainAction);
                position = "[0,-3.93,-1.25]";
                distance = 5;
                condition = "true";
            };
        };
    };
    class Land_A_FuelStation_Feed: Strategic {
        transportFuel = 0;
        EGVAR(refuel,hooks)[] = {{-0.34,0,0}, {0.34,0,0}};
        EGVAR(refuel,fuelCargo) = -10;
    };
    class Land_Ind_FuelStation_Feed_EP1: House_EP1 {
        transportFuel = 0;
        EGVAR(refuel,hooks)[] = {{-0.34,0,0}, {0.34,0,0}};
        EGVAR(refuel,fuelCargo) = -10;
    };
    class Land_FuelStation_Feed_PMC: Strategic {
        transportFuel = 0;
        EGVAR(refuel,hooks)[] = {{-0.34,0,0}, {0.34,0,0}};
        EGVAR(refuel,fuelCargo) = -10;
    };
};
