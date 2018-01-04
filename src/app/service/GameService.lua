local GameService=class("GameService",cc.Ref)

---------------------------
--@param
--@return
function GameService:ctor(layer,views,model)
    self.layer=layer
    self.views=views
    self.model=model
    local btn=cc.ui.UIPushButton.new({normal="rstLotteryItem0.png",pressed="rstLotteryItem1.png"})
        :pos(display.width-100,display.bottom+100)
        :addTo(layer,999,999)
        :onButtonClicked(function()
            self:onfire(10)
        end)
end

---------------------------
--边界检测
--@param view userdata 精灵视图
--@param move point_table 移动距离
--@return
function GameService:edgeDetection(move)
    local vx,vy,w,h=ZMath.getPosAndSize(self.views[self.model])
    local mp=cc.pAdd(move,cc.p(vx,vy))
    if ZMath.ifRam(mp.x,mp.y,w,h) then
        return mp
    end
end

---------------------------
--移动事件
--@param move point_table 移动坐标
--@return
function GameService:onMove(move)
    if not move then
        self.model:doEvent(self.model.RESUME)
        return
    end
    if move.y<-3 or move.y>3 then
        self.model:doEvent(self.model.RESUME)
        return
    end
    if move.x<-1 then
        self.model:doEvent(self.model.MOVEL)
    elseif move.x>1 then
        self.model:doEvent(self.model.MOVER)
    end
end



---------------------------
--大技能
--@param
--@return
function GameService:onfire(num)

    local j=1
    local scheduler = cc.Director:getInstance():getScheduler()
    local  myupdate
    --每帧刷新
    local function update(dt)
        local i=0
        while i<=360 do
            if i<=180  then
                local weapon=newClass("weapon",{viewType=3,roleType=2})
                local bullet= newClass("bulletView",weapon):addTo(self.layer)
                local pos=cc.p(self.views[self.model]:getPosition())
                self.views[self.model]:fire(bullet,ZMath.getrx(i,display.width*1.1,0),ZMath.getry(i,display.top*1.1,pos.y))
            end
            i=i+10
        end
        if j>=num then
            scheduler:unscheduleScriptEntry(myupdate)
        end
        j=j+1
    end
    myupdate = scheduler:scheduleScriptFunc(update, 0.1, false)

end

---------------------------
--@param
--@return
function GameService:addBullet(model,y,p,isD)
    local weapon,bullet=nil
    local hv=cc.p(self.views[self.model]:getPosition())
    if not y and not p and not isD then
        weapon=newClass("weapon",{viewType=3,roleType=3})
        bullet=newClass("bulletView",weapon,hv):addTo(self.layer,999)
        model:addWeapon(bullet)
        return
    end
    if not p then
        p=cc.p(0,0)
    end

    weapon=newClass("weapon",{viewType=3})
    local point=cc.pAdd(cc.p(self.views[model]:getPosition()),p)
    bullet= newClass("bulletView",weapon,point):addTo(self.layer)
    --  bullet:setRotation(checkint(rotation))
    model:addWeapon(bullet)
    local i= math.random(1,10)
    if isD then
        bullet:play("d",false)
    else
        bullet:play("loading",false)
    end
    model:moveWeapon(bullet,0,y)

end
--[[
---------------------------
--@param
--@return
function GameService:addBullet(model,y,p,isD)

if not p then
p=cc.p(0,0)
end
local weapon=newClass("weapon",{viewType=3})
local point=cc.pAdd(cc.p(self.views[model]:getPosition()),p)
local bullet= newClass("bulletView",weapon,point):addTo(self.layer)
--  bullet:setRotation(checkint(rotation))
model:addWeapon(bullet)
local i= math.random(1,10)
if isD then
bullet:play("d",false)
else
bullet:play("loading",false)
end
model:moveWeapon(bullet,0,y)

end
--]]

---------------------------
--@param
--@return
function GameService:addEnemy()
    --    local enemy= newClass("hero",{viewType=3,roleType=2})
    local enemy= newClass("hero",{nickname="enemy",viewType=2,roleType=1})
    self.views[enemy]=newClass("armatureView",enemy)
    --    self.views[enemy]:setRotation(180)
    self.views[enemy]:pos(display.cx,display.top-200):addTo(self.layer,10)
    --self:addBullet(enemy,-display.top,0.5)
    self:addScheduler(self.addBullet,1,enemy,-display.top,nil)

end


---------------------------
--添加线程模块
--@param
--@return
function GameService:addScheduler(func,interval,...)
    local t=1
    local m,y,p,isD=...
    local scheduler = cc.Director:getInstance():getScheduler()
    local  myupdate
    --每帧刷新
    local function update(dt)
        --        self.views[m]:play("penhuo",true)
        t=t+1
        handler(self,func)(m,y,p,isD)
        print(t)
        if m:getNickname()== "enemy" then
            if t==1  then
                self.views[m]:play("penhuo",true)
            elseif t==3  then
                self.views[m]:play("Transformers")
            elseif t==6  then
                self.views[m]:play("Shoot1")
            elseif t==9  then
                self.views[m]:play("Shoot2")
            elseif t==12  then
                self.views[m]:play("end")
            elseif t==15  then
                t=1
            end
        end

        --            scheduler:unscheduleScriptEntry(myupdate)
    end
    myupdate = scheduler:scheduleScriptFunc(update, interval, false)
end


---------------------------
--@param
--@return
function GameService:update(dt)

end

return GameService