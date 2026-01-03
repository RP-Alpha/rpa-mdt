RegisterNetEvent('rpa-mdt:server:requestOpen', function()
    local src = source
    local player = exports['rpa-lib']:GetFramework().Functions.GetPlayer(src)
    if not player then return end

    -- Check Job
    local job = player.PlayerData.job.name
    if job ~= 'police' and job ~= 'ambulance' then
        exports['rpa-lib']:Notify(src, "Unauthorized Access", "error")
        return
    end

    local charName = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    local rank = player.PlayerData.job.grade.name

    TriggerClientEvent('rpa-mdt:client:open', src, {
        name = charName,
        rank = rank,
        job = job
    })
end)
