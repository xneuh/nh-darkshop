ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent('hypex:getTwojStarySharedTwojaStaraObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

RegisterNetEvent("nh_darkshop:OpenDark_CL", function()
    OpenDarkShop(1)
end)

RegisterCommand("Test",function()
    ESX.TriggerServerCallback('nh_kp:getLevel', function(res) 
        print(res)
    end, 'handlarz')	
end)

CreateThread(function()
    while(1) do 
        Wait(5)
        local dist = #(GetEntityCoords(PlayerPedId()) - vec3(-313.01,-1036.8699, 35.4008))

        if(dist <= 4) then
            ESX.DrawMarker(vec3(-313.01,-1036.8699, 35.4008))
            if(dist <= 1.3) then
                ESX.ShowHelpNotification("~INPUT_PICKUP~ aby porozmawiać z nieznajomym")
                if(IsControlJustReleased(0,38)) then
                    TriggerServerEvent("nh_darkshop:OpenDark")
                end
            end
        else
            Wait(750)
        end

    end
end)

OpenDarkShop = function(lvl)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'dark_menu',
        {
            align    = 'center',
            title    = 'Handlarz Bronią',
            elements = Config.Items[lvl]
        },
        function(data, menu)
            print(data.current.value, data.current.price, data.current.price_black, data.current.exp, data.current.ammo)
            print(json.encode(data.current))
            ChooseCurrency(data.current.value, data.current.price, data.current.price_black, data.current.exp, data.current.ammo)
        end,
        function(data, menu)
            menu.close()
        end
    )
end

ChooseCurrency = function(selectedWeapon, price, priceBlack, xp, ammo)
    print(selectedWeapon, price, priceBlack, xp, ammo)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'currency_menu',
        {
            align    = 'center',
            title    = 'Wybierz Rodzaj Płatności',
            elements = {
                {label = 'Brudna Gotówka <font style="color:red">[$' .. priceBlack .. ']</font>',  value = 'black_money'},
                {label = 'Gotówka <font style="color: green">[$' .. price .. ']</font>', value = 'money'}
            }
        },
        function(data, menu)
            print(selectedWeapon)
            if(data.current.value == 'black_money') then 
                TriggerServerEvent('nh_darkshop:buyWeapon', selectedWeapon, data.current.value, priceBlack, xp, ammo)
            else
                TriggerServerEvent('nh_darkshop:buyWeapon', selectedWeapon, data.current.value, price, xp, ammo)
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

