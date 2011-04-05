-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- main.lua
-----------------------------------------------------------
require("globals.lua")
require("objects.lua")
require("network.lua")

function love.load()

	server_start(8169)

	love.graphics.setBackgroundColor(0x84, 0xca, 0xff)

	load_images()

	init_object_structs()

	create_object_belt()
	create_object_tank1()
	create_object_tank2()
	create_object_cloud()
	create_object_bubble()
	
	init_timers()
	
   --  Interval value = Animation's Delay time * The number of Animation's frame
   -- 100 ms * 2 frame = 200 ms (Interval)
   love.keyboard.setKeyRepeat(5, 75)

	do
		local t = Bubble:new()
		t:insert(lists.f)
	end

	do
		local t = Tank:new()
		t:insert(lists.f)
	end

	do
		local t = Tank2:new()
		t:insert(lists.f)
	end
	
	for i=1,25 do
		local t = Cloud:new()
		t:insert(lists.b)
	end

	for i,v in pairs(lists) do
		v:update(10)
	end

end

function love.keypressed(k)
	local t
    if k == ' ' then
    	if game_direction == 1 then
    		game_direction = 0
    	else
	    	game_direction = 1
	    end
    end
--    if k == 'up' then
    
    if love.keyboard.isDown('up') then
    	if game_direction == 1 then
		    turret_angle1 = turret_angle1 + 1
		    if turret_angle1 >= 90 then
		    	turret_angle1 = 90
		    end
    	else
		    turret_angle2 = turret_angle2 + 1
		    if turret_angle2 >= 90 then
		    	turret_angle2 = 90
		    end
	    end
    end
    if k == 'down' then
    	if game_direction == 1 then
		    turret_angle1 = turret_angle1 - 1
		    if turret_angle1 <= 0 then
		    	turret_angle1 = 0
		    end
    	else
		    turret_angle2 = turret_angle2 - 1
		    if turret_angle2 <= 0 then
		    	turret_angle2 = 0
		    end
	    end
    end


    if k == 'escape' then
        love.event.push('q') -- quit the game
    end
end

function love.update(dt)

	lube.server:update(dt)
	lube.server:acceptAll()

	if gamestate == "menu" then
		--  
		--  
	elseif gamestate == "running" then
		--
		for i,v in pairs(timers) do 
			v:update(dt)
		end

		for i,v in pairs(lists) do
			v:update(dt)
		end
		--
	elseif gamestate == "gamewon" then
		--
		--
	elseif gamestate == "gamelost" then
		--
		--
	end

	love.timer.sleep(10)
end

function love.draw()

	if gamestate == "menu" then
		--  
		--  
	elseif gamestate == "running" then
		--
		-- draw background objects
		lists.b:draw()
		-- Ground
		love.graphics.setColor(146, 201, 87)
		love.graphics.rectangle("fill", 0, 460, 800, 70)
		love.graphics.setColor(205, 227, 161)
		love.graphics.rectangle("fill", 0, 450, 800, 10)
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(myownIP,10,10)
		-- draw foreground objects
		lists.f:draw()
		--
	elseif gamestate == "gamewon" then
		--
		--
	elseif gamestate == "gamelost" then
		--
		--
	end

end

