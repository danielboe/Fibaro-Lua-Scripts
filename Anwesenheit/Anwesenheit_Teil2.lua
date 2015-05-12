--[[
%% properties
130 value
%% globals
--]]

-----------------------------------------------------------------------------------------------------------------------------------------
local scene = 7-- ID dieser Szene
local motion = 130 -- ID des Bewegungssensors 
local door = 134 -- türsensor ID
------------------------------------------------------

-- sichere anwesenheit trigger

fibaro:debug("--") 
if (fibaro:countScenes()>1) or tonumber(fibaro:getGlobalValue("Zimmer")) > 2 then
	fibaro:debug("stop scene") 
	fibaro:abort()
end
if tonumber(fibaro:getValue(door, "value")) == 0 and tonumber(fibaro:getValue(motion, "value")) > 0 then
	fibaro:setGlobal("Zimmer", "3")
	fibaro:debug("zimmer3")
	fibaro:abort()
end
fibaro:debug("---") 
fibaro:killScenes(scene)