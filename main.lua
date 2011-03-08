-------------------------------------------------
-- batalha server for IHM & TSWI
-- By: luisfcorreia
-------------------------------------------------

require("LUBE.lua")
require("math")

function love.load()
--	muzik = love.audio.newSource("musica.ogg");
--	love.audio.play(muzik, 0);

	lube.server:Init(8169,"tcp")
	lube.server:setPing(true, 2, "PING!")
	lube.server:setHandshake("#batalha*")
	lube.server:setCallback(updatedata, connect, disconnect)
	gamestarted = false
	Players = {}
	numclients = 0

	texto = 0

	x = 0
	y = 0
	radius = 100
	rad = 0.0174532925
	
    s_x = 400
    s_y = 240
	
	love.graphics.setLine(5,"smooth")
end

function love.update(dt)
	lube.server:update(dt)
	lube.server:acceptAll()
  
	x = s_x + (radius * math.cos(texto*rad))
	y = s_y - (radius * math.sin(texto*rad))
end

function love.draw()

  love.graphics.setColor( 126, 126, 126, 128 )
 
  love.graphics.rectangle( "fill", 0, 450, 800, 480 )
  love.graphics.rectangle( "fill", 350, 500, 50, 200 )
	
	
  love.graphics.setColor( 226, 156, 26, 248 )
  love.graphics.print("This:" .. texto, 10, 50)
  love.graphics.print(numclients, 10, 80)
  
  love.graphics.line(s_x,s_y,x,y)
end

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
	texto = data

		
end

