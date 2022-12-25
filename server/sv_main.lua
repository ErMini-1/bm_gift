-- @vars
local Core = nil
local Version = "esx"

if (GetResourceState('es_extended') == 'started') then
    Core = exports['es_extended']:getSharedObject()
elseif (GetResourceState('qb-core') == 'started') then
    Core = exports['qb-core']:GetCoreObject()
    Version = 'qbcore'
end

-- @events
AddEventHandler('onResourceStart', function(res)
    if (res == GetCurrentResourceName()) then
        if (not GetResourceState('oxmysql') == 'started' or not GetResourceState('mysql-async') == 'started') then
            print("[^5bm_gift^7] [^1ERROR^7] - You need oxmysql or mysql-async to use this script")
        else
            print("[^5bm_gift^7] [^2SUCCESS^7] - All correct, Merry Christmas!")
        end
    end
end)

RegisterNetEvent('bm_gift:get', function()
    if (Version == 'esx') then
        local player = Core.GetPlayerFromId(source)
        if (GetResourceState('oxmysql') == 'started') then
            MySQL.query('SELECT claimed FROM gifts WHERE identifier = ?', {player.identifier}, function(result)
                if (not result[1] or not result[1].claimed) then
                    claimGift(player)
                    MySQL.insert('INSERT INTO gifts (`claimed`, `identifier`) VALUES (1, ?)', {
                        player.identifier
                    })
                else
                    player.showNotification(Languages[Config.Locale]['alreadyClaimed'])
                end
            end)
        elseif (GetResourceState('mysql-async') == 'started') then
            MySQL.Async.fetchAll('SELECT claimed FROM gifts WHERE identifier = @identifier', {['@identifier'] = player.identifier}, function(result)
                if (not result[1] or not result[1].claimed) then
                    claimGift(player)
                    MySQL.Async.execute('INSERT INTO gifts (`claimed`, `identifier`) VALUES (1, @identifier)', {
                        ['@identifier'] = player.identifier
                    })
                else
                    player.showNotification(Languages[Config.Locale]['alreadyClaimed'])
                end
            end)
        end
    elseif (Version == 'qbcore') then
        local player = Core.Functions.GetPlayer(source)
        if (GetResourceState('oxmysql') == 'started') then
            MySQL.query('SELECT claimed FROM gifts WHERE identifier = ?', {player.PlayerData.citizenid}, function(result)
                if (not result[1] or not result[1].claimed) then
                    claimGift(player)
                    MySQL.insert('INSERT INTO gifts (`claimed`, `identifier`) VALUES (1, ?)', {
                        player.PlayerData.citizenid
                    })
                else
                    TriggerClientEvent('QBCore:Notify', player.PlayerData.source, Languages[Config.Locale]['alreadyClaimed'], "error")
                end
            end)
        elseif (GetResourceState('mysql-async') == 'started') then
            MySQL.Async.fetchAll('SELECT claimed FROM gifts WHERE identifier = @identifier', {['@identifier'] = player.PlayerData.citizenid}, function(result)
                if (not result[1] or not result[1].claimed) then
                    claimGift(player)
                    MySQL.Async.execute('INSERT INTO gifts (`claimed`, `identifier`) VALUES (1, @identifier)', {
                        ['@identifier'] = player.PlayerData.citizenid
                    })
                else
                    TriggerClientEvent('QBCore:Notify', player.PlayerData.source, Languages[Config.Locale]['alreadyClaimed'], "error")
                end
            end)
        end
    end
end)

-- @funcs
function claimGift(player)
    if (Version == 'esx') then
        for i,v in pairs(Config.rewards) do
            if (i == 'items') then
                for k,b in pairs(v) do
                    player.addInventoryItem(b.item, b.quantity)
                end
            end

            if (i == 'weapons') then
                for k,b in pairs(v) do
                    player.addWeapon(b.weapon, b.ammo)
                end
            end
        end
        player.showNotification(Languages[Config.Locale]['giftClaimed'])
    elseif (Version == 'qbcore') then
        for i,v in pairs(Config.rewards) do
            if (i == 'items') then
                for k,b in pairs(v) do
                    player.Functions.AddItem(b.item, b.quantity)
                end
            end
        end
        TriggerClientEvent('QBCore:Notify', player.PlayerData.source, Languages[Config.Locale]['giftClaimed'], "success")
    end
end