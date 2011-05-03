-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- mainmenu.lua
-----------------------------------------------------------

function tank_draw()


end

function tank_update()


end

function tank_setup()

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
	tanque.scale = 0.5
end

--[[
	Belt.update = function(self, dir, dt)
		for i,b in ipairs(self.teeth) do
			b.t = b.t + dt
			local pi
			if dir == 1 then
				pi = math.pi
			else
				pi = -math.pi
			end
			if b.t < self.th then
				local t = b.t
				b.x = self.x + self.w * (t/self.th)
				if dir == 1 then
					b.y = self.y
				else
					b.y = self.y + self.d
				end
			elseif b.t < self.th + self.ta then
				local t = (self.th + self.ta - b.t)
				b.x = self.x + self.w + math.cos(-pi*t + pi/2)*self.r
				b.y = self.y + self.r + math.sin(-pi*t + pi/2)*self.r
			elseif b.t < self.th*2 + self.ta then
				local t = (b.t - self.th*2 + self.ta)/self.th
				b.x = self.x + self.w * (2-t)
				if dir == 1 then
					b.y = self.y + self.d
				else
					b.y = self.y
				end
			elseif b.t < self.total then
				local t = (self.th*2 + self.ta - b.t)
				b.x = self.x + math.cos(-pi*t + pi/2)*self.r
				b.y = self.y + self.r + math.sin(-pi*t + pi/2)*self.r
			else
				b.t = b.t - self.total
			end
		end
	end

	Belt.draw = function(self)
		for i,b in ipairs(self.teeth) do
			love.graphics.draw(images.belt_tooth, b.x, b.y, 0, self.scale,self.scale,1,1)
		end
	end
end


	Tank.draw = function(self)
		love.graphics.draw(images.turret_cannon_00, self.x+pos, self.y-16,angle,self.scale,self.scale,32,32)
		love.graphics.draw(images.turret_body, self.x+10, self.y-40, 0, self.scale,self.scale,1,1)
		love.graphics.draw(images.belt_track, self.belt.x-37, self.belt.y-14, 0, self.scale,self.scale,1,1)		
		love.graphics.draw(images.wheel, self.x, self.y, 0, self.scale,self.scale,1,1)
		love.graphics.draw(images.wheel, self.x+self.i, self.y, 0, self.scale,self.scale,1,1)
		love.graphics.draw(images.wheel, self.x+self.i*2, self.y, 0, self.scale,self.scale,1,1)
		self.belt:draw()
	end

end
]]
