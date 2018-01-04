local Exhaust=class("Exhaust",function()
    local exhaust= display.newSprite()
    display.addSpriteFrames("p-f.png",2)
    exhaust:setSpriteFrame("p-f1_1.png")
    return exhaust
end)

---------------------------
--@param
--@return
function Exhaust:ctor()
    local pattern="p-f1_%d.png"
    local action=display.newFramesAnimation(pattern,1,2)
    self:playAnimationForever(action)
end
    

return Exhaust