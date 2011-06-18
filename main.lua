-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- main.lua
-----------------------------------------------------------
require("globals.lua")
require("network.lua")
require("utils.lua")
require("mainmenu.lua")
require("objects.lua")

function love.load()

	love.graphics.setBackgroundColor(0x84, 0xca, 0xff)
	love.graphics.setColor(255, 255, 255, 255)

	load_images()

	init_object_structs()

	create_object_belt()
	create_object_tank1()
	create_object_tank2()
	create_object_cloud()
	create_object_bubble()
	create_object_bullet()
	
	init_timers()
	
	m_tank_setup()
	
   --  Interval value = Animation's Delay time * The number of Animation's frame
   -- 100 ms * 2 frame = 200 ms (Interval)
   love.keyboard.setKeyRepeat(5, 75)

	do
		local t = Bubble:new()
		--t:insert(lists.f)
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

	if server_started == 0 then
		server_start(8169)
		server_started = 1
	end
end

function love.keypressed(k)
    if love.keyboard.isDown(' ') then
    	if game_direction == 1 then
    		game_direction = 0
    		bullet1_active = 0
    	else
	    	game_direction = 1
    		bullet2_active = 0
	    end
    end
--    if k == 'up' then

    if love.keyboard.isDown('2') then
    	if game_direction == 0 then
--			if bullet2_active == 0 then

				turret_angle2 = random_angle()
				
				local t = Bullet:new(game_direction,turret_angle2,random_force())
				t:insert(lists.x)
				bullet2_active = 1
--			end    
		end    
    end

    if gamestate == "menu" then
        if love.keyboard.isDown('s') then
		    gamestate = "running" -- quit the game
		end
	
    end

    if love.keyboard.isDown('escape') then
    	if gamestate == "running" then
	    	gamestate = "menu" -- quit the game
    	elseif gamestate == "menu" then
        	love.event.push('q') -- quit the game
    	end
    end
end

function love.update(dt)

	if server_started == 1 then
		lube.server:update(dt)
		lube.server:acceptAll()
	end


	if gamestate == "menu" then
		--
		m_tank_update(dt)
		for i,v in pairs(lists) do
			v:update(dt)
		end		  
		init_globals()
		--  
	elseif gamestate == "running" then
	
		--
		for i,v in pairs(timers) do 
			v:update(dt)
		end

		for i,v in pairs(lists) do
			v:update(dt)
		end
		
		if game_direction == 0 then
		
			bullet_dt = bullet_dt + dt
		
			if math.floor(bullet_dt % 5) == 1 then
		
				bullet_dt = 0
		
				if bullet_fired == 0 then

					game_direction = 1
					bullet_fired = 5

				else

					bullet_fired = bullet_fired - 1
			
					turret_angle2 = random_angle()
	
					local t = Bullet:new(game_direction,turret_angle2,random_force())
					t:insert(lists.x)
					bullet2_active = 1

				end
			end
		
		end
		--
	elseif gamestate == "gamewon" then
		--
		-- reset colors		--
	elseif gamestate == "gamelost" then
		--
		--
	end

	love.timer.sleep(10)
end

function love.draw()

	if gamestate == "menu" then
		--
		-- draw background objects
		lists.b:draw()		--
		
		paint_ground()
		m_tank_draw()
		  
		--  
	elseif gamestate == "running" then
	
		--
		-- draw background objects
		lists.b:draw()

		-- draw bullets
		lists.x:draw()
			
		paint_ground()

		-- draw foreground objects
		lists.f:draw()
		
		paint_shield_bars()
		
--[[
		-- debug tank position
		love.graphics.setColor(123, 123, 255, 50)
		love.graphics.rectangle("fill",   5, 385, 90, 65)
		love.graphics.rectangle("fill", 705, 385, 90, 65)
]]--		

		--
	elseif gamestate == "gamewon" then
		--
		love.graphics.setColor(123, 123, 255, 255)
		love.graphics.print("Tank 1 WINS!",10,10)
		-- Ground
		love.graphics.setColor(146, 201, 87, 255)
		love.graphics.rectangle("fill", 0, 460, 800, 70)
		love.graphics.setColor(205, 227, 161, 255)
		love.graphics.rectangle("fill", 0, 450, 800, 10)
		--
	elseif gamestate == "gamelost" then
		--
		love.graphics.setColor(123, 123, 255, 255)
		love.graphics.print("Tank 2 WINS!",10,10)
		-- Ground
		love.graphics.setColor(146, 201, 87, 255)
		love.graphics.rectangle("fill", 0, 460, 800, 70)
		love.graphics.setColor(205, 227, 161, 255)
		love.graphics.rectangle("fill", 0, 450, 800, 10)
		-- reset colors
		--
	end

end

