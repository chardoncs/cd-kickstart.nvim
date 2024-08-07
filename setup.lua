#!/usr/bin/env luajit

-- Pseudo main entry
local function main(args)
  for _, x in ipairs(args.usage) do
    print(x)
  end
end

if not pcall(getfenv, 4) then
  local args = {
    usage = {},
  }

  local usage_in = false

  for _, a in ipairs(arg) do
    if usage_in then
      for u in string.gmatch(a, "[^,]+") do
        table.insert(args.usage, u)
      end

      usage_in = false
      goto continue
    end

    if a == "-u" or a == "--usage" then
      usage_in = true
    else
      io.stderr:write(string.format("Invalid argument: %q\n", a))
      os.exit(1)
    end

    ::continue::
  end

  main(args)
end
