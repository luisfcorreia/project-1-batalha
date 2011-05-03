-----------------------------------------------------------
-- 2011 IHM - Universidade Atlântica
-- (C) Luis Correia
-- utils.lua
-----------------------------------------------------------

function paint_ground()
	-- Ground
	love.graphics.setColor(146, 201, 87)
	love.graphics.rectangle("fill", 0, 460, 800, 70)
	love.graphics.setColor(205, 227, 161)
	love.graphics.rectangle("fill", 0, 450, 800, 10)
end

-- Collision detection function.
-- Checks if box1 and box2 overlap.
-- w and h mean width and height.
function CheckCollision(box1x, box1y, box1w, box1h, box2x, box2y, box2w, box2h)
    if box1x > box2x + box2w - 1 or -- Is box1 on the right side of box2?
       box1y > box2y + box2h - 1 or -- Is box1 under box2?
       box2x > box1x + box1w - 1 or -- Is box2 on the right side of box1?
       box2y > box1y + box1h - 1    -- Is b2 under b1?
    then
        return false                -- No collision. Yay!
    else
        return true                 -- Yes collision. Ouch!
    end
end


--[[
-- mark shots that are not visible for removal
if v.y < 0 then 			
table.insert(remShot, i) 		
end 		 		
-- check for collision with enemies 		
for ii,vv in ipairs(enemies) do 			
if CheckCollision(v.x,v.y,2,5, vv.x,vv.y,vv.width,vv.height) then 				 				
-- mark that enemy for removal 				
table.insert(remEnemy, ii) 				
-- mark the shot to be removed 				
table.insert(remShot, i) 				 			
end 		
end 		 		 		 	
end 	 	 	
-- remove the marked enemies 	
for i,v in ipairs(remEnemy) do 		
table.remove(enemies, v) 	
end 	 	

for i,v in ipairs(remShot) do 		
table.remove(hero.shots, v) 	
end 	 	 	 	
-- update those evil enemies 	
for i,v in ipairs(enemies) do 		
-- let them fall down slowly 		
v.y = v.y + dt 		 		
-- check for collision with ground 		
if v.y > 465 then
	-- you loose!!!
end

]]

