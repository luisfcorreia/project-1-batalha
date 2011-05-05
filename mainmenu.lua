-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- mainmenu.lua
-----------------------------------------------------------

function m_tank_draw()
	love.graphics.draw(images.turret_cannon_00, tanque.x+50, tanque.y-16,tanque.angle,tanque.scale,tanque.scale,32,32)
	love.graphics.draw(images.turret_body, tanque.x+10, tanque.y-40, 0, tanque.scale,tanque.scale,1,1)
	love.graphics.draw(images.belt_track, tanque.x-37+14, tanque.y-14-3, 0, tanque.scale,tanque.scale,1,1)		
	love.graphics.draw(images.wheel, tanque.x, tanque.y, 0, tanque.scale,tanque.scale,1,1)
	love.graphics.draw(images.wheel, tanque.x+tanque.i, tanque.y, 0, tanque.scale,tanque.scale,1,1)
	love.graphics.draw(images.wheel, tanque.x+tanque.i*2, tanque.y, 0, tanque.scale,tanque.scale,1,1)
	--tanque.belt:draw()
	for i,b in ipairs(tanque.bteeth) do
		love.graphics.draw(images.belt_tooth, tanque.x + b.x, tanque.y + b.y, 0, tanque.scale,tanque.scale,1,1)
	end
end

function m_tank_belt_update(dt)
	for i,b in ipairs(tanque.bteeth) do
		b.t = b.t + dt
		local pi
		pi = math.pi

		if b.t < tanque.bth then
			local t = b.t
			b.x = tanque.bx + tanque.bw * (t/tanque.bth)
			b.y = tanque.by
		elseif b.t < tanque.bth + tanque.bta then
			local t = (tanque.bth + tanque.bta - b.t)
			b.x = tanque.bx + tanque.bw + math.cos(-pi*t + pi/2)*tanque.br
			b.y = tanque.by + tanque.br + math.sin(-pi*t + pi/2)*tanque.br
		elseif b.t < tanque.bth*2 + tanque.bta then
			local t = (b.t - tanque.bth*2 + tanque.bta)/tanque.bth
			b.x = tanque.bx + tanque.bw * (2-t)
			b.y = tanque.by + tanque.bd
		elseif b.t < tanque.btotal then
			local t = (tanque.bth*2 + tanque.bta - b.t)
			b.x = tanque.bx + math.cos(-pi*t + pi/2)*tanque.br
			b.y = tanque.by + tanque.br + math.sin(-pi*t + pi/2)*tanque.br
		else
			b.t = b.t - tanque.btotal
		end
	end
end

function m_tank_update(dt)
	m_tank_mainx = m_tank_mainx + (50 * dt)

	if m_tank_mainx >= screen_width then
		m_tank_mainx = -70
	end

	tanque.x = m_tank_mainx
	tanque.angle = tanque.angle + dt*5
	m_tank_belt_update(dt)
end

function m_tank_setup()

	tanque.br = 15

	tanque.bd = tanque.br*2
	tanque.bhalf_c = math.pi*tanque.br
	tanque.bc = 2*tanque.bhalf_c
	tanque.bth = 1
	tanque.bta = 1
	tanque.bw = tanque.bth*tanque.bhalf_c
	tanque.btotal = tanque.bth*2+tanque.bta*2
	tanque.bscale = 0.5
	tanque.bteeth = {}
	for i=0,29 do
		local b = { 
			x = 0, 
			y = 0, 
			t = (tanque.btotal/30)*i
		}
		table.insert(tanque.bteeth, b)
	end
	tanque.x = 10
	tanque.y = 416
	tanque.i = 25
	tanque.bx = tanque.x+14
	tanque.by = tanque.y-3
	tanque.bx = 14
	tanque.by = -3
	tanque.angle = 50
	tanque.scale = 0.5
end


