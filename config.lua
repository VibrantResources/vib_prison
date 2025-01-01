Config = Config or {}

Config.GenericStuff = {
    Debug = true,
    Policejob = 'police',
}

Config.MainPrison = {
    CheckSentenceDuration = vector3(1769.06, 2571.02, 45.63),
    InmateMenu = {
        MenuLocation = vector3(1841.82, 2578.84, 46.01),
    },
    Enteringprison = {
        EnterLocations = { -- Locations the player could spawn after being jailed
            vector4(1628.59, 2499.2, 45.56, 356.74),
            -- vector4(1762.52, 2596.69, 45.72, 191.92),
            -- vector4(1762.52, 2596.69, 45.72, 191.92),
        },
        ArrivalPed = { -- Doctor ped that talks to player on first arrival to prison
            Model = 's_m_m_doctor_01',
            Location = vector4(1628.76, 2504.86, 45.56, 160.1),
        },
        ReturnOnLoginLocations = { -- Lcoations where the player could spawn when relogging whilst jailed
            vector4(1774.53, 2481.23, 45.74, 27.98),
            vector4(1767.59, 2500.72, 45.74, 209.76),
        },
    },
    LeavingPrison = vector4(1848.93, 2585.69, 45.67, 269.53),
    PrisonClothes = { -- Clothes the jailed player will be given, change to relevant slot numbers
        Male = {
            outfitData = {
                ['hat'] = { 
                    item = 0, 
                    texture = 0,
                },
                ['t-shirt'] = { 
                    item = 15, 
                    texture = 0,
                },
                ['torso2'] = { 
                    item = 345, 
                    texture = 0,
                },
                ['arms'] = { 
                    item = 0, 
                    texture = 0,
                },
                ['pants'] = { 
                    item = 3, 
                    texture = 7,
                },
                ['shoes'] = { 
                    item = 1, 
                    texture = 0,
                },
            },
        },
        Female = {
            outfitData = {
                ['hat'] = { 
                    item = 0, 
                    texture = 0,
                },
                ['t-shirt'] = { 
                    item = 14,
                    texture = 0,
                },
                ['torso2'] = { 
                    item = 370, 
                    texture = 0,
                },
                ['arms'] = { 
                    item = 0, 
                    texture = 0,
                },
                ['pants'] = { 
                    item = 0, 
                    texture = 12,
                },
                ['shoes'] = { 
                    item = 1, 
                    texture = 0,
                },
            },
        }
    }
}

Config.ContrabandItems = { -- These items are removed from the player permanently on being jailed
    'weapon_smg',
    'cokebaggystagetwo',
    'cokebaggystagethree',
    'weedplant_weed',
}

Config.Visitation = {
    VisitationPed = {
        Model = "s_m_m_dockwork_01",
        Location = vector4(1839.75, 2580.49, 45.01, 172.59),
    },
    VisitationRoom = {
        InmateLocation = vector4(1828.61, 2591.12, 46.01, 180.91),
        VisitorLocation = vector4(1834.39, 2587.28, 46.01, 91.95),
        GuardPedLocation = vector4(1834.72, 2590.15, 46.01, 110.84),
    },
}

Config.Jobs = {
    Electrician = {
        PedModel = 's_m_m_dockwork_01',
        PedLocation = vector4(1760.23, 2516.73, 44.56, 70.37),
        SentenceReductionOnJobSuccess = 1, -- Amount of months taken off jail sentence when succesfully completing each repair location
        RepairLocations = { -- Locations for repair job, chosen at random each time
            vector3(1761.53, 2540.47, 45.56),
            vector3(1718.62, 2527.33, 45.56),
            vector3(1664.93, 2501.58, 45.56),
            vector3(1627.76, 2538.46, 45.56),
            vector3(1629.88, 2564.3, 45.56),
            vector3(1652.73, 2564.34, 45.56),
            vector3(1737.34, 2504.7, 45.56),
            vector3(1700.34, 2474.94, 45.56),
            vector3(1679.92, 2479.9, 45.56),
            vector3(1643.85, 2490.83, 45.56),
            vector3(1622.43, 2507.72, 45.56),
            vector3(1609.74, 2539.77, 45.56),
            vector3(1608.98, 2566.95, 45.56),
        },
    },
}

Config.WineMaking = {
    Locations = {
        ['orange_burst'] = {
            Location = vector3(175.41, 6448.2, 31.3),
            ingredients = {
                orange = 5,
                water = 3,
            },
        }
    },
}