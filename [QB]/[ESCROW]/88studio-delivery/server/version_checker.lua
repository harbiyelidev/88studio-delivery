local resource = GetInvokingResource() or GetCurrentResourceName()
local script = GetResourceMetadata(resource, 'scriptname', 0)
local version = GetResourceMetadata(resource, 'version', 0)
local newversion

Citizen.CreateThread(function()
    local function ToNumber(str)
        return tonumber(str)
    end
    PerformHttpRequest('https://raw.githubusercontent.com/harbiyelidev/88studio/main/'..script..'.txt',function(error, result, headers)
        if not result then 
            return print('^1The version check failed, github is down.^0') 
        end
        local result = json.decode(result:sub(1, -2))
        if ToNumber(result.version:gsub('%.', '')) > ToNumber(version:gsub('%.', '')) then
            print('^3['..script..'] - New update available now!^0\nCurrent Version: ^1'..version..'^0.\nNew Version: ^2'..result.version..'^0.\nNews: ^2'..result.news..'^0.\n^5Download it now on your keymaster.fivem.net^0.')
        else
            print('^3['..script..'] ^2- You are using the latest version of the script. ^0\nCurrent Version: ^1'..version..'^0.')
        end
    end, 'GET')
end)