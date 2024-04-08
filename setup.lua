#!/usr/bin/env luajit

-- Pseudo-main function
function main()
  print("Hello")
end

if not pcall(getfenv, 4) then
  main()
end
