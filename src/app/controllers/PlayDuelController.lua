local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local PlayDuelController = newLayer("PlayDuelController")

function PlayDuelController:ctor()
    self:init()

end

function PlayDuelController:init()
    newClass("background"):addTo(self)
    self.views={}
    --帧动画
--      self.hero= newClass("hero",{viewType=3})
--    self.views[self.hero]=newClass("heroView",self.hero)
    --骨骼动画
    self.hero= newClass("hero",{viewType=2,roleType=2,nickname="player"})
    self.views[ self.hero]=newClass("armatureView", self.hero)

    self.views[self.hero]:pos(display.cx-100,100):addTo(self,99)
    self.gameService=newClass("gameService",self, self.views,self.hero)
    self.cursorPos={}
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT,handler(self,self.onTouch))
    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,function(dt)
        self.gameService:update(dt)
    end)
    self:scheduleUpdate()
    --计划一个以指定时间间隔执行的全局事件回调，并返回该计划的句柄。
    self.sched=nil
    self.sched= scheduler.scheduleGlobal(function()
        self:addBullet()
        --        self.gameService:addEnemy(self.views)
    end,0.15)
    self.gameService:addEnemy(self.views)

end
---------------------------
--@param heroView app.view.HeroView 角色视图
--@param event Event 事件
--@return
function PlayDuelController:onTouch(event)
    if event.name=="began" then
        self.cursorPos=cc.p(event.x,event.y)
    elseif event.name=="moved" then
        local point=cc.p(event.x-self.cursorPos.x,event.y-self.cursorPos.y)
        local p=self.gameService:edgeDetection(point)
        self.views[self.hero]:move(p)
        self.gameService:onMove(point)
        self.cursorPos=cc.p(event.x,event.y)
    elseif event.name=="ended" then
        self.gameService:onMove()
        --      self.views[self.hero]:play("Transformers_STAR")
    end
    return true
end


---------------------------
--@param
--@return
function PlayDuelController:addBullet()
    self.gameService:addBullet( self.hero,display.top+10,nil,1)
    for i=-5, 5 do
        self.gameService:addBullet( self.hero,display.top+10,cc.p(i*10,-math.abs(i*10)+50))
    end
    if true then
        for i=1, 2 do
            self.gameService:addBullet(self.hero)
        end
    end
end

return PlayDuelController
