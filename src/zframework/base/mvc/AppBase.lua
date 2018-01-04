--------------------------
--class AppBase 这个类还需要进一步扩展
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

--local lfs = require("lfs")

--[[--
游戏的app的“超类”
--]]
local B = class("B", cc.mvc.AppBase)

--[[
--以下方法可留备用，需要用时打开

---------------------------
--获取文件名
--@param path 文件路径
-- @usage#        实例: 
--  strippath(D:\cocos\base\src\app\scenes\MainScene.lua) 得到 MainScene.lua
local function stripfilename(path)
return string.match(path, ".+\\([^\\]*%.%w+)$") -- *nix system
end

---------------------------
--获取不带扩展名的文件名
--@param path 文件路径
-- @usage#        实例: 
--  strippath(D:\cocos\base\src\app\scenes\MainScene.lua) 得到 MainScene
local function stripextension(filename)
local idx = filename:match(".+()%.%w+$")
if(idx) then
return filename:sub(1, idx-1)
else
return filename
end
end

--]]
--[[--
---无法跨平台所以抛弃使用
---------------------------
--加载存储类路径
--@param path lua文件的存放路径
-- @usage#        实例: 
--  loadDir(D:\cocos\base\src\app)
local function loadDir(path)
    if type(path)=="table" then
        return
    end
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..'\\'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
                loadDir(f)
            else
                setFolders(strippath(f))
            end
        end
    end
end
--]]

key = ""
function PrintTable(table , level)
    level = level or 1
    local indent = ""
    for i = 1, level do
        indent = indent.."  "
    end

    if key ~= "" then
        print(indent..key.." ".."=".." ".."{")
    else
        print(indent .. "{")
    end

    key = ""
    for k,v in pairs(table) do
        if type(v) == "table" then
            key = k
            PrintTable(v, level + 1)
        else
            local content = string.format("%s%s = %s", indent .. "  ",tostring(k), tostring(v))
            print(content)
        end
    end
    print(indent .. "}")

end
function B:replaceScene(sceneName, args, transitionType, time, more)
    local scenePackageName = self.packageRoot .. ".scenes." .. sceneName
    local sceneClass = require(scenePackageName)
--    local scene = sceneClass.createScene(unpack(checktable(args)))
    local scene = sceneClass.new(unpack(checktable(args)))
--    local scene = newClass(scenePackageName,unpack(checktable(args)))
    display.replaceScene(scene, transitionType, time, more)
end

function B:ctor(appName, packageRoot)
    B.super.ctor(self, appName, packageRoot)
    -- -- 游戏初始化
    self:init()
end


---------------------------
--初始化,主要负责加载一些数据
function B:init()
--    loadDir(lfs.currentdir().."\\src\\app")--无法跨平台所以抛弃使用
--    folderKey=nil
end
--------------------------------------------
--得到一个类对象
--@param className 类名
--@return 类对象
--@usage#        实例: 
--                  B:createClass("MainScene") 返回 MainScene对象
function B:createClass(className,...)
  
    local class = getClass(className)
    return class.create(...)
end

return B
