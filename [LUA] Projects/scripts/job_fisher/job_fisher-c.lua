exports.motiontext:Draw3DTextPermanent({
    xyz={x = -1851.1120605469, y = -1240.9846191406, z = 8.6051025390625},
    text={
        content= "[JOB] ~y~Fisher~n~~c~/getjob",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
exports.motiontext:Draw3DTextPermanent({
    xyz={x = -1849.8330078125, y = -1249.8461914063, z = 8.6051025390625},
    text={
        content= "[JOB] ~y~Fisher~n~~c~/fish",
        rgb={171 , 0, 0},
        textOutline=true,
        scaleMultiplier=1,
        font=0
    },
    perspectiveScale=2,
    radius=100,
})
RegisterNetEvent("job_fisher-c::PlayAnimation")
AddEventHandler("job_fisher-c::PlayAnimation", function()
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'world_human_stand_fishing', 0, true)
end)