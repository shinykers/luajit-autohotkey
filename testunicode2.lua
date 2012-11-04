local unicode = require("unicode")
local utf8 = unicode.utf8
unicode.string = string
ctype="utf8"
function test(str,s,e,pat,repl)
utf8.len(str)
print (str)
print(unicode[ctype].sub(str,s,e))
print(unicode[ctype].reverse(str))
print(unicode[ctype].gsub(str,pat,repl))
end

test("我爱你，我的小乖乖！Lua is good!hello hello world world",2,5,"(%w+)", "%1 %1")
