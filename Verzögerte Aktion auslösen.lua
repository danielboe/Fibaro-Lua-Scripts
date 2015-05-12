--[[
%% properties
105 value
%% globals
--]]

--in diesem Beispiel wird ein Push nach Zeit X gesendet.
--wenn fenster länger als 10 sek. offen, dann sende push. ansonsten abbruch

--------------------------------------------------------------------------
local starttimer = 10 --timeout bis aktion ausgeführt wird (in Sekunden)
local FensterK = 105 --value fenster oder anderer trigger (auch im kopf anpassen!)
---------------------------------------------------------------------------

if fibaro:countScenes() > 1 then
  fibaro:debug("stop scene");
  fibaro:abort();
end

fibaro:debug("start");
local timer = os.time();
local move = 0;

while (os.time() - timer < starttimer) and (tonumber(fibaro:getValue(FensterK, "value")) > 0) do
	fibaro:sleep(1000);
end

if (tonumber(fibaro:getValue(FensterK, "value")) > 0) then
	fibaro:debug("fenster offen"); 
	--fibaro:call(XX, "sendDefinedPushNotification", "XX") -- auszuführende aktion, zb push nach X Sekunden
	fibaro:abort();
end

fibaro:debug("fenster zu ende");
fibaro:abort();