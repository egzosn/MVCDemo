--------------------------
--class FramesArmatureView 帧动画视图
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16

local FramesArmatureView = class("FramesArmatureView",function(model)
    local sprite= display.newSprite()
    return sprite
end)

function FramesArmatureView:ctor(model)
    --    local cls=model.class
    --    self.model=model
    self.action={}--用于存储动作
--    print("FramesArmatureView:ctor(model)")
    --    self:init(model)
    --    self:playAnimationOnce(self.action["death"])--测试
    --    self:play("death")
    --    cc.EventProxy.new(model,self)--这里添加独特的事件，对应的model也必须添加对应的状态
    --        :addEventListener(cls.CHANGE_STATE_EVENT,handler(self,self.onStateChang_))
    --        :addEventListener(cls.KILL_EVENT, handler(self, self.onKill_))
    --        :addEventListener(cls.LEAVE_STATE_EVENT,handler(self,self.onStateLeave))
    
end

---------------------------
--帧动画初始化。这里需要转至游戏加载时，将所有角色动画View加载至缓存
--
function FramesArmatureView:onInit(model)
--    print("FramesArmatureView:init")
    --    local roleType=model:getRoleType()
    --    local role=roleConfig.viewType[3].roleType[roleType]
    local roleType=model:getRoleType()
    local view=roleConfig.viewType[3]
    local role={}
    if not view then
        return nil
    else
        role=view.roleType[roleType]
    end
    for key, var in pairs(role.actionName) do
        local begin,length=1,nil
        local action= role.action[var]
        local  pattern=nil
        if not action["isGroup"] then
--            print(action[1],action[2],action[3])
            local basename,extname= display.addSpriteFrames(action[1],action[2],action[3])
            if type(action[2])=="number" and type(action[3])=="number" then
                for group=1, action[3]  do
                    --self.action[role.actionName[group]]= view.newAnimation(basename..group.."_%d"..extname,1,action[2])
--                    print(string.format(basename..group.."_%d"..extname,action[2]))
                    self.action[role.actionName[group]]= {basename..group.."_%d"..extname,action[2]}
                end
                break
            elseif type(action[3])=="number" then
                length=action[3]
            end
            pattern=basename.."1_%d"..extname
        else
            pattern=action[1]

        end
        self.action[role.actionName[key]] ={pattern,begin,length}
    end
    --    self:setSpriteFrame(string.format(self.action[role.actionName[1]][1],1))

end

--[[
function FramesArmatureView:onStateChang_(event)
print("11视图状态改变的时候")
self:updateSprite(self.model:getState())
end

function FramesArmatureView:onStateLeave(event)
local state=self.model:getState()
if state~="idle" then
print("视图离开状态的时候"..state)
--        self:getAnimation():play("left")
self:getAnimation():gotoAndPause(1)
end
end



function FramesArmatureView:updateSprite(state)
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
--@param isLoop boolean|integer 是否循环|设置精灵帧（第几帧）,默认false 不循环
--@param removeWhenFinished boolean 是否自动销毁,默认false 不自动销毁
--@usage 
--循环播放 move动作
--  FramesArmatureView:play("move",true) ： 参数removeWhenFinished自动销毁 在这无效，后续升级改变成 number delay 播放前等待的时间
--播放move动作:
--  FramesArmatureView:play("move")  | FramesArmatureView:play("move",false) ：播放move动作
--  FramesArmatureView:play("move",false,true) : 动画播放完成后就删除用于播放动画的 Sprite 对象。例如一个爆炸效果：
--设置精灵帧,设置move动作的第3帧为显示帧:
--  FramesArmatureView:play("move",3) 参数removeWhenFinished自动销毁 在这无效。
function FramesArmatureView:play(actionName,isLoop,removeWhenFinished)

    if type(isLoop)~="number" then
        if not isLoop then
            isLoop=false
        end
--     print("self.action[actionName][3]")
        local begin,length=nil,nil
        if not self.action[actionName][3] then
            begin=1
            length=self.action[actionName][2]
        else
            begin=self.action[actionName][2]
            length=self.action[actionName][3]
        end
--        if checkint(length)==1 then
--        	self:setSpriteFrame(string.format(self.action[actionName][1],begin))
--        	return
--        end
        
        local animation= display.newFramesAnimation(self.action[actionName][1],begin, length)
--      print("play:"..self.action[actionName][1],self.action[actionName][2],self.action[actionName][3])
        if isLoop then
            self:playAnimationForever(animation)
        else
            self:playAnimationOnce(animation,removeWhenFinished)
        end
    else
        self:setSpriteFrame(string.format(self.action[actionName][1],isLoop))
    end
    return nil
end

------------------------
--添加动作
--@param actionName string 动作名称
--@param pattern    string 模式字符串
--@param begin      integer 开始位置
--@param length     integer 长度
function FramesArmatureView:addAction(actionName,pattern, begin ,length)
    self.action[actionName]={pattern,begin,length}
end


--[[--
--这个事件属于基本事件交予子类实现
function FramesArmatureView:onKill_(event)
self:play("death")
end
--]]


return FramesArmatureView
