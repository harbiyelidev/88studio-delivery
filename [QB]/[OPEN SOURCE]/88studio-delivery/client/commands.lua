Citizen.CreateThread(function()
    if Config.Commands.AddEXP.enable then
        RegisterCommand(Config.Commands.AddEXP.command, function(source, args, rawCommand)
            if not args[1] or not args[2] then
                return TriggerEvent('88studio-core:sendNotification', 'Eksik argümanlar...', 'error', 3000)
            end

            local target = tonumber(args[1])
            local xp = tonumber(args[2])

            if not target or not xp then
                return TriggerEvent('88studio-core:sendNotification', 'Eksik argümanlar...', 'error', 3000)
            end

            if target < 1 or xp < 1 then
                return TriggerEvent('88studio-core:sendNotification', 'Eksik argümanlar...', 'error', 3000)
            end

            TriggerServerEvent('88studio-delivery:server:addEXP', target, xp)
        end, false)
    end
    
    if Config.Commands.RemoveEXP.enable then
        RegisterCommand(Config.Commands.RemoveEXP.command, function(source, args, rawCommand)
            if not args[1] or not args[2] then
                return TriggerEvent('88studio-core:sendNotification', 'Eksik argümanlar...', 'error', 3000)
            end

            local target = tonumber(args[1])
            local xp = tonumber(args[2])

            if not target or not xp then
                return TriggerEvent('88studio-core:sendNotification', 'Eksik argümanlar...', 'error', 3000)
            end

            if target < 1 or xp < 1 then
                return TriggerEvent('88studio-core:sendNotification', 'Eksik argümanlar...', 'error', 3000)
            end

            TriggerServerEvent('88studio-delivery:server:removeEXP', target, xp)
        end, false)
    end
    
    if Config.Commands.ResetEXP.enable then
        RegisterCommand(Config.Commands.ResetEXP.command, function(source, args, rawCommand)
            if not args[1] then
                return TriggerEvent('88studio-core:sendNotification', 'Geçerli bir ID belirtin!', 'error', 3000)
            end

            local target = tonumber(args[1])

            if not target then
                return TriggerEvent('88studio-core:sendNotification', 'Geçerli bir ID belirtin!', 'error', 3000)
            end

            if target < 1 then
                return TriggerEvent('88studio-core:sendNotification', 'Geçerli bir ID belirtin!', 'error', 3000)
            end

            TriggerServerEvent('88studio-delivery:server:resetEXP', target)
        end, false)
    end
end)