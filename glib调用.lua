
ffi.cdef[[

	int g_utf8_strlen ( char * str, int max);
]]

local glib=ffi.load("libglib")--use glib
--[[
char*	g_utf8_substring	( char * str, int start_pos, int end_pos);
function utf8sub(str,start_pos,end_pos)
local strC = ffi.new("char[" .. #str .. "]")
ffi.copy(strC,str)
return ffi.string(glib.g_utf8_substring(strC,start_pos,end_pos))
end
]]--
function utf8len(str,n)
local strC = ffi.new("char[" .. #str .. "]")
ffi.copy(strC,str)
return glib.g_utf8_strlen(strC,n)
end

print (utf8len("我just是单",3))
