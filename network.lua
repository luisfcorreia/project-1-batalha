-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
--
-- network.lua
-----------------------------------------------------------
require("LUBE.lua")

function connect(ip, port)
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
end

function disconnect(ip, port)

end

function updatedata(data, ip, port)
	-- processar os dados que vem do android
	texto = tonumber(data)
	if texto > 89 then
		texto = 90
	end
end

