local QBCore = nil
local blips = {}
local jobDutyStatus = {}

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

-- Function to create blip
local function createBlip(info)
    local blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(blip, info.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, info.scale)
    SetBlipColour(blip, info.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.joblabel)
    EndTextCommandSetBlipName(blip)
    return blip
end

-- Function to update blip visibility and color based on duty status
local function updateBlip(jobname)
    local onDuty = jobDutyStatus[jobname] or false
    for _, info in pairs(Config.Blips) do
        if info.jobname == jobname then
            if info.alwaysOn then
                if not blips[jobname] then
                    blips[jobname] = createBlip(info)
                end
                SetBlipColour(blips[jobname], info.color)
            else
                if onDuty then
                    if not blips[jobname] then
                        blips[jobname] = createBlip(info)
                    end
                    SetBlipColour(blips[jobname], info.color)
                else
                    if blips[jobname] then
                        RemoveBlip(blips[jobname])
                        blips[jobname] = nil
                    end
                end
            end
            break
        end
    end
end

-- Event handler for duty status updates
RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.onduty then
        jobDutyStatus[JobInfo.name] = true
    else
        jobDutyStatus[JobInfo.name] = false
    end
    updateBlip(JobInfo.name)
end)

-- Create initial blips for always-on jobs and set default duty status
Citizen.CreateThread(function()
    while QBCore == nil do
        Citizen.Wait(100)
    end
    for _, info in pairs(Config.Blips) do
        if info.alwaysOn then
            blips[info.jobname] = createBlip(info)
        end
        jobDutyStatus[info.jobname] = false
    end
end)