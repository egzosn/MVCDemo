--------------------------
--class SimpleView 简单视图
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local SimpleView = class("SimpleView",function(model)
    local roleType=  model:getRoleType()
   
    local role=roleConfig.viewType[1].roleType[roleType]
    if role then
     return display.newSprite(role[1])
    end
    return display.newSprite()
end)
function SimpleView:ctor(model)
   
--    local cls=model.class
--    self.model=model
--    self.action={}
--    cc.EventProxy.new(model,self)--这里添加独特的事件，对应的model也必须添加对应的状态
--        :addEventListener(cls.CHANGE_STATE_EVENT,handler(self,self.onStateChang))
--        :addEventListener(cls.KILL_EVENT, handler(self, self.onKill_))
end


---------------------------
--@param
--@return
function SimpleView:onInit(model)
   
end

--[[
function SimpleView:onStateChang(event)
    print("SimpleView监听：视图状态改变的时候")
    self:updateSprite(self.model:getState())
end

function SimpleView:onStateLeave(event)
    local state=self.model:getState()
    if state~="idle" then
        print("SimpleView监听：视图离开状态的时候"..state)
        --        self:getAnimation():play("left")
    end
end


function SimpleView:updateSprite(state)
    print("SimpleView监听：精灵状态："..state)
    print("SimpleView监听：更新精灵视图")

    local frameName
    if state == "idle" then
        print("SimpleView监听：角色普通视图")
    elseif state == "leftmove" then
        self:setRotation(-15)                  
    elseif state == "rightmove" then
        self:setRotation(15)                  
    elseif state == "leftglide" then
        self:setRotation(30)
    elseif state == "rightglide" then
        self:setRotation(-30)
    end

end
--]]
------------------------------------
--简单精灵的播放
function SimpleView:play(action)--因为简单精灵没有动画，所以将进行对应的方法调用
    print("SimpleView监听："..action)
    
    handler(self,self[action])()--这里执行对应的动作方法
    
end

---[[--
--这个事件属于基本事件交予子类实现
function SimpleView:death()
    print("SimpleView监听：死了")
end
--]]

return SimpleView
