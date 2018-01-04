--------------------------
--记录视图类
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local viewConfig={
    [1]="SimpleView",
    [2]="ArmatureView",
    [3]="FramesArmatureView"
}

---------------------------
--设置视图的子类
--@function [parent=#src.zframework.viewConfig] setViewConfig
--@param viewTpye string 视图类型  三种类型：SimpleView,ArmatureView,FramesArmatureView
--@param childView string 视图的子类
function viewConfig.setViewConfig(viewTpye,childView)
    viewConfig[viewTpye]=childView
end

---------------------------
----获取视图
--@function [parent=#src.zframework.viewConfig] name
--@param viewTpye string 视图类型  三种类型：SimpleView,ArmatureView,FramesArmatureView
--@return #string 视图名称
function viewConfig.setViewConfig(viewTpye)
    return viewConfig[viewTpye]
end

return viewConfig