Jobs = Jobs or {}

Jobs = {
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