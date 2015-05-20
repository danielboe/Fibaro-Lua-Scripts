--[[
%% properties

%% globals
Zimmer
Nacht
auto_off_zimmer
--]]


--passendes licht script zum anwesenheits-script
--verschiedene beleuchtungen, je nach status der variable

-----------------------------------------------------------------------------------------------------------------------------------------
local scene = 8-- ID dieser Szene
local licht = 132 -- ID Lichtsensor
local switch = 122 -- ID der LED Leiste
local switch2 = 150 -- ID Licht

local lichtwert = 55 -- Wert für "Genug Tageslicht" grenze (licht bleibt dann aus)

local Zimmer = fibaro:getGlobalValue("Zimmer") -- ZIMMER (anwesenheit zimmer, siehe auch anwesenheitsscript)
local NACHT = tonumber(fibaro:getGlobalValue("Nacht")) --NACHT (nacht variable 1/0)
local AUTO = tonumber(fibaro:getGlobalValue("auto_off_zimmer")) --AUTO (auto off, globale variable um automatische scripts zu deaktivieren)
-----------------------------------------------------------------------------------------------------------------------------------------

fibaro:debug("start1") 
if (fibaro:countScenes()>2) or AUTO == 1 then
	fibaro:debug("stop scene") 
	fibaro:abort()
end
-- SCHALTE LICHT EIN & AUS (wenn nicht nacht)
if tonumber(Zimmer) > 0 and  tonumber(fibaro:getValue(licht, "value")) < lichtwert and NACHT == 0 then
	fibaro:debug("ausgelöst")
	if tonumber(Zimmer) < 3 then
  		fibaro:call(switch, "setColor", "255", "235", "170", "0")
    	fibaro:debug("stat1")    	
    	if tonumber(Zimmer) == 2 then
        fibaro:call(switch, "turnOn") --lampe an
        fibaro:debug("stat2")
    	end
    fibaro:abort()
 	end
  	if tonumber(Zimmer) == 3 then
    	fibaro:call(switch, "turnOff")
    	fibaro:call(switch2, "turnOn") --lampe an
    	fibaro:debug("stat3")
    	fibaro:abort()
  	end
end
if tonumber(Zimmer) < 1 then
	fibaro:call(switch, "turnOff")
	fibaro:call(switch2, "turnOff") --lampe aus
	fibaro:killScenes(scene)
end
