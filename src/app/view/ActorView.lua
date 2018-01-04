local ActorView=class("ActorView",zf.mvc.ViewBase)
  
---------------------------
--进入时加载
--这里也可以用于一些初始化操作
--@param
--@return
function ActorView:onEnter(model)
    self.model=model
    self:addProxyEventListener(model.CHANGE_STATE_EVENT,handler(self,self.onStateChang_))
    local size=self:getContentSize()
    
    
    -------------------
    --创建僚机
    self.wps={}
    display.addSpriteFrames("plane_hero/wingplane.plist","plane_hero/wingplane.png")
    if model:getNickname()=="enemy" then
    	return
    end
    for i=1,2 do
        self.wps[i]=display.newSprite("#wingplane_4.png")
            :pos((-1)^i*(size.width+30),-50)
            :addTo(self)
    end
    --------------------
end

---------------------------
--@param
--@return
function ActorView:getWps()
	return self.wps
end

---------------------------
--@param
--@return
function ActorView:updateWps()
	
end

---------------------------
--视图改变
--@param
--@return
function ActorView:onStateChang_(event)
    self:update(self.model:getState())
end
                                                                                                                                                                                                                 

---------------------------
--@param point point_table 精灵坐标
--@return
function ActorView:move(point,flag)
    if not flag then
        if point then
            self:setPosition(point)
        end
      else
        self:Bymove(point,1)
    end
end


---------------------------
--@param
--@return
function ActorView:Bymove(point,time)
	transition.moveBy(self,{
	        time=time,
        	x=point.x,
        	y=point.y,
        	onComplete=function(event)
        		
        	end
        	})
end

---------------------------
--@param
--@return
function ActorView:fire(weapon,mx,my,isWp)
    if not isWp then
        local pos=cc.p(self:getPosition())    
        weapon:pos(pos.x,pos.y-20)
        local rotation=ZMath.getFireAngle(pos.x,pos.y,mx,my)
        weapon:setRotation(rotation+10)
        weapon:play("yellow",false)
      else
        display.addSpriteFrames("wpbullet.png")
        
    end
    self.model:addWeapon(weapon)
    self.model:moveWeapon(weapon,mx,my)
end

return ActorView