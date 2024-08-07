#!/usr/bin/env luajit

-- Pseudo main entry
local function main() 
end

if not pcall(getfenv, 4) then
  main()
end
