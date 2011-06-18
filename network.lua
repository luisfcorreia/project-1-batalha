-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- network.lua
-----------------------------------------------------------
-- 20110328 21:18 <bartbes> I like where this is going, QR codes for connecting androids

require("LUBE.lua")

function server_start(port)
	lube.server:Init(port,"tcp")
	lube.server:setPing(true, 2, "PING!")
	lube.server:setHandshake("#batalha*")
	lube.server:setCallback(updatedata, connect, disconnect)
	myownIP= lube.server.socket:getsockname()
end

function connect(ip, port)
--[[
	numclients = numclients + 1
	if numclients > 2 then
		server:send("Client=Rejected", ip)
	elseif numclients == 2 and not gamestarted then
		local i = 0
		for ip, port in pairs(Clients) do
			i = i + 1
			server:send("Client=" .. i, ip)
			table.insert(Players, { ip = ip, port = port })
		end
		gamestarted = true
	else
		server:send("Client=InHold", ip)
	end
]]--	
end

function disconnect(ip, port)
--[[
]]--	
end

function updatedata(data, ip, port)
	-- processar os dados que vem do android
	if data ~= nil then
	
		print(data)
	
		if gamestate == "running" then
			-- receber e processar dados do android	
			dados = {}
			dados = string.split(data,"+")
	
			turret_force1 = tonumber(dados[1])/2
			turret_angle1 = tonumber(dados[2])

			if turret_angle1 >= turret_max_angle then
				turret_angle1 = turret_max_angle
			end

			if game_direction == 1 then
			
				bullet_fired = bullet_fired - 1
				
				if bullet_fired == 0 then
					game_direction = 0
					bullet_fired = 5
				else
		
					local t = Bullet:new(game_direction,turret_angle1,turret_force1)
					t:insert(lists.x)
				end
			
			end
		end	
		
		if data == "GAMESTART" then
			-- passar do estado menu para o estado Jogo
			if gamestate == "menu" then
				gamestate = "running"
			end
		end
		
	end	
end

