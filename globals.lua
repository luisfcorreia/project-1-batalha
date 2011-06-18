-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- objects.lua
-----------------------------------------------------------
rad = 0.0174532925
gamestate = "running"
gamestate = "menu"
game_direction = 1
server_started = 0

gravity = 1

turret_max_angle = 85
turret_min_angle = 5

turret_angle1 = 5
turret_angle2 = 5

bullet1_active = 0
bullet1_speed = 0

bullet2_active = 0
bullet2_speed = 0

bullet_fired = 5
bullet_dt = 5

screen_width = love.graphics.getWidth()
screen_height = love.graphics.getHeight()

tank1_shield = 200
tank2_shield = 200

-- maradisses para o mainmenu :P
tanque = {}
m_tank_mainx = 0
m_tank_angle = 1

function init_globals()
	tank1_shield = 200
	tank2_shield = 200
end
