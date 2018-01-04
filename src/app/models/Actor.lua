--[[--
“角色”类

level 是角色的等级，角色的攻击力、防御力、初始 Hp 都和 level 相关

]]

local Actor = class("Actor",zf.mvc.ModelBase)

-- 定义事件
Actor.CHANGE_STATE_EVENT = "CHANGE_STATE_EVENT"
Actor.KILL_EVENT = "KILL_EVENT"
Actor.MOVEL_EVENT = "MOVEL_EVENT"
Actor.LEAVE_STATE_EVENT = "LEAVE_STATE_EVENT"

--Actor.attr=clone(zf.mvc.ModelBase.attr)
Actor.attr=clone( zf.mvc.ModelBase.attr)
Actor.attr["nickname"] = {"string","hero"}
--定义状态
Actor.START="start"
Actor.MOVEL="movel"
Actor.MOVER="mover"
Actor.READY="ready"
Actor.RESUME="resume"
Actor.KILL="kill"
Actor.RELIVE="relive"

--------------------------------
--@param properties table#number 角色属性或者视图类型
--@param events table 事件
--@param callbacks table 事件对应的回调
function Actor:ctor(properties,events, callbacks)
    Actor.super.ctor(self,properties)
--    print(" Actor:ctor()")
    --注册事件分发
    cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
    -- 因为角色存在不同状态，所以这里为 Actor 绑定了状态机组件
    cc(self):addComponent("components.behavior.StateMachine")--:exportMethods()
    -- 由于状态机仅供内部使用，所以不应该调用组件的 exportMethods() 方法，改为用内部属性保存状态机组件对象
    self.fsm_= self:getComponent("components.behavior.StateMachine")
    ---[[
    local defaultEvents={
        --初始状态
        {name=Actor.START,form="none",to="idle"},
        
        --左移动状态
        {name=Actor.MOVEL,form="idle",to="leftmove"},
        
        --右移动状态
        {name=Actor.MOVER,form="idle",to="rightmove"},
        
        --恢复       
        {name=Actor.RESUME,form={"leftmove","rightmove"},to="idle"},
        
        --死亡
        {name=Actor.KILL,form="idle",to="dead"},
        
        --复活
        {name = Actor.RELIVE, from = "dead",to = "idle"}
    }
    --对继承类的状态进行合并
    table.insertto(defaultEvents,checktable(events))

    local defaultCallbacks={
        onchangestate=handler(self,self.onChangeState_),
        onstart=handler(self,self.onStart_),
        onmove=handler(self,self.onMove_),
        onfire=handler(self,self.onFire_),
        onready=handler(self,self.onReady_),
        onkill=handler(self,self.onKill_),
        onrelive=handler(self,self.onRelive_),
        onleavestate=handler(self,self.onLeave_) 
    }
    table.merge(defaultCallbacks,checktable(callbacks))
    self.fsm_:setupState({
        initial = Actor.START,
        events = defaultEvents,
        callbacks = defaultCallbacks
    })
end

function Actor:getNickname()
    return self.nickname
end
---------------------------
--当状态发生改变的时候被激活
--@param
--@return
function Actor:onChangeState_(event)
	event={name=Actor.CHANGE_STATE_EVENT,form=event.form,to=event.to}
    self:dispatchEvent(event)
--    print("当状态发生改变的时候被激活")
end
---------------------------
--离开任何状态时被激活 
--@param
--@return
function Actor:onLeave_(event)
    event={name=Actor.LEAVE_STATE_EVENT,form=event.form,to=event.to}
    self:dispatchEvent(event)
--    print("离开任何状态时被激活 ")
end
---------------------------
--
--初始状态
--@param
--@return
function Actor:onStart_(event)
--    print("初始状态")
    self:dispatchEvent({name=Actor.START})
end

---------------------------
--移动状态
--@param
--@return
function Actor:onMove_(event)
--    print("移动状态")
    self:dispatchEvent({name=Actor.MOVEL_EVENT})
end
---------------------------
--死亡状态
--@param
--@return
function Actor:onKill_(event)
--    print("死亡状态")
    self:dispatchEvent({name=Actor.KILL_EVENT})
end
---------------------------
--复活状态
--@param
--@return
function Actor:onRelive_(event)
--    print("复活状态")
    self:dispatchEvent({name=Actor.READY})
end


---------------------------
--获取当前状态
--@param
--@return strng#state
function Actor:getState()
    return self.fsm_:getState()
end


---------------------------
--@param string event
--@return strng#state
function Actor:doEvent(event)
    self.fsm_:doEvent(event)
end


---------------------------
--@param string event
--@return strng#state
function Actor:fire_()
    self.fsm_:doEvent(Actor.FIRE)
    self.fsm_:doEvent(Actor.READY,Actor.FIRE_COOLDOWN)
end

return Actor
