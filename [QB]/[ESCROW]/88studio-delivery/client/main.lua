inTheJob = false
vehiclePlate = nil
BusinessPed = false
MissionBlip = false
firstOpen = true
isOpenMenu = false
isOpenPhone = false
PlayerData = {}
jobDetails = {}
packageInTheTrunk = 0
isDoorOpen = false
oldMialege = 0
cc = nil
phoneProp = nil
ox_target = {}

local earnedXP = 0
local earnedMoney = 0
local deliveredPackage = 0

IntType = nil

Language = Lang[Config.Language]

-- ███╗   ███╗ █████╗ ██╗███╗   ██╗    ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
-- ████╗ ████║██╔══██╗██║████╗  ██║    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
-- ██╔████╔██║███████║██║██╔██╗ ██║    █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   
-- ██║╚██╔╝██║██╔══██║██║██║╚██╗██║    ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   
-- ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   

RegisterNetEvent('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    CreateEntity()
    ScriptStarting()
    IntType = Config.Interaction.type
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = Framework.Functions.GetPlayerData()

    CreateEntity()
    ScriptStarting()
    IntType = Config.Interaction.type
end)

RegisterNetEvent('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    if IntType == 'qb-target' then
        exports['qb-target']:RemoveTargetEntity(bossPed)
        exports['qb-target']:RemoveTargetEntity(BusinessPed)
        exports['qb-target']:RemoveTargetBone({'boot'}, Language.TARGET.PUT_PACKAGE_VEHICLE)
        exports['qb-target']:RemoveTargetBone({'boot'}, Language.TARGET.PICK_UP_PACKAGE_VEHICLE)
    elseif IntType == 'qtarget' then
        exports['qtarget']:RemoveTargetEntity(bossPed)
        exports['qtarget']:RemoveTargetEntity(BusinessPed)
        exports['qtarget']:RemoveTargetBone({'boot'}, Language.TARGET.PUT_PACKAGE_VEHICLE)
        exports['qtarget']:RemoveTargetBone({'boot'}, Language.TARGET.PICK_UP_PACKAGE_VEHICLE)
    elseif IntType == 'ox_target' then
        exports['ox_target']:removeLocalEntity(bossPed)
        exports['ox_target']:removeLocalEntity(BusinessPed)
        exports['ox_target']:removeGlobalVehicle('deliver_put_package_vehicle')
    end

    if bossPed then
        DeleteEntity(bossPed)
    end

    if newProp then
        DeleteEntity(newProp)
    end

    if MissionBlip then
        RemoveBlip(MissionBlip)
    end
    TriggerEvent('chat:removeSuggestion', Config.DutyTablet.command.name)
    StopTabletAnim()
    StopPhoneAnim()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if IntType == 'qb-target' then
        exports['qb-target']:RemoveTargetEntity(bossPed)
        exports['qb-target']:RemoveTargetEntity(BusinessPed)
        exports['qb-target']:RemoveTargetBone({'boot'}, Language.TARGET.PUT_PACKAGE_VEHICLE)
        exports['qb-target']:RemoveTargetBone({'boot'}, Language.TARGET.PICK_UP_PACKAGE_VEHICLE)
    elseif IntType == 'qtarget' then
        exports['qtarget']:RemoveTargetEntity(bossPed)
        exports['qtarget']:RemoveTargetEntity(BusinessPed)
        exports['qtarget']:RemoveTargetBone({'boot'}, Language.TARGET.PUT_PACKAGE_VEHICLE)
        exports['qtarget']:RemoveTargetBone({'boot'}, Language.TARGET.PICK_UP_PACKAGE_VEHICLE)
    elseif IntType == 'ox_target' then
        exports['ox_target']:removeLocalEntity(bossPed)
        exports['ox_target']:removeLocalEntity(BusinessPed)
        exports['ox_target']:removeGlobalVehicle('deliver_put_package_vehicle')
    end

    if bossPed then
        DeleteEntity(bossPed)
    end

    if newProp then
        DeleteEntity(newProp)
    end

    if MissionBlip then
        RemoveBlip(MissionBlip)
    end
    TriggerEvent('chat:removeSuggestion', Config.DutyTablet.command.name)
    StopTabletAnim()
    StopPhoneAnim()
end)

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

-- ███████╗██╗██████╗ ███████╗████████╗     ██████╗ ██████╗ ███████╗███╗   ██╗
-- ██╔════╝██║██╔══██╗██╔════╝╚══██╔══╝    ██╔═══██╗██╔══██╗██╔════╝████╗  ██║
-- █████╗  ██║██████╔╝███████╗   ██║       ██║   ██║██████╔╝█████╗  ██╔██╗ ██║
-- ██╔══╝  ██║██╔══██╗╚════██║   ██║       ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║
-- ██║     ██║██║  ██║███████║   ██║       ╚██████╔╝██║     ███████╗██║ ╚████║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝

FirstOpen = function()
    if firstOpen then
        nuiMessage('SET_LANGUAGE', Lang[Config.Language].WEB)
        local jobs = {
            {
                id = 'sweet',
                name = Lang[Config.Language].WEB.SWEET_JOB_NAME,
                description = Lang[Config.Language].WEB.SWEET_JOB_DESC,
                level = Config.Stage.sweet.requiredLevel,
                image = 'bg-1',
            },
            {
                id = 'pizza', 
                name = Lang[Config.Language].WEB.PIZZARIA_JOB_NAME,
                description = Lang[Config.Language].WEB.PIZZARIA_JOB_DESC,
                level = Config.Stage.pizzaria.requiredLevel, 
                image = 'bg-2',
            },
            {
                id = 'hamburger', 
                name = Lang[Config.Language].WEB.HAMBURGER_JOB_NAME,
                description = Lang[Config.Language].WEB.HAMBURGER_JOB_DESC,
                level = Config.Stage.hamburger.requiredLevel, 
                image = 'bg-3',
            },
        }

        local cars = {
            sweet = {
                {
                    id = 'scooter',
                    name = Lang[Config.Language].WEB.BAD_COURIER_SCOOTER_NAME,
                    description = Lang[Config.Language].WEB.BAD_COURIER_SCOOTER_DESC,
                    level = Config.Stage.sweet.vehicles['1'].requiredLevel,
                    image = 'coruier-motor',
                },
                {
                    id = 'normal', 
                    name = Lang[Config.Language].WEB.NORMAL_COURIER_VEHICLE_NAME,
                    desc = Lang[Config.Language].WEB.NORMAL_COURIER_VEHICLE_DESC,
                    level = Config.Stage.sweet.vehicles['2'].requiredLevel, 
                    image = 'coruier-car',
                },
                {
                    id = 'luxury', 
                    name = Lang[Config.Language].WEB.LUXURY_COURIER_VEHICLE_NAME,
                    desc = Lang[Config.Language].WEB.LUXURY_COURIER_VEHICLE_DESC,
                    level = Config.Stage.sweet.vehicles['3'].requiredLevel, 
                    image = 'coruier-scar',
                },
            },
            pizza = {
                {
                    id = 'scooter',
                    name = Lang[Config.Language].WEB.BAD_COURIER_SCOOTER_NAME,
                    desc = Lang[Config.Language].WEB.BAD_COURIER_SCOOTER_DESC,
                    level = Config.Stage.pizzaria.vehicles['1'].requiredLevel,
                    image = 'coruier-motor',
                },
                {
                    id = 'normal', 
                    name = Lang[Config.Language].WEB.NORMAL_COURIER_VEHICLE_NAME,
                    desc = Lang[Config.Language].WEB.NORMAL_COURIER_VEHICLE_DESC,
                    level = Config.Stage.pizzaria.vehicles['2'].requiredLevel, 
                    image = 'coruier-car',
                },
                {
                    id = 'luxury', 
                    name = Lang[Config.Language].WEB.LUXURY_COURIER_VEHICLE_NAME,
                    desc = Lang[Config.Language].WEB.LUXURY_COURIER_VEHICLE_DESC,
                    level = Config.Stage.pizzaria.vehicles['3'].requiredLevel, 
                    image = 'coruier-scar',
                },
            },
            hamburger = {
                {
                    id = 'scooter',
                    name = Lang[Config.Language].WEB.BAD_COURIER_SCOOTER_NAME,
                    desc = Lang[Config.Language].WEB.BAD_COURIER_SCOOTER_DESC,
                    level = Config.Stage.pizzaria.vehicles['1'].requiredLevel,
                    image = 'coruier-motor',
                },
                {
                    id = 'normal', 
                    name = Lang[Config.Language].WEB.NORMAL_COURIER_VEHICLE_NAME,
                    desc = Lang[Config.Language].WEB.NORMAL_COURIER_VEHICLE_DESC,
                    level = Config.Stage.pizzaria.vehicles['2'].requiredLevel, 
                    image = 'coruier-car',
                },
                {
                    id = 'luxury', 
                    name = Lang[Config.Language].WEB.LUXURY_COURIER_VEHICLE_NAME,
                    desc = Lang[Config.Language].WEB.LUXURY_COURIER_VEHICLE_DESC,
                    level = Config.Stage.pizzaria.vehicles['3'].requiredLevel, 
                    image = 'coruier-scar',
                },
            },
        }
        
        nuiMessage('SET_JOBS', jobs)
        nuiMessage('SET_CARS', cars)
        firstOpen = false
    end
end

-- ███████╗████████╗ ██████╗ ██████╗     ████████╗ █████╗ ██████╗ ██╗     ███████╗████████╗     █████╗ ███╗   ██╗██╗███╗   ███╗
-- ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗    ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝╚══██╔══╝    ██╔══██╗████╗  ██║██║████╗ ████║
-- ███████╗   ██║   ██║   ██║██████╔╝       ██║   ███████║██████╔╝██║     █████╗     ██║       ███████║██╔██╗ ██║██║██╔████╔██║
-- ╚════██║   ██║   ██║   ██║██╔═══╝        ██║   ██╔══██║██╔══██╗██║     ██╔══╝     ██║       ██╔══██║██║╚██╗██║██║██║╚██╔╝██║
-- ███████║   ██║   ╚██████╔╝██║            ██║   ██║  ██║██████╔╝███████╗███████╗   ██║       ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║
-- ╚══════╝   ╚═╝    ╚═════╝ ╚═╝            ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝   ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝

StopTabletAnim = function()
	StopAnimTask(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
	DeleteObject(Tablet)
end

StopPhoneAnim = function()
	StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 3.0, 3.0, -1, 49, 0, false, false, false)
	DeleteObject(phoneProp)
end


-- ███████╗████████╗ █████╗ ██████╗ ████████╗    ████████╗ █████╗ ██████╗ ██╗     ███████╗████████╗     █████╗ ███╗   ██╗██╗███╗   ███╗
-- ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝    ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝╚══██╔══╝    ██╔══██╗████╗  ██║██║████╗ ████║
-- ███████╗   ██║   ███████║██████╔╝   ██║          ██║   ███████║██████╔╝██║     █████╗     ██║       ███████║██╔██╗ ██║██║██╔████╔██║
-- ╚════██║   ██║   ██╔══██║██╔══██╗   ██║          ██║   ██╔══██║██╔══██╗██║     ██╔══╝     ██║       ██╔══██║██║╚██╗██║██║██║╚██╔╝██║
-- ███████║   ██║   ██║  ██║██║  ██║   ██║          ██║   ██║  ██║██████╔╝███████╗███████╗   ██║       ██║  ██║██║ ╚████║██║██║ ╚═╝ ██║
-- ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝          ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝   ╚═╝       ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝

StartTabletAnim = function()
    RequestAnimDict("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a")
    while not HasAnimDictLoaded("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a") do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a" ,8.0, -8.0, -1, 50, 0, false, false, false)
    Tablet = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(Tablet, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.05, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
end

StartPhoneAnim = function()
    RequestAnimDict("cellphone@")
    while not HasAnimDictLoaded("cellphone@") do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 3.0, 3.0, -1, 49, 0, false, false, false)

    local playerPed = PlayerPedId()
    phoneProp = CreateObject(GetHashKey('prop_npc_phone_02'), 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(phoneProp, playerPed, GetPedBoneIndex(playerPed, 57005), 0.15, -0.01, -0.03, 0.0, 270.0, 180.0, true, true, false, true, 1, true)
end


--  ██████╗ ███████╗████████╗    ███████╗██████╗ ███████╗███████╗    ██████╗  █████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗     ███████╗██████╗  ██████╗ ████████╗███████╗
-- ██╔════╝ ██╔════╝╚══██╔══╝    ██╔════╝██╔══██╗██╔════╝██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝     ██╔════╝██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
-- ██║  ███╗█████╗     ██║       █████╗  ██████╔╝█████╗  █████╗      ██████╔╝███████║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗    ███████╗██████╔╝██║   ██║   ██║   ███████╗
-- ██║   ██║██╔══╝     ██║       ██╔══╝  ██╔══██╗██╔══╝  ██╔══╝      ██╔═══╝ ██╔══██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║    ╚════██║██╔═══╝ ██║   ██║   ██║   ╚════██║
-- ╚██████╔╝███████╗   ██║       ██║     ██║  ██║███████╗███████╗    ██║     ██║  ██║██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝    ███████║██║     ╚██████╔╝   ██║   ███████║
--  ╚═════╝ ╚══════╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚══════╝╚═╝      ╚═════╝    ╚═╝   ╚══════╝

GetFreeParkingSpots = function()
    for _, parkingSpot in ipairs(ParkingSpot) do
        local veh, distance = Framework.Functions.GetClosestVehicle(vector3(parkingSpot.x, parkingSpot.y, parkingSpot.z))
        if veh == -1 or distance >= 1.5 then
            return parkingSpot
        end
    end
end

--  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗    ██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗███████╗    ██████╗ ██╗     ██╗██████╗ 
-- ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝    ██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔════╝    ██╔══██╗██║     ██║██╔══██╗
-- ██║     ███████║█████╗  ██║     █████╔╝     ██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║█████╗      ██████╔╝██║     ██║██████╔╝
-- ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗     ██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══╝      ██╔══██╗██║     ██║██╔═══╝ 
-- ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗    ██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ███████╗    ██████╔╝███████╗██║██║     
--  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝    ╚═════╝ ╚══════╝╚═╝╚═╝     

CheckTaskTrolleyToRemoveBlip = function()
    local playerPed = PlayerPedId()
    
    Citizen.CreateThread(function()
        while true do
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if vehicle and vehicle ~= 0 then
                local plate = GetVehicleNumberPlateText(vehicle)
                if plate == vehiclePlate then
                    TriggerEvent('88studio-delivery:client:newBusinessLocation')
                    CreateThread(function()
                        ShowDutyTime()
                    end)
                    CreateThread(function()
                        SetVehicleKM()
                    end)
                    CreateThread(function()
                        CheckVehicleDistance()
                    end)
                    CreateThread(function()
                        CheckDifferentVehicle()
                    end)
                    break
                end
            end

            Citizen.Wait(1000)
        end
    end)
end

-- ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗         ██████╗ ██████╗  ██████╗ ██████╗     ███╗   ███╗ ██████╗ ██████╗ ███████╗██╗     
-- ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║         ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝██║     
-- ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║         ██████╔╝██████╔╝██║   ██║██████╔╝    ██╔████╔██║██║   ██║██║  ██║█████╗  ██║     
-- ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║         ██╔═══╝ ██╔══██╗██║   ██║██╔═══╝     ██║╚██╔╝██║██║   ██║██║  ██║██╔══╝  ██║     
-- ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗    ██║     ██║  ██║╚██████╔╝██║         ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗███████╗
-- ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝         ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝

InstallPropModel = function(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(1)
    end
end

-- ███╗   ██╗███████╗██╗    ██╗    ██████╗ ██╗   ██╗███████╗██╗███╗   ██╗███████╗███████╗███████╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ████╗  ██║██╔════╝██║    ██║    ██╔══██╗██║   ██║██╔════╝██║████╗  ██║██╔════╝██╔════╝██╔════╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██╔██╗ ██║█████╗  ██║ █╗ ██║    ██████╔╝██║   ██║███████╗██║██╔██╗ ██║█████╗  ███████╗███████╗    ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ██║╚██╗██║██╔══╝  ██║███╗██║    ██╔══██╗██║   ██║╚════██║██║██║╚██╗██║██╔══╝  ╚════██║╚════██║    ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ██║ ╚████║███████╗╚███╔███╔╝    ██████╔╝╚██████╔╝███████║██║██║ ╚████║███████╗███████║███████║    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝     ╚═════╝  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

GetRandomWorkplaceCoordinates = function()
    return BusinessCoords[jobDetails.job_type][math.random(1, #BusinessCoords[jobDetails.job_type])]
end

GetRandomCustomerCoordinates = function()
    return CustomerCoords[math.random(1, #CustomerCoords)]
end

--  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗    ██████╗ ██╗███████╗███████╗███████╗██████╗ ███████╗███╗   ██╗████████╗    ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗
-- ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝    ██╔══██╗██║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝████╗  ██║╚══██╔══╝    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝
-- ██║     ███████║█████╗  ██║     █████╔╝     ██║  ██║██║█████╗  █████╗  █████╗  ██████╔╝█████╗  ██╔██╗ ██║   ██║       ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  
-- ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗     ██║  ██║██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══██╗██╔══╝  ██║╚██╗██║   ██║       ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  
-- ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗    ██████╔╝██║██║     ██║     ███████╗██║  ██║███████╗██║ ╚████║   ██║        ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗
--  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝    ╚═════╝ ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝         ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝

CheckDifferentVehicle = function()
    local playerPed = PlayerPedId()
    Citizen.CreateThread(function()
        while inTheJob and Config.NoAnotherVehicle.enable do
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if vehicle and vehicle ~= 0 then
                local plate = GetVehicleNumberPlateText(vehicle)
                if plate ~= vehiclePlate then
                    inTheJob = false
                    TriggerEvent('88studio-core:sendNotification', Config.NoAnotherVehicle.message, 'error', 3000)
                    TriggerServerEvent('88studio-delivery:server:createBlips', ReturnVehicleCoords, Config.Blip.failBlip, 'Return Vehicle Back')
                    TriggerEvent('88studio-delivery:client:failJob')
                    break
                end
            end

            Citizen.Wait(1500)
        end
    end)
end

-- ███████╗███████╗████████╗    ██████╗ ██████╗  ██████╗ ██████╗ 
-- ██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
-- ███████╗█████╗     ██║       ██████╔╝██████╔╝██║   ██║██████╔╝
-- ╚════██║██╔══╝     ██║       ██╔═══╝ ██╔══██╗██║   ██║██╔═══╝ 
-- ███████║███████╗   ██║       ██║     ██║  ██║╚██████╔╝██║     
-- ╚══════╝╚══════╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     

local propBool = false
local SetupGetTarget = false
SetProp = function()
    local playerPed = PlayerPedId()
    if not propBool then
        local model = Objects[jobDetails.job_type].object
        InstallPropModel(model)
        local modelHash = GetHashKey(model)
        prop = CreateObject(modelHash, Objects[jobDetails.job_type].spawnX, Objects[jobDetails.job_type].spawnY, Objects[jobDetails.job_type].spawnZ, Objects[jobDetails.job_type].isNetwork, Objects[jobDetails.job_type].netMissionEntity, Objects[jobDetails.job_type].doorFlag)

        AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, Objects[jobDetails.job_type].boneIndex), Objects[jobDetails.job_type].xPos, Objects[jobDetails.job_type].yPos, Objects[jobDetails.job_type].zPos, Objects[jobDetails.job_type].xRot, Objects[jobDetails.job_type].yRot, Objects[jobDetails.job_type].zRot, true, true, false, true, 1, true)
        RequestAnimDict(Objects[jobDetails.job_type].animDict)
        TaskPlayAnim(playerPed, Objects[jobDetails.job_type].animDict, Objects[jobDetails.job_type].animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
        SetModelAsNoLongerNeeded(modelHash)

        propBool = true
        packageInTheTrunk = 1
        PutTheTrunk()

        CreateThread(function()
            while DoesEntityExist(prop) do
                if not IsEntityPlayingAnim(playerPed, Objects[jobDetails.job_type].animDict, Objects[jobDetails.job_type].animName, 3) then
                    TaskPlayAnim(playerPed, Objects[jobDetails.job_type].animDict, Objects[jobDetails.job_type].animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
                end
                Wait(1000)
            end
            RemoveAnimDict(Objects[jobDetails.job_type].animDict)
        end)
    else
        if DoesEntityExist(prop) then
            DetachEntity(playerPed, true, false)
            DeleteEntity(prop)
            prop = nil
            ClearPedTasksImmediately(playerPed)
            propBool = false

            if inTheJob and packageInTheTrunk == 2 and not SetupGetTarget then
                GetTheTrunk()
            end
        end
    end
end

-- ██████╗ ██╗   ██╗████████╗    ████████╗██╗  ██╗███████╗    ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗    ████████╗██████╗ ██╗   ██╗███╗   ██╗██╗  ██╗
-- ██╔══██╗██║   ██║╚══██╔══╝    ╚══██╔══╝██║  ██║██╔════╝    ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝    ╚══██╔══╝██╔══██╗██║   ██║████╗  ██║██║ ██╔╝
-- ██████╔╝██║   ██║   ██║          ██║   ███████║█████╗      ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗         ██║   ██████╔╝██║   ██║██╔██╗ ██║█████╔╝ 
-- ██╔═══╝ ██║   ██║   ██║          ██║   ██╔══██║██╔══╝      ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝         ██║   ██╔══██╗██║   ██║██║╚██╗██║██╔═██╗ 
-- ██║     ╚██████╔╝   ██║          ██║   ██║  ██║███████╗    ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗       ██║   ██║  ██║╚██████╔╝██║ ╚████║██║  ██╗
-- ╚═╝      ╚═════╝    ╚═╝          ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝       ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝
                                                                                                                                                                    

PutTheTrunk = function()
    local ped = PlayerPedId()

    if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
        exports[Config.Interaction.type]:AddTargetBone({'boot'}, {
            options = {
                {
                    label = Lang[Config.Language].TARGET.PUT_PACKAGE_VEHICLE,
                    icon = 'fas fa-box',
                    action = function(entity)
                        packageInTheTrunk = 2
                        FreezeEntityPosition(ped, true)
                        local animDict = Animations.vehicleTrunk.animDict
                        RequestAnimDict(animDict)
                        while not HasAnimDictLoaded(animDict) do
                            Citizen.Wait(100)
                        end
                        SetProp()
                        ClearPedTasks(ped)
                        TaskPlayAnim(ped, animDict, Animations.vehicleTrunk.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
                        Citizen.Wait(1000)
                        FreezeEntityPosition(ped, false)
                        ClearPedTasks(ped)
                    end,
                    canInteract = function(entity, distance, data)
                        local plaka = GetVehicleNumberPlateText(entity)
                        return (plaka == vehiclePlate and packageInTheTrunk == 1)
                    end,
                }
            },
            distance = 2.5,
        })
    elseif Config.Interaction.type == 'ox_target' then
        exports.ox_target:addGlobalVehicle({
            name = 'deliver_put_package_vehicle',
            label = Lang[Config.Language].TARGET.PUT_PACKAGE_VEHICLE,
            icon = 'fas fa-box',
            distance = 2.5,
            bones = 'boot',
            onSelect = function()
                packageInTheTrunk = 2
                FreezeEntityPosition(ped, true)
                local animDict = Animations.vehicleTrunk.animDict
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(100)
                end
                SetProp()
                ClearPedTasks(ped)
                TaskPlayAnim(ped, animDict, Animations.vehicleTrunk.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
                Citizen.Wait(1000)
                FreezeEntityPosition(ped, false)
                ClearPedTasks(ped)
            end,
            canInteract = function(entity)
                local plaka = GetVehicleNumberPlateText(entity)
                return (plaka == vehiclePlate and packageInTheTrunk == 1)
            end,
        })
    elseif Config.Interaction.type == 'drawtext' then
        Citizen.CreateThread(function()
            while inTheJob and propBool and packageInTheTrunk == 1 do
                local sleep = 1500
                local playerCoords = GetEntityCoords(ped)
                local vehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 3.0, 0, 70)
    
                if vehicle ~= 0 then
                    local plaka = GetVehicleNumberPlateText(vehicle)
    
                    if plaka == vehiclePlate then
                        sleep = 5
                        local boneIndex = GetEntityBoneIndexByName(vehicle, "boot")
                        
                        if boneIndex ~= -1 then
                            local boneCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
        
                            exports['88studio-core']:DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z, Lang[Config.Language].DRAWTEXT.PUT_PACKAGE_VEHICLE)
                            if IsControlJustPressed(0, 38) then
                                packageInTheTrunk = 2
                                FreezeEntityPosition(ped, true)
                                local animDict = Animations.vehicleTrunk.animDict
                                RequestAnimDict(animDict)
                                while not HasAnimDictLoaded(animDict) do
                                    Citizen.Wait(100)
                                end
                                SetProp()
                                ClearPedTasks(ped)
                                TaskPlayAnim(ped, animDict, Animations.vehicleTrunk.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
                                Citizen.Wait(1000)
                                FreezeEntityPosition(ped, false)
                                ClearPedTasks(ped)
                            end
                        end
                    end
                end
                Citizen.Wait(sleep)
            end
        end)
    end
end

--  ██████╗ ███████╗████████╗    ████████╗██╗  ██╗███████╗    ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗    ████████╗██████╗ ██╗   ██╗███╗   ██╗██╗  ██╗
-- ██╔════╝ ██╔════╝╚══██╔══╝    ╚══██╔══╝██║  ██║██╔════╝    ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝    ╚══██╔══╝██╔══██╗██║   ██║████╗  ██║██║ ██╔╝
-- ██║  ███╗█████╗     ██║          ██║   ███████║█████╗      ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗         ██║   ██████╔╝██║   ██║██╔██╗ ██║█████╔╝ 
-- ██║   ██║██╔══╝     ██║          ██║   ██╔══██║██╔══╝      ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝         ██║   ██╔══██╗██║   ██║██║╚██╗██║██╔═██╗ 
-- ╚██████╔╝███████╗   ██║          ██║   ██║  ██║███████╗    ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗       ██║   ██║  ██║╚██████╔╝██║ ╚████║██║  ██╗
--  ╚═════╝ ╚══════╝   ╚═╝          ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝       ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝

GetTheTrunk = function()
    local ped = PlayerPedId()
    SetupGetTarget = true
    if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
        exports[Config.Interaction.type]:AddTargetBone({'boot'}, {
            options = {
                {
                    label = Lang[Config.Language].TARGET.PICK_UP_PACKAGE_VEHICLE,
                    icon = 'fas fa-box',
                    action = function(entity)
                        packageInTheTrunk = 1
                        FreezeEntityPosition(ped, true)
                        local animDict = Animations.vehicleTrunk.animDict
                        RequestAnimDict(animDict)
                        while not HasAnimDictLoaded(animDict) do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(ped, animDict, Animations.vehicleTrunk.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
                        Citizen.Wait(1000)
                        SetProp()
                        ClearPedTasks(ped)
                        FreezeEntityPosition(ped, false)
                    end,
                    canInteract = function(entity, distance, data)
                        local plaka = GetVehicleNumberPlateText(entity)
                        return (plaka == vehiclePlate and packageInTheTrunk == 2)
                    end,
                }
            },
            distance = 2.5,
        })
    elseif Config.Interaction.type == 'ox_target' then
        exports.ox_target:addGlobalVehicle({
                label = Lang[Config.Language].TARGET.PICK_UP_PACKAGE_VEHICLE,
                icon = 'fas fa-box',
                distance = 2.5,
                bones = 'boot',
                onSelect = function()
                    packageInTheTrunk = 1
                    FreezeEntityPosition(ped, true)
                    local animDict = Animations.vehicleTrunk.animDict
                    RequestAnimDict(animDict)
                    while not HasAnimDictLoaded(animDict) do
                        Citizen.Wait(100)
                    end
                    TaskPlayAnim(ped, animDict, Animations.vehicleTrunk.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
                    Citizen.Wait(1000)
                    SetProp()
                    ClearPedTasks(ped)
                    FreezeEntityPosition(ped, false)
                end,
                canInteract = function(entity)
                    local plaka = GetVehicleNumberPlateText(entity)
                    return (plaka == vehiclePlate and packageInTheTrunk == 2)
                end,
            })
    elseif Config.Interaction.type == 'drawtext' then
        Citizen.CreateThread(function()
            while inTheJob and not propBool and packageInTheTrunk == 2 do
                local sleep = 1500
                local playerCoords = GetEntityCoords(ped)
                local vehicle = GetClosestVehicle(playerCoords.x, playerCoords.y, playerCoords.z, 3.0, 0, 70)
    
    
                if vehicle ~= 0 then
                    local plaka = GetVehicleNumberPlateText(vehicle)
    
                    if plaka == vehiclePlate then
                        sleep = 5
                        local boneIndex = GetEntityBoneIndexByName(vehicle, "boot")
                        
                        if boneIndex ~= -1 then
                            local boneCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
        
                            exports['88studio-core']:DrawText3D(boneCoords.x, boneCoords.y, boneCoords.z, Lang[Config.Language].LUA.PICK_UP_PACKAGE_VEHICLE)
                            if IsControlJustPressed(0, 38) then
                                packageInTheTrunk = 1
                                FreezeEntityPosition(ped, true)
                                local animDict = Animations.vehicleTrunk.animDict
                                RequestAnimDict(animDict)
                                while not HasAnimDictLoaded(animDict) do
                                    Citizen.Wait(100)
                                end
                                TaskPlayAnim(ped, animDict, Animations.vehicleTrunk.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
                                Citizen.Wait(1000)
                                SetProp()
                                ClearPedTasks(ped)
                                FreezeEntityPosition(ped, false)
                            end
                        end
                    end
                end
                Citizen.Wait(sleep)
            end
        end)
    end
end

-- ███████╗██╗  ██╗ ██████╗ ██╗    ██╗    ██████╗ ██╗   ██╗████████╗██╗   ██╗    ████████╗██╗███╗   ███╗███████╗
-- ██╔════╝██║  ██║██╔═══██╗██║    ██║    ██╔══██╗██║   ██║╚══██╔══╝╚██╗ ██╔╝    ╚══██╔══╝██║████╗ ████║██╔════╝
-- ███████╗███████║██║   ██║██║ █╗ ██║    ██║  ██║██║   ██║   ██║    ╚████╔╝        ██║   ██║██╔████╔██║█████╗  
-- ╚════██║██╔══██║██║   ██║██║███╗██║    ██║  ██║██║   ██║   ██║     ╚██╔╝         ██║   ██║██║╚██╔╝██║██╔══╝  
-- ███████║██║  ██║╚██████╔╝╚███╔███╔╝    ██████╔╝╚██████╔╝   ██║      ██║          ██║   ██║██║ ╚═╝ ██║███████╗
-- ╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝     ╚═════╝  ╚═════╝    ╚═╝      ╚═╝          ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝

local lastTime = 0
local failJobNumber = 0

ShowDutyTime = function()

    lastTime =  1000 * 60 * Config.MaxTimetoDeliverPackage
    nuiMessage('TOGGLE_PHONE', {
        isOpen = true,
        type = 1,
        userPhone = {
            time = 1000 * 60 * Config.MaxTimetoDeliverPackage,
        }
    })
    while inTheJob do
        Citizen.Wait(1000)
        if not isOpenPhone then
            if not isOpenTimer then
                nuiMessage('TOGGLE_PHONE', {
                    isOpen = true,
                    type = 1,
                    userPhone = {
                        time = lastTime,
                    }
                })

                isOpenTimer = true
            end
        else
            isOpenTimer = false
        end

        if not inTheJob then
            nuiMessage('TOGGLE_PHONE', {
                isOpen = false,
                type = 0,
            })
            break
        end

        lastTime = lastTime - 1000

        if lastTime <= 0 then
            failJobNumber = failJobNumber + 1
            if failJobNumber == Config.MaximumTimeout then
                inTheJob = false
                nuiMessage('TOGGLE_PHONE', {
                    isOpen = false,
                })
                TriggerEvent('88studio-core:sendNotification', Lang[Config.Language].LUA.YOU_SCREWED_UP, 'error', 3000)
                TriggerServerEvent('88studio-delivery:server:createBlips', ReturnVehicleCoords, Config.Blip.failBlip, 'Return Vehicle Back')
                TriggerEvent('88studio-delivery:client:failJob')
            else
                isOpenTimer = false
                TriggerEvent('88studio-delivery:client:newBusinessLocation')
                packageInTheTrunk = 0
            end
        end
    end
end

SetVehicleKM = function()
    local playerPed = PlayerPedId()

    CreateThread(function()
        while not failJob and inTheJob do
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if DoesEntityExist(vehicle) then
                local plate = GetVehicleNumberPlateText(vehicle)

                if plate == vehiclePlate and GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1) then
                    local currentCoords = GetEntityCoords(vehicle)
                    Wait(1000)
                    local updatedCoords = GetEntityCoords(vehicle)

                    local traveled = #(updatedCoords - currentCoords) / 100

                    if traveled > 0 then 
                        oldMialege = oldMialege + traveled
                    end
                end
            end
            Wait(Config.MileageUpdateInterval)
        end
    end)
end

CheckVehicleDistance = function()
    local firstNotification = false
    local secondNotification = false

    CreateThread(function()
        while not failJob and inTheJob  do
            local vehList = GetGamePool('CVehicle')
            for _, vehicle in ipairs(vehList) do
                if GetVehicleNumberPlateText(vehicle) == vehiclePlate then
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local vehCoords = GetEntityCoords(vehicle)
                    local distance = #(playerCoords - vehCoords)
                    if distance > Config.CheckVehicleDist.firstDistance and distance < Config.CheckVehicleDist.secondDistance then
                        if not firstNotification then
                            TriggerEvent('88studio-core:sendNotification', Config.CheckVehicleDist.firstMessage, 'error', 3000)
                            firstNotification = true
                        end
                    elseif distance > Config.CheckVehicleDist.secondDistance then
                        if not secondNotification then
                            inTheJob = false
                            TriggerEvent('88studio-core:sendNotification', Config.CheckVehicleDist.secondMessage, 'error', 3000)
                            TriggerServerEvent('88studio-delivery:server:createBlips', ReturnVehicleCoords, Config.Blip.failBlip, 'Return Vehicle Back')
                            TriggerEvent('88studio-delivery:client:failJob')
                            secondNotification = true
                            break
                        end
                    elseif distance < 10 then
                        firstNotification = false
                    end
                end
            end
            Wait(1500)
        end
    end)
end

-- ███╗   ██╗██╗   ██╗██╗     ██████╗ █████╗ ██╗     ██╗     ██████╗  █████╗  ██████╗██╗  ██╗
-- ████╗  ██║██║   ██║██║    ██╔════╝██╔══██╗██║     ██║     ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝
-- ██╔██╗ ██║██║   ██║██║    ██║     ███████║██║     ██║     ██████╔╝███████║██║     █████╔╝ 
-- ██║╚██╗██║██║   ██║██║    ██║     ██╔══██║██║     ██║     ██╔══██╗██╔══██║██║     ██╔═██╗ 
-- ██║ ╚████║╚██████╔╝██║    ╚██████╗██║  ██║███████╗███████╗██████╔╝██║  ██║╚██████╗██║  ██╗
-- ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝

RegisterNUICallback('close', function(data, cb)
    isOpenMenu = false
    isOpenPhone = false
    SetNuiFocus(false, false)
    cb("ok")
    
    if Config.DutyTablet.type == 'command' or Config.DutyTablet.type == 'item' then
        StopTabletAnim()
    end

    StopPhoneAnim()
end)

RegisterNUICallback('stopDuty', function(data, cb)
    cb("ok")

    inTheJob = false
    TriggerServerEvent('88studio-delivery:server:createBlips', ReturnVehicleCoords, Config.Blip.failBlip, 'Return Vehicle Back')
    ReturnVehicle()
end)

-- ███████╗████████╗ █████╗ ██████╗ ████████╗    ██████╗ ██╗   ██╗████████╗██╗   ██╗
-- ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝    ██╔══██╗██║   ██║╚══██╔══╝╚██╗ ██╔╝
-- ███████╗   ██║   ███████║██████╔╝   ██║       ██║  ██║██║   ██║   ██║    ╚████╔╝ 
-- ╚════██║   ██║   ██╔══██║██╔══██╗   ██║       ██║  ██║██║   ██║   ██║     ╚██╔╝  
-- ███████║   ██║   ██║  ██║██║  ██║   ██║       ██████╔╝╚██████╔╝   ██║      ██║   
-- ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═════╝  ╚═════╝    ╚═╝      ╚═╝   

RegisterNUICallback('startDuty', function(data, cb)
    cb("ok")

    local vehicle = nil

    inTheJob = true
    jobDetails = {
        job_type = data.job,
        vehicle = data.vehicle,
    }

    vehicle = Config.Cars[jobDetails.vehicle].model

    jobDetails['vehicle'] = vehicle

    TriggerServerEvent('88studio-delivery:server:SetStartTime')
    TriggerServerEvent('88studio-delivery:server:giveJobPhone')
    SpawnVehicle(vehicle)
end)

-- ██████╗ ███████╗ ██████╗ ██╗███████╗████████╗███████╗██████╗     ███████╗██╗   ██╗███████╗███╗   ██╗████████╗
-- ██╔══██╗██╔════╝██╔════╝ ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗    ██╔════╝██║   ██║██╔════╝████╗  ██║╚══██╔══╝
-- ██████╔╝█████╗  ██║  ███╗██║███████╗   ██║   █████╗  ██████╔╝    █████╗  ██║   ██║█████╗  ██╔██╗ ██║   ██║   
-- ██╔══██╗██╔══╝  ██║   ██║██║╚════██║   ██║   ██╔══╝  ██╔══██╗    ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   
-- ██║  ██║███████╗╚██████╔╝██║███████║   ██║   ███████╗██║  ██║    ███████╗ ╚████╔╝ ███████╗██║ ╚████║   ██║   
-- ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝   

--  ██████╗ ██████╗ ███████╗███╗   ██╗    ████████╗ █████╗ ██████╗ ██╗     ███████╗████████╗
-- ██╔═══██╗██╔══██╗██╔════╝████╗  ██║    ╚══██╔══╝██╔══██╗██╔══██╗██║     ██╔════╝╚══██╔══╝
-- ██║   ██║██████╔╝█████╗  ██╔██╗ ██║       ██║   ███████║██████╔╝██║     █████╗     ██║   
-- ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║       ██║   ██╔══██║██╔══██╗██║     ██╔══╝     ██║   
-- ╚██████╔╝██║     ███████╗██║ ╚████║       ██║   ██║  ██║██████╔╝███████╗███████╗   ██║   
--  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝       ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝   ╚═╝   

RegisterNetEvent('88studio-delivery:client:openTablet', function()
    PlayerData = Framework.Functions.GetPlayerData()
    
    if isOpenMenu or inTheJob then
        return
    end

    if Config.CheckStatus.OpenTablet.enable then
        if Config.CheckStatus.OpenTablet.inTheVehicle then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                return
            end
        end

        if Config.CheckStatus.OpenTablet.notDead then
            if PlayerData.metadata['inlaststand'] or PlayerData.metadata['isdead'] then
                return
            end
        end

        if Config.CheckStatus.OpenTablet.notHandcuffed then
            if PlayerData.metadata['ishandcuffed'] then
                return
            end
        end

        if Config.CheckStatus.OpenTablet.noWeapon then
            if GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey("WEAPON_UNARMED") then
                return
            end
        end
    end

    if Config.DutyTablet.type == 'command' or Config.DutyTablet.type == 'item' then
        StartTabletAnim()
    end

    Framework.Functions.TriggerCallback('88studio-delivery:server:userDetail', function(data)
        SetNuiFocus(true, true)

        if firstOpen then
            FirstOpen()
            firstOpen = false
        end 

        if Config.ProfileImage == 'game' then
            if GetResourceState('MugShotBase64') == 'started' then
                data.courierImage = exports["MugShotBase64"]:GetMugShotBase64(PlayerPedId(), false)
            else
                data.courierImage = false
            end
        end

        nuiMessage('TOGGLE_TABLET', {
            isOpen = true,
            userDetail = data,
        })
    end, false)
    isOpenMenu = true
end)

--  ██████╗ ██████╗ ███████╗███╗   ██╗    ██████╗ ██╗  ██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔═══██╗██╔══██╗██╔════╝████╗  ██║    ██╔══██╗██║  ██║██╔═══██╗████╗  ██║██╔════╝
-- ██║   ██║██████╔╝█████╗  ██╔██╗ ██║    ██████╔╝███████║██║   ██║██╔██╗ ██║█████╗  
-- ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║    ██╔═══╝ ██╔══██║██║   ██║██║╚██╗██║██╔══╝  
-- ╚██████╔╝██║     ███████╗██║ ╚████║    ██║     ██║  ██║╚██████╔╝██║ ╚████║███████╗
--  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

RegisterNetEvent('88studio-delivery:client:openPhone', function()
    if not inTheJob or failJob then
        return
    end

    SetNuiFocus(true, true)

    StartPhoneAnim()


    Framework.Functions.TriggerCallback('88studio-delivery:server:userDetail', function(data)
        SetNuiFocus(true, true)

        if firstOpen then
            FirstOpen()
            firstOpen = false
        end 

        if Config.ProfileImage == 'game' then
            if GetResourceState('MugShotBase64') == 'started' then
                data.courierImage = exports["MugShotBase64"]:GetMugShotBase64(PlayerPedId(), false)
            else
                data.courierImage = false
            end
        end

        data.time = lastTime
        data.package = packageInTheTrunk

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if playerPed and playerPed > 0 then
            local streetName, crossingRoad = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
            data.courierStreet = GetStreetNameFromHashKey(streetName)
        end
        
        if cc then
            local secondStreetName, secondCrossingRoad = GetStreetNameAtCoord(cc.x, cc.y, cc.z)
            data.customerStreet = GetStreetNameFromHashKey(secondStreetName)

            local distanceInMeters = #(vector3(playerCoords.x, playerCoords.y, playerCoords.z) - vector3(cc.x, cc.y, cc.z))
            data.customerDistance = string.format("%.2f", distanceInMeters / 1000)
        else
            data.customerStreet = false
        end
    
        nuiMessage('TOGGLE_PHONE', {
            isOpen = true,
            type = 2,
            userPhone = data,
        })
    end, true)

    isOpenPhone = true
end)


RegisterNetEvent('88studio-delivery:client:stopDuty', function()

end)

-- ███╗   ██╗███████╗██╗    ██╗    ██████╗ ██╗   ██╗███████╗██╗███╗   ██╗███████╗███████╗███████╗    ██╗      ██████╗  ██████╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
-- ████╗  ██║██╔════╝██║    ██║    ██╔══██╗██║   ██║██╔════╝██║████╗  ██║██╔════╝██╔════╝██╔════╝    ██║     ██╔═══██╗██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ██╔██╗ ██║█████╗  ██║ █╗ ██║    ██████╔╝██║   ██║███████╗██║██╔██╗ ██║█████╗  ███████╗███████╗    ██║     ██║   ██║██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
-- ██║╚██╗██║██╔══╝  ██║███╗██║    ██╔══██╗██║   ██║╚════██║██║██║╚██╗██║██╔══╝  ╚════██║╚════██║    ██║     ██║   ██║██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
-- ██║ ╚████║███████╗╚███╔███╔╝    ██████╔╝╚██████╔╝███████║██║██║ ╚████║███████╗███████║███████║    ███████╗╚██████╔╝╚██████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝     ╚═════╝  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

RegisterNetEvent('88studio-delivery:client:newBusinessLocation', function()
    local businessCoords = GetRandomWorkplaceCoordinates()

    TriggerEvent('88studio-core:sendNotification', Lang[Config.Language].LUA.GO_TO_MISSION_BUSINESS, 'success', 3000)
    TriggerServerEvent('88studio-delivery:server:createBlips', businessCoords.coords, Config.Blip.businessBlip, '88 Business')
    CreatePedForBusiness(businessCoords.coords, businessCoords.ped)
end)

-- ██████╗ ███████╗ ██████╗███████╗██╗██╗   ██╗███████╗    ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗
-- ██╔══██╗██╔════╝██╔════╝██╔════╝██║██║   ██║██╔════╝    ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝
-- ██████╔╝█████╗  ██║     █████╗  ██║██║   ██║█████╗      ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  
-- ██╔══██╗██╔══╝  ██║     ██╔══╝  ██║╚██╗ ██╔╝██╔══╝      ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  
-- ██║  ██║███████╗╚██████╗███████╗██║ ╚████╔╝ ███████╗    ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗
-- ╚═╝  ╚═╝╚══════╝ ╚═════╝╚══════╝╚═╝  ╚═══╝  ╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

RegisterNetEvent('88studio-delivery:client:receivePackage', function()
    local playerPed = PlayerPedId()
    SetProp()

    if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
        exports[Config.Interaction.type]:RemoveTargetEntity(BusinessPed)
    elseif Config.Interaction.type == 'ox_target' then
        exports[Config.Interaction.type]:removeLocalEntity(BusinessPed)
    end

    local customers = GetRandomCustomerCoordinates()

    TriggerServerEvent('88studio-delivery:server:createBlips', customers.coords, Config.Blip.customerBlip, '88 Customer')

    cc = customers.coords
    CreateCustomerHome(customers.coords, customers.animCoord)
end)

--  ██████╗██████╗ ███████╗ █████╗ ████████╗███████╗    ███╗   ███╗██╗███████╗███████╗██╗ ██████╗ ███╗   ██╗    ██████╗ ██╗     ██╗██████╗ 
-- ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ████╗ ████║██║██╔════╝██╔════╝██║██╔═══██╗████╗  ██║    ██╔══██╗██║     ██║██╔══██╗
-- ██║     ██████╔╝█████╗  ███████║   ██║   █████╗      ██╔████╔██║██║███████╗███████╗██║██║   ██║██╔██╗ ██║    ██████╔╝██║     ██║██████╔╝
-- ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██╔══╝      ██║╚██╔╝██║██║╚════██║╚════██║██║██║   ██║██║╚██╗██║    ██╔══██╗██║     ██║██╔═══╝ 
-- ╚██████╗██║  ██║███████╗██║  ██║   ██║   ███████╗    ██║ ╚═╝ ██║██║███████║███████║██║╚██████╔╝██║ ╚████║    ██████╔╝███████╗██║██║     
--  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝ ╚══════╝╚═╝╚═╝     
RegisterNetEvent('88studio-delivery:client:createBlips', function(coords, blip, name)
    if DoesBlipExist(MissionBlip) then
        RemoveBlip(MissionBlip)
    end
    
    MissionBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    
    SetBlipSprite(MissionBlip, blip.sprite)
    SetBlipColour(MissionBlip, blip.color)
    SetBlipRoute(MissionBlip, blip.route)
    SetBlipRouteColour(MissionBlip, blip.color)
    
    SetBlipDisplay(MissionBlip, 4)
    SetBlipScale(MissionBlip, blip.scale)
    SetBlipAsShortRange(MissionBlip, false)
    SetBlipHighDetail(MissionBlip, true)
    
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(MissionBlip)
end)

-- ███████╗ █████╗ ██╗██╗              ██╗ ██████╗ ██████╗ 
-- ██╔════╝██╔══██╗██║██║              ██║██╔═══██╗██╔══██╗
-- █████╗  ███████║██║██║              ██║██║   ██║██████╔╝
-- ██╔══╝  ██╔══██║██║██║         ██   ██║██║   ██║██╔══██╗
-- ██║     ██║  ██║██║███████╗    ╚█████╔╝╚██████╔╝██████╔╝
-- ╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝     ╚════╝  ╚═════╝ ╚═════╝ 
                                                        

RegisterNetEvent('88studio-delivery:client:failJob', function()
    local playerPed = PlayerPedId()
    ReturnVehicle()
end)

-- ██████╗ ███████╗██╗     ███████╗████████╗███████╗    ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗
-- ██╔══██╗██╔════╝██║     ██╔════╝╚══██╔══╝██╔════╝    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝
-- ██║  ██║█████╗  ██║     █████╗     ██║   █████╗      ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  
-- ██║  ██║██╔══╝  ██║     ██╔══╝     ██║   ██╔══╝      ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  
-- ██████╔╝███████╗███████╗███████╗   ██║   ███████╗     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗
-- ╚═════╝ ╚══════╝╚══════╝╚══════╝   ╚═╝   ╚══════╝      ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝

RegisterNetEvent('88studio-delivery:client:deleteVehicle', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if (vehicle and vehicle ~= 0 and vehicle ~= 0 and GetVehicleNumberPlateText(vehicle) == vehiclePlate) then
        DeleteEntity(vehicle)
    end
end)

-- ███████╗ █████╗ ██╗   ██╗███████╗         ██╗ ██████╗ ██████╗ 
-- ██╔════╝██╔══██╗██║   ██║██╔════╝         ██║██╔═══██╗██╔══██╗
-- ███████╗███████║██║   ██║█████╗           ██║██║   ██║██████╔╝
-- ╚════██║██╔══██║╚██╗ ██╔╝██╔══╝      ██   ██║██║   ██║██╔══██╗
-- ███████║██║  ██║ ╚████╔╝ ███████╗    ╚█████╔╝╚██████╔╝██████╔╝
-- ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝     ╚════╝  ╚═════╝ ╚═════╝ 

RegisterNetEvent('88studio-delivery:client:saveJob', function()
    if DoesBlipExist(MissionBlip) then
        RemoveBlip(MissionBlip)
    end

    if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
        exports[Config.Interaction.type]:RemoveZone("return-car")
    elseif Config.Interaction.type == 'ox_target' then
        exports.ox_target:removeZone(ox_target.return_vehicle)
    end

    TriggerServerEvent('88studio-delivery:server:saveJob', {
        xp = earnedXP,
        money = earnedMoney,
        delivered = deliveredPackage,
        mileage = oldMialege,
    })
end)

-- ██████╗ ███████╗██╗     ██╗██╗   ██╗███████╗██████╗     ██████╗  █████╗  ██████╗██╗  ██╗ █████╗  ██████╗ ███████╗
-- ██╔══██╗██╔════╝██║     ██║██║   ██║██╔════╝██╔══██╗    ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔══██╗██╔════╝ ██╔════╝
-- ██║  ██║█████╗  ██║     ██║██║   ██║█████╗  ██████╔╝    ██████╔╝███████║██║     █████╔╝ ███████║██║  ███╗█████╗  
-- ██║  ██║██╔══╝  ██║     ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗    ██╔═══╝ ██╔══██║██║     ██╔═██╗ ██╔══██║██║   ██║██╔══╝  
-- ██████╔╝███████╗███████╗██║ ╚████╔╝ ███████╗██║  ██║    ██║     ██║  ██║╚██████╗██║  ██╗██║  ██║╚██████╔╝███████╗
-- ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
                                                                                                                 
RegisterNetEvent('88studio-delivery:client:deliverPackage', function(c, ac)
    local coords = c
    local animCoords = ac
    local ped = PlayerPedId()
    isDoorOpen = true
    
    SetPlayerControl(PlayerId(), false, 0)
    
    ClearPedTasksImmediately(ped)

    local model = 'a_f_m_bevhills_02'

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    CustomerPed = CreatePed(0, model, vector3(coords.x, coords.y, coords.z-1.0), coords.w, false, false)
    local CustomerPedCoords = GetOffsetFromEntityInWorldCoords(ped, 1.0, -2.0, 1.0)
    SetEntityAlpha(CustomerPed, 0.0, false)
    FreezeEntityPosition(CustomerPed, true)
    SetEntityInvincible(CustomerPed, true)
    SetBlockingOfNonTemporaryEvents(CustomerPed, true)

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, CustomerPedCoords.x, CustomerPedCoords.y, CustomerPedCoords.z)
    PointCamAtEntity(cam, CustomerPed, 0.0, 0.0, 0.0, true)
    -- SetCamRot(cam, -10.0, 0.0, animCoords.w - 2)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, false)
    
    RequestAnimDict(Animations.RingBell.animDict)
    while not HasAnimDictLoaded(Animations.RingBell.animDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(ped, Animations.RingBell.animDict, Animations.RingBell.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
    Citizen.Wait(2000)
    
    ClearPedTasks(ped)
    
    TaskGoStraightToCoord(ped, animCoords.x, animCoords.y, animCoords.z, 1.0, -1, animCoords.w, 0.0)
    
    while not IsEntityAtCoord(ped, animCoords.x, animCoords.y, animCoords.z, 1.0, 1.0, 1.0, false, true, 0) do
        Citizen.Wait(0)
    end
    
    Citizen.Wait(5000)

    SetEntityAlpha(CustomerPed, 255, false)

    Citizen.Wait(3000)
    
    RequestAnimDict(Animations.givePackage.animDict)
    while not HasAnimDictLoaded(Animations.givePackage.animDict) do
        Citizen.Wait(0)
    end

    
    Citizen.Wait(1000)
    
    SetProp()
    ClearPedTasks(ped)
    TaskPlayAnim(ped, Animations.givePackage.animDict, Animations.givePackage.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
    TaskPlayAnim(CustomerPed, Animations.givePackage.animDict, Animations.givePackage.animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)

    Citizen.Wait(2000)
    
    packageInTheTrunk = 0

    local model = Objects[jobDetails.job_type].object
    InstallPropModel(model)
    local modelHash = GetHashKey(model)
    prop = CreateObject(modelHash, Objects[jobDetails.job_type].spawnX, Objects[jobDetails.job_type].spawnY, Objects[jobDetails.job_type].spawnZ, Objects[jobDetails.job_type].isNetwork, Objects[jobDetails.job_type].netMissionEntity, Objects[jobDetails.job_type].doorFlag)

    AttachEntityToEntity(prop, CustomerPed, GetPedBoneIndex(CustomerPed, Objects[jobDetails.job_type].boneIndex), Objects[jobDetails.job_type].xPos, Objects[jobDetails.job_type].yPos, Objects[jobDetails.job_type].zPos, Objects[jobDetails.job_type].xRot, Objects[jobDetails.job_type].yRot, Objects[jobDetails.job_type].zRot, true, true, false, true, 1, true)
    RequestAnimDict(Objects[jobDetails.job_type].animDict)
    TaskPlayAnim(CustomerPed, Objects[jobDetails.job_type].animDict, Objects[jobDetails.job_type].animName, 5.0, 5.0, -1, 51, 0, 0, 0, 0)
    SetModelAsNoLongerNeeded(modelHash)

    ClearPedTasks(CustomerPed)
    ClearPedTasks(ped)
    Citizen.Wait(2000)

    DeleteEntity(CustomerPed)
    DeleteEntity(prop)
    SetPlayerControl(PlayerId(), true, 0)
    RenderScriptCams(false, false, 0, true, false)
    DestroyCam(cam, false)
    

    local LocalXP = 0
    local LocalMoney = 0

    if Config.Stage[jobDetails.job_type].earnedXP.type == 'stable' then
        LocalXP = Config.Stage[jobDetails.job_type].earnedXP.stable
        earnedXP = earnedXP + LocalXP
    elseif Config.Stage[jobDetails.job_type].earnedXP.type == 'random' then
        LocalXP = math.random(Config.Stage[jobDetails.job_type].earnedXP.random.min, Config.Stage[jobDetails.job_type].earnedXP.random.max)
        earnedXP = earnedXP + LocalXP
    end

    if Config.Stage[jobDetails.job_type].packageFee.type == 'stable' then
        LocalMoney = Config.Stage[jobDetails.job_type].packageFee.stable
        earnedMoney = earnedMoney + LocalMoney
    elseif Config.Stage[jobDetails.job_type].packageFee.type == 'random' then
        LocalMoney = math.random(Config.Stage[jobDetails.job_type].packageFee.random.min, Config.Stage[jobDetails.job_type].packageFee.random.max)
        earnedMoney = earnedMoney + LocalMoney
    end

    TriggerEvent('88studio-core:sendNotification', string.format(Lang[Config.Language].LUA.DELIVERED_PACKAGE, LocalMoney, LocalXP), 'success', 3000)

    lastTime =  1000 * 60 * Config.MaxTimetoDeliverPackage
    nuiMessage('TOGGLE_PHONE', {
        isOpen = true,
        type = 1,
        userPhone = {
            time = 1000 * 60 * Config.MaxTimetoDeliverPackage,
        }
    })

    deliveredPackage = deliveredPackage + 1

    TriggerServerEvent('88studio-delivery:server:checkHack', {xp = LocalXP, money = LocalMoney})
    TriggerEvent('88studio-delivery:client:newBusinessLocation')
end)