
-- вводим имя сети и пароль сюда
ssid,pass = "HONOR 20e","123456789";

if (file.open('wificonf') == true)then
   ssid = string.gsub(file.readline(), "\n", "");
   pass = string.gsub(file.readline(), "\n", "");
   file.close();
end

wifi.setmode(wifi.STATION)
wifi.sta.config(ssid,pass)
wifi.sta.autoconnect(1);
print('IP:',wifi.sta.getip());
--print('MAC:',wifi.sta.getmac());

led1 = 3
led2 = 4
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
restart=0;

gpio.write(led1, gpio.LOW);
gpio.write(led2, gpio.LOW);

temperatur = require("ds18b20")
gpio0 = 3
gpio2 = 4
temperatur.setup(gpio0)
addrs = temperatur.addrs()
temp = temperatur.read()

t=0
tmr.alarm(0,1000, 1, function() t=t+1 if t>999 then t=0 end end)

srv=net.createServer(net.TCP, 1000)
srv:listen(80,function(conn)
    conn:on("receive",function(client,request)
    -- парсинг для отслеживания нажатий кнопок _GET
            local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
    -- это начало веб сайта
       -- в начале ставим <html><body>, в конце каждой строки знак \
   -- в конце последней строки не ставим знак \, а </body></html>
    conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n\
   <!DOCTYPE HTML>\
   <html><body bgcolor="#6699ff"><h1>&nbsp;</h1>\
<h1 style="text-align: center;">ESP8266 ESP-01</h1>\
<p>&nbsp;</p>\
<p align="center"><a href=\"?pin=ON1\"><button style=\"background: #B0CE3A; color: White; border-radius: 50px; font-size: 15px;\">Обновить</button></a></p>\
<p align="center">Поле переменной:&nbsp;<input maxlength="4" name="v" size="4" style="background: #cccccc" type="text"value="'..temp..'"></p>\
<p align="center">&nbsp;</p>\
<p align="center">&nbsp;</p>\
<hr>\
<address style="text-align: center;">Gauss</address></body></html>') 

    if(_GET.pin == "ON1")then
temperatur = require("ds18b20")
gpio0 = 3
gpio2 = 4
temperatur.setup(gpio0)
addrs = temperatur.addrs()
temp = temperatur.read()
    end

    conn:on("sent",function(conn) conn:close() end)
    collectgarbage();

    
    end)
    
end)


