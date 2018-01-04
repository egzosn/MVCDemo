--------------------------
--class ViewBase
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local M= class("M",import(".views.init"))

---------------------------
--初始化 服务视图
--@param model userdata 实体
--@param pos point_table 坐标
function M:ctor(model,pos)
   
    M.super.ctor(self,model)
    if pos then
        self:setPosition(pos)
    end
    local cls=model.class
    self.model=model
    self.eventProxy=cc.EventProxy.new(model, self)--事件代理
--        :addEventListener(cls.CHANGE_STATE_EVENT,handler(self,self.onStateChang))
--        :addEventListener(cls.MOVEL_EVENT, handler(self, self.onMove_))
--        :addEventListener(cls.KILL_EVENT, handler(self, self.onKill_))
    --        :addEventListener(cls.LEAVE_STATE_EVENT,handler(self,self.onStateLeave))
    self:onInit(model)
    self:onEnter(model)
end

----------------
--进入时加载
--这里也可以用于一些初始化操作
--@param model userdata 实体
function M:onEnter(model)
--    print("M:onStart(model)")
end

---------------------------
--添加事件监听
--@param event string 事件名
--@param handler function 事件回调方法
--@return
function M:addProxyEventListener(event,Handler)
    self.eventProxy:addEventListener(event , handler(self,Handler))
    return self
end


--[[
function M:onStateChang(event)
    print("Service监听：视图状态改变的时候")
    self:updateSprite(self.model:getState())
end

function M:onStateLeave(event)
    local state=self.model:getState()
    if state~="idle" then
        print("Service监听：视图离开状态的时候"..state)
--        self:getAnimation():play("left")
    end
end


function M:updateSprite(state)
    print("Service监听：精灵状态："..state)
    print("Service监听：更新精灵视图")
    
    local frameName
    if state == "idle" then
        print("Service监听：角色普通视图")
    elseif state == "leftmove" then
        self:setRotation(-15) 
--        self.actor:setRotation(-15) --这样可以直接调用View的方法                  
    elseif state == "rightmove" then
        self:setRotation(15)                  
    elseif state == "leftglide" then
        self:setRotation(30)
    elseif state == "rightglide" then
        self:setRotation(-30)
    end

end

function M:onMove_(event)
    print("监Service监听：移动")
    print(self:getPosition())
    print(self:getPosition())
    print(self.model:getState())
end

function M:onKill_(event)
    print("监Service监听：ice。死了")
    self:play("death")
end
--]]


return M