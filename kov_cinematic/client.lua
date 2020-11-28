ESX = nil
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    
    ESX.TriggerServerCallback('kov_cinematic:getnpcsState', function(State)
        for npc,state in pairs(State) do
            Config.Cinematics[npc].enable = state
        end
    end)
    Citizen.Wait(500000) -- Olası Hata Durumu İçin
    for i=1, #Config.Cinematics, 1 do
        TriggerServerEvent('kov_cinematic:checkPedPoint', Config.Cinematics[i].name)
        Citizen.Wait(100)
        ESX.TriggerServerCallback('kov_cinematic:getDateName', function(statu)
            local count = #Config.Cinematics[i].Subtitle.Talk
            Config.Cinematics[i].state = tonumber(statu)
            if count <= Config.Cinematics[i].state then
                Config.Cinematics[i].state = count
            end
        end, Config.Cinematics[i].name)
        ESX.TriggerServerCallback('kov_cinematic:getPlayerPoint', function(result)
            if Config.Relationships.good <= tonumber(result) then
                Config.Cinematics[i].relationship = 'good'
            elseif Config.Relationships.bad >= tonumber(result) then
                Config.Cinematics[i].relationship = 'bad'
            else
                Config.Cinematics[i].relationship = 'medium'
            end
        end, Config.Cinematics[i].name)
        Citizen.Wait(5)
    end
end)

local talkenable = false
local selection = 0
local pause = false
local talkfinished = false

Citizen.CreateThread(function()
    Citizen.Wait(500000) -- Olası Hata Durumu İçin
    while true do
        Citizen.Wait(0)
        local coordsMe = GetEntityCoords(GetPlayerPed(-1), false)
        for i=1, #Config.Cinematics, 1 do
            local coords = Config.Cinematics[i].Npc.coord
            local distance = Vdist2(coordsMe, coords)
            if distance < Config.Range then
                if IsControlJustPressed(0, Keys[Config.KeyForTalk]) then 
                    ESX.TriggerServerCallback('kov_cinematic:getDay', function(now)
                        ESX.TriggerServerCallback('kov_cinematic:getDayName', function(day)
                            if Config.Cinematics[i].enable == false then
                                if now == day then
                                    talkenable = true
                                    Citizen.Wait(0)
                                    if pause == false then
                                        for j=1, #Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship], 1 do
                                            if talkfinished ~= true then
                                                TriggerServerEvent('kov_cinematic:updateNPCState', i, true)
                                                if Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation ~= nil then
                                                    ClearPedTasks(Config.Cinematics[i].Npc.npc)
                                                    if Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.type == 1 then
                                                        TaskPlayAnim(Config.Cinematics[i].Npc.npc, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.anim, 0, true)
                                                    elseif Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.type == 2 then
                                                        RequestAnimDict(Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.dict)
                                                        while (not HasAnimDictLoaded(Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.dict)) do Citizen.Wait(0) end
                                                        TaskPlayAnim(Config.Cinematics[i].Npc.npc, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.dict, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.anim, 1.5, 1.5, -1, 1, 0, false, false, false)
                                                    end
                                                    timer = Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.wait 
                                                    while timer > 0 do
                                                        Citizen.Wait(1000)
                                                        timer = timer - 1
                                                    end
                                                end
                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].ped, Config.Cinematics[i].name)
                                                timer2 = Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].wait
                                                while timer2 > 0 do
                                                    Citizen.Wait(1000)
                                                    timer2 = timer2 - 1
                                                end
                                                talkenable = true
                                                for k=1, #Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections, 1 do
                                                    TriggerEvent("notification",k..". "..Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[k].title)
                                                end
                                                exports["np-taskbar"]:taskBar(Config.AnswerWaitTime,"Cevap Bekleniyor...")
                                                Citizen.Wait(Config.AnswerWaitTime)
                                                if distance < Config.Range then
                                                    ESX.TriggerServerCallback('kov_cinematic:getName', function(firstname,lastname)
                                                        local name = nil
                                                        name =  firstname ..' '..  lastname
                                                        if selection == 1 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[1] ~= nil then
                                                            TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                        elseif  selection == 2 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[2] ~= nil then
                                                            TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                        elseif  selection == 3 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[3] ~= nil then
                                                            TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                        elseif  selection == 4 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[4] ~= nil then
                                                            TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                        elseif  selection == 5 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[5] ~= nil then
                                                            TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                        else
                                                            TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].whendontsayanything, Config.Cinematics[i].name)
                                                            talkfinished = true 
                                                            return
                                                        end
                                                        selection = 0
                                                    end)
                                                else
                                                    TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].whendontsayanything, Config.Cinematics[i].name)
                                                    talkfinished = true 
                                                    return
                                                end
                                                Citizen.Wait(1000)
                                                talkenable = false 
                                            end
                                        end
                                        talkfinished = false
                                        TriggerServerEvent('kov_cinematic:updateNPCState', i, false)
                                    end
                                    Citizen.Wait(50)
                                elseif now ~= day then
                                    TriggerServerEvent('kov_cinematic:updateDay', Config.Cinematics[i].name)
                                    Config.Cinematics[i].state = Config.Cinematics[i].state + 1
                                    TriggerServerEvent('kov_cinematic:updateDate', Config.Cinematics[i].name, tostring(Config.Cinematics[i].state))
                                    Citizen.Wait(500)
                                    if pause == false then
                                        for j=1, #Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship], 1 do
                                            if talkfinished ~= true then
                                                TriggerServerEvent('kov_cinematic:updateNPCState', i, true)
                                                if Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation ~= nil then
                                                    ClearPedTasks(Config.Cinematics[i].Npc.npc)
                                                    if Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.type == 1 then
                                                        TaskPlayAnim(Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.npc, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.anim, 0, true)
                                                    elseif Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.type == 2 then
                                                        RequestAnimDict(Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.dict)
                                                        while (not HasAnimDictLoaded(Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.dict)) do Citizen.Wait(0) end
                                                        TaskPlayAnim(Config.Cinematics[i].Npc.npc, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.dict, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.anim, 1.5, 1.5, -1, 1, 0, false, false, false)
                                                    end
                                                    timer = Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].animation.wait 
                                                    while timer > 0 do
                                                        Citizen.Wait(1000)
                                                        timer = timer - 1
                                                    end
                                                end
                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].ped, Config.Cinematics[i].name)
                                                timer2 = Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].wait 
                                                while timer2 > 0 do
                                                    Citizen.Wait(1000)
                                                    timer2 = timer2 - 1
                                                end
                                                talkenable = true
                                                for k=1, #Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections, 1 do
                                                    TriggerEvent("notification",k.." "..Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[k].title)
                                                end
                                                exports["np-taskbar"]:taskBar(Config.AnswerWaitTime,"Cevap Bekleniyor...")
                                                Citizen.Wait(Config.AnswerWaitTime)
                                                if distance < Config.Range then
                                                    ESX.TriggerServerCallback('kov_cinematic:getName', function(firstname,lastname)
                                                        local name = nil
                                                        name =  firstname ..' '..  lastname
                                                        ESX.TriggerServerCallback('kov_cinematic:getPlayerPoint', function(currentpoint)
                                                            if selection == 1 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[1] ~= nil then
                                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                                TriggerServerEvent('kov_cinematic:updatePedPoint', Config.Cinematics[i].name, tostring(tonumber(currentpoint) + Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].relation))
                                                            elseif  selection == 2 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[2] ~= nil then
                                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                                TriggerServerEvent('kov_cinematic:updatePedPoint', Config.Cinematics[i].name, tostring(tonumber(currentpoint) + Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].relation))
                                                            elseif  selection == 3 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[3] ~= nil then
                                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                                TriggerServerEvent('kov_cinematic:updatePedPoint', Config.Cinematics[i].name, tostring(tonumber(currentpoint) + Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].relation))
                                                            elseif  selection == 4 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[4] ~= nil then
                                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                                TriggerServerEvent('kov_cinematic:updatePedPoint', Config.Cinematics[i].name, tostring(tonumber(currentpoint) + Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].relation))
                                                            elseif  selection == 5 and Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[5] ~= nil then
                                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].title, name)
                                                                TriggerServerEvent('kov_cinematic:updatePedPoint', Config.Cinematics[i].name, tostring(tonumber(currentpoint) + Config.Cinematics[i].Subtitle.Talk[Config.Cinematics[i].state][Config.Cinematics[i].relationship][j].selections[selection].relation))
                                                            else
                                                                TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].whendontsayanything, Config.Cinematics[i].name)
                                                                talkfinished = true 
                                                                return
                                                            end
                                                            selection = 0
                                                        end, Config.Cinematics[i].name)
                                                    end)
                                                else
                                                    TriggerEvent('kov_cinematic:addChatCl', i, Config.Cinematics[i].whendontsayanything, Config.Cinematics[i].name)
                                                    talkfinished = true 
                                                    return
                                                end
                                                Citizen.Wait(Config.WaitTime)
                                                talkenable = false
                                            end
                                        end
                                        talkfinished = false
                                    end
                                    Citizen.Wait(50)
                                    talkfinished = true
                                    TriggerServerEvent('kov_cinematic:updateNPCState', i, false)
                                end
                            end
                        end, Config.Cinematics[i].name)
                    end, Config.Cinematics[i].name)
                end
           else
                if talkenable == true then
                    selection = 0
                end
            end
        end
        if talkenable == true then
			if IsControlJustReleased(0, Keys['N7']) then
                selection = 1
                ESX.ShowNotification('1. Şıkkı Seçtin', false, false, 'black')
			end
			if IsControlJustReleased(0, Keys['N8']) then
                selection = 2
                ESX.ShowNotification('2. Şıkkı Seçtin', false, false, 'black')
			end
			if IsControlJustReleased(0, Keys['N9']) then
                selection = 3
                ESX.ShowNotification('3. Şıkkı Seçtin', false, false, 'black')
            end
            if IsControlJustReleased(0, Keys['N4']) then
                selection = 4
                ESX.ShowNotification('4. Şıkkı Seçtin', false, false, 'black')
            end
            if IsControlJustReleased(0, Keys['N5']) then
                selection = 5
                ESX.ShowNotification('5. Şıkkı Seçtin', false, false, 'black')
			end
		end
    end
end)

RegisterNetEvent('kov_cinematic:updateState')
AddEventHandler('kov_cinematic:updateState', function(npc, state)
    Config.Cinematics[npc].enable = state
end)

RegisterNetEvent('kov_cinematic:AddChat')
AddEventHandler('kov_cinematic:AddChat', function(i, text, name)
    local coordsPlayer = GetEntityCoords(GetPlayerPed(-1), false)
    local coords = GetEntityCoords(Config.Cinematics[i].Npc.coord, false)
    local distance = Vdist2(coordsMe, coords)
    if distance < 150 then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args =  {name , ': '.. text .. ' ' }
        })
        --[[
        local timer = GetGameTimer() + 9000
        while timer >= GetGameTimer() do
            drawText(text)
            Wait(0)
        end
        ]]
    end
end)

drawText = function(text)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.95)
end

RegisterNetEvent("kov_cinematic:addChatCl")
AddEventHandler("kov_cinematic:addChatCl", function(i, text, name)
    TriggerServerEvent('kov_cinematic:ChatADD', i, text, name)
end)

--[[
RegisterCommand('deneme', function()
    TriggerEvent('kov_cinematic:ExtraTalk', 1, 'C4')
end)


RegisterCommand('deneme', function()
    local denem, deneme2 = PedRelationShip(1)
    print(denem)
    print(deneme2)
end)
]]
RegisterNetEvent('kov_cinematic:ExtraTalk')
AddEventHandler('kov_cinematic:ExtraTalk', function(name, talk)
    Citizen.Wait(10)
    TriggerServerEvent('kov_cinematic:ChatADD', name, Config.Cinematics[name].Subtitle.Extra[talk][Config.Cinematics[name].relationship], Config.Cinematics[name].name)
end)

function TalkEnded(name)
    return Config.Cinematics[name].enable
end

function PedRelationShip(name)
    return Config.Cinematics[name].relationship, Config.Cinematics[name].state
end

RegisterNetEvent('kov_cinematic:CreatePed')
AddEventHandler('kov_cinematic:CreatePed', function(ped)
    if Config.Cinematics[ped].enable == false then
        RequestModel(Config.Cinematics[ped].Npc.model)
        while not HasModelLoaded(Config.Cinematics[ped].Npc.model) do
            Citizen.Wait(10)
        end
        Config.Cinematics[ped].Npc.npc = CreatePed(26, Config.Cinematics[ped].Npc.model ,Config.Cinematics[ped].Npc.coord, Config.Cinematics[ped].Npc.heading, 1, 0)
        SetPedFleeAttributes(Config.Cinematics[ped].Npc.npc, 0, 0)
        FreezeEntityPosition(Config.Cinematics[ped].Npc.npc, true)
        SetEntityInvincible(Config.Cinematics[ped].Npc.npc, true)
        SetBlockingOfNonTemporaryEvents(Config.Cinematics[ped].Npc.npc, true)
        Citizen.Wait(100)
        if Config.Cinematics[ped].Npc.animation ~= nil then
            if Config.Cinematics[ped].Npc.animation.type == 1 then
                TaskPlayAnim(Config.Cinematics[ped].Npc.animation.npc, Config.Cinematics[ped].Npc.animation.anim, 0, true)
            elseif Config.Cinematics[ped].Npc.animation.type == 2 then
                RequestAnimDict(Config.Cinematics[ped].Npc.animation.dict)
            while (not HasAnimDictLoaded(Config.Cinematics[ped].Npc.animation.dict)) do Citizen.Wait(0) end
                TaskPlayAnim(Config.Cinematics[ped].Npc.npc, Config.Cinematics[ped].Npc.animation.dict, Config.Cinematics[ped].Npc.animation.anim, 1.5, 1.5, -1, 1, 0, false, false, false)
            end
            Citizen.Wait(1)
        end
    end
end)

Citizen.CreateThread(function()
    for i=1, #Config.Cinematics, 1 do
        Citizen.Wait(0)
        TriggerEvent('kov_cinematic:CreatePed', i)
    end
end)
