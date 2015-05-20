--[[
%% properties

%% globals
PC
Abwesend
Nacht
auto_off_zimmer
--]]


--szene startet das radio (hier mit dem pc)
--optimal für hifi anlage, welche mit z.b. tv oder pc angehen soll

-----------------------------------------------------------------------------------------------------------------------------------------
local switch = 128 -- ID Radio
local PC = tonumber(fibaro:getGlobalValue("PC")) --PC (PC ein aus)
local ABW = tonumber(fibaro:getGlobalValue("Abwesend")) --ABW (abwesend ja nein) NACHT (nacht variable 1/0)
local NACHT = tonumber(fibaro:getGlobalValue("Nacht")) --NACHT (nacht variable 1/0)
local AUTO = tonumber(fibaro:getGlobalValue("auto_off_zimmer")) --AUTO (auto off, globale variable um automatische scripts zu deaktivieren)
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------Script-----------------

fibaro:debug("start1") 
if (fibaro:countScenes()>3) or AUTO == 1 then
  fibaro:debug("stop scene") 
  fibaro:abort()
end
-- PC an
if NACHT < 1 and ABW < 1 and PC > 0 then
  fibaro:call(switch, "turnOn")
	fibaro:debug("radio an")
  fibaro:abort()
end  
if ABW > 0 or PC < 1 or NACHT == 1 then --()wenn nacht oder radio nicht benötigt wird
  fibaro:call(switch, "turnOff")
  fibaro:debug("radio aus") 
  fibaro:abort()
end