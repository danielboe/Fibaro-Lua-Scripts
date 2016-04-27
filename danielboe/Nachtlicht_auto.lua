--[[
%% properties

%% globals
Zimmer
auto_off_zimmer
--]]

--startet gedimmtes nachtlicht, wenn NACHT status. optimal, um nicht hinzufallen :)
--benötigt anwesenheitsvariable und Script

------------------------------------------------------------------
local door = 134-- ID des türkontakts
local switch = 122 -- ID der LED Leiste

local ZIMMER = 0
local NACHT = 0
local AUTO = tonumber(fibaro:getGlobalValue("auto_off_zimmer")) --AUTO (auto off, globale variable um automatische scripts zu deaktivieren)
ZIMMER = tonumber(fibaro:getGlobalValue("Zimmer"))  -- ZIMMER (anwesenheit zimmer, siehe auch anwesenheitsscript)
NACHT = tonumber(fibaro:getGlobalValue("Nacht")) --NACHT (nacht variable 1/0)

if NACHT == 0 or AUTO == 1 then
	fibaro:debug("stop scene") 
	fibaro:abort()
end

fibaro:debug("start")
if ZIMMER == 0 then
  fibaro:call(switch, "turnOff")
  fibaro:abort()
end
if NACHT == 1 and ZIMMER < 3 then	
  	--led auf nachtlicht und ein
  	fibaro:call(switch, "setColor", "25", "1", "1", "0")
  	fibaro:abort()
end
if NACHT == 1 and ZIMMER == 3 then	
  	--led aus, wenn anwesend
	fibaro:call(switch, "turnOff")
	fibaro:debug("led aus")
end
fibaro:debug("ende")