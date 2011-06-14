-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- objects.lua
-----------------------------------------------------------
function create_object_belt()
	-- -----------------------------------------------------------------------------------------------------
	Belt = Object:new()
	Belt.__index = Belt
	setmetatable(Belt, Object)

	Belt.new = function(self, n)

		local o = {}

		o.r = 15
		o.d = o.r*2
		o.half_c = math.pi*o.r
		o.c = 2*o.half_c
		o.x = 200
		o.y = 300
		o.th = 1
		o.ta = 1
		o.w = o.th*o.half_c
		o.total = o.th*2+o.ta*2
		o.scale = 0.5
		o.teeth = {}

		for i=0,n-1 do
			local b = { x = 0, y = 0, t = (o.total/n)*i }
			table.insert(o.teeth, b)
		end

		setmetatable(o, Belt)
		return o
	end

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

function tank_draw(self,angle,pos)
	love.graphics.draw(images.turret_cannon_00, self.x+pos, self.y-16,angle,self.scale,self.scale,32,32)
	love.graphics.draw(images.turret_body, self.x+10, self.y-40, 0, self.scale,self.scale,1,1)
	love.graphics.draw(images.belt_track, self.belt.x-37, self.belt.y-14, 0, self.scale,self.scale,1,1)		
	love.graphics.draw(images.wheel, self.x, self.y, 0, self.scale,self.scale,1,1)
	love.graphics.draw(images.wheel, self.x+self.i, self.y, 0, self.scale,self.scale,1,1)
	love.graphics.draw(images.wheel, self.x+self.i*2, self.y, 0, self.scale,self.scale,1,1)
	self.belt:draw()
end

function create_object_tank1()
	-- -----------------------------------------------------------------------------------------------------
	Tank = Object:new()
	Tank.__index = Tank
	setmetatable(Tank, Object)

	Tank.new = function(self)
		local o = {}
		o.x = 10
		o.y = 416
		o.i = 25
		o.belt = Belt:new(30)
		o.belt.x = o.x+14
		o.belt.y = o.y-3
		o.scale = 0.5
		setmetatable(o, Tank)
		return o
	end

	Tank.update = function(self, dt)
		self.belt:update(game_direction,dt)
	end

	Tank.draw = function(self)
		tank_draw(self,(turret_angle1)*-rad,50)
	end
end

function create_object_tank2()
	-- -----------------------------------------------------------------------------------------------------
	Tank2 = Object:new()
	Tank2.__index = Tank2
	setmetatable(Tank2, Object)

	Tank2.new = function(self)
		local o = {}
		o.x = 710
		o.y = 416
		o.i = 25
		o.belt = Belt:new(30)
		o.belt.x = o.x+14
		o.belt.y = o.y-3
		o.scale = 0.5
		setmetatable(o, Tank2)
		return o
	end

	Tank2.update = function(self, dt)
		self.belt:update(game_direction,dt)
	end

	Tank2.draw = function(self)
		tank_draw(self,(turret_angle2-180)*rad,34)
	end
end

function create_object_cloud()
	-- -----------------------------------------------------------------------------------------------------
	Cloud = Object:new()
	Cloud.__index = Cloud
	setmetatable(Cloud, Object)

	Cloud.new = function(self)
		local o = {}
		o.image = images["cloud_plain_"..tostring(math.random(1,5))]
		o.x = 800
		o.y = math.random(0, 140)
		o.alpha = math.random(64, 248)
		o.scale = 1/math.random(1, 4)
		o.xt = -200;
		o.dx = o.xt - o.x
		o.speed = math.random(10, 160)
		o.duration = -o.dx/o.speed
		o.l = 1
		
		setmetatable(o, Cloud)
		return o
	end
end

function create_object_bubble()
	-- -----------------------------------------------------------------------------------------------------
	Bubble = Object:new()
	Bubble.__index = Bubble
	setmetatable(Bubble, Object)

	Bubble.new = function(self)
		local o = {}
		o.x = 40
		o.y = 20
		o.angle = 0
		setmetatable(o, Bubble)
		return o
	end

	Bubble.update = function(self, dt)
		self.angle = self.angle + dt*5
	end

	Bubble.draw = function(self)
		local yv = math.sin(self.angle)*5
		love.graphics.draw(images.bubble, self.x, self.y+yv)
		love.graphics.draw(images.ownip, self.x+94, self.y+yv+84,0,1,1,1,1)
	end
end

function create_object_bullet()
	-- -----------------------------------------------------------------------------------------------------
	Bullet = Object:new()
	Bullet.__index = Bullet
	setmetatable(Bullet, Object)

	Bullet.new = function(self,direction,angle,force)
		local o = {}
		o.image = images["bullet"]
		o.t = 0
		if direction == 0 then
			angulo = (270 - angle) * rad
			bullet2_active = 1
			o.x = 740  
			o.y = 370
		else
			angulo = (90 + angle) * rad
			bullet1_active = 1
			o.x = 50 +25 
			o.y = 370 
		end
		o.scale = 0.5
		o.anglex = math.sin(angulo)
		o.angley = math.cos(angulo)
		o.speedx = force * o.anglex
		o.speedy = force * o.angley
		o.alpha = 255
		setmetatable(o, Bullet)
		return o
	end

	Bullet.update = function(self, dt)
		local d = 0
		self.x = self.x + (dt + self.speedx)
		self.y = self.y + (dt + self.speedy)
		self.speedy = (self.speedy + 1) * gravity
		self.speedx = self.speedx * gravity


--		love.graphics.rectangle("fill",   5, 385, 90, 65)
--		love.graphics.rectangle("fill", 705, 385, 90, 65)


		-- right Tank
--		if CheckCollision(self.x, self.y, 34, 34, 710, 400, 80, 80) then
		if game_direction == 1 and CheckCollision(self.x, self.y, 34, 34, 705, 385, 90, 65) then
			d = 1
			tank2_shield = tank2_shield - 1 
			if tank2_shield == 0 then 
				gamestate = "gamewon"
			end
		end

		-- left Tank
--		if CheckCollision(self.x, self.y, 34, 34, 10, 400, 80, 80) then
		if game_direction == 0 and CheckCollision(self.x, self.y, 34, 34,  5, 385, 90, 65) then
			d = 1
			tank1_shield = tank1_shield - 1 
			if tank1_shield == 0 then 
				gamestate = "gamelost"
			end
		end
--[[
		-- ground
		if CheckCollision(self.x, self.y, 34, 34, 0, 470, 800, 30) then
			d = 1
		end
]]--
		if d == 1 then
--			self = nil
			self.image = images["bullet-2"]
		else
			self.image = images["bullet"]
		end
	end

	Bullet.draw = function(self)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(self.image, self.x, self.y,1,self.scale,self.scale)
	end
end


function init_timers()
	-- -----------------------------------------------------------------------------------------------------
	timers = {}

	Timer = {}
	Timer.__index = Timer

	Timer.spawn = function(self, tick, f)
		local o = {
			passed = 0,
			tick = tick,
			f = f
		}
		setmetatable(o, Timer)
		table.insert(timers, o)
	end

	Timer.update = function(self, dt)
		self.passed = self.passed + dt
		while self.passed > self.tick do
			self.passed = self.passed + self.tick
			self.f()
		end
	end
end


function init_object_structs()

	List = {}
	List.__index = List

	List.new = function(self)
		local o = {
			head = nil,
		}
		setmetatable(o, List)
		return o
	end

	List.update = function(self, dt)
		local n = self.head
		while n do
			n:update(dt)
			n = n.next
		end
	end

	List.draw = function(self)
		local n = self.head
		while n do
			n:draw()
			n = n.next
		end
	end

	lists = {
		b = List:new(),
		f = List:new(),
		x = List:new()
	}

-- -----------------------------------------------------------------------------------------------------
	Node = {}
	Node.__index = Node

	Node.new = function(self, object)
		local o = {
			next = nil,
		}
		setmetatable(o, List)
		return o
	end

	Node.insert = function(self, list)
		local h = list.head
		list.head = self
		self.next = h
	end

	Node.remove = function(self)
		parent.next = self.next
	end

-- -----------------------------------------------------------------------------------------------------
	Object = Node:new()
	Object.__index = Object
	setmetatable(Object, Node)

	Object.new = function(self)
		local o = {
			image = nil,
			x = 0,
			y = 0,
			dx = -400,
			dy = 0,
			scale = 1,
			r = 0,
			duration = 30,
			passed = 0,
			t = 0,
			alpha = 255
		}
		setmetatable(o, Object)
		return o
	end

	Object.update = function(self, dt)
		if game_direction == 1 then
			self.passed = self.passed + dt
		else
			self.passed = self.passed - dt
		end
		while self.passed > self.duration do
			if game_direction == 1 then
				self.passed = self.passed - self.duration
			else
				self.passed = self.passed + self.duration
			end
		end
		self.t = self.passed/self.duration
	end

	Object.draw = function(self)
		if self.image then
			local x = self.x
			x = self.x + self.dx*self.t
			local y = self.y + self.dy*self.t
			local r = self.r*self.t
			love.graphics.setColor(255, 255, 255, self.alpha)
			love.graphics.draw(self.image, x, y, r, self.scale)
			love.graphics.setColor(255, 255, 255, 255)
		end
	end
end

function load_images()
	names = {
		"wheel",
		"belt_tooth",
		"belt_track",
		"turret_body",
		"turret_cannon_00",
		"tree01",
		"star",
		"bullet",
		"bullet-2",
--		"cloud_plain_1",
		"cloud_plain_2",
		"cloud_plain_3",
		"cloud_plain_4",
		"cloud_plain_5",
		"bubble",
		"ownip",
	}

	images = {}

	for i,v in pairs(names) do
		images[v] = love.graphics.newImage(v..".png")
	end
end


