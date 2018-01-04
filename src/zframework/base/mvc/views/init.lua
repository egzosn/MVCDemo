--------------------------
--class V 视图结点,还有不足需扩展
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local CURRENT_MODULE_NAME = ...
local view=require(zf.PACKAGE_NAME..".viewConfig")
view.PACKAGE = string.sub(CURRENT_MODULE_NAME, 1, -6)
--------------------------
--视图结点,根据模型的视图类型创建不同的视图
--@param model userdata 实体
--@param pos point_table 坐标
--@return view
local V= class("V",function(model,pos)
    local actor=nil
        actor=require(view.PACKAGE.."."..view[model:getViewType() ]).new(model)
    return actor
end)
return V

