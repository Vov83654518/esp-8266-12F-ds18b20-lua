if file.open("PinLamp.txt", "r+") then
    pinLamp = tonumber(file.readline())
    print(pinLamp)
    file.close()
elseif (pinLamp == nil)then 
  file.open("PinLamp.txt", "a")
  file.flush()
  file.writeline("4")
  pinLamp = 4
  file.close()
else
    file.open("PinLamp.txt", "a")
  file.flush()
  file.writeline("4")
  pinLamp = 4
  file.close()
end

if file.open("IpPodkl.txt", "r+") then
    ProhIp = file.readline()
    print(ProhIp)
    file.close()
else
  file.open("IpPodkl.txt", "a")
  file.flush()
  file.writeline("0.0.0.0")
  ProhIp = "0.0.0.0"
  file.close()
end

if file.open("PinTemp.txt", "r+") then
    gpio0 = tonumber(file.readline())
    print(gpio0)
    file.close()
elseif (gpio0 == nil)then 
  file.open("PinTemp.txt", "a")
  file.flush()
  file.writeline("3")
  gpio0 = 3
  file.close()
else
    file.open("PinTemp.txt", "a")
  file.flush()
  file.writeline("3")
  gpio0 = 3
  file.close()
end

--pinLamp = 6
----pinLamp = 4
--gpio0 = 5
----gpio0 = 3
gpio.mode(pinLamp, gpio.OUTPUT)

temperatur = require("ds18b20")
temperatur.setup(gpio0)
temp = temperatur.read()

station_cfg2={}

if file.open("login.txt", "r+") then
    station_cfg2.ssid = file.read()
    print(station_cfg2.ssid)
    file.close()
else
  file.open("login.txt", "a")
  file.flush()
  file.writeline("HONOR20e")
  station_cfg2.ssid = "HONOR20e";
  file.close()
end

if file.open("pass.txt", "r+") then
    station_cfg2.pwd = file.read()
    print(station_cfg2.pwd)
    file.close()
else
  file.open("pass.txt", "a")
  file.flush()
  file.writeline("123456789")
  station_cfg2.pwd = "123456789";
  file.close()
end

if file.open("test.txt", "r+") then
    idial = tonumber(file.readline())
    file.close()
elseif (idial == nil)then 
  file.open("test.txt", "a")
  file.flush()
  file.writeline("80")
  idial = 80
  file.close()
else 
  file.open("test.txt", "a")
  file.flush()
  file.writeline("80")
  idial = 80
  file.close()
end

if file.open("Hag.txt", "r+") then
    hag = tonumber(file.readline())
    print(hag)
    file.close()
elseif (hag == nil)then 
  file.open("Hag.txt", "a")
  file.flush()
  file.writeline("2")
  hag = 2
  file.close()
else
    file.open("Hag.txt", "a")
  file.flush()
  file.writeline("2")
  hag = 2
  file.close()
end

----hag = 2

print(idial)
print(temp)

if (idial == nil) then idial = 80 end
if (temp == nil) then temp = 0 end
if(temp <= idial)then 
    gpio.write(4, gpio.HIGH);
elseif(temp > idial)then
    gpio.write(4, gpio.LOW);
end

srv=net.createServer(net.TCP, 1000)
srv:listen(80,function(conn) end)

blinktime = 1000

mytimer = tmr.create()

mytimer:register(blinktime, tmr.ALARM_AUTO, function(t)
    temp = temperatur.read() 
    if (temp ~= nil) then
        if(temp <= idial)then 
            gpio.write(pinLamp, gpio.HIGH);
        elseif(temp > idial)then
            gpio.write(pinLamp, gpio.LOW);
        end
    end
end)

mytimer:start()

Status = "Rab"
