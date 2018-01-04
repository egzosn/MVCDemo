local Hero = extends("Hero","actor")

---------------------------
--@param
--@return
function Hero:init()
--    print("Hero:init()")
    self.isDie=false
    self.weapons={}--武器或技能
    self.angle=0--精灵的角度
end
--[[
function Hero:fire(weapon,x,y)

--    self:moveWeapon(weapon,x,y)
end
--]]

--这里有需要改动
function Hero:addWeapon(weapon)
    if weapon then
        self.weapons[weapon]=weapon
    end

end

function Hero: getWeapons()
    return self.weapons
end
--[[--

武器 技能移动    需改动
@param num x 
@param num y

]]
function Hero:moveWeapon(weapon,x,y)
--    print(x,y)
    transition.moveBy(weapon,{  
        x = x ,  
        y = y ,  
        time = 1,
        onComplete = function (event)  
            self.weapons[event]= nil  
            event:removeSelf()  

        end  
    })  
    self.weapons[weapon]=weapon
end

--[[
    设置精灵的角度
@param number#angle
--]]
function Hero:setAngle(angle)
    self.angle=angle
end

--[[
获取精灵的角度
--@return number#angle
--]]
function Hero:getAngle()
    return self.angle
end
function Hero:getIsDie()
    print(self.isDie)
    return self.isDie
end
function Hero:setDie(isDie)
    self.isDie=isDie
end
function Hero:onEnter()

end


return Hero
