local JobStartTime = 0
local jobStarted = false

Framework.Functions.CreateCallback('88studio-delivery:server:userDetail', function(source, cb, args)

    local Player = exports['88studio-core']:GetPlayer(source)
    
    if Player then
        local detail = {}

        if args then
            ExecuteSql("SELECT * FROM 88studio_delivery WHERE citizenid = ?", {exports['88studio-core']:GetCitizenId(Player)}, function(result)
                if result and result[1] then
                    local data = result[1]
                    detail = {
                        fullname = exports['88studio-core']:GetFullname(Player),
                        description = "Lorem ipsum dolor sit amet",
                        hours = math.floor(data.duty_time / 3600),
                        minutes = math.floor((data.duty_time % 3600) / 60),
                        seconds = math.floor(data.duty_time % 60),
                    }
                else
                    detail = {
                        fullname = exports['88studio-core']:GetFullname(Player),
                        description = "Lorem ipsum dolor sit amet",
                        hours = 0,
                        minutes = 0,
                        seconds = 0,
                    }

                    ExecuteSql("INSERT INTO 88studio_delivery (citizenid) VALUES (?)", {exports['88studio-core']:GetCitizenId(Player)})
                end
            end)
        else
            ExecuteSql("SELECT * FROM 88studio_delivery WHERE citizenid = ?", {exports['88studio-core']:GetCitizenId(Player)}, function(result)
                if result and result[1] then
                    local data = result[1]
                    detail = {
                        fullname = exports['88studio-core']:GetFullname(Player),
                        description = "Lorem ipsum dolor sit amet",
                        hours = math.floor(data.duty_time / 3600),
                        minutes = math.floor((data.duty_time % 3600) / 60),
                        seconds = math.floor(data.duty_time % 60),
                        currentLevel = math.floor(data.current_xp / 3000),
                        currentXp = data.current_xp,
                        totalEarnedMoney = data.total_cash,
                        totalEarnedXP = data.total_xp,
                        totalPackagesDistributed = data.total_package,
                        totalDistanceTraveled = data.total_km,
                    }
                else
                    detail = {
                        fullname = exports['88studio-core']:GetFullname(Player),
                        description = "Lorem ipsum dolor sit amet",
                        hours = 0,
                        minutes = 0,
                        seconds = 0,
                        currentLevel = 0,
                        currentXp = 0,
                        totalEarnedMoney = 0,
                        totalEarnedXP = 0,
                        totalPackagesDistributed = 0,
                        totalDistanceTraveled = 0,
                    }

                    ExecuteSql("INSERT INTO 88studio_delivery (citizenid) VALUES (?)", {exports['88studio-core']:GetCitizenId(Player)})
                end
            end)
        end

        cb(detail)
    end
end)

RegisterNetEvent('88studio-delivery:server:createBlips', function(coords, blip, name)
    local src = source

    TriggerClientEvent('88studio-delivery:client:createBlips', src, coords, blip, name)
end)

RegisterNetEvent('88studio-delivery:server:saveJob', function(data)
    local src = source
    local Player = exports['88studio-core']:GetPlayer(src)

    if not jobStarted then
        return TriggerEvent('88studio-core:server:CreateLog', 'Delivery_Cheater', Lang[Config.Language].LUA.HACK_DELIVERY, green, string.format(Lang[Config.Language].LUA.HACK_DELIVERY_DESC, exports['88studio-core']:GetFullname(Player), exports['88studio-core']:GetCitizenId(Player), src), false)
    end

    if Player and Config.DutyPhone.type == 'item' then
        exports['88studio-core']:RemoveItem(src, Config.DutyPhone.item.name, 1)
    end

    if Player then
        exports['88studio-core']:AddMoney(Player, data.money, 'bank')
        if Config.GiveMoney.moneyType == 'cash' then
            if Config.GiveMoney.moneyIsItem then
                exports['88studio-core']:AddItem(Player, Config.GiveMoney.moneyItem, data.money)
            else
                exports['88studio-core']:AddMoney(Player, data.money, 'cash')
            end
        elseif Config.GiveMoney.moneyType == 'bank' then
            exports['88studio-core']:AddMoney(Player, data.money, 'bank')
        end
        local DutyTime = os.time() - JobStartTime
        local hours = math.floor(DutyTime / 3600)
        local minutes = math.floor((DutyTime % 3600) / 60)
        local seconds = math.floor(DutyTime % 60)
        ExecuteSql("UPDATE 88studio_delivery SET current_xp = current_xp + ?, total_xp = total_xp + ?, total_cash = total_cash + ?, total_package = total_package + ?, duty_time = duty_time + ?, total_km = total_km + ? WHERE citizenid = ?", {data.xp, data.xp, data.money, data.delivered, DutyTime, data.mileage, exports['88studio-core']:GetCitizenId(Player)})
        TriggerEvent('88studio-core:server:CreateLog', 'Delivery_Stop_Duty', Lang[Config.Language].LUA.STOP_DELIVERY, green, string.format(Lang[Config.Language].LUA.STOP_DELIVERY_DESC, exports['88studio-core']:GetFullname(Player), exports['88studio-core']:GetCitizenId(Player), src, data.money, data.xp, data.mileage, hours .. 'H ' .. minutes .. 'M '.. seconds .. 'S'), false)
    end
end)

if Config.Commands.AddEXP.enable then
    Framework.Commands.Add(Config.Commands.AddEXP.command, Config.Commands.AddEXP.description, {{name = 'id', help = 'Player ID'}, {name = 'xp', help = 'XP Amount'}}, true, function(source, args)
        if not args[1] or not args[2] then
            return
        end

        local target = tonumber(args[1])
        local xp = tonumber(args[2])

        if not target or not xp then
            return
        end

        if target < 1 or xp < 1 then
            return
        end

        TriggerEvent('88studio-delivery:server:addEXP', target, xp)
    end, Config.Commands.AddEXP.minRank)
end

if Config.Commands.RemoveEXP.enable then
    Framework.Commands.Add(Config.Commands.RemoveEXP.command, Config.Commands.RemoveEXP.description, {{name = 'id', help = 'Player ID'}, {name = 'xp', help = 'XP Amount'}}, true, function(source, args)
        if not args[1] or not args[2] then
            return
        end

        local target = tonumber(args[1])
        local xp = tonumber(args[2])

        if not target or not xp then
            return
        end

        if target < 1 or xp < 1 then
            return
        end

        TriggerEvent('88studio-delivery:server:removeEXP', target, xp)
    end, Config.Commands.RemoveEXP.minRank)
end

if Config.Commands.RemoveEXP.enable then
    Framework.Commands.Add(Config.Commands.ResetEXP.command, Config.Commands.ResetEXP.description, {{name = 'id', help = 'Player ID'}}, true, function(source, args)
        if not args[1] then
            return
        end

        local target = tonumber(args[1])

        if not target then
            return
        end

        if target < 1 then
            return
        end

        TriggerEvent('88studio-delivery:server:resetEXP', target)
    end, Config.Commands.ResetEXP.minRank)
end

RegisterNetEvent('88studio-delivery:server:addEXP', function(target, xp)
    local src = source
    local Player = exports['88studio-core']:GetPlayer(src)
    local tPlayer = exports['88studio-core']:GetPlayer(target)

    if Player and tPlayer then
        ExecuteSql("UPDATE 88studio_delivery SET current_xp = current_xp + ? WHERE citizenid = ?", {xp, exports['88studio-core']:GetCitizenId(tPlayer)})
        TriggerClientEvent('88studio-core:sendNotification', src, string.format(Lang[Config.Language].LUA.ADD_XP, target, xp), 'success', 3000)
        if Config.Commands.AddEXP.sendLog then
            TriggerEvent('88studio-core:server:CreateLog', 'Delivery_Admin_Commands', Lang[Config.Language].LUA.USED_ADMIN_COMMAND, green, string.format(Lang[Config.Language].LUA.ADD_XP_DESC, exports['88studio-core']:GetFullname(Player), exports['88studio-core']:GetCitizenId(Player), src, exports['88studio-core']:GetFullname(tPlayer), exports['88studio-core']:GetCitizenId(tPlayer), target, xp), false)
        end
    end
end)

RegisterNetEvent('88studio-delivery:server:removeEXP', function(target, xp)
    local src = source
    local Player = exports['88studio-core']:GetPlayer(src)
    local tPlayer = exports['88studio-core']:GetPlayer(target)

    if Player and tPlayer then
        ExecuteSql("UPDATE 88studio_delivery SET current_xp = current_xp - ? WHERE citizenid = ?", {xp, exports['88studio-core']:GetCitizenId(tPlayer)})
        TriggerClientEvent('88studio-core:sendNotification', src, string.format(Lang[Config.Language].LUA.REMOVE_XP, target, xp), 'success', 3000)
        if Config.Commands.RemoveEXP.sendLog then
            TriggerEvent('88studio-core:server:CreateLog', 'Delivery_Admin_Commands', Lang[Config.Language].LUA.USED_ADMIN_COMMAND, green, string.format(Lang[Config.Language].LUA.REMOVE_XP_DESC, exports['88studio-core']:GetFullname(Player), exports['88studio-core']:GetCitizenId(Player), src, exports['88studio-core']:GetFullname(tPlayer), exports['88studio-core']:GetCitizenId(tPlayer), target, xp), false)
        end
    end
end)

RegisterNetEvent('88studio-delivery:server:resetEXP', function(target)
    local src = source
    local Player = exports['88studio-core']:GetPlayer(src)
    local tPlayer = exports['88studio-core']:GetPlayer(target)

    if Player and tPlayer then
        ExecuteSql("UPDATE 88studio_delivery SET current_xp = 0 WHERE citizenid = ?", {exports['88studio-core']:GetCitizenId(tPlayer)})
        TriggerClientEvent('88studio-core:sendNotification', src, string.format(Lang[Config.Language].LUA.RESET_XP, target), 'success', 3000)
        if Config.Commands.ResetEXP.sendLog then
            TriggerEvent('88studio-core:server:CreateLog', 'Delivery_Admin_Commands', Lang[Config.Language].LUA.USED_ADMIN_COMMAND, green, string.format(Lang[Config.Language].LUA.RESET_XP_DESC, exports['88studio-core']:GetFullname(Player), exports['88studio-core']:GetCitizenId(Player), src, exports['88studio-core']:GetFullname(tPlayer), exports['88studio-core']:GetCitizenId(tPlayer), target), false)
        end
    end
end)

RegisterNetEvent('88studio-delivery:server:SetStartTime', function()
    local src = source
    local Player = exports['88studio-core']:GetPlayer(src)
    JobStartTime = os.time()
    jobStarted = true

    TriggerEvent('88studio-core:server:CreateLog', 'Delivery_Start_Duty', Lang[Config.Language].LUA.START_DELIVERY, green, string.format(Lang[Config.Language].LUA.START_DELIVERY_DESC, exports['88studio-core']:GetFullname(Player), exports['88studio-core']:GetCitizenId(Player), src), false)
end)

RegisterNetEvent('88studio-delivery:server:giveJobPhone', function()
    if Config.JobPhone then
        local src = source
        local Player = exports['88studio-core']:GetPlayer(src)

        if Player and Config.DutyPhone.type == 'item' then
            exports['88studio-core']:AddItem(src, Config.DutyPhone.item.name, 1)
        end
    end
end)