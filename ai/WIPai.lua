--- forts API ---
function LogTables(Table,IndentLevel)
    if Table == nil then
        Log("nil")
    else
        IndentLevel = IndentLevel or 1
        local indent = string.rep("    ", IndentLevel)
        local indentinf = string.rep("    ", IndentLevel-1)
        local metatable = getmetatable(Table) --metatables are a lua feature to modify how table behave (mainly operators). Vec3 has one allowing you to use + and * on them like a mathematical vector
        if metatable and metatable.__tostring then --if the table has a built in print method, use it
            Log(indent .. tostring(Table) .. ",")
        else --default print method, same as their format in forts' code
            Log(indentinf .. "{")
            for k,v in pairs(Table) do
                if type(k) == "number" then
                    if type(v) == "table" then
                        LogTables(v,IndentLevel+1)
                    elseif type(v) == "function" then
                        LogFunctionB(v)
                    elseif type(v) == "string" then
                        Log(indent .. '"' .. v .. '",')
                    else
                        Log(indent .. tostring(v) .. ",")
                    end
                else
                    if type(v) == "table" then
                        Log(indent .. tostring(k) .. " = ")
                        LogTables(v,IndentLevel+1)
                    elseif type(v) == "function" then
                        LogFunctionB(v)
                    elseif type(v) == "string" then
                        Log(indent .. tostring(k) .. ' = "' .. v .. '",')
                    else
                        Log(indent .. tostring(k) .. " = " .. tostring(v) .. ",")
                    end
                end
            end
            if IndentLevel > 1 then
                Log(indentinf .. "},")
            else
                Log(indentinf .. "}")
            end
        end
    end
end

----------------------------------------------------------------------------------------------------------------
--Function LogFunction
--If FindFunctionName is present, logs the name of the function (instead of the memory adress)

function LogFunctionB(Func)
    if FindFunctionName and FindFunctionName(Func) then
        Log("function : " .. FindFunctionName(Func))
    else
        Log(tostring(Func))
    end
end

----------------------------------------------------------------------------------------------------------------
--Function BetterLog
--Log the argument in the approriate format. convert it automatically to a string if needed.
--v : variable to log (any type)

function BetterLog(v)
    if type(v) == "table" then
        local metatable = getmetatable(v) --metatables are a lua feature to modify how table behave (mainly operators). Vec3 has one allowing you to use + and * on them like a mathematical vector
        if metatable and metatable.__tostring then --if the table has a built in print method, use it
            Log(tostring(v))
        else
            LogTables(v) --otherwise use the default method of tables
        end
    elseif type(v) == "function" then
        LogFunctionB(v)
    else
        Log(tostring(v))
    end
end
offensivePhase = true -- The difficulty is always enough to enable this
data.UpdatePeriod = 0.2
data.UpdateAfterRebuildDelay = 0.1
data.NonConstructionPeriodStdDev = 1
data.NonConstructionPeriodMean = 1
data.NonConstructionPeriodMin = 1
data.ConstructionPeriodStdDev = 1
data.ConstructionPeriodMean = 2
data.ConstructionPeriodMin = 1
data.NoConstructionPauseFactor = 1.1
data.OffensivePhase = 1
data.AntiAirPeriod = 0.4
data.AntiAirMinTimeToImpact = 1.8
data.AntiAirReactionTimeMin = 0
data.AntiAirReactionTimeMax = 0.05
data.DoorCloseDelayMin = 0
-- data.DoorCloseDelayMax = 0.1
data.DoorCloseDelayMax = 6
data.NoTargetCloseDoorDelay = 0.05
data.GroupDoorOpenDelay = 0.05
data.MissileDoorFireDelay = 0.05
data.RepairPeriod = 1
data.ReplaceDeviceDelayMin = 0
data.ReplaceDeviceDelayMax = 0.1
data.MissileAimingDelay = 0
data.FireStdDevDefault = 0
data.DisableFrustration = true

-- to make balance functions from base ai.lua pick the highest value even if players forgot to set AI to hard in lobby screen
difficulty = 1

data.ProjectileHitpoints["rocketemp"] = 0
data.ProjectileHitpoints["rocket"] = 0
data.ProjectileHitpoints["firebeam"] = 450
data.ProjectileHitpoints["buzzsaw"] = 40*19
data.ProjectileHitpoints["shotgun"] = 160

data.AntiAirLateralStdDev =
{
	[PROJECTILE_TYPE_BULLET] = 5,
	[PROJECTILE_TYPE_MORTAR] = 15,
	[PROJECTILE_TYPE_MISSILE] = 5,
}
--[[
Log("WeaponFiresLobbedProjectile")
BetterLog(WeaponFiresLobbedProjectile)
Log("IsHeavyWeapon")
BetterLog(IsHeavyWeapon)
Log("WeaponFiresIndirect")
BetterLog(WeaponFiresIndirect)
Log("FireDuringRebuildProbability")
BetterLog(data.FireDuringRebuildProbability)
Log("AntiAirMinTimeToImpact")
BetterLog(AntiAirMinTimeToImpact)
Log("OffensiveFireProbability")
BetterLog(data.OffensiveFireProbability)
Log("IgnoreProtectionProbability")
BetterLog(data.IgnoreProtectionProbability)
Log("FireErrorStdDev")
BetterLog(FireErrorStdDev )
Log("AntiAirErrorStdDev")
BetterLog(data.AntiAirErrorStdDev )
Log("AntiAirPower")
BetterLog(data.AntiAirPower )
Log("AntiAirOpenDoor")
BetterLog(data.AntiAirOpenDoor )
Log("AntiAirInclude")
BetterLog(data.AntiAirInclude )
Log("AntiAirExclude")
BetterLog(data.AntiAirExclude)
Log("AntiAirFiresAtVirtualWithin")
BetterLog(data.AntiAirFiresAtVirtualWithin)
Log("AntiAirLateralStdDev")
BetterLog(data.AntiAirLateralStdDev)

-- identifies the weapon as able to shoot down projectiles
-- i.e. if absent the weapon will never be used for anti-air
Log("AntiAirFireProbability")
BetterLog(data.AntiAirFireProbability)

-- AI will not fire if projectile arrives at less than this time
Log("AntiAirFireLeadTimeMin")
BetterLog(AntiAirFireLeadTimeMin)
Log("AntiAirFireLeadTimeMax")
-- AI will not fire if projectile arrives longer than this time
BetterLog(AntiAirFireLeadTimeMax)

-- defaults to actual speed if not present
Log("AntiAirFireSpeed")
BetterLog(AntiAirFireSpeed)
Log("AntiAirMinTimeToImpact")
-- AI will consider itself in danger if in trajectory and time is less than this
BetterLog(AntiAirMinTimeToImpact)


-- Additional time added to AntiAirFireLeadTimeMin and AntiAirFireLeadTimeMax if a door is in the way
--AntiAirDoorDelay = 1
Log("AntiAirClaimsProjectile")
-- Weapons listed here will prevent other anti-air weapons firing at a projectile when they fire
-- to spread anti-air more efficiently over a greater number of projectiles
BetterLog(AntiAirClaimsProjectile)
Log("FireWeaponFunction")
BetterLog(FireWeaponFunction)
]]

-- Stop AI from favoring turbines
for i, v in ipairs(SmallArmsPriorities) do
	if v == "turbine" or v == "turbine2" then
		table.remove(SmallArmsPriorities, i)
	end
end


data.ProjectileSplash =
{
	["mortar"] = 120,
	["mortar2"] = 130,
	["missile2"] = 350,
	["missile2inv"] = 350,
	["cannon"] = 200/2,
	["firebeam"] = 160,
	["rocketemp"] = 150+50+20,
	["rocket"] = 200-50,
	["cannon20mm"] = 100-30,
	["howitzer"] = 250-50,
	["buzzsaw"] = 50,
}

data.GroundDevices =
{
	["mine"] = -50,
	["mine2"] = -50,
	["missile"] = -50,
	["missile2"] = -50,
	["missileinv"] = 50,
	["missile2inv"] = 50,
}

data.ShieldExclusions =
{
	["sniper"] = true,
	["buzzsaw"] = true,
	["machinegun"] = true,
	["minigun"] = true,
	["flak"] = true,
	["cannon20mm"] = true,
	["laser"] = true,
	["firebeam"] = true,
	["magnabeam"] = true,
}

data.MetalExclusions =
{
	["machinegun"] = true,
	["flak"] = true,
	["buzzsaw"] = true,
}

data.IgnoreProtectionProbability["rocket"] = 0.2
--[[data.IgnoreProtectionProbability["howitzer"] = 0.1 -- 0otherwise		TOADD TO BASE MOD
data.AntiAirLateralStdDev =
{
	[PROJECTILE_TYPE_BULLET] = 10,
	[PROJECTILE_TYPE_MORTAR] = 40,
	[PROJECTILE_TYPE_MISSILE] = 10,
}]]
-- make snipers fire more often
data.OffensiveFireProbability["sniper"] = 1


for k, v in pairs(FireErrorStdDev) do
	FireErrorStdDev[k] = 0
end

for k, v in pairs(data.AntiAirErrorStdDev) do
	data.AntiAirErrorStdDev[k] = 0
end

for k, v in pairs(data.AntiAirFireProbability) do
	data.AntiAirFireProbability[k] = 1
end

for k, v in pairs(data.FireDuringRebuildProbability) do
	data.FireDuringRebuildProbability[k] = 1-((1-v)*0.7)
end

-- Stop AI from favoring turbines
for i, v in ipairs(SmallArmsPriorities) do
	if v == "turbine" or v == "turbine2" then
		table.remove(SmallArmsPriorities, i)
	end
end

function TryCloseWeaponDoorsWithDelay(id)
	ScheduleCall(0, TryCloseWeaponDoors, id) -- 1 frame delay
end

function TryCloseWeaponDoors(id)
   Log("tcwd")
   Log(""..id)
	--LogDetail("TryCloseWeaponDoors of " .. id)
	local spotterInUse = data.SpotterInUse[id]
	local missileLaunching = data.MissileLaunching[id]
	local available = IsAIDeviceAvailable(id)
	if not spotterInUse and not missileLaunching and available then
		local fireTime = GetWeaponFiringTimeRemaining(id)
		if fireTime < 0.2 then -- TODO: check if this causes lasers to be bad
			CloseWeaponDoors(id)
		else
			ScheduleCall(fireTime, TryCloseWeaponDoors, id)
		end
	end
end
-------------------------------------------------------
-- BEGIN fixes by @alexd26 (Discord ID:526090170521616384) --
-------------------------------------------------------
-- AI not repairing fix
data.RepairDamageThresholdNormal = 1
data.RepairDamageThresholdRebuilding = 1

-- structure HP lookup table
data.StructureHPList = {bracing = 150, backbracing = 100, armour = 400, door = 400, shield = 1000}

-- custom RAY_HIT return types:
data.RAY_HIT_OBSTRUCTED = 69420

ShowObstructionRays = true
-- This is for canAfford, therefor lasers will be able to fire a bit before they are full
WeaponFireCosts =
{
	["machinegun"] = Value(0,30),
	["minigun"] = Value(20,300),
	["sniper"] = Value(0,30),
	["sniper2"] = Value(3,200),
	["mortar"] = Value(3,150),
	["mortar2"] = Value(15,400),
	["buzzsaw"] = Value(0,1200),
	["missile"] = Value(40,1800),
	["missile2"] = Value(50,4000),
	["missileinv"] = Value(40,1800),
	["missile2inv"] = Value(50,4000),
	["smokebomb"] = Value(30,300),
	["flak"] = Value(30,300),
	["shotgun"] = Value(15,800),
	["rocketemp"] = Value(20,800),
	["rocket"] = Value(30,1200),
	["cannon20mm"] = Value(40,2000),
	["cannon"] = Value(75,3000),
	["howitzer"] = Value(70,4000),
	["firebeam"] = Value(0,3000*0.6), -- 800 per second
	["magnabeam"] = Value(0,5000*0.4), --428.5 per second
	["laser"] = Value(0,5000*0.8), --3333.33 per second
}
--[[weaponnames =  
{
"machinegun",
"minigun",
"sniper",
"sniper2",
"mortar",
"mortar2",
"missile",
"missile2",
"missileinv",
"missile2inv",
"cannon",
"laser",
"flak",
"shotgun",
"rocketemp",
"rocket",
"firebeam",
"cannon20mm",
"buzzsaw",
"howitzer",
"smoke",
"magnabeam",
"smokebomb",
}]]
AllTypesOfDevicesAndWeapons = {
	"machinegun",
	"minigun",
	"sniper",
	"sniper2",
	"mortar",
	"mortar2",
	"missile",
	"missile2",
	"missileinv",
	"missile2inv",
	"cannon",
	"laser",
	"flak",
	"shotgun",
	"rocketemp",
	"rocket",
	"firebeam",
	"cannon20mm",
	"buzzsaw",
	"howitzer",
	"magnabeam",
	"smokebomb",
	"munitions",	
	"factory",
	"upgrade",
	"workshop",
	"armoury", 
	"barrel",
	"battery", 
	"mine2",
	"mine",
	"turbine2",
	"turbine",
	"store",
	"repairstation",
   "sandbags",
   "reactor",
}
--[[function Load()
	--Log("m")
	local count =GetWeaponCountSide(2)
	Log("r")
	for i=0,count-1 do
		local id = GetWeaponIdSide(2, i)
		local savename = GetDeviceType(id)
		local cost = GetWeaponFireCost(id)
		Log('[\"'..savename..'\"] = Value('..cost.metal..","..cost.energy..")")
	end
	Log("e")]]
	--[[for i=1,#weaponnames do
		cost = GetWeaponFireCost(weaponnames[i])
		Log('[\"'..weaponnames[i]..'\"] = Value('..cost.metal..","..cost.energy..")")
	end]]
--end


function LogLower(x)
	BetterLog(x)
end
function LogMid(x)
	BetterLog(x)
end
function LogHigh(x)
	BetterLog(x)
end
function LogHighest(x)
	BetterLog(x)
end

function Load(gameStart)
   GameStarted = true
   
   if teamId%MAX_SIDES == 1 then
		enemyTeamId = 2
	else
		enemyTeamId = 1
	end

   FindStartingEnemyDevices()
   FindStartingTeamWeapon()
	local debugLevel = GetConstant("AI.DebugLevel")
	if debugLevel >= LOG_CONFIG and GetGameMode() ~= "Multiplayer" then
		UpdateLogLevel(debugLevel)
		Log("Load AI Team " .. teamId .. ", difficulty = " .. difficulty)
	end

	if AILogLevel >= LOG_ENUMERATION and Fort then
		LogDetail("Initial Fort table")
		for k,action in ipairs(Fort) do
			LogAction(k, action)
		end
	end

	if Fort then
		local extraLine = 0
		if FortTeam then
			extraLine = 1
		end

		-- remember the file lines from which the raw actions came from
		-- this is to allow interruption and partial re-recording of AI forts
		for k,action in ipairs(Fort) do
			-- this offset must correspond to the lines added at the start of an AI fort script
			-- in CommandInterpreter::StartRecordingFort
			action.Line = k + 10 + extraLine

			if false and k > 2 then
				local actionCreateB = Fort[k - 1]
				local actionCreateA = Fort[k - 2]

				if action.Type == CREATE_LINK
					and actionCreateB.Type == CREATE_NODE
					and actionCreateA.Type == CREATE_NODE then

					if action.OriginalNodeAId == actionCreateB.OriginalNodeAId and action.OriginalNodeBId == actionCreateA.OriginalNodeBId then
						LogEnum("Swapping extrusion order at line " .. action.Line)

						Fort[k - 1] = action
						Fort[k] = actionCreateB
					end
				end	
			end				
		end
	end

	data.fortIndex = 1
	data.OriginalToActual = {}
	data.ExpectedNodeDestroy = {}
	data.ExpectedLinkDestroy = {}
	data.DisabledStructure = {}

	data.currWeapon = 0
	data.NextAntiAirIndex = 0
	data.activeBuilding = true
	data.NewNodes = {}
	data.DynamicNodePos = {} -- shifted from original position to fit the terrain (e.g. rope tie downs), key is original node id
	data.DeviceDeleteToRebuild = {} -- when deleting a device to rebuild some structure, to queue the rebuild on delete
	data.Frustration = {}
	data.offenceBucket = 0 -- tracks the opportunities for offence
	data.offencePoints = 100000000 -- shooting weapons require these points so mission scripts can throttle or gate offence
	data.maxGroupSize = 5

	DiscoverOriginalNodes()

	DiscoverUnknownDeviceTargets(SmallArmsPriorities, SmallArmsPrioritiesExclude, "SmallArmsPriorities")
	DiscoverUnknownDeviceTargets(HeavyArmsPriorities, HeavyArmsPrioritiesExclude, "HeavyArmsPriorities")

	if data.FortHasFoundations then
		data.ConstructionErrorToleranceMin = 30
		data.ConstructionErrorToleranceMax = 70
		data.ConstructionErrorToleranceRate = 4
	end

	-- prevent teams executing in the same frame
	-- to avoid CPU usage spikes
	local offset = 0
	if teamId%MAX_SIDES == 2 then
		offset = 0.7
	end
	local fortId = math.floor(teamId/MAX_SIDES)
	offset = offset + 2.3*fortId/4

	ScheduleCall(2 + offset, UpdateAI)
	ScheduleCall(1.5 + offset, TryShootDownProjectiles)
	if not data.HumanAssist then
		ScheduleCall(7 + offset, Repair)
		ScheduleCall(30 + offset, DecayFrustration)
	end
	
	GetAttackHintsFromProps(teamId%MAX_SIDES)
end

function FindStartingEnemyDevices()
   --local sideDevices = {}
   local deviceCount = GetDeviceCountSide(enemyTeamId)
   for index = 0,deviceCount - 1 do
      local id = GetDeviceIdSide(enemyTeamId, index)
      local saveName = GetDeviceType(id)
      --[[if sideDevices[saveName] == nil then
         sideDevices[saveName] = {}
      end]]
      --table.insert(sideDevices[saveName], id)
      Log("On team: "..enemyTeamId.." Adding: "..saveName.." "..id)
      table.insert(data.DevicesOnEnemyTeam[saveName], id)
   end
end

function FindStartingTeamWeapon()
   --local sideDevices = {}
   local deviceCount = GetDeviceCount(teamId)
   for index = 0,deviceCount - 1 do
      local id = GetDeviceId(teamId, index)
      local saveName = GetDeviceType(id)
      --[[if sideDevices[saveName] == nil then
         sideDevices[saveName] = {}
      end]]
      --table.insert(sideDevices[saveName], id)
      if IsWeapon(id) then
         Log("On team: "..enemyTeamId.." Adding: "..saveName.." "..id)
         table.insert(data.TeamWeapons, {id = id, saveName = saveName, isAvailable = true})
      end
   end
end

data.TeamWeapons = {}

data.DevicesOnEnemyTeam = {}

for i=1,#AllTypesOfDevicesAndWeapons do
	data.DevicesOnEnemyTeam[AllTypesOfDevicesAndWeapons[i]] = {}
end

EnableHumanAssist = function() end

function AddDeviceToEnemySide(Id,saveName)
   --Log("AI team: "..teamId.."Enemy: "..enemyTeamId.." "..Id.." "..saveName)
   Log("Add, Enemy: "..enemyTeamId.." "..Id.." "..saveName)
	if data.DevicesOnEnemyTeam[saveName][Id] then Log("THIS DEVICE ALREADY EXISTS?")return else data.DevicesOnEnemyTeam[saveName][Id] = Id end
end

function RemoveDeviceFromEnemySide(Id,saveName)
   --Log("AI team: "..teamId.."Enemy: "..enemyTeamId.." "..Id.." "..saveName)
   Log("Remove, Enemy: "..enemyTeamId.." "..Id.." "..saveName)
   if data.DevicesOnEnemyTeam[saveName][Id] then data.DevicesOnEnemyTeam[saveName][Id] = nil return end
end

function AddDeviceToTeamWeapons(Id,saveName)
   --Log("AI team: "..teamId.."Enemy: "..enemyTeamId.." "..Id.." "..saveName)
   if IsWeapon(Id) then
      Log("Add, Enemy: "..enemyTeamId.." "..Id.." "..saveName)
      if data.TeamWeapons[Id] then Log("THIS DEVICE ALREADY EXISTS?")return else data.TeamWeapons[Id] = Id end
   end
end

function RemoveDeviceFromTeamWeapons(Id,saveName)
   --Log("AI team: "..teamId.."Enemy: "..enemyTeamId.." "..Id.." "..saveName)
   Log("Remove, Enemy: "..enemyTeamId.." "..Id.." "..saveName)
   if data.TeamWeapons[Id] then data.DevicesOnEnemyTeam[Id] = nil return end
end


function OnDeviceTeamUpdated(oldTeamId, newTeamId, deviceId, saveName) -- This is run before game start due to structures not actually owning/parenting ground devices, use GameStarted to ignore these calls
   if not GameStarted then Log("ignoring device due to being called before Load: "..saveName) return end
	Log(saveName.." "..deviceId)
	if newTeamId%100 == enemyTeamId then
		AddDeviceToEnemySide(deviceId,saveName)
	elseif oldTeamId%100 == enemyTeamId then
		RemoveDeviceFromEnemySide(deviceId,saveName)
	end
   if newTeamId%100 == teamId then 
      AddDeviceToTeamWeapons(deviceId,saveName)
	elseif oldTeamId%100 == teamId then
		RemoveDeviceFromTeamWeapons(deviceId,saveName)
	end
end

function OnDeviceCompleted(ODCteamId, deviceId, saveName)
   Log(""..saveName)
   if ODCteamId == teamId then
      AddDeviceToTeamWeapons(ODCteamId,saveName)
   end
end

function OnDeviceCreated(deviceTeamId, deviceId, saveName, nodeA, nodeB, t, upgradedId)
	Log("d"..deviceId)
	if deviceTeamId%100 == enemyTeamId then
		AddDeviceToEnemySide(deviceId,saveName)
	end
	if data.gameEnded or data.HumanAssist then return end

	if deviceTeamId == teamId and saveName == "barreltemp" then
		ScheduleCall(Balance(6, 1), DestroyBarrel, nodeA, nodeB)
	end
end

function OnGroundDeviceCreated(teamId, deviceId, saveName, pos, upgradedId)
	Log("gd"..deviceId)
	if teamId%100 == enemyTeamId then
		AddDeviceToEnemySide(deviceId,saveName)
	end
end


function OnDeviceDeleted(deviceTeamId, deviceId, saveName, nodeA, nodeB, t)
   Log("deleted"..deviceId..saveName)
	if deviceTeamId%100 == enemyTeamId then
		RemoveDeviceFromEnemySide(deviceId,saveName)
	end
   if deviceTeamId == teamId then
      RemoveDeviceFromTeamWeapons(deviceTeamId,saveName)
   end
	if OnDeviceDestroyed and data.DeviceDeleteToRebuild[deviceId] then
		OnDeviceDestroyed(deviceTeamId, deviceId, saveName, nodeA, nodeB, t,true)
	end
end

function OnDeviceDestroyed(deviceTeamId, deviceId, saveName, nodeA, nodeB, t,CalledRecursively)
   if not CalledRecursively then
      Log("destroyed"..deviceId..saveName)
      --BetterLog(data.DevicesOnEnemyTeam)
      if deviceTeamId%100 == enemyTeamId then
         RemoveDeviceFromEnemySide(deviceId,saveName)
      end
      if deviceTeamId == teamId then
         RemoveDeviceFromTeamWeapons(deviceTeamId,saveName)
      end
   end
	CheckDeviceForRebuild(deviceId, saveName, nodeA, nodeB)
	data.ActionQueue[deviceId] = nil
end
WeaponRetargetsWhileOpeningDoorsChance =
{
	["machinegun"]=	0.3,
	["minigun"] =	0.7,
	["sniper"] =	0.95,
	["sniper2"] =	0.2,
	["mortar"] =	0.3,
	["mortar2"] = 	0.3,
	["buzzsaw"] =	0.4,
	["missile"] =	0.3,
	["missile2"] = 	0.3,
	["missileinv"]=	0.3,
	["missile2inv"]=0.3,
	["smokebomb"] = 0.2,
	["flak"] = 		1, -- this should never be used...
	["shotgun"] = 	0.7,
	["rocketemp"] = 0.5,
	["rocket"] = 	0.5,
	["cannon20mm"]=	0.7,
	["cannon"] = 	0.8,
	["howitzer"] = 	0.8,
	["firebeam"] = 	1,
	["magnabeam"] = 1,
	["laser"] = 	0.7,
}
function FireAllAvailableWeaponsLoop()
   --BetterLog(data.TeamWeapons)
	for key, WeaponTable in pairs(data.TeamWeapons) do
		if WeaponTable.isAvailable then
         Log("Loop: "..WeaponTable.saveName)
			local RandomFloat = GetRandomFloat(0,1, "FireAllAvailableWeaponsLoop " .. WeaponTable.id)
			if not data.ResourceStarved then
				TryFireWeapon(WeaponTable,false,RandomFloat)
			else
				local type = GetDeviceType(WeaponTable.id)
				local probability = data.StarvedProbabilityFactor*(data.FireDuringRebuildProbability[type] or 0)
				if RandomFloat > probability then
					local context = "starvation"
					LogLower("Avoiding fire of " .. type .. " during " .. context .. ", probability " .. probability)
					--return false
				else
					TryFireWeapon(WeaponTable,false,RandomFloat)
				end
			end
		end
		--if IsDeviceAvailable(WeaponTable.id) then
	end
end

function UpdateWeaponAvaliblity(id)-- due to emp I think IsWeaponReadyToFire needs to just be in the fire code
--IsDeviceAvailable No human to be an issue
--IsWeaponReadyToFire
--OnRepair, get hp
--onemp get emp
end
function UpdateAllWeaponsAvaliblity()
	--for key, value in pairs(data.WeaponsOwnedByThisAI) do --WeaponsOwnedByThisAI, not decoy
		
	--end
end

function TryFireWeapon(WeaponTable,doorcall,RandomFloat)
	if data.gameEnded then
		return
	end
	local id = WeaponTable.id
	
	if not DeviceExists(id) then
		LogHighest("TryFireWeapon device no longer exists")
		return
	end

	local type = WeaponTable.saveName

		--for i = 1, ScheduledCallCountOfFunc(TryFireGun) do
		--	local attemptedGroup = GetScheduledCallOfFuncParam(TryFireGun, 1, 2)

	local probability = data.OffensiveFireProbability[type]
	--LogMid("TryFireWeapon " .. type .. ": probability " .. tostring(probability).. "Roll: "..RandomFloat%0.01*100+0.01 .." "..id.." "..type)

	-- don't use defensive weapons for offence
	if probability and RandomFloat%0.01*100+0.01 > probability then
		LogLower("Aborting fire due to random chance")
		return
	end
	-- don't try to use weapons painting a target for other weapons
	-- or it's being used by a human player or reloading
	if IsSpotter(type, teamId) and (IsWeaponSpotting(id) or data.SpotterInUse[id]) then
		LogLower("Weapon not available (spotting)")
		return
	elseif data.MissileLaunching[id] then
		LogLower("Weapon not available (in use)")
		return
	elseif not IsWeaponReadyToFire(id) then
		return
	end
	local teamResources = GetTeamResources(teamId)
	if not CanAfford(teamResources - (WeaponFireCosts[type]--[[ or GetWeaponFireCost(id)]])) then
   LogLower("can't afford to fire weapon: resources = " .. teamResources .. ", cost = " .. WeaponFireCosts[type])
		--TryCloseWeaponGroupDoors(group)
		return
	end

   --BetterLog(WeaponTable)
	local currentTarget = FindPrioritizedTarget(WeaponTable,doorcall,RandomFloat)
	if currentTarget == nil then
		LogHigh("No target")
		if not data.SpotterInUse[id] and not data.MissileLaunching[id] then
			ScheduleCall(data.NoTargetCloseDoorDelay, TryCloseWeaponGroupDoors, nil)
		end
		return
	end
			--PaintTarget(group, currentTarget)

   local doorsObstructing = false
   if not RequiresSpotter(type, teamId) then
      LogLower("Attempting to open group weapon doors " .. id .. " of type " .. type)
      local result = FireWeapon(id, currentTarget, 0, FIREFLAG_TEST | FIREFLAG_FORCEDOORSOPEN | FIREFLAG_EXTRACLEARANCE)
      if result == FIRE_DOOR then
         doorsObstructing = true
      end
   end
   if doorsObstructing then
      LogLower("  Doors obstructing group, opening. leader " .. type)
      ScheduleCall(data.GroupDoorOpenDelay, TryFireWeapon, WeaponTable,doorcall,RandomFloat)
      return   
   end

   if not RequiresSpotter(type, teamId) then
      LogLower("Attempting to fire group weapon " .. id .. " of type " .. type)
      --local result = FireWeapon(gid, currentTarget, data.FireErrorStdDevOverride[type] or FireErrorStdDev[type] or data.FireStdDevDefault, FIREFLAG_EXTRACLEARANCE)
      local result = FireWeaponHandler(id, type, currentTarget, data.FireErrorStdDevOverride[type] or FireErrorStdDev[type] or data.FireStdDevDefault, data.FireWeaponHandlerFireFlags)
      if result == FIRE_SUCCESS then
         LogLower("Fired weapon " .. id .. " of type " .. type)
         -- close door in a little delay
         TryCloseWeaponDoorsWithDelay(id, "TryFireGun 2 door ")
         data.offencePoints = data.offencePoints - 1
      elseif result == FIRE_DOOR then
         LogLower("  Door hit, retry single weapon " .. id)
         -- door will be opening, try again soon
         ScheduleCall(data.GroupDoorOpenDelay, TryFireGun, id)
      else
         LogLower(FIRE[result] .. ": close doors after failure")
         TryCloseWeaponDoorsWithDelay(id, "TryFireGun 3 door ")
      end
   end
   -- remaining members require painting
   --[[if #group > 0 then
      PaintTarget(group, currentTarget)
   end]]
end

function FindPrioritizedTarget(WeaponTable,doorcall,RandomFloat) -- door call can be in curr target?
	local weaponName = WeaponTable.saveName
	if not priorities[weaponName] then Log("Weapon \"" .. weaponName .. "\" has no target priority list. Aborting fire.") return end

	local MaxPriority = 0
	local bestTarget = Vec3()
	local hitpoints = data.ProjectileHitpoints[weaponName]

	local ignoreProtectionProb = data.IgnoreProtectionProbability[weaponType]
	apple = RandomFloat%0.000001*1000000+0.01
	Log("ignoreprot "..apple)
	if ignoreProtectionProb ~= nil and GetRandomFloat(0, 1, "FindPriorityTarget IP " .. WeaponTable.id) <= ignoreProtectionProb then
		LogLower("  Ignoring protection")
		hitpoints = 100000000
	end

	for k=1,#priorities[weaponName] do
		if priorities[weaponName][k][2] < 0 then --[[goto]] continue end -- don't cast ray if direct hit has negative priority
		if MaxPriority > priorities[weaponName][k][2] and MaxPriority > priorities[weaponName][k][3] then break end
		for i=1,#data.DevicesOnEnemyTeam[priorities[weaponName][k][1]] do
			-- Get obstructed w priorities[WeaponTable.saveName][k][2] and priorities[WeaponTable.saveName][k][3]
			-- Max Priority = obs return 1
			-- Target - obs return 2
			local target = data.DevicesOnEnemyTeam[priorities[weaponName][k][1]][i]
			local targetPos = GetDeviceCentrePosition(target)
			local targetPriority = 0
			-- IsTargetObstructed(<weaponId>, <weaponName>, <position of target>, <hitpoints>)
			-- dmgDealt is 100% - HP left of target after hitting (only relevant when splash damage is dealt)
			local targetObstructed, dmgDealt = IsTargetObstructed(WeaponTable.id, weaponName, targetPos, hitpoints)
			
			if not targetObstructed then
				if dmgDealt then
					targetPriority = priorities[weaponName][k][3] * dmgDealt
				else
					targetPriority = priorities[weaponName][k][2]
				end
				if MaxPriority < targetPriority then
					MaxPriority = targetPriority
					bestTarget = targetPos
				end
			end
		end
		--::continue::
	end

	return bestTarget
	--[[for key, value in pairs(data.DevicesOnEnemyTeam.Cores) do -- If a weapon has a shot on a enemy core then take it.
		--FireRay
	end]]
	--[[if WeaponTable.currentTarget then -- if there is a target from a previous shot, interation of this function or if another weapon is requesting fire to a target then use it as the target
		if not doorcall then
			return WeaponTable.currentTarget
		else
			if WeaponRetargetsWhileOpeningDoorsChance[WeaponTable.saveName] < RandomFloat%0.0001*10000+0.01 then
				return WeaponTable.currentTarget -- TODO: make sure to add a check for this table to see if the typing is still valid (exposed weapon is still an exposed weapon.)
			end
		end
	end 
	TargetRandom = RandomFloat%0.000001*1000000+0.01
	if WeaponPriorities[WeaponTable.saveName].ExposedWeapons > TargetRandom then
		for key, value in pairs(data.DevicesOnEnemyTeam.Weapons) do -- If a weapon has a shot on a enemy core then take it.
			--FireRay
			-- if no valid target then continue, else return the target of most value + randomseed
		end
	end]]
end
--[[WeaponPriorities =
{
	["sniper"] = {ExposedWeapons = 0.9,ExposedDevices = 0.99,SplashibleWeapons = 1.1,SplashibleDevices = 1.1,CoveredWeapons = 1,CoveredDevices = 1.1,Structure = 1.1}
}]]

-- returns:
-- boolean isTargetObstructed (If true, the other 2 return values might be undefined)
-- boolean splashRequired to hit
-- float dmgDealt if splashRequired (formula: 1 - distanceToTarget/SplashRadius)
function IsTargetObstructed(weaponId, weaponType, pos, hitpoints)
	--Log("weaponId: " .. weaponId .. ", weaponType: " .. weaponType .. ", line of sight: " .. tostring(needLineOfSight) .. ", line to structure: " .. tostring(needLineToStructure))
	
	
	-- Ray casting fix by @cronkhinator (Discord ID: 165842061055098880)
	-- Makes AI fire much more consistently
	-- Also makes tiny doored weapons functional
	-- VERY high computational cost, will fix when CastRay supports more ray flags


	-- these flags might work eventually, but are not supported by CastRay (except for Debug rays)
	local rayFlags = RAY_EXCLUDE_CONSTRUCTION | RAY_ALLIED_BG_BLOCKS | RAY_EXCLUDE_DYNAMIC_TERRAIN
	if data.TargetingIgnoreNeutral then rayFlags = rayFlags | RAY_EXCLUDE_NEUTRAL end
	if data.TargetingNeutralBlocks then rayFlags = rayFlags | RAY_NEUTRAL_BLOCKS end

	-- first check if angle to shoot is blocked by friendly structure:

	if not AimWeapon(weaponId, pos) then
		LogDetail("  No firing solution")
		return true
	end
	
	local hardPointPos = GetWeaponHardpointPosition(weaponId)

	-- calculate firing angle
	local alpha = GetDeviceAngle(weaponId)
	local beta = GetAimWeaponAngle()
	local gamma = alpha - math.pi/2
	local delta = gamma + beta

	-- vector in direction of where weapon shoots
	local firingDirection = Vec3()
	firingDirection.x = math.cos(delta) * 250
	firingDirection.y = -math.sin(delta) * 250
	local aimDirection = hardPointPos + firingDirection

	-- check if next 5 tiles inn that direction are free
	local hitType = CastTargetObstructionRayNew(hardPointPos, aimDirection, math.huge, rayFlags, weaponType)
	
	if hitType == data.RAY_HIT_OBSTRUCTED then
		return true
	end
	-- else, can actually fire there

	-- variable "pos" is the position of the chosen target
	if WeaponFiresLobbedProjectile[weaponType] then
		-- Log("Lobbed")
		-- cast a ray back from the target to avoid terrain
		if AimWeapon(weaponId, pos) then
			-- mirror fire angle to get the incoming angle at the target
			-- there will be error due to drag and change in elevation
			local angle = GetAimWeaponAngle()
			angle = math.pi - angle
			local testPos = Vec3()
			testPos.x = pos.x + 1000*math.cos(angle)
			testPos.y = pos.y - 1000*math.sin(angle)
			if CastGroundRay(pos, testPos, TERRAIN_PROJECTILE) == RAY_HIT_TERRAIN then
				LogDetail("  Target obstructed by terrain")
				return true
			end
		else
			LogDetail("  No firing solution")
			return true
		end
	end

	if false then --not needLineOfSight and not needLineToStructure then
		if ShowObstructionRays then SpawnCircle(hardPointPos, 150, Colour(255,255,255,255), 5) end
		return false
	else
		
		if ShowObstructionRays then rayFlags = rayFlags | RAY_DEBUG end

--		local hitType = CastRayFromDevice(weaponId, pos, hitpoints, rayFlags, 0)
--		Log("Casting ray from " .. weaponType .. ", teamId: " .. teamId .. " to " .. GetDeviceType(GetDeviceIdAtPosition(pos)) .. ", pos: " .. pos)

		hitType, dmgDealt = CastTargetObstructionRayNew(hardPointPos, pos, hitpoints, rayFlags, weaponType)

		if hitType == data.RAY_HIT_OBSTRUCTED then return true end -- target obstructed/cannot be reached (projectileHP < 0)

		LogEnum("cast ray " .. RAY_HIT[hitType] .. " team " .. GetRayHitSideId())
		if true then --needLineOfSight then
			if (hitType == RAY_HIT_WEAPON or hitType == RAY_HIT_DEVICE) and GetRayHitSideId()%MAX_SIDES == enemyTeamId and CastGroundRayFromWeapon(weaponId, pos, TERRAIN_PROJECTILE) == 0  then
				return false, dmgDealt
			end
		else
			LogDetail("hitType " .. hitType .. ", hit team " .. GetRayHitSideId())
			if hitType ~= RAY_HIT_TERRAIN and GetRayHitTeamId()%MAX_SIDES == enemyTeamId then
				return false, dmgDealt
			end
		end
	end
	return true
end

function comparePositions(pos1, pos2)
	return (pos1.x == pos2.x and pos1.y == pos2.y)
end

-- custom function by @cronkhinator for TargetObstruction check
-- returns:
-- hitType of ray
-- boolean splashRequired
-- float dmgDealt if splashRequired (formula: 1 - distanceToTarget/SplashRadius)
function CastTargetObstructionRayNew(source, target, hitpoints, rayFlags, weaponType)
	local hitType
	local hitSaveName
	local projectileHP = hitpoints
	-- offset new ray starting position of ray every loop
	local rayVec = target - source
	local length = math.sqrt(rayVec.x^2 + rayVec.y^2)
	-- nrmVec is basically the offset vector to prevent the ray from hitting the same thing twice
	local nrmVec = Vec3()
	nrmVec.x = rayVec.x / length
	nrmVec.y = rayVec.y / length
	nrmVec.z = rayVec.z
	
	local hits = {}
	-- have to offset ray by a bit every time, because CastRay ray collides with literally everything, including friendly doors and background
	repeat
		hitType = CastRay(source, target, rayFlags, 0)

		if hitType == RAY_HIT_NOTHING or hitType == RAY_HIT_TERRAIN then return hitType end


		local hitPos = GetRayHitPosition()
		if hits[hitPos.x .. " " .. hitPos.y] == true then
			-- AI would get stuck in infinite loop
			break
		end
		hits[hitPos.x .. " " .. hitPos.y] = true
		source = hitPos + nrmVec
		hitSaveName = GetRayHitMaterialSaveName()


		if not (GetRayHitTeamId() == teamId and (GetRayHitDoor() or hitSaveName == weaponType) or hitSaveName == "backbracing") then -- ignore friendly doors
			if hitSaveName ~= "backbracing" or (weaponType == "buzzsaw" or weaponType == "howitzer") then -- ignore backbracing unless buzz or howie
				if (GetRayHitSideId()%MAX_SIDES == teamId) then return data.RAY_HIT_OBSTRUCTED end -- projectile path collides with friendly entity			
				-- ray hits (enemy or) structure/device if code makes it to here
				if data.StructureHPList[hitSaveName] ~= nil then
					-- known material
					local nodeIdA = GetRayHitLinkNodeIdA()
					local nodeIdB = GetRayHitLinkNodeIdB()

					--Log("weaponType: " .. weaponType .. ", isInShieldExclusions: " .. tostring(data.ShieldExclusions[weaponType]) .. ", hitpoints: " .. hitpoints)
							
					if hitSaveName == "armour" or (hitSaveName == "door" and data.OpenDoors[nodeIdA .. " " .. nodeIdB] ~= true) and data.MetalExclusions[weaponType] then return data.RAY_HIT_OBSTRUCTED end
					if hitSaveName == "shield" and data.ShieldExclusions[weaponType] then return data.RAY_HIT_OBSTRUCTED end
					
					if (nodeIdA > 0 and nodeIdB > 0) then
						-- don't reduce HP if door is open
						if data.OpenDoors[nodeIdA .. " " .. nodeIdB] ~= true then
							-- GetLinkHealth is the percentage of HP left
							projectileHP = projectileHP - GetLinkHealth(nodeIdA, nodeIdB) * data.StructureHPList[hitSaveName]
							if ShowObstructionRays then SpawnCircle(hitPos, 50, Colour(0, 0, 255, 255), 5) end
						end
					else 
						-- node ids not received for whatever reason
						projectileHP = projectileHP - data.StructureHPList[hitSaveName]
					end
	--					Log(" - " .. nodeIdA .. " " ..nodeIdB .. ", projectileHP: " .. projectileHP .. ", linkHealth " .. GetLinkHealth(nodeIdA, nodeIdB))
				else
					-- unknown material, likely modded (or shield)
				end
			end
		end
--			Log(" - HitPos: " .. GetRayHitPosition() .. ", hitType: " .. hitType .. ", hit: " .. hitSaveName .. ", teamId: " .. GetRayHitTeamId() .. ", projectileHP: " .. projectileHP)
		local reachedTarget = comparePositions(hitPos, target)
	until (reachedTarget or projectileHP < 0)


	if projectileHP < 0 then
		if data.ProjectileSplash[weaponType] then
			local distance = Vec3Length(target - GetRayHitPosition())
			if ShowObstructionRays then SpawnCircle(GetRayHitPosition(), data.ProjectileSplash[weaponType], Red(92), 5) end
			local dmgDealt = 1 - distance / data.ProjectileSplash[weaponType]
			if dmgDealt > 0 then return RAY_HIT_WEAPON, dmgDealt end
		end

		return data.RAY_HIT_OBSTRUCTED
	end

	return hitType, false
end

function UpdateAI()
	if data.gameEnded or data.defeated then return end

--	UpdateLogLevel(LOG_DETAIL)

--	Log(data.gameFrame .. " data.offencePoints " .. data.offencePoints)
--	Log("UpdateAI " .. data.gameFrame .. ", Disable " .. tostring(data.Disable))

	-- TODO: wait for best time to activate with a hint from the commander script
	--[[local teamCommanderPoints = GetTeamCommanderPoints(teamId)
	if not data.DisableCommander and teamCommanderPoints == 1 and not IsHumanOnSide(teamId) and data.gameTime >= 4*60 then
		ActivateCommander(teamId)
	end]]

	local teamResources = GetTeamResources(teamId)
	--local offensivePhase = not data.BuildOnly and difficulty >= data.HardThreshold or TableLength(data.ActionQueue) > 0

	-- find nodes that have moved significantly from their expected positions
	local deformedNodes = FindDeformedNodes()

	-- AI toggles between pause (data.resumeTime is set) and construction (data.pauseTime is set)
	-- within pause it will spend some proportion of time on offense (data.OffensivePhase by default)
	-- if there's no construction left it will spend more time on offense
	-- if there are deformed nodes offense is avoided and construction suspended
	--[[if not offensivePhase and #deformedNodes == 0 and not data.BuildOnly then
		local noConstruction = (data.fortIndex >= #Fort and data.activeBuilding)
		local offensiveProportion = data.OffensivePhase
		if noConstruction then
			LogDetail("no construction: reducing idle phase")
			offensiveProportion = data.OffensivePhaseHard
		end
		if data.resumeTime then
			local timeLeft = data.resumeTime - data.gameTime
			local proportionLeft = timeLeft/data.pausePeriod
			offensivePhase = proportionLeft < offensiveProportion
			if offensivePhase then
				LogDetail("offensive phase")
			else
				LogDetail("waiting for offensive phase")
			end
		end
	end]]

	-- delete deformed nodes progressively
	ProcessDeformedNodes(deformedNodes)
   FireAllAvailableWeaponsLoop()
	-- only shoot while construction is paused or the difficulty level is extreme
	--if offensivePhase and not data.Disable and not data.DisableOffence then
		--[[local weaponCount = GetWeaponCount(teamId)
		local attemptCount = 0
		if weaponCount > 0 then
			local done = false
			local firstIndex = data.currWeapon
			repeat
				if data.currWeapon < weaponCount then
					if UpdateWeapon(data.currWeapon, not data.activeBuilding) then
						done = true
					end
					
					data.currWeapon = data.currWeapon + 1
					if data.currWeapon == weaponCount then
						data.currWeapon = 0
					end
				else
					data.currWeapon = 0
				end
				attemptCount = attemptCount + 1
				if data.currWeapon == firstIndex or attemptCount >= weaponCount then
					done = true -- prevent continuous cycle on unready weapons
				end
			until done
		end==
		--LogEnum("Offence bucket = " .. data.offenceBucket)
	--end]]
	--for key, value in pairs(data.WeaponsOwnedByThisAI) do
			
	--end

	data.activeBuilding = false

	-- Attempt to rebuild parts of the fort that have been lost
	if Fort and not data.Disable and not data.DisableRebuild and #deformedNodes == 0 then
		for k,action in ipairs(Fort) do
			if data.Rebuild[k] then
				LogDetail("Rebuild action[" .. k .. "] = " .. ACTION[action.Type])
				local result, skipAction = ExecuteFortAction(action, k)
				if result then
					data.Rebuild[k] = nil
					ResetFrustration(k)
					if not skipAction then
						LogDetail("Rebuild succeeded")
						ScheduleCall(data.UpdateAfterRebuildDelay, UpdateAI)
						return
					else
						LogDetail("Rebuild succeeded and skipped")
					end
				else
					LogError("Rebuild action " .. k .. " failed")
					if not skipAction then
						--LogOriginalToActual()
						--ScheduleCall(3 - 2*difficulty, UpdateAI)
						--return
						LogDetail("Rebuild no skip")
						ScheduleCall(data.UpdateAfterRebuildDelay, UpdateAI)
						return
					else
						LogDetail("Rebuild skipped")
					end
				end
			end
		end
	end

	--LogDetail("data.fortIndex = " .. data.fortIndex .. "/" .. #Fort)

	-- if execution gets to here there may be some frustrated rebuild actions
	-- but normal building can proceed while waiting for those to correct (or not)
	data.activeBuilding = true

	--LogEnum("gameTime " .. data.gameTime .. " pauseTime " .. (data.pauseTime or "nil") .. " resumeTime " .. (data.resumeTime or "nil"))

	-- pause construction periodically to slow the AI down
	local paused = data.Disable
	if not data.pauseTime and not data.HumanAssist and not data.BuildOnly then
		if data.resumeTime == nil or data.gameTime > data.resumeTime then
			-- ready to resume, schedule a new pause time
			data.pausePeriod = nil
			data.resumeTime = nil
			local delay = GetNormalFloat(data.ConstructionPeriodStdDev, data.ConstructionPeriodMean, "UpdateAI construction delay")
			if delay < data.ConstructionPeriodMin then delay = data.ConstructionPeriodMin end
			data.pauseTime = data.gameTime + delay
			LogDetail("Resuming construction: pausing in " .. delay .. " seconds")
		else
			-- wait until we have reached the resume time
			LogEnum("paused: " .. data.resumeTime - data.gameTime .. " seconds to go")
			paused = true
		end
	end

	if not paused and not data.HumanAssist then
		-- build the given fort in sequence
		while Fort and data.fortIndex <= #Fort do
			local action = Fort[data.fortIndex]
			LogEnum("action[" .. data.fortIndex .. "] = " .. ACTION[action.Type])
			local result, skip = ExecuteFortAction(action, data.fortIndex)
			if result then
				ResetFrustration(data.fortIndex)
				data.fortIndex = data.fortIndex + 1
				if not skip then break end
			elseif IsFrustrated(data.fortIndex) then
				LogDetail("Proceeding past frustrated action, rebuild later")
				data.Rebuild[data.fortIndex] = true
				data.fortIndex = data.fortIndex + 1
				if not skip then break end
			else
				break
			end
		end

		-- see if it's time to pause construction, and decide how long for
		-- some of the pause time the AI will use for offense
		if data.pauseTime then
			local newNodeCount = TableLength(data.NewNodes)
		
			if data.gameTime > data.pauseTime and newNodeCount == 0 then
				data.pauseTime = nil
				data.pausePeriod = GetNormalFloat(data.NonConstructionPeriodStdDev, data.NonConstructionPeriodMean, "UpdateAI PausePeriod")
				if data.pausePeriod < data.NonConstructionPeriodMin then data.pausePeriod = data.NonConstructionPeriodMin end
				--[[if data.offenceBucket == 0 then
					-- shorten the construction pause if there aren't many weapons or targets
					data.pausePeriod = 0.1*data.pausePeriod*difficulty + data.pausePeriod*(1 - difficulty)
				end]]
				if data.fortIndex >= #Fort and data.activeBuilding then
					LogDetail("No construction, increasing pause period")
					data.pausePeriod = data.NoConstructionPauseFactor*data.pausePeriod
				end
				data.resumeTime = data.gameTime + data.pausePeriod
				LogDetail("Pausing construction. Resuming in " .. data.pausePeriod .. " seconds.")
			else
				LogEnum("executing: pause in " .. data.pauseTime - data.gameTime .. " seconds")
			end
		end
	end

	ScheduleCall(data.UpdatePeriod, UpdateAI)
end
-- Back turbine targeting fix
--[[
function TargetObstructed(weaponId, weaponType, pos, hitpoints, needLineOfSight, needLineToStructure)
	--Log("weaponId: " .. weaponId .. ", weaponType: " .. weaponType .. ", line of sight: " .. tostring(needLineOfSight) .. ", line to structure: " .. tostring(needLineToStructure))
	
	
	-- Ray casting fix by @cronkhinator (Discord ID: 165842061055098880)
	-- Makes AI fire much more consistently
	-- Also makes tiny doored weapons functional
	-- VERY high computational cost, will fix when CastRay supports more ray flags


	-- these flags might work eventually, but are not supported by CastRay (except for Debug rays)
	local rayFlags = RAY_EXCLUDE_CONSTRUCTION | RAY_ALLIED_BG_BLOCKS | RAY_EXCLUDE_DYNAMIC_TERRAIN
	if data.TargetingIgnoreNeutral then rayFlags = rayFlags | RAY_EXCLUDE_NEUTRAL end
	if data.TargetingNeutralBlocks then rayFlags = rayFlags | RAY_NEUTRAL_BLOCKS end

	-- first check if angle to shoot is blocked by friendly structure:

	if not AimWeapon(weaponId, pos) then
		LogDetail("  No firing solution")
		return true
	end
	
	local hardPointPos = GetWeaponHardpointPosition(weaponId)

	-- calculate firing angle
	local alpha = GetDeviceAngle(weaponId)
	local beta = GetAimWeaponAngle()
	local gamma = alpha - math.pi/2
	local delta = gamma + beta

	-- vector in direction of where weapon shoots
	local firingDirection = Vec3()
	firingDirection.x = math.cos(delta) * 250
	firingDirection.y = -math.sin(delta) * 250
	local aimDirection = hardPointPos + firingDirection

	-- check if next 5 tiles inn that direction are free
	local hitType = CastTargetObstructionRay(hardPointPos, aimDirection, math.huge, rayFlags, weaponType)
	
	if hitType == data.RAY_HIT_OBSTRUCTED then
		return true
	end
	-- else, can actually fire there

	-- variable "pos" is the position of the chosen target
	if WeaponFiresLobbedProjectile[weaponType] then
		-- Log("Lobbed")
		-- cast a ray back from the target to avoid terrain
		if AimWeapon(weaponId, pos) then
			-- mirror fire angle to get the incoming angle at the target
			-- there will be error due to drag and change in elevation
			local angle = GetAimWeaponAngle()
			angle = math.pi - angle
			local testPos = Vec3()
			testPos.x = pos.x + 1000*math.cos(angle)
			testPos.y = pos.y - 1000*math.sin(angle)
			if CastGroundRay(pos, testPos, TERRAIN_PROJECTILE) == RAY_HIT_TERRAIN then
				LogDetail("  Target obstructed by terrain")
				return true
			end
		else
			LogDetail("  No firing solution")
			return true
		end
	end

	if not needLineOfSight and not needLineToStructure then
		if ShowObstructionRays then SpawnCircle(hardPointPos, 150, Colour(255,255,255,255), 5) end
		return false
	else
		
		if ShowObstructionRays then rayFlags = rayFlags | RAY_DEBUG end

--		local hitType = CastRayFromDevice(weaponId, pos, hitpoints, rayFlags, 0)
--		Log("Casting ray from " .. weaponType .. ", teamId: " .. teamId .. " to " .. GetDeviceType(GetDeviceIdAtPosition(pos)) .. ", pos: " .. pos)

		hitType = CastTargetObstructionRay(hardPointPos, pos, hitpoints, rayFlags, weaponType)

		if hitType == data.RAY_HIT_OBSTRUCTED then return true end -- target obstructed/cannot be reached (projectileHP < 0)

		LogEnum("cast ray " .. RAY_HIT[hitType] .. " team " .. GetRayHitSideId())
		if needLineOfSight then
			if (hitType == RAY_HIT_WEAPON or hitType == RAY_HIT_DEVICE) and GetRayHitSideId()%MAX_SIDES == enemyTeamId and CastGroundRayFromWeapon(weaponId, pos, TERRAIN_PROJECTILE) == 0  then
				return false
			end
		else
			LogDetail("hitType " .. hitType .. ", hit team " .. GetRayHitSideId())
			if hitType ~= RAY_HIT_TERRAIN and GetRayHitTeamId()%MAX_SIDES == enemyTeamId then
				return false
			end
		end
	end
	return true
end

function comparePositions(pos1, pos2)
	return (pos1.x == pos2.x and pos1.y == pos2.y)
end

-- custom function by @cronkhinator for TargetObstruction check

function CastTargetObstructionRay(source, target, hitpoints, rayFlags, weaponType)
	local hitType
	local hitSaveName
	local projectileHP = hitpoints
	-- offset new ray starting position of ray every loop
	local rayVec = target - source
	local length = math.sqrt(rayVec.x^2 + rayVec.y^2)
	-- nrmVec is basically the offset vector to prevent the ray from hitting the same thing twice
	local nrmVec = Vec3()
	nrmVec.x = rayVec.x / length
	nrmVec.y = rayVec.y / length
	nrmVec.z = rayVec.z
	
	local hits = {}
	-- have to offset ray by a bit every time, because CastRay ray collides with literally everything, including friendly doors and background
	repeat
		hitType = CastRay(source, target, rayFlags, 0)

		if hitType == RAY_HIT_NOTHING or hitType == RAY_HIT_TERRAIN then return hitType end


		local hitPos = GetRayHitPosition()
		if hits[hitPos.x .. " " .. hitPos.y] == true then
			-- AI would get stuck in infinite loop
			break
		end
		hits[hitPos.x .. " " .. hitPos.y] = true
		source = hitPos + nrmVec
		hitSaveName = GetRayHitMaterialSaveName()


		if not (GetRayHitTeamId() == teamId and (GetRayHitDoor() or hitSaveName == weaponType) or hitSaveName == "backbracing") then -- ignore friendly doors
			if hitSaveName ~= "backbracing" or (weaponType == "buzzsaw" or weaponType == "howitzer") then -- ignore backbracing unless buzz or howie
				if (GetRayHitSideId()%MAX_SIDES == teamId) then return data.RAY_HIT_OBSTRUCTED end -- projectile path collides with friendly entity			
				-- ray hits (enemy or) structure/device if code makes it to here
				if data.StructureHPList[hitSaveName] ~= nil then
					-- known material
					local nodeIdA = GetRayHitLinkNodeIdA()
					local nodeIdB = GetRayHitLinkNodeIdB()

					--Log("weaponType: " .. weaponType .. ", isInShieldExclusions: " .. tostring(data.ShieldExclusions[weaponType]) .. ", hitpoints: " .. hitpoints)
							
					if hitSaveName == "armour" or (hitSaveName == "door" and data.OpenDoors[nodeIdA .. " " .. nodeIdB] ~= true) and data.MetalExclusions[weaponType] then return data.RAY_HIT_OBSTRUCTED end
					if hitSaveName == "shield" and data.ShieldExclusions[weaponType] then return data.RAY_HIT_OBSTRUCTED end
					
					if (nodeIdA > 0 and nodeIdB > 0) then
						-- don't reduce HP if door is open
						if data.OpenDoors[nodeIdA .. " " .. nodeIdB] ~= true then
							-- GetLinkHealth is the percentage of HP left
							projectileHP = projectileHP - GetLinkHealth(nodeIdA, nodeIdB) * data.StructureHPList[hitSaveName]
							if ShowObstructionRays then SpawnCircle(hitPos, 50, Colour(0, 0, 255, 255), 5) end
						end
					else 
						-- node ids not received for whatever reason
						projectileHP = projectileHP - data.StructureHPList[hitSaveName]
					end
	--					Log(" - " .. nodeIdA .. " " ..nodeIdB .. ", projectileHP: " .. projectileHP .. ", linkHealth " .. GetLinkHealth(nodeIdA, nodeIdB))
				else
					-- unknown material, likely modded (or shield)
				end
			end
		end
--			Log(" - HitPos: " .. GetRayHitPosition() .. ", hitType: " .. hitType .. ", hit: " .. hitSaveName .. ", teamId: " .. GetRayHitTeamId() .. ", projectileHP: " .. projectileHP)
		local reachedTarget = comparePositions(hitPos, target)
	until (reachedTarget or projectileHP < 0)


	if projectileHP < 0 then
		if data.ProjectileSplash[weaponType] then	
			local distance = Vec3Length(target - GetRayHitPosition())
			if ShowObstructionRays then SpawnCircle(GetRayHitPosition(), data.ProjectileSplash[weaponType], Red(92), 5) end
			if data.ProjectileSplash[weaponType] >= distance then return RAY_HIT_WEAPON end
		end

		return data.RAY_HIT_OBSTRUCTED
	end

	return hitType
end

-- targeting ground devices fix

function FindPriorityTarget(weaponId, type, priorities, needLineOfSight, needLineToStructure)
	local weaponType = GetDeviceType(weaponId)
	local targetModifierFunction = WeaponTargetModifierFunction[type]
	local weaponPos = GetDevicePosition(weaponId)
	
	-- weapon target selection
	if TableLength(data.WeaponTargets) > 0 then
		local targetPos = FindWeaponTarget(weaponId, needLineOfSight)
		if targetPos then
			return ModifyTargetPos(weaponId, weaponPos, targetPos, targetModifierFunction)
		end
	end

	-- attack hint target selection
	if TableLength(data.AttackHintTargets) > 0 then
		local ahProb = data.AttackHintTargetProbability[weaponType]
		if ahProb == nil then
			ahProb = data.AttackHintTargetProbabilityDefault
		end
		if ahProb > 0 and GetRandomFloat(0, 1, "FindPriorityTarget AH " .. weaponId) <= ahProb then
			local targetPos = FindAttackHintTarget(weaponId)
			if targetPos then
				return ModifyTargetPos(weaponId, weaponPos, targetPos, targetModifierFunction)
			end
		end
	end

	-- special target selection
	if TableLength(data.SpecialTargets) > 0 then
		local stProb = data.SpecialTargetProbability[weaponType]
		if stProb == nil then
			stProb = data.SpecialTargetProbabilityDefault
		end
		if stProb > 0 and GetRandomFloat(0, 1, "FindPriorityTarget ST " .. weaponId) <= stProb then
			local targetPos = FindSpecialTarget(weaponId, needLineOfSight)
			if targetPos then
				return ModifyTargetPos(weaponId, weaponPos, targetPos, targetModifierFunction)
			end
		end
	end

	local deviceCount = GetDeviceCountSide(enemyTeamId)
	
	-- randomise the start of the target search so we're not always shooting at the same thing
	local searchStart = 1 + math.floor(math.abs(GetNormalFloat(#priorities/5, 0, "FindPriorityTarget searchStart " .. weaponId)))
	if searchStart > #priorities then
		searchStart = #priorities
	end
	LogEnum("searchStart " .. searchStart)

	local hitpoints = data.ProjectileHitpoints[weaponType] or 0
	
	local ignoreProtectionProb = data.IgnoreProtectionProbability[weaponType]
	if ignoreProtectionProb ~= nil and GetRandomFloat(0, 1, "FindPriorityTarget IP " .. weaponId) <= ignoreProtectionProb then
		LogDetail("  Ignoring protection")
		hitpoints = 100000000
	end

	local searchEnd = #priorities
	local searchDir = 1
	p = searchStart
	
	-- sort all enemy devices by type
	local testAllEnemyTeams = next(data.TargetTeamsExclude) == nil
	local sideDevices = {}
	for index = 0,deviceCount - 1 do
		local id = GetDeviceIdSide(enemyTeamId, index)
		if testAllEnemyTeams or not data.TargetTeamsExclude[GetDeviceTeamIdActual(id)] then
			local saveName = GetDeviceType(id)
			if sideDevices[saveName] == nil then
				sideDevices[saveName] = {}
			end
			table.insert(sideDevices[saveName], id)
		end
	end

	repeat
		local priorityType = priorities[p]
		local potentialTargets = {}
		local devices = sideDevices[priorityType]
		if devices then
			LogDetail("considering " .. #devices .. " of type " .. priorityType)
			for k, id in ipairs(devices) do
				local pos = ModifyTargetPos(weaponId, weaponPos, GetDeviceCentrePosition(id), targetModifierFunction)
				LogEnum("  Testing device " .. id)
				local targetType = GetDeviceType(id)
				if data.GroundDevices[targetType] then
					pos = Vec3(pos.x, pos.y + data.GroundDevices[targetType], pos.z)
					if ShowObstructionRays then SpawnCircle(pos, 10, Blue(92), 5) end
				end
				if (pos.y <= GetWaterLevel(pos.x) or deviceType == "reactor")
					and targetType == priorityType					
					and not TargetObstructed(weaponId, weaponType, pos, hitpoints, needLineOfSight, needLineToStructure)
					and not IsCloaked(id) then
					LogEnum("Target found")
					table.insert(potentialTargets, pos)
				end
			end
		end

		-- select a target randomly to avoid always attacking the first
		if #potentialTargets > 0 then
			local index = GetRandomInteger(1, #potentialTargets, "FindPriorityTarget potentials " .. weaponId)
			return potentialTargets[index]
		end
		
		if searchDir == 1 and p == searchEnd and searchStart > 1 then
			LogDetail("Reversing target search direction")
			-- we've failed to find a randomised target below our preference
			-- search up to the top, don't test already searched targets
			searchEnd = 1
			p = searchStart - 1
			searchDir = -1
		else
			p = p + searchDir
		end
	until p == searchEnd + searchDir

	-- no device target, test random parts of the structure
	local structureAttempts = data.WeaponTargetStructureAttempts[weaponType] or data.WeaponTargetStructureAttemptsDefault
	if structureAttempts > 0 then
		local nodeCount = NodeCount(enemyTeamId)
		if nodeCount > 0 then
			for i=1,structureAttempts do
				local index = GetRandomInteger(0, nodeCount - 1, "FindPriorityTarget StructAttempt")
				local nodeId = GetNodeId(enemyTeamId, index)
				if testAllEnemyTeams or not data.TargetTeamsExclude[NodeTeam(nodeId)] then
					local pos = ModifyTargetPos(weaponId, weaponPos, NodePosition(nodeId), targetModifierFunction)
					LogEnum("  Considering target node " .. nodeId)
					if (pos.y <= GetWaterLevel(pos.x) or i == structureAttempts)
						and not TargetObstructed(weaponId, weaponType, pos, 0, false, needLineToStructure) then
						LogDetail("  Structure target found for " .. weaponType .. ", node " .. nodeId)
						return pos
					end
				end
			end
		end
	end

	return nil
end
]]
function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- Fix nuke firing
data.GroupingAffinity["missile2"]["alone"] = 1

-- AI giving up after obstruction fix
-- TODO (Endo): Consider future-proofing fix; only two lines changed from
--              original, after `-- maybe a human player put something there`
function ExecuteFortAction(action, index)
	if IsFrustrated(index) then
		LogError("Skipping frustrated action " .. index)
		if AILogLevel >= LOG_DETAIL then
			LogAction(index, action)
		end
		return false, true
	end

	if AILogLevel >= LOG_DETAIL then
		LogAction(index, action)
	end

	local actualNodeA = data.OriginalToActual[action.OriginalNodeAId]
	local ownerA = nil
	if actualNodeA then ownerA = NodeTeam(actualNodeA) end

	-- a required node doesn't exist yet or we don't own it
	if action.OriginalNodeAId and (actualNodeA == nil or (ownerA ~= teamId and ownerA ~= 0)) then
		LogError("Node " .. action.OriginalNodeAId .. " doesn't exist yet")
		LogOriginalToActual()

		-- TODO: needs testing
		--AddFrustration(index)

		if action.ExistingFort then
			-- commands to rebuild the starting fort can include create node command from both ends, referencing non-existent nodes
			-- we may need to execute later commands to build one
			return false, true
		else
			return false -- , true -- TODO: needs testing
		end
	end

	local isRebuild = data.Rebuild[index]
	local actualNodeB = data.OriginalToActual[action.OriginalNodeBId]

	if actualNodeA ~= nil then
		local sId = NodeStructureId(actualNodeA)	
		--Log("Checking structure " .. sId)
		if data.DisabledStructure[sId] then
			--Log("Structure " .. sId .. " of action index " .. index .. " disabled")
			-- this structure is disabled, so skip it for now
			return false, true
		end
	end

	if action.Type == CREATE_NODE then
		if actualNodeB == nil then
			if actualNodeA == nil then -- source node destroyed?
				LogError("CreateNode failed: from missing actual N" .. action.OriginalNodeAId)
				return false, true
			elseif NodeLinkCount(actualNodeA) <= 1 and not IsFoundation(actualNodeA) and not IsPointOnGround(action.NewNodePos, teamId) then
				LogDetail("CreateNode skipped: source unstable")
				return false, true
			else
				local dest = Vec3(action.NewNodePos.x, action.NewNodePos.y)

				local existingNode = SnapToNode(dest, teamId, 20)
				if existingNode > 0 then
					LogDetail("CreateNode skipped: AN" .. existingNode .. " already present at location for ON" .. action.OriginalNodeBId)
					data.OriginalToActual[action.OriginalNodeBId] = existingNode

					if ShowOriginalNodes then
						AddTextControl("", "N"..action.OriginalNodeBId, "N"..action.OriginalNodeBId, ANCHOR_BOTTOM_CENTER, dest, true, "Normal")
					end

					local succeeded = true
					if not IsNodeLinkedTo(actualNodeA, existingNode) then
						local result = CreateLink(teamId, action.MaterialSaveName, actualNodeA, existingNode)
						succeeded = (result == CS_SUCCESS or result == CS_INVALIDTYPE or result == CS_INVALIDNODES)
						LogDetail("CreateNode: create link to existing node " .. CS[result])
					end
					return succeeded, true
				end

				local constructionCost = GetLinkCost(actualNodeA, dest, action.MaterialSaveName, false)
				constructionCost = 1.1*constructionCost + 1.1*GetLinkLengthCost(150, "bracing", teamId)
				local resources = GetTeamResources(teamId)
				if not CanAfford(resources - constructionCost) then
					LogDetail("Can't afford to build node and bracing link, saving..")
					return false
				end

				-- If the construction fails soon after the instruction will soon become frustrated
				AddFrustration(index)

				data.CreatingNode = true -- to prevent incorrect mapping in OnNodeCreated
				local newNodeId = CreateNode(teamId, action.MaterialSaveName, actualNodeA, dest)
				data.ResourceStarved = (newNodeId == CS_INSUFFICIENTRESOURCES)
				data.CreatingNode = false
				if newNodeId >= 0 then
					-- add the created node to the mapping of original to actual so we can use the actual ones in future
					data.OriginalToActual[action.OriginalNodeBId] = newNodeId
					if not IsFoundation(newNodeId) and not BraceNewNode(action.OriginalNodeAId, action.OriginalNodeBId, index) then
						-- keep track of which nodes are waiting for a stabilising strut so we don't prematurely pause construction
						data.NewNodes[newNodeId] = data.gameTime
						--AddTextControl("", "NN"..newNodeId, "NN"..newNodeId, ANCHOR_BOTTOM_CENTER, dest, true, "Normal")
					end
					if ShowOriginalNodes then
						AddTextControl("", "N"..action.OriginalNodeBId, "N"..action.OriginalNodeBId, ANCHOR_BOTTOM_CENTER, dest, true, "Normal")
					end
					LogDetail("Created N" .. newNodeId)
					
					return true
				else
					actualNodeB = nil
					LogError("CreateNode failed: " .. CS[newNodeId] .. " from actual N" .. actualNodeA)
					if newNodeId == CS_NODESTOOFAR or newNodeId == CS_NODESTOOCLOSE or newNodeId == CS_NOGROUND then
						return CreateNodeDynamic(newNodeId, action, actualNodeA, dest, index)
					else
						if ShowPositions then
							SpawnEffect("effects/node_flash.lua", NodePosition(actualNodeA))
							SpawnEffect("effects/node_flash.lua", dest)
						end
						
						LogDetail(CS[newNodeId] .. ": skipping action, rebuilding " .. tostring(rebuild))
						return (newNodeId == CS_NOGROUND), true
					end
				end
			end
		elseif IsNodeLinkedTo(actualNodeA, actualNodeB) and GetLinkMaterialSaveName(actualNodeA, actualNodeB) == action.MaterialSaveName then
			LogDetail("Node and link exist, action passed")
			return true, true
		else
			LogDetail("Node exists but link doesn't, relinking AN" .. actualNodeA .. "-AN" .. actualNodeB .. ", ON" .. action.OriginalNodeAId .. "-ON" .. action.OriginalNodeBId)

			-- skip links to a free node
			if not IsFoundation(actualNodeA) and NodeLinkCount(actualNodeA) == 0 or
			   not IsFoundation(actualNodeB) and NodeLinkCount(actualNodeB) == 0 then
			   LogDetail("Avoiding link to free node, skipping")
			   return false, true
			end

			-- reject links that are too co-linear
			if UnstableColinear(actualNodeA, actualNodeB) then
				AddFrustration(index)
				return false, true
			end

			-- the node we want to create already exists, so just link to it instead of recreating it (happens during rebuilding process)
			local result = CreateLink(teamId, action.MaterialSaveName, actualNodeA, actualNodeB)
			data.ResourceStarved = (result == CS_INSUFFICIENTRESOURCES)
			if result == CS_SUCCESS then
				return true
			else
				AddFrustration(index)
				LogError(CS[result] .. " AN" .. actualNodeA .. "-AN" .. actualNodeB .. ", ON" .. action.OriginalNodeAId .. "-ON" .. action.OriginalNodeBId)
				if ShowPositions then
					SpawnEffect("effects/node_flash.lua", NodePosition(actualNodeA))
					SpawnEffect("effects/node_flash.lua", NodePosition(actualNodeB))
				end
				return result ~= CS_INVALIDTYPE, true
			end
		end
	elseif action.Type == DESTROY_NODE then
		-- remove the mapping before deletion so we don't try to rebuild the node when notified of its destruction
		DestroyNode(teamId, actualNodeA)
		data.NewNodes[actualNodeA] = nil
		--DeleteControl("", "NN"..actualNodeA)
		data.ExpectedNodeDestroy[actualNodeA] = true
		return true
	elseif action.Type == CREATE_LINK then
		-- see if a required node doesn't exist yet
		-- if we are rebuilding the starting fort then this isn't considered a failure
		-- since relinking is prioritised over recreating nodes, it just means the nodes have to be rebuilt
		local rebuildingStartingFort = isRebuild and index <= data.StartingFortLastIndex
		
		if actualNodeA == nil then
			if not rebuildingStartingFort then LogError("CREATE_LINK original node " .. action.OriginalNodeAId .. " doesn't exist") end
			return rebuildingStartingFort, true
		end
		if actualNodeB == nil then
			if MaterialIsSegmented(action.MaterialSaveName) and action.PosB then
				local posB = Vec3(action.PosB.x, action.PosB.y)
				return CreateNodeDynamic(CS_NOGROUND, action, actualNodeA, posB, index)
			else
				if not rebuildingStartingFort then LogError("CREATE_LINK original node " .. action.OriginalNodeBId .. " doesn't exist") end
				return rebuildingStartingFort, true
			end
		end

		if IsNodeLinkedTo(actualNodeA, actualNodeB) and GetLinkMaterialSaveName(actualNodeA, actualNodeB) == action.MaterialSaveName then
			-- link already exists and we have control of it, consider the action successful
			LogDetail("Link already exists, action passed")
			return true, true
		end

		-- skip links to a free node
		if not IsFoundation(actualNodeA) and NodeLinkCount(actualNodeA) == 0 or
		   not IsFoundation(actualNodeB) and NodeLinkCount(actualNodeB) == 0 then
		   LogDetail("Avoiding link to free node, skipping")
		   return false, true
		end

		-- If the construction fails soon after the instruction will soon become frustrated
		AddFrustration(index)
 
		-- reject links that are too co-linear
		if UnstableColinear(actualNodeA, actualNodeB) then
			LogDetail("UnstableColinear")
			return false, true
		end

		-- temporarily reject links to neutral nodes that are too far from their expected position, or traveling quickly,
		-- as they may be falling; connecting to them can cause the AI to get stuck
		local ownerB = NodeTeam(actualNodeB)
		if ownerB == 0 then
			local actualPosA = NodePosition(actualNodeA)
			local actualPosB = NodePosition(actualNodeB)

			if action.PosA then
				local originalPosA = data.DynamicNodePos[action.OriginalNodeAId] or Vec3(action.PosA.x, action.PosA.y)
				local displacementA = Vec3Dist(originalPosA, actualPosA)
				local velA = NodeVelocity(actualNodeA)
				local speedA = Vec3Length(velA)

				if 0.5*displacementA + 1.5*speedA > 50 then
					if ShowDisplacementErrors then
						SpawnLine(actualPosA, originalPosA, Red(), 2)
						SpawnLine(actualPosA, actualPosB, White(), 2)
						Log(data.gameFrame .. ": T" .. teamId .. " displacement error: distance " .. math.floor(displacementA) .. ", speed " .. math.floor(speedA))
					end
					return false, true
				end
			end

			if action.PosB then
				local originalPosB = data.DynamicNodePos[action.OriginalNodeBId] or Vec3(action.PosB.x, action.PosB.y)
				local displacementB = Vec3Dist(originalPosB, actualPosB)
				local velB = NodeVelocity(actualNodeB)
				local speedB = Vec3Length(velB)

				if 0.5*displacementB + 1.5*speedB > 50 then
					if ShowDisplacementErrors then
						SpawnLine(actualPosB, originalPosB, Red(), 2)
						SpawnLine(actualPosA, actualPosB, White(), 2)
						Log(data.gameFrame .. ": T" .. teamId .. " displacement error: distance " .. math.floor(displacementB) .. ", speed " .. math.floor(speedB))
					end
					return false, true
				end
			end
		end

		local result = CreateLink(teamId, action.MaterialSaveName, actualNodeA, actualNodeB)
		data.ResourceStarved = (result == CS_INSUFFICIENTRESOURCES)
		if result == CS_SUCCESS or result == CS_NODESTOOFAR or result == CS_NODESTOOCLOSE then
			if result ~= CS_SUCCESS then LogError(CS[result]) end
			return true
		elseif isRebuild and result == CS_INSUFFICIENTRESOURCES and
			action.MaterialSaveName == "door" then
			if GetLinkMaterialSaveName(actualNodeA, actualNodeB) == nil then
				LogError(CS[result] .. ": Building a temporary bg bracing prop instead of " .. action.MaterialSaveName)
				result = CreateLink(teamId, "backbracing", actualNodeA, actualNodeB)
				if result ~= CS_SUCCESS then LogError(CS[result]) end
			end
			return false, true
		elseif isRebuild and result == CS_INSUFFICIENTRESOURCES and
			action.MaterialSaveName ~= "bracing" and
			action.MaterialSaveName ~= "backbracing" and
			action.MaterialSaveName ~= "rope" then
			if GetLinkMaterialSaveName(actualNodeA, actualNodeB) == nil then
				LogError(CS[result] .. ": Building a temporary bracing prop instead of " .. action.MaterialSaveName)
				result = CreateLink(teamId, "bracing", actualNodeA, actualNodeB)
				if result ~= CS_SUCCESS then LogError(CS[result]) end
			end
			return false, true
		else
			LogError(CS[result] .. " AN" .. actualNodeA .. "-AN" .. actualNodeB)
			return false, true
		end
	elseif action.Type == DESTROY_LINK then
		EnumerateChainNodes(actualNodeA, actualNodeB, "ForgetActualNode")
		table.insert(data.ExpectedLinkDestroy, { actualNodeA, actualNodeB })
		DestroyLink(teamId, actualNodeA, actualNodeB)
		return true
	elseif action.Type == CREATE_DEVICE then
		if action.GroundPosition then
			local id = GetDeviceIdAtPosition(action.GroundPosition)
			if id > 0 and GetDeviceTeamIdActual(id) ~= teamId then
				LogError("Obstructing device not owned")
				return true
			end

			LogDetail("device id = " .. id)

			if id <= 0 then
				LogDetail("Creating device " .. (UpgradeSource[action.DeviceSaveName] or action.DeviceSaveName))
				local result = CreateGroundDevice(teamId, UpgradeSource[action.DeviceSaveName] or action.DeviceSaveName, action.GroundPosition, 90)
				data.ResourceStarved = (result == CD_INSUFFICIENTRESOURCES)
				if result >= 0 then
					-- success
					data.Devices[result] = index
					if UpgradeSource[action.DeviceSaveName] then
						LogDetail(" - building upgrade precursor...")
						return false -- need to come back to this action to build the upgraded device
					end
					return true
				elseif result == CD_OCCUPIED or result == CD_OBSTRUCTION or result == CD_INVALIDTYPE then
					-- assume for now it's occupied with something valuable
					-- maybe a human player put something there
					LogDetail("Skip step due to being obstructed, occupied, or invalid.")
					return false, true
				else
					if not data.ResourceStarved and result ~= CD_PREREQUISITECONSTRUCT then
						AddFrustration(index, result)
					end
					LogError(CD[result] .. ": retrying")
					if isRebuild then return false, true end -- do something else and try again later
					return false, true
				end
			elseif UpgradeSource[action.DeviceSaveName] then -- upgraded existing device
				LogDetail("checking device type for upgrade")
				if GetDeviceType(id) == UpgradeSource[action.DeviceSaveName] then
					if not IsAIDeviceAvailable(id) then
						return false -- device is in use by a human, don't upgrade it
					elseif IsDummy(id) then
						return false
					end

					-- try to upgrade what's there
					LogDetail("upgrading " .. UpgradeSource[action.DeviceSaveName] .. " to " .. action.DeviceSaveName)
					result = UpgradeDevice(id, action.DeviceSaveName)
					data.ResourceStarved = (result == UD_INSUFFICIENTRESOURCES)
					if result >= 0 then
						data.Devices[id] = nil -- forget original device
						data.Devices[result] = index -- remember upgrade
						return true
					elseif result == UD_INVALIDDEVICE or result == UD_INVALIDUPGRADE then
						LogError(UD[result] .. ": giving up")
						return true
					else
						if not data.ResourceStarved and result ~= UD_PREREQUISITECONSTRUCT then
							AddFrustration(index, result)
						end
						LogError(UD[result] .. ": retrying")
						if isRebuild then
							LogDetail("isRebuild")
							-- do something else and try again later
							return false, true
						end
						LogDetail("not isRebuild")
						return false
					end
				else
					LogError("upgraded device location occupied by incompatible device " .. GetDeviceType(id))
					return true
				end
			else
				LogDetail("Obstructed by " .. id .. " (" .. GetDeviceType(id) .. "): waiting")
				AddFrustration(index)
				return false
			end
		else -- build device on a platform
			-- a required node doesn't exist yet
			if actualNodeA == nil or actualNodeB == nil then
				AddFrustration(index)
				LogError(action.OriginalNodeAId .. " or " .. action.OriginalNodeBId ..  " doesn't exist, retrying")
				return false, true
			end

			local id = GetDeviceIdOnPlatform(actualNodeA, actualNodeB)
			if id > 0 and GetDeviceTeamIdActual(id) ~= teamId then
				LogError("Device not owned")
				return true
			end
			
			if id <= 0 then
				LogDetail("creating device " .. action.DeviceSaveName .. " AN" .. actualNodeA .. "-AN" .. actualNodeB .. " t" .. action.LinkT)
				local result = CreateDevice(teamId, UpgradeSource[action.DeviceSaveName] or action.DeviceSaveName, actualNodeA, actualNodeB, action.LinkT)
				data.ResourceStarved = (result == CD_INSUFFICIENTRESOURCES)
				if result >= 0 then
					-- The result passed back is the new device's id. Remember it so if the device is destroyed we can rebuild it using this action
					data.Devices[result] = index
					if UpgradeSource[action.DeviceSaveName] then
						LogDetail(" - building upgrade precursor...")
						return false -- need to come back to this action to build the upgraded device
					end
					return true
				elseif result == CD_OCCUPIED or result == CD_OBSTRUCTION or result == CD_INVALIDTYPE then
					-- assume it's occupied with something valuable a player built
					AddFrustration(index)
					LogError(CD[result] .. ": skipping")
					return false, true
				else
					if not data.ResourceStarved and result ~= CD_PREREQUISITECONSTRUCT then
						AddFrustration(index)
					end
					LogError(CD[result] .. ": retrying")
					if isRebuild then return false, true end -- skip and try again later
					return false
				end
			elseif UpgradeSource[action.DeviceSaveName] then -- try to upgrade existing device
				if GetDeviceType(id) == UpgradeSource[action.DeviceSaveName] then
					if not IsAIDeviceAvailable(id) then
						return false -- device is in use by a human, don't upgrade it
					elseif IsDummy(id) then
						return false
					end

					LogDetail("upgrading " .. UpgradeSource[action.DeviceSaveName] .. " to " .. action.DeviceSaveName)
					local result = UpgradeDevice(id, action.DeviceSaveName)
					if result >= 0 then
						data.Devices[id] = nil -- forget original device
						data.Devices[result] = index -- remember upgrade
						return true
					elseif result == UD_INVALIDDEVICE or result == UD_INVALIDUPGRADE then
						LogError(UD[result] .. ": giving up")
						return true
					elseif result == UD_PREREQUISITENOTMET then
						LogError(UD[result] .. ": skipping")
						if isRebuild then return false, true end
						return false
					else
						LogError(UD[result] .. ": retrying")
						return false
					end
				else
					LogError("Upgraded device location occupied by incompatible device")
					return true
				end		
			elseif result == CD_PREREQUISITENOTMET and UpgradeSource[action.DeviceSaveName] then
				LogDetail("Building device prerequisite " .. UpgradeSource[action.DeviceSaveName])
				-- build the pre-requisite first and try to upgrade later
				local result = CreateDevice(teamId, UpgradeSource[action.DeviceSaveName], actualNodeA, actualNodeB, action.LinkT)
				data.ResourceStarved = (result == CD_INSUFFICIENTRESOURCES)
				if result < 0 then
					LogError(CD[result])
				end
				return result >= 0
			else
				LogError("Obstructed by " .. GetDeviceType(id) .. ", giving up")
				return true
			end
		end
	elseif action.Type == DESTROY_DEVICE then
		if action.OriginalNodeAId and action.OriginalNodeAId > 0 then
			local result = DestroyDevice(teamId, actualNodeA, actualNodeB)
			if result == DD_SUCCESS then
				return true
			else
				AddFrustration(index)
				return false
			end
		else
			local devId = GetDeviceIdAtPosition(action.Pos)
			if devId > 0 and GetDeviceType(devId) == action.DeviceSaveName and GetDeviceTeamIdActual(devId) == teamId then
				local result = DestroyDeviceById(devId)
				if result == DD_SUCCESS then
					return true
				else
					AddFrustration(index)
					return false
				end
			else
				AddFrustration(index)
				return false
			end
		end
	elseif action.Type == CONNECT then
		if actualNodeA and actualNodeB then
			local actualNodeADest = data.OriginalToActual[action.OriginalNodeAIdDest]
			local actualNodeBDest = data.OriginalToActual[action.OriginalNodeBIdDest]

			if actualNodeA and actualNodeB and actualNodeADest and actualNodeBDest then
				if ConnectPortals(teamId,
					actualNodeA,
					actualNodeB,
					actualNodeADest,
					actualNodeBDest) == CP_SUCCESS then
					return true, true
				end
			end
		end
		return false
	elseif action.Type == SWITCH then
		if actualNodeA and actualNodeB then
			if SwitchPortal(teamId,
					actualNodeA,
					actualNodeB) == CP_SUCCESS then
				return true
			end
		end
		return false
	end
	
	Log("Error: Reached end of ExecuteFortAction with action:")
	LogAction(index, action)
end

-----------------------------------------------------
-- END fixes by @alexd26 (Discord ID:526090170521616384) --
-----------------------------------------------------

---------------------------------------------------------------
-- START fixes by @cronkhinator (Discord ID: 165842061055098880) --
---------------------------------------------------------------

-- fix AI repairing open doors
-- fix AI not repairing at all (when resource starved)

data.OpenDoors = {}

function OnDoorState(teamId, nodeA, nodeB, doorState)
	if doorState == DS_CLOSED or doorState == DS_CLOSING then
		data.OpenDoors[nodeA .. " " .. nodeB] = false
	else
		data.OpenDoors[nodeA .. " " .. nodeB] = true
	end
end

function RepairEnumeratedLink(nodeA, nodeB, saveName, relativeHealth, stress, segmentsOnFire, deviceId)
	if relativeHealth < data.repairDamageThreshold or segmentsOnFire > 0 then
		LogEnum("repairing link: " .. (nodeA or "nil") .. ", " .. (nodeB or "nil"))
		if nodeA and nodeB and (not data.DisableExtinguish or segmentsOnFire == 0) then
			if data.OpenDoors[nodeA .. " " .. nodeB] ~= true then
				RepairLink(nodeA, nodeB)
				linkRepairCount = linkRepairCount + 1
			end
		end
	end
	if deviceId > 0
		and not data.MissileLaunching[deviceId]
		and IsAIDeviceAvailable(deviceId)
		and not data.ResourceStarved then
		LogEnum("Repairing link device " .. deviceId)
		RepairDevice(deviceId)
	end
	
	-- continue enumeration
	return true
end

-------------------------------------------------------------
-- END fixes by @cronkhinator (Discord ID: 165842061055098880) --
-------------------------------------------------------------
ExcludedDevices = {"sandbags","reactor"}
function AddCoreToPriorities()
	--Log("AddCore start")
	for _, Priority in pairs(priorities) do
		--Log("Filling Priority "..index.." with Core")
		PossibleMissingDevice = "reactor"
		itemFound = false
		for _, savename in pairs(Priority) do
			if PossibleMissingDevice == savename[1] then itemFound = true break end
		end
		if not itemFound then table.insert(Priority,1,{PossibleMissingDevice,101,100}) --[[Log("item: "..PossibleMissingDevice.." added") else Log("item: "..PossibleMissingDevice.." was already in the list")]]end
	end
end

function FillPriorities() -- This is to allow modded weapons to be easily added to targeting without requiring the modder to add custom priorities to all of them
	--Log("FillPri start")	--TODO: Add a check so any early check that might contain -1 don't stop the execution, order the list.
	for _, Priority in pairs(priorities) do
		--Log("Filling Priority "..index.." with empties")
		for _key, PossibleMissingDevice in pairs(AllTypesOfDevicesAndWeapons) do
         local skipThisItr = false
         for _, ExcludedDevice in pairs(ExcludedDevices) do
            if PossibleMissingDevice == ExcludedDevice then skipThisItr = true break end
         end
         if skipThisItr then continue end
			itemFound = false
			for _, savename in pairs(Priority) do
				if PossibleMissingDevice == savename[1] then itemFound = true break end
			end
			if not itemFound then table.insert(Priority,{PossibleMissingDevice,0,0}) --[[Log("item: "..PossibleMissingDevice.." added") else Log("item: "..PossibleMissingDevice.." was already in the list")]]end
		end
	end
end
--table.sort(priorities[i], function(a,b) return tonumber(a) < tonumber(b) end)
function FillPriorityEmpty(Priority)
	--Log("Filling "..Priority)
	for _, PossibleMissingDevice in pairs(AllTypesOfDevicesAndWeapons) do

      local skipThisItr = false
      for _, ExcludedDevice in pairs(ExcludedDevices) do
         if PossibleMissingDevice == ExcludedDevice then skipThisItr = true break end
      end
      if skipThisItr then continue end

		itemFound = false
		for _, savename in pairs(priorities[Priority]) do
			if PossibleMissingDevice == savename[1] then itemFound = true break end
		end
		if not itemFound then table.insert(priorities[Priority],{PossibleMissingDevice,-1,-1}) --[[Log("item: "..PossibleMissingDevice.." added") else Log("item: "..PossibleMissingDevice.." was already in the list")]]end

	end
end
--table.insert(priorities,1,{"reactor",101,100})

LogLower("priorities are being defined.")
priorities = {
   -- uww ze coure is waweaws tawrgetted furst
   -- must be ordered by priority (max(direct, splash)), descending
   -- {"reactor", 101, 100} is implicitly given in every table unless specified otherwise
   -- {"savename", 0.1, 0} for every savename in AllTypesOfDevicesAndWeapons, is implicitly given in every table unless specified otherwise
   -- (-1,_) counts as disabled, (0,-1) will automaticly remove splash calculation from the weapon (if its 0 it will still count as valid, but have 0 priority.)
   ["machinegun"] = {
      {"machinegun", 100,-1},
   },

   ["minigun"] = {
      {"machinegun", 100,-1},
      {"turbine2",   99,-1},
      {"mine2",      99,-1},
      {"turbine",    98,-1},
      {"mine",       98,-1},
      {"barrel",     95,-1},
      {"munitions",  92,-1},
      {"factory",    92,-1},
      {"upgrade",    92,-1},
      {"workshop",   91,-1},
      {"armoury",    91,-1},
      {"shotgun",    90,-1},
      {"mortar2",    85,-1},
      {"mortar",     84,-1},
      {"battery",    81,-1},
      {"store",      81,-1},
      {"rocketemp",  80,-1},
      {"rocket",     80,-1},
      {"smokebomb",  80,-1},
      {"missile2",   75,-1},
      {"missile2inv",75,-1},
      {"missile",    70,-1},
      {"missileinv", 70,-1},
      {"howitzer",   65,-1},
      {"cannon",     65,-1},
      {"laser",      65,-1},
      {"cannon20mm", 60,-1},
      {"firebeam",   60,-1},
      {"magnabeam",  60,-1},
      {"buzzsaw",    55,-1},
      {"minigun",    55,-1},
      {"flak",       50,-1},
      {"sniper2",    40,-1},
      {"sniper",     20,-1},
      {"repairstation", 5,-1},
   },

   ["sniper"] = {
      {"barrel", 100,-1},
      {"buzzsaw", 100,-1},
      {"cannon20mm", 100,-1},
      {"firebeam", 100,-1},
      {"rocketemp", 95,-1},
      {"flak", 94,-1},
      {"laser", 90,-1},
      {"sniper2", 85,-1},
      {"sniper", 84,-1},
      {"minigun", 80,-1},
      {"rocket", 75,-1},
      {"smokebomb", 75,-15},
      {"shotgun", 75,-1},
      {"missile2", 75,-1},
      {"missile2inv", 75,-1},
      {"missile", 70,-1},
      {"missileinv", 70,-1},
      {"mortar2", 65,-1},
      {"mortar", 64,-1},
      {"machinegun", 60,-1},
      {"magnabeam", 60,-1},
      {"cannon", 55,-1},
      {"howitzer", 54,-1},
      {"munitions", 51,-1},
      {"factory", 51,-1},
      {"upgrade", 51,-1},
      {"workshop", 50,-1},
      {"armoury", 50,-1},
      {"battery", 50,-1},
      {"mine2", 10,-1},
      {"mine", 9,-1},
      {"turbine2", 5,-1},
      {"turbine", 4,-1},
      {"store", 4,-1},
      {"repairstation", 4,-1},
   },

   ["sniper2"] = {
      {"barrel", 100,-1},
      {"buzzsaw", 100,-1},
      {"cannon20mm", 100,-1},
      {"firebeam", 100,-1},
      {"shotgun", 95,-1},
      {"rocketemp", 95,-1},
      {"flak", 94,-1},
      {"laser", 90,-1},
      {"sniper2", 85,-1},
      {"sniper", 84,-1},
      {"minigun", 80,-1},
      {"rocket", 75,-1},
      {"smokebomb", 75,-1},
      {"missile2", 75,-1},
      {"missile2inv", 75,-1},
      {"missile", 70,-1},
      {"missileinv", 70,-1},
      {"mortar2", 65,-1},
      {"mortar", 64,-1},
      {"machinegun", 60,-1},
      {"magnabeam", 60,-1},
      {"howitzer", 55,-1},
      {"cannon", 55,-1},
      {"munitions", 51,-1},
      {"factory", 51,-1},
      {"upgrade", 51,-1},
      {"workshop", 50,-1},
      {"armoury", 50,-1},
      {"battery", 30,-1},
      {"mine2", 20,-1},
      {"store", 5,-1},
   },

   ["mortar"] = {
      {"machinegun", 100, 50},
      {"flak", 100, -1},
      {"barrel", 100, 70},
      {"munitions", 95, -1},
      {"factory", 95, -1},
      {"upgrade", 95, -1},
      {"workshop", 94, -1},
      {"armoury", 94, -1},
      {"mine2", 90, -1},
      {"turbine2", 85, -1},
      {"mine", 85, -1},
      {"turbine", 80, -1},
      {"missile2", 80, -1},
      {"missile2inv", 80, -1},
      {"missile", 75, -1},
      {"missileinv", 75, -1},
      {"howitzer", 70, -1},
      {"cannon", 65, -1},
      {"laser", 65, -1},
      {"cannon20mm", 60, -1},
      {"firebeam", 60, -1},
      {"magnabeam", 60, -1},
      {"buzzsaw", 50, -1},
      {"rocketemp", 50, -1},
      {"sniper2", 50, -1},
      {"sniper", 50, 40},
      {"minigun", 50, -1},
      {"rocket", 50, -1},
      {"smokebomb", 50, -1},
      {"shotgun", 50, -1},
      {"mortar2", 50, -1},
      {"mortar", 50, -1},
      {"battery", 30, 30},
      {"store", 29, -1},
      {"repairstation", 5, -1},
   },

   ["mortar2"] = {
      {"machinegun", 100, 60},
      {"flak", 100, 40},
      {"barrel", 100, 70},
      {"munitions", 95, -1},
      {"factory", 95, -1},
      {"upgrade", 95, -1},
      {"workshop", 94, -1},
      {"armoury", 94, -1},
      {"mine2", 90, -1},
      {"turbine2", 85, -1},
      {"mine", 85, -1},
      {"turbine", 80, -1},
      {"missile2", 80, -1},
      {"missile2inv", 80, -1},
      {"missile", 75, -1},
      {"missileinv", 75, -1},
      {"howitzer", 70, -1},
      {"cannon", 65, -1},
      {"laser", 65, -1},
      {"cannon20mm", 60, -1},
      {"firebeam", 60, 50},
      {"battery", 30, 60},
      {"buzzsaw", 50, -1},
      {"rocketemp", 50, -1},
      {"sniper2", 50, -1},
      {"sniper", 50, -1},
      {"minigun", 50, -1},
      {"rocket", 50, -1},
      {"smokebomb", 50, -1},
      {"shotgun", 50, -1},
      {"mortar2", 50, -1},
      {"mortar", 50, -1},
      {"magnabeam", 29, -1},
      {"store", 29, -1},
      {"repairstation", 5, -1},
   },

   ["missile"] = {
      {"turbine2", 100,-1},
      {"turbine", 100,-1},
      {"machinegun", 100,-1},
      {"flak", 100,-1},
      {"barrel", 100,-1},
      {"shotgun", 100,-1},
      {"munitions", 95,-1},
      {"factory", 95,-1},
      {"upgrade", 95,-1},
      {"workshop", 94,-1},
      {"armoury", 94,-1},
      {"missile2", 90,-1},
      {"missile2inv", 90,-1},
      {"mine2", 90,-1},
      {"mine", 85,-1},
      {"missile", 75,-1},
      {"missileinv", 75,-1},
      {"howitzer", 70,-1},
      {"cannon", 65,-1},
      {"laser", 65,-1},
      {"battery", 61,-1},
      {"cannon20mm", 60,-1},
      {"firebeam", 60,-1},
      {"magnabeam", 60,-1},
      {"buzzsaw", 50,-1},
      {"rocketemp", 50,-1},
      {"sniper2", 50,-1},
      {"sniper", 50,-1},
      {"minigun", 50,-1},
      {"rocket", 50,-1},
      {"smokebomb", 50,-1},
      {"mortar2", 50,-1},
      {"mortar", 50,-1},
      {"store", 29,-1},
      {"repairstation", 5,-1},
   },

   ["missileinv"] = {
      {"turbine2", 100,-1},
      {"turbine", 100,-1},
      {"machinegun", 100,-1},
      {"flak", 100,-1},
      {"barrel", 100,-1},
      {"shotgun", 100,-1},
      {"munitions", 95,-1},
      {"factory", 95,-1},
      {"upgrade", 95,-1},
      {"workshop", 94,-1},
      {"armoury", 94,-1},
      {"missile2", 90,-1},
      {"missile2inv", 90,-1},
      {"mine2", 90,-1},
      {"mine", 85,-1},
      {"missile", 75,-1},
      {"missileinv", 75,-1},
      {"howitzer", 70,-1},
      {"cannon", 65,-1},
      {"laser", 65,-1},
      {"battery", 61,-1},
      {"cannon20mm", 60,-1},
      {"firebeam", 60,-1},
      {"magnabeam", 60,-1},
      {"buzzsaw", 50,-1},
      {"rocketemp", 50,-1},
      {"sniper2", 50,-1},
      {"sniper", 50,-1},
      {"minigun", 50,-1},
      {"rocket", 50,-1},
      {"smokebomb", 50,-1},
      {"mortar2", 50,-1},
      {"mortar", 50,-1},
      {"store", 29,-1},
      {"repairstation", 5,-1},
   },

   ["missile2"] = {
      {"barrel", 0, 100}, -- will most definitely be sniped
      {"howitzer", 100, 96},
      {"cannon", 95, 95},
      {"laser", 15, 95}, -- will be taken out by snipers etc. before nuke arrives, thus low direct fire prob
      {"cannon20mm", 15, 90},
      {"firebeam", 15, 90},
      {"rocket", 0, 60},
      {"smokebomb", 0, 60},
      {"buzzsaw", 0, 50},
      {"rocketemp", 0, 50},
      {"magnabeam", 10, 50},
      {"sniper2", 0, 50},
      {"sniper", 0, 50},
      {"minigun", 0, 50},
      {"mortar2", 0, 50},
      {"mortar", 0, 50},
      {"shotgun", 0, 50},
      {"machinegun", 0, 40},
      {"flak", 0, 40},
      {"turbine2", 5, 20},
   },

   ["missile2inv"] = {
      {"barrel", 0, 100}, -- will most definitely be sniped
      {"howitzer", 100, 96},
      {"cannon", 95, 95},
      {"laser", 15, 95}, -- will be taken out by snipers etc. before nuke arrives, thus low direct fire prob
      {"cannon20mm", 15, 90},
      {"firebeam", 15, 90},
      {"rocket", 0, 60},
      {"smokebomb", 0, 60},
      {"buzzsaw", 0, 50},
      {"rocketemp", 0, 50},
      {"magnabeam", 10, 50},
      {"sniper2", 0, 50},
      {"sniper", 0, 50},
      {"minigun", 0, 50},
      {"mortar2", 0, 50},
      {"mortar", 0, 50},
      {"shotgun", 0, 50},
      {"machinegun", 0, 40},
      {"flak", 0, 40},
      {"turbine2", 5, 20},
   },

   ["cannon"] = {
      {"howitzer", 100, 60},
      {"cannon", 100, 50},
      {"laser", 100, 50},
      {"missile2", 95, -1},
      {"missile2inv", 95, -1},
      {"missile", 93, -1},
      {"missileinv", 93, -1},
      {"munitions", 92, 15},
      {"factory", 92, 15},
      {"upgrade", 92, -1},
      {"workshop", 91, -1},
      {"armoury", 91, -1},
      {"cannon20mm", 90, 30},
      {"firebeam", 80, 10},
      {"magnabeam", 80, 10},
      {"barrel", 30, 80,},
      {"battery", 75, 50},
      {"mine2", 71, -1},
      {"mortar2", 71, 50},
      {"mortar", 70, 50},
      {"mine", 70, -1},
      {"turbine2", 69, 20},
      {"turbine", 68, -1},
      {"rocketemp", 65, 50},
      {"store", 65, -1},
      {"rocket", 60, 25},
      {"smokebomb", 60, -1},
      {"buzzsaw", 60, -1},
      {"minigun", 50, 20,},
      {"sniper2", 50, 15},
      {"shotgun", 40, 15},
      {"flak", 35, 15},
      {"sniper", 20, 10},
      {"repairstation", 5, -1},
      {"machinegun", -1, -1}, -- never fire cannon at machine gun
   },

   ["laser"] = {
      {"howitzer", 100,-1,},
      {"cannon", 100,-1,},
      {"laser", 100,-1,},
      {"missile2", 95,-1,},
      {"missile2inv", 95,-1,},
      {"missile", 93,-1,},
      {"missileinv", 93,-1,},
      {"munitions", 92,-1,},
      {"factory", 92,-1,},
      {"upgrade", 92,-1,},
      {"workshop", 91,-1,},
      {"armoury", 91,-1,},
      {"cannon20mm", 90,-1,},
      {"firebeam", 80,-1,},
      {"magnabeam", 80,-1,},
      {"battery", 75,-1,},
      {"mine2", 71,-1,},
      {"mortar2", 71,-1,},
      {"mortar", 70,-1,},
      {"mine", 70,-1,},
      {"turbine2", 69,-1,},
      {"turbine", 68,-1,},
      {"rocketemp", 65,-1,},
      {"store", 65,-1,},
      {"rocket", 60,-1,},
      {"buzzsaw", 60,-1,},
      {"sniper2", 55,-1,},
      {"minigun", 50,-1,},
      {"smokebomb", 50,-1,},
      {"shotgun", 50,-1,},
      {"barrel", 40,-1,},
      {"flak", 30,-1,},
      {"sniper", 20,-1,},
      {"repairstation", 20,-1,},
      {"machinegun", -1,-1}, -- never fire a laser at a machine gun
   },

   ["flak"] = {
      {"mortar2", 3,-1},
      {"mortar", 2,-1},
      {"machinegun", 1,-1},
   },

   ["shotgun"] = {
      {"machinegun", 70,-1},
      {"rocketemp", 70,-1},
      {"rocket", 70,-1},
      {"firebeam", 70,-1},
      {"battery", 65,-1},
      {"barrel", 65,-1},
      {"munitions", 64,-1},
      {"factory", 64,-1},
      {"upgrade", 64,-1},
      {"workshop", 63,-1},
      {"armoury", 63,-1},
      {"turbine2", 63,-1},
      {"mortar2", 63,-1},
      {"minigun", 62,-1},
      {"mortar", 60,-1},
      {"turbine", 60,-1},
      {"howitzer", 60,-1},
      {"cannon20mm", 55,-1},
      {"missile2", 55,-1},
      {"missile2inv", 55,-1},
      {"missile", 50,-1},
      {"missileinv", 50,-1},
   },

   ["rocketemp"] = {
      {"reactor",101,80},
      {"missile2", 60,100},
      {"missile2inv", 60,100},
      {"howitzer", 35, 100},
      {"cannon", 35, 100},
      {"laser", 40, 100},
      {"missile", 50,80},
      {"missileinv", 50,80},
      {"firebeam", 40,70},
      {"cannon20mm", 40,70},
      {"turbine2", 70,60},
      {"turbine", 70,60},
      {"munitions", 64,70},
      {"factory", 64,70},
      {"battery", 65,60},
      {"barrel", 65,30},
      {"upgrade", 64,65},
      {"workshop", 63,60},
      {"armoury", 63,60},
      {"rocketemp", 40,60},
      {"rocket", 40,60},
      {"mine", 30,50},
      {"mine2", 30,50},
      {"machinegun", 30,5},
      {"magnabeam", 10, 5},
   },

   ["rocket"] = {
      {"howitzer", 45, 100},
      {"cannon", 50, 100},
      {"laser", 55, 100},
      {"firebeam", 50,75},
      {"cannon20mm", 50,75},
      {"turbine2", 75,50},
      {"turbine", 70,50},
      {"battery", 65,50},
      {"barrel", 65,60},
      {"rocketemp", 60,60},
      {"rocket", 60,60},
      {"buzzsaw",60,50},
      {"minigun",60,50},
      {"munitions", 60,40},
      {"factory", 60,40},
      {"upgrade", 21,20},
      {"workshop", 21,20},
      {"armoury", 21,20},
      {"flak",21,60},
      {"shotgun",21,55}, 
      {"smokebomb",21,30},
      {"machinegun", 0,20},
      {"missile2", 15,0},
      {"missile2inv", 15,0},
      {"missile", 15,0},
      {"missileinv", 15,0},
      {"mine", 10,15},
      {"mine2", 10,15},
      {"magnabeam", 2, 10},
   },

   ["firebeam"] = {
      {"laser", 100, 80},
      {"firebeam", 100, 80},
      {"cannon20mm", 95, 80},
      {"cannon", 90, 50},
      {"barrel", 90, 80,},
      {"battery", 75, 60},
      {"mortar2", 71, 60},
      {"mortar", 70, 50},
      {"rocketemp", 65, 70},
      {"rocket", 60, 70},
      {"turbine2", 69, 60},
      {"turbine", 68, -1},
      {"smokebomb", 60, -1},
      {"buzzsaw", 60, -1},
      {"minigun", 50, 20,},
      {"sniper2", 50, 15},
      {"shotgun", 40, 15},
      {"flak", 35, 15},
      {"howitzer", 35, 35},
      {"sniper", 25, 30},
      {"mine2", 23, -1},
      {"munitions", 22, 15},
      {"factory", 22, 15},
      {"upgrade", 21, -1},
      {"workshop", 20, -1},
      {"armoury", 20, -1},
      {"mine", 20, -1},
      {"store", 11, -1},
      {"repairstation", 10, 0},
      {"machinegun", 10, 10},
      {"missile2", 1, -1},
      {"missile2inv", 1, -1},
      {"missile", 1, -1},
      {"missileinv", 1, -1},
   },

   ["cannon20mm"] = {
      {"battery", 65,25},
      {"barrel", 65,60},
      {"machinegun", 60,10},
      {"laser", 55, 70},
      {"cannon20mm", 55,20},
      {"rocketemp", 55,10},
      {"rocket", 55,10},
      {"cannon", 55,10},
      {"missile2", 55,5},
      {"missile2inv", 55,5},
      {"missile", 50,5},
      {"missileinv", 50,5},
      {"turbine2", 50,20},
      {"turbine", 45,-1},
      {"munitions", 45,-1},
      {"factory", 45,-1},
      {"upgrade", 45,-1},
      {"workshop", 45,-1},
      {"armoury", 45,-1},
      {"firebeam", 30,10},
      {"store", 5, -1},
   },

   ["buzzsaw"] = {
      {"reactor", 140,200},
      {"barrel", 80, 195},
      {"battery", 75, 195},
      {"munitions", 30, 170},
      {"factory", 30, 170},
      {"upgrade", 20, 150},
      {"workshop", 20, 150},
      {"armoury", 20, 150},
      {"howitzer", 70, 100},
      {"cannon", 60, 100},
      {"laser", 70, 100},
      {"store", 50, 90},
      {"rocket", 45, 90},
      {"rocketemp", 65, 90},
      {"cannon20mm", 90, 30},
      {"mortar2", 60, 90},
      {"missile2", 50, 85},
      {"missile2inv", 50, 85},
      {"firebeam", 80, 85},
      {"shotgun", 50, 85},
      {"missile", 50, 80},
      {"missileinv", 50, 80},
      {"mortar", 50, 80},
      {"mine2", 40, 75},
      {"mine", 40, 75},
      {"smokebomb", 40, 65},
      {"minigun", 40, 65,},
      {"buzzsaw", 30, 65},
      {"flak", 25, 60},
      {"sniper2", 25, 60},
      {"machinegun", 20, 50},
      {"sniper", 15, 30},
      {"turbine2", 30, -1},
      {"turbine", 25, -1},
      {"magnabeam", -1, -1}, -- ignore magnabeam :(
   },

   ["howitzer"]  = {
      {"barrel", 50, 100},
      {"cannon", 20, 100},
      {"laser", 20, 100},
      {"cannon20mm", 10, 95},
      {"firebeam", 10, 95},
      {"mine2", 0, 90},
      {"mine", 0, 90},
      {"missile2", 0, 90},
      {"missile2inv", 0, 90},
      {"missile", 0, 90},
      {"missileinv", 0, 90},
      {"howitzer", 20, 85},
      {"battery", 50, 10},
      {"factory", 50, 10},
      {"munitions", 50, 10},
      {"magnabeam", 40, 10},
      {"smokebomb", 10, 40}, -- Other wepons will have too easy of a time shooting this down, don't prioritize them
   },
   ["magnabeam"] = {
      {"reactor", 1,-1},
   },
   ["smokebomb"] = {
      {"machinegun", 1, 100},
      {"flak", 1, 100},
      {"reactor", 2, 30},
   }
}
--prioritiesListLength = #priorities, Not called recursivly.
FillPriorityEmpty("magnabeam")
FillPriorityEmpty("machinegun")
FillPriorityEmpty("flak")
FillPriorities()
AddCoreToPriorities()
--BetterLog(priorities)