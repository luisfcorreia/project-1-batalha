-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- conf.lua
-----------------------------------------------------------
function love.conf(t)
	t.title = "batalha, com fisgas"
	t.modules.audio = false
	t.modules.sound = false
	t.modules.physics = false
	t.modules.joystick = false
	t.modules.native = false
	t.modules.font = true
	t.screen.width = 800
	t.screen.height = 480
	t.screen.fullscreen = false
end

