local display = false

RegisterNetEvent('rpa-mdt:client:open', function(data)
    SetNuiFocus(true, true)
    display = true
    SendNUIMessage({
        action = 'open',
        data = data
    })
    
    -- Play animation (Tablet)
    local ped = PlayerPedId()
    if not IsEntityPlayingAnim(ped, "amb@world_human_seat_wall_tablet@female@base", "base", 3) then
        RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
        while not HasAnimDictLoaded("amb@world_human_seat_wall_tablet@female@base") do Wait(10) end
        TaskPlayAnim(ped, "amb@world_human_seat_wall_tablet@female@base", "base", 8.0, -8.0, -1, 50, 0, false, false, false)
        
        -- Prop? usually handled by animation or explicit prop creation
    end
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    display = false
    ClearPedTasks(PlayerPedId())
    cb('ok')
})

RegisterCommand('mdt', function()
    TriggerServerEvent('rpa-mdt:server:requestOpen')
end)
