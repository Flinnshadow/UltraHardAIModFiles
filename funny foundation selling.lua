dofile("scripts/forts.lua")
dofile("ui/uihelper.lua")

data.linkLists = {}
function DeleteLinks(nodeIdA, nodeIdB, saveName, relativeHealth, stress)
  table.insert(data.linkLists[NodeTeam(nodeIdA)], { nodeIdA = nodeIdA, nodeIdB = nodeIdB, deviceId = GetDeviceIdOnPlatform(nodeIdA, nodeIdB) })
  return true
end

function DeleteEverything(teamId)
  --LogToFile('DeleteEverything('..teamId..')')
  teamId = tonumber(teamId)
  data.linkLists[teamId] = {}
  EnumerateLinks(teamId, "DeleteLinks", 1, 1, "", true)
  for _, link in ipairs(data.linkLists[teamId]) do
    --LogToFile('link.deviceId='..link.deviceId)
    if link.deviceId >= 0 then
      -- DestroyDeviceById(link.deviceId)
    else
      DestroyLink(teamId, link.nodeIdA, link.nodeIdB)
    end
  end
end

function DeleteFoundations(teamId)
  --LogToFile('DeleteFoundations('..teamId..')')
  teamId = tonumber(teamId)
  
  local foundFoundation = false
  local nodeCount = NodeCount(teamId)
  if nodeCount > 0 then
    for nodeIdx = 0, (nodeCount - 1) do                                            -- loop all my nodes
      local nodeId = GetNodeId(teamId, nodeIdx)
      --LogToFile('nodeId='..nodeId..'')
      if nodeIdx > 0 and IsFoundation(nodeId) and NodeTeam(nodeId) == teamId then  -- if it's my foundation
        DestroyNode(teamId, nodeId)                                                -- delete my foundation nodes ;-)
        foundFoundation = true
      end
    end
  end
  
  if not foundFoundation then
    DeleteEverything(teamId)
  end
end

function OnGameResult(winningTeamId)
  for _, team in ipairs(DiscoverTeams(winningTeamId)) do
    DeleteFoundations(team)
  end
end

function DiscoverTeams(sideId)
	local teamFound = {}
	local teams = {}
	local count = GetDeviceCountSide(sideId)
	for i = 0, count - 1 do
		local id = GetDeviceIdSide(sideId, i)
		local currTeam = GetDeviceTeamIdActual(id)
		if not teamFound[currTeam] and GetDeviceType(id) == "reactor" then
			teamFound[currTeam] = true
			table.insert(teams, currTeam)
		end
	end
	return teams
end
