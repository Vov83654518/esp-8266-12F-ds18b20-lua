wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
    print(wifi.sta.gethostname())
  srv:close()
  srv=net.createServer(net.TCP, 1000)
srv:listen(80,function(conn)
    conn:on("receive",function(client,request)
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
        temp = temperatur.read()  
        rezultates = _GET.pin
    if("SIPV"== rezultates and idial < 300)then
        idial = idial + hag 
        if file.open("test.txt", "w+") then
          file.flush()
            file.writeline(tostring(idial))
            file.close()
        end
    elseif("SIMV"== rezultates and idial >= 1)then
        idial = idial - hag  
        if file.open("test.txt", "w+") then
          file.flush()
            file.writeline(tostring(idial))
            file.close()
        end
    elseif("ON1" == rezultates)then
        if file.open("test.txt", "w+") then
          file.flush()
            file.writeline(tostring(idial))
            file.close()
        end
    end
    if (temp == nil) then temp=0 end
    tempn = temp - temp%1
    file.open("IpPodkl.txt", "a")
    file.flush()
    ProhIp = wifi.sta.getip()
    file.writeline(ProhIp)
    file.close()
    print(wifi.sta.getip())
    conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n\
   <!DOCTYPE HTML>\
   <html><body bgcolor="#6699ff"><h1>&nbsp</h1>\
<h1 align="center"><big><big><big>Температура:'..tempn..'</big></big></big></h1>\
<h1 align="center"><big><big><big>Нагрев до  :'..idial..'</big></big></big></h1>\
<h1 align="center"><a href=\"?pin=SIMV\"><button style=\"background: #ff3300; color: White; border-radius: 180px;  font-size: 50px;  width:200px;\">-' ..hag..'</button></a>\
<a href=\"?pin=SIPV\"><button style=\"background: #B0CE3A; color: White; border-radius: 180px; font-size: 50px;  width:200px;\"> +' ..hag..' </button></a></h1>\
<h1>&nbsp</h1>\
<h1>&nbsp</h1>\
<h1 align="center"><a href=\"?pin=ON1\"><button style=\"background: #B0CE3A; color: White; border-radius: 180px; font-size: 70px;\">Обновить</button></a></h1>\
</body></html>') 
    conn:on("sent",function(conn) conn:close() end)
    collectgarbage();
    end)
end)
end)
