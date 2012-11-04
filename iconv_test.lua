-- Test for lua ffi iconv bindings
-- iconv homepage: http://www.gnu.org/s/libiconv/

package.path = "./?/init.lua;" .. package.path
package.loaded [ "iconv" ] = dofile ( "init.lua" )

local iconv = require "iconv"
-- From ASCII, To UTF-8 (note argument order is opposite to iconv_open)
local c = iconv.new ( "ASCII" , "UTF-8" )
print ( c ( "lol" ) )
