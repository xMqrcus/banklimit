local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")


local sleep = 5000
CreateThread(function()
    while true do
        Wait(sleep)
        local players = GetPlayers()
        if #players > 10 then sleep = 7500 end -- Formindsker lag
        for i = 1, #players do
            local user_id = vRP.getUserId({i})
            local moneyBank = vRP.getBankMoney({user_id})
            local moneyWallet = vRP.getMoney({user_id})
            if moneyBank >= Config.triggerAmountBank or moneyWallet >= Config.triggerAmountWallet then
                if Config.banEnabled then
                    vRP.setBanned({user_id, 1, Config.banMessage})
                    DropPlayer(i, Config.kickMessage)
                    local dmessage = "ID **".. tostring(user_id).. "** har over det tilladte antal på sig!"
                    PerformHttpRequest(Config.webhookLink, function(err, text, headers) end, 'POST', json.encode({username = Config.webhookName, content = dmessage}), { ['Content-Type'] = 'application/json' })    
                else
                    DropPlayer(i, Config.kickMessage)
                    local dmessage = "ID **".. tostring(user_id).. "** har over det tilladte antal på sig!"
                    PerformHttpRequest(Config.webhookLink, function(err, text, headers) end, 'POST', json.encode({username = Config.webhookName, content = dmessage}), { ['Content-Type'] = 'application/json' })
                end
            end
            Wait(2000) -- Formindsker lag
        end
    end
end)