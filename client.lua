local QBCore = nil
local blips = {}
local jobDutyStatus = {}

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

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
                if not blips[jobname] then
                    blips[jobname] = createBlip(info)
                end
                if onDuty then
                    SetBlipColour(blips[jobname], info.color)
                else
                    SetBlipColour(blips[jobname], info.offDutyColor)
                end
            end
            break
        end
    end
end

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.onduty then
        jobDutyStatus[JobInfo.name] = true
    else
        jobDutyStatus[JobInfo.name] = false
    end
    updateBlip(JobInfo.name)
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    
    for _, info in pairs(Config.Blips) do
        blips[info.jobname] = createBlip(info)
        if info.alwaysOn then
            SetBlipColour(blips[info.jobname], info.color)
        else
            jobDutyStatus[info.jobname] = false
            SetBlipColour(blips[info.jobname], info.offDutyColor)
        end
    end
end)