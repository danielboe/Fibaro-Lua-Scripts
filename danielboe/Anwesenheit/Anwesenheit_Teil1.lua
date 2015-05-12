--[[
%% properties
134 value
130 value
%% globals
--]]

--Das Script schreibt eine Variable anwesend in 3 Stufen. Tür offen, im raum, sicher anwesend. es besteht aus 2 teilen
--die perfekte grundlage für eine lichtsteuerung. detail im forum: 
--http://siio.de/board/thema/anwesenheits-check-mit-motion-sensor-tuersensor/

-- VARIABLEN Konfiguration (Bewegungsmelder & Türsensor muss oben unter %% properties aufgeführt sein) löst die szene aus
-----------------------------------------------------------------------------------------------------------------------------------------
local scene = 9-- ID dieser Szene
local motion = 130 -- ID des Bewegungssensors 
local motiontime = 30 -- Timeout des Motion Sensors (Par. 22)
local door = 134 -- türsensor ID
local starttimer = 400 --timeout für status 2 (answesend, tür offen)

-----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------
---------------------Script-----------------

fibaro:debug("--");

if fibaro:countScenes() > 1 then
  fibaro:debug("stop scene");
  fibaro:abort();
end

if tonumber(fibaro:getValue(door, "value")) > 0 and tonumber(fibaro:getValue(motion, "value")) == 0 and tonumber(fibaro:getGlobalValue("Zimmer")) == 0 then
  fibaro:debug("zimmer1");
  fibaro:setGlobal("Zimmer", "1");
  fibaro:abort();
end

if tonumber(fibaro:getValue(door, "value")) > 0 and tonumber(fibaro:getValue(motion, "value")) > 0 then
  fibaro:debug("zimmer2");
  fibaro:setGlobal("Zimmer", "2");
  local timer = os.time();
  local move = 0;
  while (os.time() - timer < starttimer and tonumber(fibaro:getGlobalValue("Zimmer")) == 2) do
  	if (tonumber(fibaro:getValue(motion, "value"))) > 0 then
		timer = os.time();
	end
    if tonumber(fibaro:getValue(door, "value")) == 0 and tonumber(fibaro:getValue(motion, "value")) > 0 then
    	move = move+1;
    	if move > (motiontime + 3) then
        	fibaro:debug("Zimmer3");
        	fibaro:setGlobal("Zimmer", "3");
        	fibaro:abort();
    	end
    else
    	move = 0;
    end
  	fibaro:sleep(1000);
  end
  fibaro:debug("timerende");
  if tonumber(fibaro:getGlobalValue("Zimmer")) == 2 then
  	fibaro:setGlobal("Zimmer", "0");
  end
  fibaro:abort();
end

fibaro:debug("---");
fibaro:killScenes(scene);

