#!/usr/bin/env luajit

local program = "cd-kickstart setup"
local version = "0.1.0"

local help_text = [[
{{name}} v{{version}}

Usage:

{{program}} [OPTIONS]

Options:

-d, --dir DIR                       Specify directory to install
-p, --profile PROFILE               Install config as a profile

-P, --plugin-profile                Make profile a plugin profile, with other
                                    configurations remained global
                                    -- No effect if `--profile` is not specified

-u, --use PLUGIN1[,PLUGIN2,...]     Use optional plugins. Use commas to delimit
                                    multiple plugins

-h, --help                          Print this help
-v, --version                       Version info
]]

-- Pseudo main function
local function main(args)

  for _, x in ipairs(args.using) do
  end
end

-- Entry point (argument parsing block)
if not pcall(getfenv, 4) then
  local args = {
    using = {},
    dir = "~/.config/nvim",
    profile = nil,
    plugin_profile = false,
  }

  -- Arg parse state
  local in_state = nil

  for i, a in ipairs(arg) do
    if i < 1 then
      goto continue__arg_loop
    end

    -- use process
    if in_state == "use" then
      for u in string.gmatch(a, "[^,]+") do
        table.insert(args.using, u)
      end

      in_state = nil
      goto continue__arg_loop
    end

    -- dir process
    if in_state == "dir" then
      args.dir = a

      in_state = nil
      goto continue__arg_loop
    end

    -- profile process
    if in_state == "profile" then
      args.profile = a

      in_state = nil
      goto continue__arg_loop
    end

    -- Main arg reading
    if a == "-u" or a == "--use" then
      in_state = "use"
    elseif a == "-d" or a == "--dir" then
      in_state = "dir"
    elseif a == "-p" or a == "--profile" then
      in_state = "profile"
    elseif a == "-P" or a == "--plugin-profile" then
      args.plugin_profile = true
    elseif a == "-v" or a == "--version" then
      print(string.format("%s v%s", program, version))
      os.exit(0)
    elseif a == "-h" or a == "--help" then
      local t = string.gsub(help_text, "{{name}}", program)
      t = string.gsub(t, "{{version}}", version)
      t = string.gsub(t, "{{program}}", arg[0])

      print(t)
      os.exit(0)
    else
      io.stderr:write(string.format("Invalid argument: %q\n", a))
      os.exit(1)
    end

    ::continue__arg_loop::
  end

  main(args)
end
