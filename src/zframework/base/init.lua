--------------------------
--这是一个工厂类
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local baseLayer=import(".baseLayer")
local baseScene=import(".baseScene")

---------------------------
--创建一个图层
--@param name string 图层的名字
--@return Layer 
function newLayer(name,...)
    local layer = class(name , baseLayer)
    layer.name = name
    return layer
end
---------------------------
--创建一个图层
--@param name string 图层的名字
--@return Layer 
function newScene(name)
    local scene = class(name , baseScene)
    scene.name = name
    return scene
end