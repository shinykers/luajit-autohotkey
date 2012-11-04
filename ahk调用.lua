--AHK.DLL

--Iconv module start
require "iconv"
function createIconv(to, from)
	local cd = iconv.new(to, from)
	return function(txt)
		return cd:iconv(txt)
	end
end
L = createIconv("wchar_t", "utf-8")
--Iconv module end

function sleep(n)
   local t0 = os.clock()
   while os.clock() - t0 <= n do end
end

local ffi = require("ffi")

ffi.cdef[[
	int ahktextdll(wchar_t * Script, wchar_t * Options, wchar_t * Parameters);
]]

--local ahk =ffi.load("ahka")
local ahk =ffi.load("ahkw")--wide char needed here~

local scripts = L"Msgbox Hello World!单"
local scriptsC = ffi.new("wchar_t[" .. #scripts .. "]")
ffi.copy(scriptsC,scripts)

local Options = L""
local OptionsC = ffi.new("wchar_t[" .. #Options .. "]")
ffi.copy(OptionsC,Options)

local Parameters = L""
local ParametersC = ffi.new("wchar_t[" .. #Parameters .. "]")
ffi.copy(ParametersC,Parameters)

local t1=os.clock()
ahk.ahktextdll(scriptsC,OptionsC,ParametersC)
local t2=os.clock()
io.write(t2-t1, "\n")
os.execute("pause")



