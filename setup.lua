#!/usr/bin/env luajit

local function main()
end

if not pcall(getfenv, 4) then
  main()
end
