
-- ███╗   ██╗██╗   ██╗██╗    ███╗   ███╗███████╗███████╗███████╗ █████╗  ██████╗ ███████╗
-- ████╗  ██║██║   ██║██║    ████╗ ████║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝ ██╔════╝
-- ██╔██╗ ██║██║   ██║██║    ██╔████╔██║█████╗  ███████╗███████╗███████║██║  ███╗█████╗  
-- ██║╚██╗██║██║   ██║██║    ██║╚██╔╝██║██╔══╝  ╚════██║╚════██║██╔══██║██║   ██║██╔══╝  
-- ██║ ╚████║╚██████╔╝██║    ██║ ╚═╝ ██║███████╗███████║███████║██║  ██║╚██████╔╝███████╗
-- ╚═╝  ╚═══╝ ╚═════╝ ╚═╝    ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

nuiMessage = function(action, payload)
    SendNUIMessage({
        action = action,
        payload = payload
    })
end

--  ██████╗██████╗ ███████╗ █████╗ ████████╗███████╗    ███████╗███╗   ██╗████████╗██╗████████╗██╗   ██╗
-- ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝████╗  ██║╚══██╔══╝██║╚══██╔══╝╚██╗ ██╔╝
-- ██║     ██████╔╝█████╗  ███████║   ██║   █████╗      █████╗  ██╔██╗ ██║   ██║   ██║   ██║    ╚████╔╝ 
-- ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██╔══╝      ██╔══╝  ██║╚██╗██║   ██║   ██║   ██║     ╚██╔╝  
-- ╚██████╗██║  ██║███████╗██║  ██║   ██║   ███████╗    ███████╗██║ ╚████║   ██║   ██║   ██║      ██║   
--  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝   ╚═╝      ╚═╝   

CreateEntity = function()
    if Config.DutyTablet.type == 'interaction' then
        local model = Config.DutyTablet.interaction.model
        
        RequestModel(model)
        while not HasModelLoaded(model) do
          Wait(0)
        end
        bossPed = CreatePed(0, model, vector3(Config.DutyTablet.interaction.coords.x, Config.DutyTablet.interaction.coords.y, Config.DutyTablet.interaction.coords.z-1.0), Config.DutyTablet.interaction.coords.w, false, false)
        FreezeEntityPosition(bossPed, true)
        SetEntityInvincible(bossPed, true)
        SetBlockingOfNonTemporaryEvents(bossPed, true)
    end
end

-- ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗    ███████╗████████╗ █████╗ ██████╗ ████████╗███╗   ██╗ ██████╗     ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗
-- ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝    ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝████╗  ██║██╔════╝     ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
-- ███████╗██║     ██████╔╝██║██████╔╝   ██║       ███████╗   ██║   ███████║██████╔╝   ██║   ██╔██╗ ██║██║  ███╗    █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║
-- ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║       ╚════██║   ██║   ██╔══██║██╔══██╗   ██║   ██║╚██╗██║██║   ██║    ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║
-- ███████║╚██████╗██║  ██║██║██║        ██║       ███████║   ██║   ██║  ██║██║  ██║   ██║   ██║ ╚████║╚██████╔╝    ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
-- ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝       ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═══╝ ╚═════╝     ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

ScriptStarting = function()
    if Config.DutyTablet.type == 'interaction' then
        if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
            exports[Config.Interaction.type]:AddTargetEntity(bossPed, {
                options = {
                    {
                        icon = 'fas fa-hands',
                        label = Lang[Config.Language].TARGET.OPEN_PANEL,
                        action = function(entity)
                            if IsPedAPlayer(entity) then return false end
                            TriggerEvent('88studio-delivery:client:openTablet')
                        end,
                        canInteract = function(entity, distance, data)
                            if IsPedAPlayer(entity) then return false end
                            return true
                        end,
                    }
                },
                distance = 2.5,
            })
        elseif Config.Interaction.type == 'ox_target' then
            exports['ox_target']:addLocalEntity(bossPed, {
                icon = 'fas fa-hands',
                label = Lang[Config.Language].TARGET.OPEN_PANEL,
                onSelect = function(entity)
                    TriggerEvent('88studio-delivery:client:openTablet')
                end,
                canInteract = function(entity, distance, coords)
                    if IsPedAPlayer(entity) then return false end
                    return true
                end,
                distance = 2.5,
            })
        elseif Config.Interaction.type == 'drawtext' then
            Citizen.CreateThread(function()
                local ped = PlayerPedId()

                while true do 
                    local sleep = 1000
                    local coords = GetEntityCoords(ped)
                    local distance = #(coords - vector3(Config.DutyTablet.interaction.coords.x, Config.DutyTablet.interaction.coords.y, Config.DutyTablet.interaction.coords.z))

                    if distance < Config.Interaction.text.distance and not isOpenMenu then
                        sleep = 5, 
                        exports['88studio-core']:DrawText3D(Config.DutyTablet.interaction.coords.x, Config.DutyTablet.interaction.coords.y, Config.DutyTablet.interaction.coords.z, Lang[Config.Language].DRAWTEXT.OPEN_PANEL)
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent('88studio-delivery:client:openTablet')
                        end
                    end

                    Citizen.Wait(sleep)
                end
            end)
        end
    elseif Config.DutyTablet.type == 'item' then
        TriggerServerEvent('88studio-delivery:server:registerItem')
    elseif Config.DutyTablet.type == 'command' then
        RegisterCommand(Config.DutyTablet.command.name, function()
            TriggerEvent('88studio-delivery:client:openTablet')
        end, false)

        TriggerEvent('chat:addSuggestions', {
            {
                name=Config.DutyTablet.command.name,
                help=Config.DutyTablet.command.description,
                params={}
            },
        })
    end

    SecondSettings()
end

-- ███████╗███████╗ ██████╗ ██████╗ ███╗   ██╗██████╗     ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ██╔════╝██╔════╝██╔════╝██╔═══██╗████╗  ██║██╔══██╗    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ███████╗█████╗  ██║     ██║   ██║██╔██╗ ██║██║  ██║    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ╚════██║██╔══╝  ██║     ██║   ██║██║╚██╗██║██║  ██║    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ███████║███████╗╚██████╗╚██████╔╝██║ ╚████║██████╔╝    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
-- ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝     ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

SecondSettings = function()
    if Config.DutyPhone.type == 'command' or Config.DutyPhone.type == 'key' then
        RegisterCommand(Config.DutyPhone.command.name, function()
            TriggerEvent('88studio-delivery:client:openPhone')
        end, false)

        TriggerEvent('chat:addSuggestions', {
            {
                name=Config.DutyPhone.command.name,
                help=Config.DutyPhone.command.description,
                params={}
            },
        })
    end

    if Config.DutyPhone.type == 'key' then
        RegisterKeyMapping(Config.DutyPhone.command.name, Config.DutyPhone.command.description, 'keyboard', Config.DutyPhone.key.name)
    end

    if Config.DutyPhone.type == 'item' then
        TriggerServerEvent('88studio-delivery:server:registerItem')
    end
end

-- ███████╗██████╗  █████╗ ██╗    ██╗███╗   ██╗    ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗
-- ██╔════╝██╔══██╗██╔══██╗██║    ██║████╗  ██║    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝
-- ███████╗██████╔╝███████║██║ █╗ ██║██╔██╗ ██║    ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  
-- ╚════██║██╔═══╝ ██╔══██║██║███╗██║██║╚██╗██║    ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  
-- ███████║██║     ██║  ██║╚███╔███╔╝██║ ╚████║     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗
-- ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═══╝      ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝

SpawnVehicle = function(vehicle)
    local coords = GetFreeParkingSpots()
    Framework.Game.SpawnVehicle(vehicle, vector3(coords.x, coords.y, coords.z), coords.w, function(vehicle)
        SetVehicleOnGroundProperly(veh)
        SetVehicleNumberPlateText(veh, '88STUDIO')
        SetVehicleColours(veh, 0, 0)
        SetVehicleExtraColours(veh, 0, 0)
        SetVehicleDirtLevel(veh, 0)
        vehiclePlate = GetVehicleNumberPlateText(veh)
        VehicleKeys(vehiclePlate)
        if Config.DutyTablet.type == 'item' or Config.DutyTablet.type == 'command' then
            SetVehicleEngineOn(veh, false, true)
            CheckTaskTrolleyToRemoveBlip(vehiclePlate)
            TriggerEvent('88studio-core:sendNotification', Lang[Config.Language].LUA.GO_TO_MISSION_CAR, 'success', 3000)
        else
            SetVehicleEngineOn(veh, true, true)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent('88studio-delivery:client:newBusiness')
            CheckDifferentVehicle(vehiclePlate)
            ShowDutyTime()
            SetVehicleKM()
            CheckVehicleDistance()
        end
        exports['88studio-core']:SetFuel(veh, 100.0)
    end)

    if Config.DutyTablet.type == 'item' or Config.DutyTablet.type == 'command' then
        TriggerServerEvent('88studio-delivery:server:createBlips', coords, Config.Blip.carBlip, Lang[Config.Language].LUA.MISSION_CAR)
    end
end

--  ██████╗██████╗ ███████╗ █████╗ ████████╗███████╗    ██████╗ ██╗   ██╗███████╗██╗███╗   ██╗███████╗███████╗███████╗    ██████╗ ███████╗██████╗ 
-- ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ██╔══██╗██║   ██║██╔════╝██║████╗  ██║██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔════╝██╔══██╗
-- ██║     ██████╔╝█████╗  ███████║   ██║   █████╗      ██████╔╝██║   ██║███████╗██║██╔██╗ ██║█████╗  ███████╗███████╗    ██████╔╝█████╗  ██║  ██║
-- ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██╔══╝      ██╔══██╗██║   ██║╚════██║██║██║╚██╗██║██╔══╝  ╚════██║╚════██║    ██╔═══╝ ██╔══╝  ██║  ██║
-- ╚██████╗██║  ██║███████╗██║  ██║   ██║   ███████╗    ██████╔╝╚██████╔╝███████║██║██║ ╚████║███████╗███████║███████║    ██║     ███████╗██████╔╝
--  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝    ╚═════╝  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝    ╚═╝     ╚══════╝╚═════╝ 

CreatePedForBusiness = function(coords, ped)
    if BusinessPed then
        DeleteEntity(BusinessPed)
    end

    local model = ped

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    BusinessPed = CreatePed(0, model, vector3(coords.x, coords.y, coords.z-1.0), coords.w, false, false)
    FreezeEntityPosition(BusinessPed, true)
    SetEntityInvincible(BusinessPed, true)
    SetBlockingOfNonTemporaryEvents(BusinessPed, true)

    if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
        exports[Config.Interaction.type]:AddTargetEntity(BusinessPed, {
            options = {
                {
                    icon = 'fas fa-hand-holding-hand',
                    label = Lang[Config.Language].TARGET.PICK_UP_ORDER,
                    action = function(entity)
                        if IsPedAPlayer(entity) then return false end
                        TriggerEvent('88studio-delivery:client:receivePackage')
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        return true
                    end,
                }
            },
            distance = 2.5,
        })
    elseif Config.Interaction.type == 'ox_target' then
        exports['ox_target']:addLocalEntity(BusinessPed, {
            icon = 'fas fa-hand-holding-hand',
            label = Lang[Config.Language].TARGET.PICK_UP_ORDER,
            onSelect = function()
                TriggerEvent('88studio-delivery:client:receivePackage')
            end,
            canInteract = function(entity, distance, coords)
                if IsPedAPlayer(entity) then return false end
                return true
            end,
            distance = 2.5,
        })
    elseif Config.Interaction.type == 'drawtext' then
        Citizen.CreateThread(function()
            local ped = PlayerPedId()

            while true do 
                local sleep = 1000
                local pedCoords = GetEntityCoords(ped)
                local distance = #(pedCoords - vector3(coords.x, coords.y, coords.z))

                if distance < 2.5 then
                    sleep = 5
                    exports['88studio-core']:DrawText3D(coords.x, coords.y, coords.z, Lang[Config.Language].DRAWTEXT.PICK_UP_ORDER)
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('88studio-delivery:client:receivePackage')
                        Citizen.Wait(7000)
                        DeleteEntity(BusinessPed)
                        break
                    end
                end

                Citizen.Wait(sleep)
            end
        end)
    end
end

--  ██████╗██████╗ ███████╗ █████╗ ████████╗███████╗     ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗███████╗██████╗     ██╗  ██╗ ██████╗ ███╗   ███╗███████╗
-- ██╔════╝██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝    ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║██╔════╝██╔══██╗    ██║  ██║██╔═══██╗████╗ ████║██╔════╝
-- ██║     ██████╔╝█████╗  ███████║   ██║   █████╗      ██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║█████╗  ██████╔╝    ███████║██║   ██║██╔████╔██║█████╗  
-- ██║     ██╔══██╗██╔══╝  ██╔══██║   ██║   ██╔══╝      ██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗    ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝  
-- ╚██████╗██║  ██║███████╗██║  ██║   ██║   ███████╗    ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║███████╗██║  ██║    ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗
--  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝     ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

CreateCustomerHome = function(coords, animCoords)
    if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
        exports['qb-target']:AddBoxZone("customer_home", vector3(coords.x, coords.y, coords.z), 1.5, 1.6, {
            name = "customer_home",
            heading = 12.0,
            debugPoly = false,
            minZ = coords.z-1.0,
            maxZ = coords.z+1.0,
            }, {
            options = {
                {
                    icon = 'fas fa-hand-holding-hand',
                    label = Lang[Config.Language].TARGET.RING_THE_BELL,
                    action = function(entity)
                        if packageInTheTrunk == 1 then
                            TriggerEvent('88studio-delivery:client:deliverPackage', coords, animCoords)
                        else
                            TriggerEvent('88studio-core:sendNotification', Lang[Config.Language].LUA.SOMETHING_MISSING, 'error', 3000)
                        end
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then return false end
                        return true
                    end,
                }
            },
            distance = 2.5,
        })
    elseif Config.Interaction.type == 'ox_target' then
        exports.ox_target:addBoxZone({
            coords = vector3(coords.x, coords.y, coords.z),
            options = {
                icon = 'fas fa-hand-holding-hand',
                label = Lang[Config.Language].TARGET.RING_THE_BELL,
                distance = 2.5,
                onSelect = function()
                    if packageInTheTrunk == 1 then
                        TriggerEvent('88studio-delivery:client:deliverPackage', coords, animCoords)
                    else
                        TriggerEvent('88studio-core:sendNotification', Lang[Config.Language].LUA.SOMETHING_MISSING, 'error', 3000)
                    end
                end,
                canInteract = function(entity, distance, data)
                    if IsPedAPlayer(entity) then return false end
                    return true
                end,
            }
        })
    elseif Config.Interaction.type == 'drawtext' then
        Citizen.CreateThread(function()
            local ped = PlayerPedId()

            while true do 
                local sleep = 1000
                local pedCoords = GetEntityCoords(ped)
                local distance = #(pedCoords - vector3(coords.x, coords.y, coords.z))

                if distance < 2.5 then
                    sleep = 5
                    if not isDoorOpen then
                        exports['88studio-core']:DrawText3D(coords.x, coords.y, coords.z, Lang[Config.Language].DRAWTEXT.RING_THE_BELL)
                    end
                    if IsControlJustPressed(0, 38) then
                        if packageInTheTrunk == 1 then
                            TriggerEvent('88studio-delivery:client:deliverPackage', coords, animCoords)
                        else
                            TriggerEvent('88studio-core:sendNotification', Lang[Config.Language].LUA.SOMETHING_MISSING, 'error', 3000)
                        end
                        break
                    end
                end

                Citizen.Wait(sleep)
            end
        end)
    end
end

-- ██████╗ ███████╗████████╗██╗   ██╗██████╗ ███╗   ██╗    ██╗   ██╗███████╗██╗  ██╗██╗ ██████╗██╗     ███████╗
-- ██╔══██╗██╔════╝╚══██╔══╝██║   ██║██╔══██╗████╗  ██║    ██║   ██║██╔════╝██║  ██║██║██╔════╝██║     ██╔════╝
-- ██████╔╝█████╗     ██║   ██║   ██║██████╔╝██╔██╗ ██║    ██║   ██║█████╗  ███████║██║██║     ██║     █████╗  
-- ██╔══██╗██╔══╝     ██║   ██║   ██║██╔══██╗██║╚██╗██║    ╚██╗ ██╔╝██╔══╝  ██╔══██║██║██║     ██║     ██╔══╝  
-- ██║  ██║███████╗   ██║   ╚██████╔╝██║  ██║██║ ╚████║     ╚████╔╝ ███████╗██║  ██║██║╚██████╗███████╗███████╗
-- ╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝      ╚═══╝  ╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝╚══════╝

ReturnVehicle = function()
    if Config.Interaction.type == 'qb-target' or Config.Interaction.type == 'qtarget' then
        exports[Config.Interaction.type]:AddBoxZone("return-car", vector3(ReturnVehicleCoords.x, ReturnVehicleCoords.y, ReturnVehicleCoords.z), 1.5, 1.6, {
            name = "return-car",
            heading = 12.0,
            debugPoly = false,
            minZ = ReturnVehicleCoords.z-1.0,
            maxZ = ReturnVehicleCoords.z+1.0,
        }, {
            options = {
                {
                    icon = 'fas fa-car',
                    label = Lang[Config.Language].TARGET.RETURN_VEHICLE,
                    action = function()
                        TriggerEvent('88studio-delivery:client:deleteVehicle')
                        TriggerEvent('88studio-delivery:client:saveJob')
                    end,
                    canInteract = function(entity, distance, data)
                        if IsPedAPlayer(entity) then 
                            return false 
                        end

                        local vehicle = GetVehiclePedIsIn(playerPed, false)

                        if vehicle and vehicle ~= 0 then
                            local plate = GetVehicleNumberPlateText(vehicle)
                            if plate == vehiclePlate then
                                return true
                            end
                        else
                            return false
                        end
                    end,
                }
            },
            distance = 2.5,
        })
    elseif Config.Interaction.type == 'ox_target' then
        exports.ox_target:addBoxZone({
            coords = ReturnVehicleCoords,
            options = {
                icon = 'fas fa-car',
                label = Lang[Config.Language].TARGET.RETURN_VEHICLE,
                distance = 2.5,
                onSelect = function()
                    TriggerEvent('88studio-delivery:client:deleteVehicle')
                    TriggerEvent('88studio-delivery:client:saveJob')
                end,
                canInteract = function(entity, distance, data)
                    local vehicle = GetVehiclePedIsIn(playerPed, false)

                    if vehicle and vehicle ~= 0 then
                        local plate = GetVehicleNumberPlateText(vehicle)
                        if plate == vehiclePlate then
                            return false
                        end
                    else
                        return true
                    end
                end,
            }
        })
    elseif Config.Interaction.type == 'drawtext' then
        Citizen.CreateThread(function()
            local ped = PlayerPedId()

            while true do 
                local sleep = 1000
                local coords = GetEntityCoords(ped)
                local distance = #(coords - ReturnVehicleCoords)
                local vehicle = GetVehiclePedIsIn(ped, false)

                if (distance < Config.Interaction.text.distance and vehicle and vehicle ~= 0 and GetVehicleNumberPlateText(vehicle) == vehiclePlate) then
                    sleep = 5
                    exports['88studio-core']:DrawText3D(ReturnVehicleCoords.x, ReturnVehicleCoords.y, ReturnVehicleCoords.z, Lang[Config.Language].DRAWTEXT.RETURN_VEHICLE)
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('88studio-delivery:client:deleteVehicle')
                        TriggerEvent('88studio-delivery:client:saveJob')
                    end
                end

                Citizen.Wait(sleep)
            end
        end)
    end
end