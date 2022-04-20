wifi.setmode(wifi.STATIONAP)

station_cfg={}
station_cfg.ssid = "EspSet";
station_cfg.pwd = nil;
wifi.ap.config(station_cfg) 
wifi.ap.dhcp.start()

dofile("nach.lua")
wifi.sta.config(station_cfg2)
wifi.sta.autoconnect(1)

dofile("otprav.lua")
dofile("serv.lua")
