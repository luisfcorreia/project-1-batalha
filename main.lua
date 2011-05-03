-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- main.lua
-----------------------------------------------------------
require("utils.lua")
require("globals.lua")
require("objects.lua")
require("network.lua")
require("mainmenu.lua")

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
	create_object_bullet()
	
	init_timers()
	
	tank_setup()
	
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
    if love.keyboard.isDown(' ') then
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
		    if turret_angle1 >= turret_max_angle then
		    	turret_angle1 = turret_max_angle
		    end
    	else
		    turret_angle2 = turret_angle2 + 1
		    if turret_angle2 >= turret_max_angle then
		    	turret_angle2 = turret_max_angle
		    end
	    end
    end
    if love.keyboard.isDown('down') then
    	if game_direction == 1 then
		    turret_angle1 = turret_angle1 - 1
		    if turret_angle1 <= turret_min_angle then
		    	turret_angle1 = turret_min_angle
		    end
    	else
		    turret_angle2 = turret_angle2 - 1
		    if turret_angle2 <= turret_min_angle then
		    	turret_angle2 = turret_min_angle
		    end
	    end
    end

    if love.keyboard.isDown('1') then
    	if game_direction == 1 then
			if bullet1_active == 0 then
				local t = Bullet:new(game_direction,turret_angle1,40)
				t:insert(lists.x)
				bullet1_active = 1
			end    
		end    
    end

    if love.keyboard.isDown('2') then
    	if game_direction == 0 then
--			if bullet2_active == 0 then
				local t = Bullet:new(game_direction,turret_angle2,40)
				t:insert(lists.x)
				bullet2_active = 1
--			end    
		end    
    end

    if love.keyboard.isDown('escape') then
        love.event.push('q') -- quit the game
    end
end

function love.update(dt)

	lube.server:update(dt)
	lube.server:acceptAll()

	if gamestate == "menu" then
		--
		tank_update()
		  
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
		paint_ground()
		tank_draw()
		  
		--  
	elseif gamestate == "running" then
		--
		-- draw background objects
		lists.b:draw()
		
		paint_ground()
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(myownIP,10,10)

	
		-- draw foreground objects
		lists.f:draw()

		-- draw bullets
		lists.x:draw()
		

		--
	elseif gamestate == "gamewon" then
		--
		--
	elseif gamestate == "gamelost" then
		--
		--
	end

end

