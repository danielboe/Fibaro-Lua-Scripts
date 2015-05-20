--[[
%% properties
132 value
%% globals
PC
Abwesend
--]]

--script zur feststellung von NACHT oder TAG. Wert wird in globale Variable gespeichert.
--verschiedene parameter werden verwendet. Die globalen variablen unten müssen alle angelegt werden


local licht = 132 --licht lux sensor
local AUTO = tonumber(fibaro:getGlobalValue("auto_off_zimmer")) --AUTO (auto off, globale variable um automatische scripts zu deaktivieren)


fibaro:debug("start1") --abbruch bei doppelausführung oder wenn auto 1 ist
if (fibaro:countScenes()>1) or AUTO == 1 then
	fibaro:debug("stop scene");
	fibaro:abort();
end

local licht = tonumber(fibaro:getValue(licht, "value")) --lichtsensor
local dunkelschwelle = 40 --schwelle in lux
local nachtschwelle = 5 --schwelle in lux
local nachtstart = 1600 --22:00 = 2200
local nachtende = 0600 -- 07:00 = 0700

local PC = 0
local ABW = 0
local NACHT = 0
local ZIMMER = 0 
PC = tonumber(fibaro:getGlobalValue("PC")) --PC (PC ein aus)
ABW = tonumber(fibaro:getGlobalValue("Abwesend")) --ABW (abwesend ja nein) NACHT (nacht variable 1/0)
NACHT = tonumber(fibaro:getGlobalValue("Nacht")) --NACHT (nacht variable 1/0)
ZIMMER = tonumber(fibaro:getGlobalValue("Zimmer")) -- ZIMMER (anwesenheit zimmer, siehe auch anwesenheitsscript) 


if ZIMMER == 3 and NACHT == 0 and ABW == 0 and PC == 0 and licht < nachtschwelle then --nacht SET
	if tonumber(os.date("%H%M")) >= nachtstart or tonumber(os.date("%H%M")) <= nachtende then
  	fibaro:setGlobal("Nacht", "1")
  	fibaro:debug("Nacht1");
  	fibaro:abort();
    end
end
if (NACHT == 1 and PC == 1) or (NACHT == 1 and licht > nachtschwelle+3) then --nacht SET
	fibaro:setGlobal("Nacht", "0")
  	fibaro:debug("Nacht0");
  	fibaro:abort();
end
if (ZIMMER == 3 and NACHT == 0 and ABW == 0 and licht < dunkelschwelle and licht > nachtschwelle+5) then 
	fibaro:call(17, "pressButton", "1") --lampe an
  	if (PC == 1) then
    	--lampe schreibtisch an aktion
    end
  	fibaro:debug("Auto-LichtEin");
end  
fibaro:debug("ende") 
fibaro:abort();


