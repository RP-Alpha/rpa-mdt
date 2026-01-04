Config = {}

--[[
    ==========================================
    PERMISSIONS
    ==========================================
    
    You can grant permissions via:
    1. QB-Core/QBOX groups (admin, mod, etc.)
    2. Server.cfg ConVars with player identifiers
    
    server.cfg examples:
    setr rpa_mdt:admin "steam:110000123456789,license:abc123"
    setr rpa_mdt:view_all_records "steam:110000987654321"
    setr rpa_mdt:manage_warrants "license:xyz789"
]]

-- Who can access the MDT
Config.AccessPermissions = {
    jobs = {'police', 'ambulance', 'bcso', 'sasp', 'doj'},
    minGrade = 0,
    onDuty = true
}

-- Who can view all records (normally restricted by job)
Config.ViewAllRecordsPermissions = {
    groups = {'admin', 'god'},
    jobs = {'police', 'bcso', 'sasp'},
    minGrade = 3,
    resourceConvar = 'view_all_records'
}

-- Who can create/edit warrants
Config.ManageWarrantsPermissions = {
    jobs = {'police', 'bcso', 'sasp', 'doj'},
    minGrade = 2,
    resourceConvar = 'manage_warrants'
}

-- Who can create/edit BOLOs
Config.ManageBOLOsPermissions = {
    jobs = {'police', 'bcso', 'sasp'},
    minGrade = 1,
    onDuty = true
}

-- Who can view citizen profiles
Config.ViewProfilesPermissions = {
    jobs = {'police', 'ambulance', 'bcso', 'sasp', 'doj'},
    minGrade = 0,
    onDuty = true
}

-- Who can add notes to citizen profiles
Config.AddNotesPermissions = {
    jobs = {'police', 'bcso', 'sasp', 'doj'},
    minGrade = 0,
    onDuty = true
}

-- Who can manage the MDT (admin features)
Config.AdminPermissions = {
    groups = {'admin', 'god'},
    resourceConvar = 'admin'
}
