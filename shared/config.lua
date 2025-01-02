Config = Config or {}

Config.CoreInfo = {
    Debug = true,
}

Config.GenericStuff = {
    Debug = true,
    Policejob = 'police',
    PoliceJobType = "leo",
}

Config.JobInformation = {
    Jobs = {
        Police = {
            JobName = "police",
            JobType = "leo",
        },
        Unemployed = {
            JobName = "unemployed",
        },
    },
}

Config.Prison = {
    Locations = {
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
    },
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