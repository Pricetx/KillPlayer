-- Script to kill a single player, or all players from the server console
-- Additionally, will kill a player if they type "/kill" ingame
-- Original Author, Jonathan Price
-- License can be found at [URL]
-- Version: 0.2
class 'KillPlayer'

function KillPlayer:__init()
	-- Subscribe to console command "kill"
	Console:Subscribe("kill", self, self.ConsoleKill)

	-- Subscribe to Player Chat
	Events:Subscribe("PlayerChat", self, self.IngameKill)
end

-- Run when user types "kill" in the console
function KillPlayer:ConsoleKill(args)
	if string.len(args.text) < 1 then
		print("Usage: kill [player]")
		print("Use '*' for all players")
		return
	end

	-- If the user typed '*', kill all the people
	if args.text == "*" then
		for player in Server:GetPlayers() do
			player:SetHealth(0)
		end
		print("All players have been killed")
		return
	end

	-- Search for a player with matching name, and kill them
	for player in Server:GetPlayers() do
		if player:GetName() == args.text then
			player:SetHealth(0)
			print(player:GetName() .. " has been killed")
			return
		end
	end

	print("Sorry, a player with that name could not be found")
end

-- Run when player types "/kill"
function KillPlayer:IngameKill(args)
	if args.text == "/kill" then
		args.player:SetHealth(0)
		return
	end
end

local run = KillPlayer()
