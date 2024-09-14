ExecuteSql = function(query, parameters, cb)
    local promise = promise:new()
    local isBusy = true
    if Config.SQL == "oxmysql" then
        exports.oxmysql:execute(query, parameters, function(data)
            promise:resolve(data)
            isBusy = false

            if cb then
                cb(data)
            end
        end)
    elseif Config.SQL == "ghmattimysql" then
        exports.ghmattimysql:execute(query, parameters, function(data)
            promise:resolve(data)
            isBusy = false

            if cb then
                cb(data)
            end
        end)
    elseif Config.SQL == "mysql-async" then
        MySQL.Async.fetchAll(query, parameters, function(data)
            promise:resolve(data)
            isBusy = false
            if cb then
                cb(data)
            end
        end)
    end
    while isBusy do
        Wait(0)
    end
    return Citizen.Await(promise)
end