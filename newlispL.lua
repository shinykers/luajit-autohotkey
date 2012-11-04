function newlisp(newlisp_str)
    local ffi = require("ffi")
    local newlisp = ffi.load("newlisp")
    ffi.cdef[[
       char * newlispEvalStr(char * cmd);
    ]]
    local tmp = ffi.new("char[" .. #newlisp_str .. "]")
    ffi.copy(tmp, newlisp_str)
    return ffi.string(newlisp.newlispEvalStr(tmp))
end

--test
print("test")
print(newlisp("(* 2 100)"))
