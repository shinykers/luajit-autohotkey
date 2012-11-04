local num=40
function fibonacci(n)
  if n < 2 then
    return n
  end
  return fibonacci(n - 2) + fibonacci(n - 1)
end
local t1=os.clock()
io.write(fibonacci(num), "\n")
local t2=os.clock()
io.write(t2-t1, "\n")

local ffi = require("ffi")
ffi.cdef[[
int fibonacci( int n)
]]
local fbdll=ffi.load("fibonacci")
local t1=os.clock()
local fb=fbdll.fibonacci(num)
io.write(fb, "\n")
local t2=os.clock()
io.write(t2-t1, "\n")
