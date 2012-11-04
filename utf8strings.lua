--from 依云
-- http://lilydjwg.is-programmer.com/2012/9/18/truncate-a-utf-8-string.35603.html
--[[
function truncateUTF8String(s, n)
  local dropping = string.byte(s, n+1)
  if not dropping then return s end
  if dropping >= 128 and dropping < 192 then
    return truncateUTF8String(s, n-1)
  end
  return string.sub(s, 1, n)
end
]]--

-- 获取utf8编码字符串正确长度的方法 from 北北小朋友
-- http://blog.sina.com.cn/s/blog_53746ffc0100kknd.html
-- @param str
-- @return number
--[[
function utf8strlen(str)
local len = #str;
local left = len;
local cnt = 0;
local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc};
while left ~= 0 do
local tmp=string.byte(str,-left);
local i=#arr;
while arr[i] do
if tmp>=arr[i] then left=left-i;break;end
i=i-1;
end
cnt=cnt+1;
end
return cnt;
end
]]--

function utf8cut(s, n)
  local dropping = string.byte(s, n+1)
  if not dropping then return s end
  if dropping >= 128 and dropping < 192 then
    return utf8cut(s, n-1)
  end
  return string.sub(s, 1, n)
end

function utf8len(str)
local len = #str;
local left = len;
local cnt = 0;
local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc};
while left ~= 0 do
local tmp=string.byte(str,-left);
local i=#arr;
while arr[i] do
if tmp>=arr[i] then left=left-i;break;end
i=i-1;
end
cnt=cnt+1;
end
return cnt;
end

--function utf8sub(str


--test
local str1 = "123456abc"
local str2 = "1a二b3四5六"

local i,j = string.find(str2,"3四")

print (utf8len(str1).." "..utf8cut(str1,3)..i..j)
print (utf8len(str2).." "..string.len(str2).." "..utf8cut(str2,5))
