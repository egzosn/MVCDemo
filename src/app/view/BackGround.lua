local BackGround=class("BackGround",function ()
    return display.newNode()
end)


---------------------------
--@param
--@return
function BackGround:ctor()
    local filename="bg.png"
--    local basename,extname=display.addSpriteFrames(filename)
    self.s={}
    for i = 1, 2 do
--        self.s[i]= display.newSprite("#"..basename.."1_1"..extname):align(display.LEFT_BOTTOM)
        self.s[i]= display.newSprite(filename):align(display.LEFT_BOTTOM)
        if self.s[i-1] then
            self.s[i]:pos(0,self.s[i-1]:getContentSize().height-0.1)
        else
            self.s[i]:pos(0,0)
        end
        self:addChild(self.s[i])
    end
    self:move(-2)
--    print("self.s[1]:"..self.s[1]:getPositionY())
--    print("self.s[2]:"..self.s[2]:getPositionY())
--    self:scale(display.width/640)
end


---------------------------
--@param
--@return
function BackGround:update()

end

---------------------------
--@param
--@return
function BackGround:move(y)
    self:moveBy(1,y)
    self:moveBy(2,y)
end

---------------------------
--@param
--@return
function BackGround:moveBy(i,y)
    transition.moveBy(self.s[i],{x=0,y=y,time=0.01,onComplete=function(event)
        if self.s[i]:getPositionY()<=-self.s[1]:getContentSize().height then
            self.s[i]:setPositionY(self.s[1]:getContentSize().height)
        end
        if i==2 then
            self:move(y)
        end
    end})
    
end


return BackGround