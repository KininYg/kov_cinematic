ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local CinematicsNpc = {}

RegisterServerEvent('kov_cinematic:updatePedPoint')
AddEventHandler('kov_cinematic:updatePedPoint', function(name, point)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM kov_relationship WHERE identifier = @identifier AND name = @name', {
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name
    }, function(result)
        if result[1] ~= nil then
            MySQL.Sync.execute("UPDATE `kov_relationship` SET `point`=@point WHERE identifier = @identifier AND name = @name", { 
                ['@identifier'] = xPlayer.identifier,
                ['@name'] = name,
                ['@point'] = point
            })
        else
            MySQL.Sync.execute("INSERT INTO `kov_relationship`(`identifier`, `name`) VALUES (@identifier,@name)", { 
                ['@identifier'] = xPlayer.identifier,
                ['@name'] = name
            })
        end
    end)
end)

RegisterServerEvent('kov_cinematic:checkPedPoint')
AddEventHandler('kov_cinematic:checkPedPoint', function(name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM kov_relationship WHERE identifier = @identifier AND name = @name', {
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name
    }, function(result)
        if result[1] == nil then
            MySQL.Sync.execute("INSERT INTO `kov_relationship`(`identifier`, `name`) VALUES (@identifier,@name)", { 
                ['@identifier'] = xPlayer.identifier,
                ['@name'] = name
            })
        end
    end)
end)

RegisterServerEvent('kov_cinematic:ChatADD')
AddEventHandler('kov_cinematic:ChatADD', function(i, text, name)
    TriggerClientEvent('kov_cinematic:AddChat', -1, i, text, name)
end)

ESX.RegisterServerCallback('kov_cinematic:getPlayerPoint', function(source, cb, name)
    Citizen.Wait(50)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT point FROM kov_relationship WHERE identifier = @identifier AND name = @name', {
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name
    }, function(point)
        if point[1] ~= nil then
            cb(point[1].point)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('kov_cinematic:getStatusPed', function(source, cb, num)
    Citizen.Wait(0)
    cb(Config.Cinematics[num].Npc.created)
end)

ESX.RegisterServerCallback('kov_cinematic:getDayName', function(source, cb, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT day FROM kov_relationship WHERE identifier = @identifier AND name = @name', {
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name
    }, function(day)
        if day[1] ~= nil then
            local day = day[1].day
            Citizen.Wait(0)
            cb(day)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('kov_cinematic:getDateName', function(source, cb, name)
    Citizen.Wait(50)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT date FROM kov_relationship WHERE identifier = @identifier AND name = @name', {
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name
    }, function(date)
        if date[1] ~= nil then
            local da = date[1].date
            Citizen.Wait(0)
            cb(da)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('kov_cinematic:getDay', function(source, cb)
    cb(string.trim(os.date("%x")))
end)

RegisterServerEvent('kov_cinematic:updateDate')
AddEventHandler('kov_cinematic:updateDate', function(name, date)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Sync.execute("UPDATE `kov_relationship` SET `date`=@date WHERE identifier = @identifier AND name = @name", { 
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name,
        ['@date'] = date
    })
end)

RegisterServerEvent('kov_cinematic:updateDay')
AddEventHandler('kov_cinematic:updateDay', function(name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Sync.execute('UPDATE kov_relationship SET day = @day WHERE identifier = @identifier AND name = @name', { 
        ['@identifier'] = xPlayer.identifier,
        ['@name'] = name,
        ['@day'] = string.trim(os.date("%x"))
    })
end)

ESX.RegisterServerCallback('kov_cinematic:getName', function(source, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier}, function(result)
        data(result[1].firstname, result[1].lastname)
    end)
end)

RegisterServerEvent('kov_cinematic:updateNPCState')
AddEventHandler('kov_cinematic:updateNPCState', function(numberNPC, state)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        CinematicsNpc[numberNPC] = state
        TriggerClientEvent('kov_cinematic:updateState', -1, numberNPC, state)
    end
end)

ESX.RegisterServerCallback('kov_cinematic:getnpcsState', function(source, cb)
    cb(CinematicsNpc)
end)

string.trim = function(text)
    if text ~= nil then
        return text:match("^%s*(.-)%s*$")
    else
        return nil
    end
end