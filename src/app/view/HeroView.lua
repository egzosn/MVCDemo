local HeroView=extends("ArmatureView","actorView")
local role_f_v=ZConfig.getConfig("role_f_v")

---------------------------
--这里覆盖父类的初始化
--@param
--@return
function HeroView:onInit(model)
    local view={}
    view=ZConfig.getValTabByid(role_f_v,model:getRoleType())
    display.addSpriteFrames(view[1],view[2])
    local pos= ZMath.rIndexof(view[2],".")
    local basename,extname=ZMath.subscriptSplit(view[2],pos)
    local pattern=basename.."1_%d"..extname
    self:addAction("rightmove",pattern,1,2)
    self:addAction("leftmove",pattern,4,2)
    self:addAction("idle",pattern,3,1)
    self:play("idle",3)
    
    local size=self:getContentSize()
    self.exhaust=newClass("exhaust")
        --        :align(display.BOTTOM_CENTER)
        :pos(size.width/2,-size.height/3)
    self.exhaust:setScale(3,2)
    self:add(self.exhaust)
end
--[[
---------------------------
--进入时加载
--这里也可以用于一些初始化操作
--@param
--@return
function HeroView:onEnter(model)
    self.model=model
    self:addProxyEventListener(model.CHANGE_STATE_EVENT,handler(self,self.onStateChang_))

end

-----------------------------
--视图改变
--@param
--@return
function HeroView:onStateChang_(event)
    self:update(self.model:getState())
end
--]]
---------------------------
--@param
--@return
function HeroView:update(state)

    if state=="idle" then
        transition.stopTarget(self)
        self.exhaust:setRotation(0)
         self:play("idle",3)
    elseif state=="leftmove" then
        self.exhaust:setRotation(-10)
        self:play("leftmove")
        
    elseif state=="rightmove" then
    
      self.exhaust:setRotation(5)
        self:play("rightmove")
    end
end


--[[
---------------------------
--@param point point_table 精灵坐标
--@return
function HeroView:move(point)
    if point then
        self:setPosition(point)
    	
    end
end

---------------------------
--@param
--@return
function HeroView:fire(weapon,mx,my)
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
function HeroView:onMove_(event)
    print("HeroView:mive")
end

return HeroView