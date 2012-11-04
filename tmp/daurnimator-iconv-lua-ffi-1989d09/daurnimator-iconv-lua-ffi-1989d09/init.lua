-- iconv bindings
-- Win32 binaries can be found at http://gnuwin32.sourceforge.net/packages/libiconv.htm

local assert , error = assert , error
local tblconcat , tblinsert = table.concat , table.insert
local getenv = os.getenv

local ffi 					= require"ffi"
local ffi_util 				= require"ffi_util"
local ffi_add_include_dir 	= ffi_util.ffi_add_include_dir
local ffi_defs 				= ffi_util.ffi_defs

local iconv_lib
assert ( jit , "jit table unavailable" )
if jit.os == "Windows" then -- Windows binaries from http://ffmpeg.zeranoe.com/builds/
	local basedir = getenv ( [[ProgramFiles(x86)]] ) or getenv ( [[ProgramFiles]] )
	basedir = basedir .. [[\GnuWin32\]]

	ffi_add_include_dir ( basedir .. [[include\]] )
	iconv_lib = ffi.load ( basedir .. [[bin\libiconv2]] )
elseif jit.os == "Linux" or jit.os == "OSX" or jit.os == "POSIX" or jit.os == "BSD" then
	local ok
	ok , iconv_lib = pcall ( ffi.load , [[iconv]] )
	ok , iconv_lib = pcall ( ffi.load , [[libglib-2.0.so]] )
	assert ( ok , "No iconv library found" )
else
	error ( "Unknown platform" )
end

local libprefix = false
do
	local f = ffi_defs ( [[iconv_funcs.h]] , [[iconv_defs.h]] , {
		[[<string.h>]] ;
		[[<errno.h>]] ;
		[[iconv.h]] ;
	} , true , true )

	local n
	f , n = f:gsub ( [[typedef%s+void%s*%*%s*iconv_t;]] , [[typedef struct iconv_t *iconv_t;]] )
	if n == 0 then
		libprefix = true
		f , n = f:gsub ( [[typedef%s+void%s*%*%s*libiconv_t;]] , [[typedef struct libiconv_t *libiconv_t;]] )
	end

	assert ( n == 1 )
	ffi.cdef ( f )
end

local iconv_funcs = iconv_lib

local function check ( r )
	if ffi.cast ( "int" , r ) == -1 then
		local errstring = ffi.C.strerror ( ffi.errno ( ) )
		assert ( errstring ~= nil , "Error in error handling" )
		return error ( "Unable to create iconv conversion descriptor: " .. ffi.string ( errstring ) )
	end
	return r
end

local function new ( from , to )
	return ffi.gc ( check ( iconv_funcs.iconv_open ( to , from ) ) , iconv_funcs.iconv_close )
end

local out_buff_size = 1024
local outbuff = ffi.new ( "char[?]" , out_buff_size )
local in_buff_size = -1
local inbuff

local function doconv ( self , instr )
	local t = { }

	if #instr > in_buff_size then
		inbuff = ffi.new ( "char[?]" , #instr )
		in_buff_size = #instr
	end

	ffi.copy ( inbuff , instr , #instr )
	local inbuff_p , outbuff_p = ffi.new ( "char*[1]" , { inbuff } ) , ffi.new ( "char*[1]" , { outbuff } )
	local inleft , outleft = ffi.new ( "size_t[1]" , { #instr } ) , ffi.new ( "size_t[1]" , { out_buff_size } )

	repeat
		local n = check ( iconv_funcs.iconv ( self , inbuff_p , inleft , outbuff_p , outleft ) )
		local s = ffi.string ( outbuff , out_buff_size - outleft[0] )
		outleft[0] = out_buff_size
		tblinsert ( t , s )
	until inleft[0] == 0

	-- Reset the state
	check ( iconv_funcs.iconv ( self , nil , nil , nil , nil ) )
	return tblconcat ( t )
end

local mt = {
	__call = doconv ;
}

if libprefix then
	iconv_funcs = {
		iconv_open = iconv_lib.libiconv_open ;
		iconv_close = iconv_lib.libiconv_close ;
		iconv = iconv_lib.libiconv ;
	}
	ffi.metatype ( "struct libiconv_t" , mt )
else
	ffi.metatype ( "struct iconv_t" , mt )
end

return {
	new = new ;
}
