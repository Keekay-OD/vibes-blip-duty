RegisterServerEvent("changeBlipColor")
AddEventHandler("changeBlipColor", function(jobname, onDuty)
    TriggerClientEvent("changeBlipColor", -1, jobname, onDuty)
end)