--------------------------
--class ArmatureView 骨格动画视图
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local ArmatureView = class("ArmatureView",function(model)
--[[
    local roleType=  model:getRoleType()
    local role=roleConfig.viewType[2].roleType[roleType]
    local action=role.action
    local pos=  MathUtil.rIndexof(action,"/")
    local basename=string.sub(action,pos+1)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(action.."0.png",action.."0.plist",action..".ExportJson")
    local armature=ccs.Armature:create(basename)
    armature:getAnimation():gotoAndPause(0)
    return armature
    --]]
    return ccs.Armature:create()
end)

function ArmatureView:ctor(model)
   
--    local cls=model.class
--    self.model=model
--    cc.EventProxy.new(model,self)--这里添加独特的事件，对应的model也必须添加对应的状态
--        :addEventListener(cls.CHANGE_STATE_EVENT,handler(self,self.onStateChang_))
--        :addEventListener(cls.KILL_EVENT, handler(self, self.onKill_))
--        :addEventListener(cls.LEAVE_STATE_EVENT,handler(self,self.onStateLeave))
end

function ArmatureView:onInit(model)
--    print(" ArmatureView:init(model)")
    local roleType=  model:getRoleType()
    local role=roleConfig.viewType[2].roleType[roleType]
    local action=role.action
    local pos=  ZMath.rIndexof(action,"/")
    local basename=string.sub(action,pos+1)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(action.."0.png",action.."0.plist",action..".ExportJson")
    self:init(basename)
--    self.armature=ccs.Armature:create(basename)
--    for key, var in pairs(role.actionName) do
--        print(var)
--    end
--    self:getAnimation():play(,-1,false)
    self:play(role.actionName[1])
    self:getAnimation():gotoAndPause(0)
end



--[[
function ArmatureView:onStateChang_(event)
     print("11视图状态改变的时候")
    self:updateSprite(self.model:getState())
end

function ArmatureView:onStateLeave(event)
    local state=self.model:getState()
    if state~="idle" then
        print("视图离开状态的时候"..state)
--        self:getAnimation():play("left")
        self:getAnimation():gotoAndPause(1)
    end
end



function ArmatureView:updateSprite(state)
    print("精灵状态："..state)
    print("更新精灵视图")
    
    local frameName
    if state == "idle" then
        self:getAnimation():gotoAndPause(0)
    elseif state == "leftmove" then
        self:setRotation(-15)                  
        self:getAnimation():play("left")
    elseif state == "rightmove" then
        self:setRotation(15)                  
        self:getAnimation():play("right")
    elseif state == "leftglide" then
        self:setRotation(30)
    elseif state == "rightglide" then
        self:setRotation(-30)
    end

end
--]]

-------------------------
--@param action string 动作名字、
--@param isLoop boolean 是否循环,默认false 不循环
function ArmatureView:play(action,isLoop)
local loop=0
    if isLoop then loop=-1 end
    self:getAnimation():play(action,-1,loop)
end

--[[--
--这个事件属于基本事件交予子类实现
function FramesArmatureView:onKill_(event)
    
end
--]]

return ArmatureView
