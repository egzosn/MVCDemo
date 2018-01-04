local ArmatureView=extends("ArmatureView","actorView")
 --[[
---------------------------
--进入时加载
--这里也可以用于一些初始化操作
--@param
--@return
function ArmatureView:onEnter(model)
    self.model=model
    self:addProxyEventListener(model.CHANGE_STATE_EVENT,handler(self,self.onStateChang_))
end

---------------------------
--视图改变
--@param
--@return
function ArmatureView:onStateChang_(event)
    self:update(self.model:getState())
end
--]]
---------------------------
--@param
--@return
function ArmatureView:update(state)
    if state=="idle" then
--        self:play("N")
        self:play("Transformers_C")
--        self:play("Y_R")
    elseif state=="leftmove" then
--        self:play("Transformers_STAR")
        self:play("Y_L_1")
--        self:play("N_L_2")
    elseif state=="rightmove" then
--        self:play("N_R_2")
        self:play("Y_R_1")
--        self:play("Transformers_END")
    end
end

--[[
---------------------------
--@param point point_table 精灵坐标
--@return
function ArmatureView:move(point)
    if point then
        self:setPosition(point)
    	
    end
end

---------------------------
--@param
--@return
function ArmatureView:fire(weapon,mx,my)
    local pos=cc.p(self:getPosition())    
    weapon:pos(pos.x,pos.y-20)
    local rotation=ZMath.getFireAngle(pos.x,pos.y,mx,my)
    weapon:setRotation(rotation+10)
    weapon:play("yellow",false)
    self.model:addWeapon(weapon)
    self.model:moveWeapon(weapon,mx,my)
end
--]]
---------------------------
--@param
--@return
function ArmatureView:onMove_(event)
    print("ArmatureView:mive")
end

return ArmatureView