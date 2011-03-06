-------------------------------------------------
-- batalha server for IHM & TSWI
-- By: luisfcorreia
-------------------------------------------------

require("LUBE.lua")

function love.load()
--	muzik = love.audio.newSource("musica.ogg");
--	love.audio.play(muzik, 0);

end

function love.update(dt)
  lube.server:update(dt)
end

function love.draw()

  love.graphics.setColor( 126, 126, 126, 128 )
 
  love.graphics.rectangle( "fill", 0, 700, 1024, 768 )
  love.graphics.rectangle( "fill", 500, 500, 50, 200 )
	
	-- love.graphics.draw(textstring, 50, i)
end


