-- RP-Alpha MDT - Server
-- Uses rpa-lib permissions system

-- Helper function to check permissions
local function CheckPermission(source, permConfig)
    return exports['rpa-lib']:HasPermission(source, permConfig, 'mdt')
end

-- Request to open MDT
RegisterNetEvent('rpa-mdt:server:requestOpen', function()
    local src = source
    
    -- Check access permission
    local hasPerm, reason = CheckPermission(src, Config.AccessPermissions)
    if not hasPerm then
        exports['rpa-lib']:Notify(src, reason or "Unauthorized Access", "error")
        return
    end
    
    local player = exports['rpa-lib']:GetFramework().Functions.GetPlayer(src)
    if not player then return end

    local charName = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    local rank = player.PlayerData.job.grade.name
    local job = player.PlayerData.job.name

    -- Determine permission levels for this user
    local permissions = {
        canViewAllRecords = CheckPermission(src, Config.ViewAllRecordsPermissions),
        canManageWarrants = CheckPermission(src, Config.ManageWarrantsPermissions),
        canManageBOLOs = CheckPermission(src, Config.ManageBOLOsPermissions),
        canViewProfiles = CheckPermission(src, Config.ViewProfilesPermissions),
        canAddNotes = CheckPermission(src, Config.AddNotesPermissions),
        isAdmin = CheckPermission(src, Config.AdminPermissions)
    }

    TriggerClientEvent('rpa-mdt:client:open', src, {
        name = charName,
        rank = rank,
        job = job,
        permissions = permissions
    })
end)

-- Create warrant (permission checked)
RegisterNetEvent('rpa-mdt:server:createWarrant', function(data)
    local src = source
    
    local hasPerm, reason = CheckPermission(src, Config.ManageWarrantsPermissions)
    if not hasPerm then
        exports['rpa-lib']:Notify(src, reason or "No permission to create warrants", "error")
        return
    end
    
    -- TODO: Insert warrant into database
    exports['rpa-lib']:Notify(src, "Warrant created successfully", "success")
end)

-- Create BOLO (permission checked)
RegisterNetEvent('rpa-mdt:server:createBOLO', function(data)
    local src = source
    
    local hasPerm, reason = CheckPermission(src, Config.ManageBOLOsPermissions)
    if not hasPerm then
        exports['rpa-lib']:Notify(src, reason or "No permission to create BOLOs", "error")
        return
    end
    
    -- TODO: Insert BOLO into database
    exports['rpa-lib']:Notify(src, "BOLO created successfully", "success")
end)

-- Add citizen note (permission checked)
RegisterNetEvent('rpa-mdt:server:addCitizenNote', function(citizenId, note)
    local src = source
    
    local hasPerm, reason = CheckPermission(src, Config.AddNotesPermissions)
    if not hasPerm then
        exports['rpa-lib']:Notify(src, reason or "No permission to add notes", "error")
        return
    end
    
    -- TODO: Insert note into database
    exports['rpa-lib']:Notify(src, "Note added successfully", "success")
end)
