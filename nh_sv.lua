ESX = nil
TriggerEvent('hypex:getTwojStarySharedTwojaStaraObject', function(obj) ESX = obj end)

RegisterServerEvent('nh_darkshop:buyWeapon', function(currentWeapon, moneyType, weaprice, xp, ammo)
    print(xp)
    local src = source 
    local data = ESX.GetPlayerFromId(src)

    if(currentWeapon) then 
        MySQL.Async.fetchAll('SELECT * FROM user_skills WHERE identifier = @identifier', {
            ['@identifier'] = data.identifier
        }, function(res)
            -- print(json.encode(data.getAccount(moneyType)))
            if(res[1]) then 
                if(data.getAccount(moneyType).money ~= nil and tonumber(data.getAccount(moneyType).money) >= weaprice) then 
                    data.removeAccountMoney(moneyType, weaprice)
                    data.addInventoryWeapon(currentWeapon, 1, ammo, false)
                    data.showNotification('~b~Zakupiono ~r~[' .. currentWeapon .. '] ~b~za Cene ~r~[' .. weaprice .. ']')
                    MySQL.Async.execute('UPDATE user_skills SET handlarzexp = handlarzexp + @xp WHERE identifier = @identifier', {
                        ['@identifier'] = data.identifier,
                        ['@xp'] = xp
                    }, function()
                        data.showNotification('~b~Pozyskano ~r~[' .. xp .. 'XP]~b~ Umiejętność ~r~[Handlarz Bronią]')
                    end)
                else
                    data.showNotification('~b~Nie posiadasz wystarczająco ~r~[' .. data.getAccount(moneyType).label .. ']')
                end
            else
                data.showNotification('~b~Twoja postać nie posiada Utworzonej ~r~Karty Postaci')
            end
        end)
    end
end)

RegisterServerEvent("nh_darkshop:OpenDark", function()
    local src = source
    local data = ESX.GetPlayerFromId(src)
    if(data.getInventoryItem("terra_dark").count >= 1) then
        data.removeInventoryItem("terra_dark", 1)
        TriggerClientEvent("nh_darkshop:OpenDark_CL", src)
    else
        data.showNotification("~b~Nie posiadasz ~r~[1x " .. data.getInventoryItem("terra_dark").label .. "]")
    end
end)

-- data.addWeapon(currentWeapon, nil, nil, Config.Items[])