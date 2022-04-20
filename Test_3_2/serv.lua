wifi.eventmon.register(wifi.eventmon.AP_STACONNECTED, function(T)
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
        if(Status == "Rab") then
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
    elseif("NAST" == rezultates)then
        Status = "Nast"
    end
    if (temp == nil) then temp=0 end
    tempn = temp - temp%1
    conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n\
   <!DOCTYPE HTML>\
   <html><body bgcolor="#6699ff"><h1>&nbsp</h1>\
<h1 align="center"><big><big><big>Температура:'..tempn..'</big></big></big></h1>\
<h1 align="center"><big><big><big>Нагрев до  :'..idial..'</big></big></big></h1>\
<h1 align="center"><a href=\"?pin=SIMV\"><button style=\"background: #ff3300; color: White; border-radius: 180px;  font-size: 50px;  width:200px;\">-'..hag..'</button></a>\
<a href=\"?pin=SIPV\"><button style=\"background: #B0CE3A; color: White; border-radius: 180px; font-size: 50px;  width:200px;\"> +'..hag..' </button></a></h1>\
<h1>&nbsp</h1>\
<h1>&nbsp</h1>\
<h1 align="center"><a href=\"?pin=ON1\"><button style=\"background: #B0CE3A; color: White; border-radius: 180px; font-size: 70px;\">Обновить</button></a></h1>\
<h1 align="center"><a href=\"?pin=NAST\"><button style=\"background: #B0CE3A; color: White; border-radius: 180px; font-size: 30px;\">Настройки</button></a></h1>\
</body></html>') 
    elseif (Status == "Nast") then
        login = _GET.log
    if(login ~= nil)then print(login)end
    if("RAB"== login)then
        Status = "Rab"
    elseif(login~=nil)then
        station_cfg2={}
        cur = 1
        t = 1
        for i = 1, login:len() do
            if (login:sub(i,i+4)=="IendI")then
                if (cur == 1)then
                    if (login:sub(t,i-1) ~= "") then
                        station_cfg2.ssid = login:sub(t,i-1)
                        print(station_cfg2.ssid)
                        if file.open("login.txt", "w+") then
                            file.flush()
                            file.writeline(station_cfg2.ssid)
                            file.close()
                        end
                        wifi.sta.config(station_cfg2)
                        wifi.sta.autoconnect(1)
                    end
                    t = i
                    cur = 2
                elseif(cur == 2) then
                    if (login:sub(t+5,i-1) ~= "") then
                        station_cfg2.pwd = login:sub(t+5,i-1)
                        print(station_cfg2.pwd)
                        if file.open("pass.txt", "w+") then
                            file.flush()
                            file.writeline(station_cfg2.pwd)
                            file.close()
                        end
                        wifi.sta.config(station_cfg2)
                        wifi.sta.autoconnect(1)
                    end
                    t = i
                    cur = 3
                elseif(cur == 3) then
                    if (login:sub(t+5,i-1) ~= "") then
                        hag = login:sub(t+5,i-1)
                        print(hag)
                        if file.open("Hag.txt", "w+") then
                            file.flush()
                            file.writeline(tostring(hag))
                            file.close()
                        end
                    end
                    t = i
                    cur = 4
                elseif(cur == 4) then
                    if (login:sub(t+5,i-1) ~= "") then
                        pinLamp = login:sub(t+5,i-1)
                        print(pinLamp)
                        if file.open("PinLamp.txt", "w+") then
                            file.flush()
                            file.writeline(tostring(pinLamp))
                            file.close()
                        end
                    end
                    if (login:sub(i+5,login:len()) ~= "") then
                        gpio0 = login:sub(i+5,login:len())
                        print(gpio0)
                        if file.open("PinTemp.txt", "w+") then
                            file.flush()
                            file.writeline(tostring(gpio0))
                            file.close()
                        end
                    end
                    t = 1
                    cur = 1
                end
            end
        end
    end
    --    <h1 align="center">IP при подключении к сети</h1>\
    --<h1 align="center"><input name="Ipsta1" id="Ipsta1" type="text" placeholder="255"><input name="Ipsta2" id="Ipsta2" type="text" placeholder="255"><input name="Ipsta3" id="Ipsta3" type="text" placeholder="255"><input name="Ipsta4" id="Ipsta4" type="text" placeholder="255"></h1>\
    conn:send('HTTP/1.1 200 OK\r\nConnection: keep-alive\r\nCache-Control: private, no-store\r\n\r\n\
    <!DOCTYPE HTML>\
    <html><body bgcolor="#6699ff"><h1>&nbsp</h1>\
    <h1 align="center">Логин и пароль сети может состоять только из англиских букв и цифр!!!</h1>\
    <h1 align="center"><input name="firstname" id="firstname" type="text" placeholder="login"></h1>\
    <h1 align="center"><input name="lastname" id="lastname" type="text" placeholder="passvord"></h1>\
    <h1 align="center">Значение кнопок</h1>\
    <h1 align="center"><input name="Hag" id="Hag" type="text" placeholder="+2/-2"></h1>\
    <h1 align="center">Пин лампочки</h1>\
    <h1 align="center"><input name="PinL" id="PinL" type="text" placeholder='..pinLamp..'></h1>\
    <h1 align="center">Пин термометра</h1>\
    <h1 align="center"><input name="PinT" id="PinT" type="text" placeholder='..gpio0..'></h1>\
    <h1 align="center">'..ProhIp..'</h1>\
    <h1 align="center"><a id="elem" onclick="Function()"><button style=\"background: #B0CE3A; color: White; border-radius: 180px; font-size: 70px;\">Обновить</button></a></h1>\
    <h1 align="center"><a href=\"?log=RAB\"><button style=\"background: #B0CE3A; color: White; border-radius: 180px; font-size: 30px;\">Назад</button></a></h1>\
    <script type="text/javascript">\
        function Function(){elem.href = "?log="+firstname.value+"IendI"+lastname.value+"IendI"+Hag.value+"IendI"+PinL.value+"IendI"+PinT.value;}\
    </script>\
    </body></html>') 
    end
    conn:on("sent",function(conn) conn:close() end)
    collectgarbage();
    end)
end)
end)
