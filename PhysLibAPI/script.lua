dofile("scripts/forts.lua")                     -- Required for vector functions
dofile(path .. "/PhysLibAPI/PhysLib.lua")       -- Adds the API functions


-- Forts API function, triggered when the mod is loaded.
function Load()

    -- Loader for the API interface, necessary to tell PhysLib to talk to this mod. Parse in the name that the mod should use.
    PhysLib:Load("PhysLibAPIInterfaceExampleMod")

    -- Defines a new physics object type, which acts as a template that created objects will inherit physical properties from.
    PhysLib:RegisterObjectDefinition("IronOre1", {
        SpringConst = 3,
        Dampening = 0.45,
        DynamicFriction = 4,
        StaticFriction = 4,
        CollidesWithOthers = true
    })

    -- Subscribes to the PhysLib API event (first argument) and tells it to call the local event function (second argument) when the event is triggered.
    PhysLib:SubscribeToEvent("OnObjectCollisionWithLink", "OnObjectCollisionWithLinkLocal")
    PhysLib:SubscribeToEvent("OnObjectTravelledThroughPortal", "SomeOtherRandomName")
end

-- Forts API function, triggered when a key is pressed.

local holding = false
function OnKey(key, down)
    if key == "f" then holding = down end
    if down and key == "f" then
        -- Creates a new physics object at the mouse position, with a radius of 25, and the properties of the "IronOre1" object definition.
        local pos = ProcessedMousePos()
        SendScriptEvent("SpawnObject", tostring(pos.x) .. "," .. tostring(pos.y), "script.lua", true)
    end
end

function SpawnObject(posx, posy)

    local physicsObject = PhysLib:RegisterPhysicsObject({x = posx, y = posy}, 25, nil, "IronOre1", path .. "/effects/IronOre1.lua")
    Log(""..physicsObject.id)
end

-- Local event function that is called when a physics object collides with a link. Subscribed on line 21.
function OnObjectCollisionWithLinkLocal(objectId, objectPos, nodeIdA, nodeIdB, nodePosA, nodePosB, t, normal, distance)
    --Spawns a circle at the collision position with a radius of 5 and a white color.
    SpawnCircle(objectPos, 5, White(), 0.04)
    SpawnLine(nodePosA, nodePosB, White(), 0.04)
    local hitPoint = Vec3Lerp(nodePosA, nodePosB, t)
    SpawnCircle(hitPoint, 5, White(), 0.04)
    
end

function Vec3Lerp(a, b, t)
    return Vec3(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t)
end
function Vec3LerpNum(a, b, t)
    return {a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t}
end


-- Local event function that is called when a physics object travels through a portal. Subscribed on line 22.
function SomeOtherRandomName(objectId, nodeEnteredIdA, nodeEnteredIdB, nodeExitedIdA, nodeExitedIdB, t)
    local nodeEnterdPosA = NodePosition(nodeEnteredIdA)
    local nodeEnterdPosB = NodePosition(nodeEnteredIdB)
    local nodeExitedPosA = NodePosition(nodeExitedIdA)
    local nodeExitedPosB = NodePosition(nodeExitedIdB)

    local linkEnteredPos = Vec3Lerp(nodeEnterdPosA, nodeEnterdPosB, t)
    local linkExitedPos = Vec3Lerp(nodeExitedPosA, nodeExitedPosB, t)

    -- Spawns a line between the two positions that the object travelled through.
    SpawnLine(linkEnteredPos, linkExitedPos, Red(), 5)
end



function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    if projectileNodeIdFrom == 0 then
        return
    end
    
    local pos = NodePosition(projectileNodeId)
    local vel = NodeVelocity(projectileNodeId)
    local radius = 10
    -- Spawn a physics object at the position of the projectile, with a radius of 10, and the properties of the "IronOre1" object definition.
    local objectId = PhysLib:RegisterPhysicsObject(pos, radius, vel, "IronOre1", path .. "/effects/IronOre1.lua")

    DestroyProjectile(projectileNodeId)

end


function Update()
    local pos = ProcessedMousePos()


    if holding then
        SendScriptEvent("SpawnObject", tostring(pos.x) .. "," .. tostring(pos.y), "script.lua", true)
    end


    local otherPos = {x = 0, y = 0}

    local results = PhysLib:StructureRayCast(otherPos, pos)
    LogValue(results[1])

        for k, v in pairs(results) do
            local pos = Vec3LerpNum(v.nodeA, v.nodeB, v.linkT)
            pos.x = pos[1]
            pos.y = pos[2]
            SpawnCircle(pos, 5, White(), 0.06)
        end
    -- local radius = 250
    -- local result = PhysLib:TerrainCircleCollision(pos.x, pos.y, radius)

    -- SpawnCircle(pos, radius, White(), 0.06)
    -- local secondPos = {x = pos.x + result.normal.x * result.displacement, y = pos.y + result.normal.y * result.displacement}
    -- SpawnCircle(secondPos, radius, Red(), 0.06)
end