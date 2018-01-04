--------------------------
--class baseScene 这个类还需要进行扩展
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local M = class("baseScene", function(...)
        print("baseScene init")
        return  display.newScene(...)
end)

return M