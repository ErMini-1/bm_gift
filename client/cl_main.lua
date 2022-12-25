-- @vars
local entities = {}

-- @threads
CreateThread(function()
    ClearAreaOfObjects(Config.decorations.mainTree.locations[1].xyz, 10.0, 0)
    if (Config.decorations.mainTree.enable) then
        for i,v in pairs(Config.decorations.mainTree.locations) do
            createProp(Config.decorations.mainTree.prop, v)
        end
    end
    if (Config.decorations.smallTrees.enable) then
        for i,v in pairs(Config.decorations.smallTrees.locations) do
            createProp(Config.decorations.smallTrees.prop, v)
        end
    end
    if (Config.decorations.ped.enable) then
        for i,v in pairs(Config.decorations.ped.locations) do
            createPeds(Config.decorations.ped.model, v)
        end
    end

    while true do
        local msec = 1000
        local playerPed     = PlayerPedId()
        local playerCoords  = GetEntityCoords(playerPed)

        if #(playerCoords - Config.positions.getGift) < Config.renderDist then
            msec = 0
            create3D(Config.positions.getGift, Languages[Config.Locale]['text3D'])
            if (IsControlJustPressed(0, 38)) then
                TriggerServerEvent('bm_gift:get')
            end
        end

        Wait(msec)
    end
end)

-- @funcs
function createProp(model, coords)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    local obj = CreateObject(GetHashKey(model), coords.xyz, false, false, false)
    SetEntityHeading(obj, coords.w)
    FreezeEntityPosition(obj, true)
    PlaceObjectOnGroundProperly(obj)
end

function createPeds(model, coords)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    local ped = CreatePed(0, GetHashKey(model), coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
end

function create3D(coords, text)
    local x, y, z = table.unpack(coords)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(5)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end