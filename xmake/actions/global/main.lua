--!The Make-like Build Utility based on Lua
-- 
-- XMake is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
-- 
-- XMake is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public License
-- along with XMake; 
-- If not, see <a href="http://www.gnu.org/licenses/"> http://www.gnu.org/licenses/</a>
-- 
-- Copyright (C) 2015 - 2016, ruki All rights reserved.
--
-- @author      ruki
-- @file        main.lua
--

-- imports
import("core.base.option")
import("core.project.global")

-- main
function main()

    -- init the global configure
    --
    -- priority: option > option_default > config_check > global_cache 
    --
    global.init()

    -- override the option configure 
    for name, value in pairs(option.options()) do
        if name ~= "verbose" then
            global.set(name, value)
        end
    end

    -- merge the default options 
    for name, value in pairs(option.defaults()) do
        if name ~= "verbose" and global.get(name) == nil then
            global.set(name, value)
        end
    end

    -- merge the checked configure 
    global.check()
  
    -- merge the cached configure
    if not option.get("clean") then
        global.load()
    end

    -- save it
    global.save()

    -- dump it
    global.dump()

    -- trace
    cprint("${bright}configure ok!")
end
