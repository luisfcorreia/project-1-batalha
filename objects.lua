-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
--
-- objects.lua
-----------------------------------------------------------
function create_object_belt1()
	-- -----------------------------------------------------------------------------------------------------
	Belt = Object:new()
	Belt.__index = Belt
	setmetatable(Belt, Object)

	Belt.new = function(self, n)

		local o = {}

		o.r = 30
		o.d = o.r*2
		o.half_c = math.pi*o.r
		o.c = 2*o.half_c
		o.x = 200
		o.y = 300
		o.th = 1
		o.ta = 1
		o.w = o.th*o.half_c
		o.total = o.th*2+o.ta*2
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
			love.graphics.draw(images.belt_tooth, b.x, b.y)
		end
	end
end

function create_object_belt2()
	-- -----------------------------------------------------------------------------------------------------
	Belt2 = Object:new()
	Belt2.__index = Belt2
	setmetatable(Belt2, Object)

	Belt2.new = function(self, n,x)

		local o = {}

		o.r = 30
		o.d = o.r*2
		o.half_c = math.pi*o.r
		o.c = 2*o.half_c
		o.x = x
		o.y = 300
		o.th = 1
		o.ta = 1
		o.w = o.th*o.half_c
		o.total = o.th*2+o.ta*2
		o.teeth = {}

		for i=0,n-1 do
			local b = { x = 0, y = 0, t = (o.total/n)*i }
			table.insert(o.teeth, b)
		end

		setmetatable(o, Belt2)
		return o
	end

	Belt2.update = function(self, dt)
		for i,b in ipairs(self.teeth) do
			b.t = b.t + dt
			local pi = -math.pi

			if b.t < self.th then
				local t = b.t
				b.x = self.x + self.w * (t/self.th)
				b.y = self.y + self.d
			elseif b.t < self.th + self.ta then
				local t = (self.th + self.ta - b.t)
				b.x = self.x + self.w + math.cos(-pi*t + pi/2)*self.r
				b.y = self.y + self.r + math.sin(-pi*t + pi/2)*self.r
			elseif b.t < self.th*2 + self.ta then
				local t = (b.t - self.th*2 + self.ta)/self.th
				b.x = self.x + self.w * (2-t)
				b.y = self.y 
			elseif b.t < self.total then
				local t = (self.th*2 + self.ta - b.t)
				b.x = self.x + math.cos(-math.pi*t + pi/2)*-self.r
				b.y = self.y + self.r + math.sin(-pi*t + pi/2)*self.r
			else
				b.t = b.t - self.total
			end
		end
	end

	Belt2.draw = function(self)
		for i,b in ipairs(self.teeth) do
			love.graphics.draw(images.belt_tooth, b.x, b.y)
		end
	end
end

function create_object_tank1()
	-- -----------------------------------------------------------------------------------------------------
	Tank = Object:new()
	Tank.__index = Tank
	setmetatable(Tank, Object)

	Tank.new = function(self)
		local o = {}
		o.x = 50
		o.y = 414
		o.i = 49
		o.belt = Belt:new(30)
		o.belt.x = o.x-7
		o.belt.y = o.y-37
		o.angle = 0
		setmetatable(o, Tank)
		return o
	end

	Tank.update = function(self, dt)
		self.angle = self.angle + dt * math.pi/2
		self.belt:update(game_direction,dt)
	end

	Tank.draw = function(self)
		love.graphics.draw(images.turret_cannon_00, self.x+80, self.y-60,(texto)*-rad,self.scale,self.scale,32,32)
	
--		love.graphics.draw(images.turret_cannon_00, self.x+60, self.y-60,self.angle,self.scale,self.scale,32,32)
		love.graphics.draw(images.turret_body, self.x-12, self.y-110)
		love.graphics.draw(images.belt_track, self.belt.x-75, self.belt.y-28)		
		love.graphics.draw(images.wheel, self.x, self.y, self.angle, 1, 1, 32, 32)
		love.graphics.draw(images.wheel, self.x+self.i, self.y, self.angle, 1, 1, 32, 32)
		love.graphics.draw(images.wheel, self.x+self.i*2, self.y, self.angle, 1, 1, 32, 32)
		self.belt:draw()
	end
end

function create_object_tank2()
	-- -----------------------------------------------------------------------------------------------------
	Tank2 = Object:new()
	Tank2.__index = Tank2
	setmetatable(Tank2, Object)

	Tank2.new = function(self)
		local o = {}
		o.x = 650
		o.y = 414
		o.i = 49
		o.belt = Belt:new(30)
		o.belt.x = o.x-7
		o.belt.y = o.y-37
		o.angle = 0
		o.angle2 = 0
		o.scale = 1
		setmetatable(o, Tank2)
		return o
	end

	Tank2.update = function(self, dt)
		self.angle = self.angle + dt * math.pi/2
		self.angle2 = self.angle2 + dt * -math.pi/2
		self.belt:update(game_direction,dt)
	end

	Tank2.draw = function(self)
		love.graphics.draw(images.turret_cannon_00, self.x+30, self.y-60,(texto-180)*rad,self.scale,self.scale,32,32)
		love.graphics.draw(images.turret_body, self.x-12, self.y-110)--,0,self.scale,self.scale,32,32)
		love.graphics.draw(images.belt_track, self.belt.x-74, self.belt.y-28)--,0,self.scale,self.scale,32,32)
		love.graphics.draw(images.wheel, self.x, self.y, 0,self.scale,self.scale,32,32)
		love.graphics.draw(images.wheel, self.x+self.i, self.y, 0,self.scale,self.scale,32,32)
		love.graphics.draw(images.wheel, self.x+self.i*2, self.y, 0,self.scale,self.scale,32,32)
		self.belt:draw()
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
		o.x = 800 + math.random(0, 800)
		o.y = math.random(0, 150)
		o.alpha = math.random(64, 248)
		o.scale = 1/math.random(1, 4)
		o.xt = -700;
		o.dx = o.xt - o.x
		o.speed = math.random(10, 160)
		o.duration = -o.dx/o.speed
		
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
			self.passed = self.passed - self.tick
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
		f = List:new()
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
		self.passed = self.passed + dt
		while self.passed > self.duration do
			self.passed = self.passed - self.duration
		end
		self.t = self.passed/self.duration
	end

	Object.draw = function(self)
		if self.image then
			local x = self.x
			if game_direction == 1 then
				x = self.x + self.dx*self.t
			else
				x = self.x - self.dx*self.t
			end
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
		"star",
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

