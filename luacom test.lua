require "luacom"
talk=luacom.CreateObject("SAPI.Spvoice")
function speak(str)
        talk:speak(str)
end

strin= "good day! 你好！"

speak(strin)