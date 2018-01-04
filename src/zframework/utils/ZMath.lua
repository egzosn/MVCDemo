----------------------------
--class ZMath 这个类主要用于编写数学算法
-- @author 郑灶生
-- Creation 2014-12-17

local ZMath=class("ZMath",math)
--求两点间的距离
function ZMath.dist(ax, ay, bx, by)
    local dx, dy = bx - ax, by - ay
    return math.sqrt(dx * dx + dy * dy)
end


--算圆周上的点 传入 角度 半径 及 圆弧的x坐标
function ZMath.getrx(angle,r,x)
    return  ((r*(math.cos((angle*3.14)/180)))+x)
end

--算圆周上的点 传入 角度 半径 及 圆心的y坐标
function ZMath.getry(angle,r,y)
    return ((r*(math.sin((angle*3.14)/180)))+y)
end

--角色上下移动 flag 是否碰到上下点
function ZMath.fluctuateY (flag,role)
    local x,y=role:getPosition()
    --  local x,y=self.enemy:getPosition()

    if not flag then  
        if y<(display.height-role:getContentSize().height) then
            y=y+1
        else
            flag=true
        end
    else
        if y>0 then
            y=y-1
        else
            flag=false
        end
    end 
    role:setPosition(x,y)
    
    return flag

end

--角色上下移动 flags 是否碰到上下左右点
function  ZMath.fluctuateXY (flags,role,boundaryx)
    local x,y=role:getPosition()
    local  rand=math.random(2,4)

    if not flags.lr then
        if x<(display.width-role:getContentSize().width/2) then
            x=x+3     

        else
            flags.lr=true   
        end

    else
        if x>boundaryx then
            x=x-3           
        else
            flags.lr=false   
        end     
    end

    if not flags.flag then
        if y<(display.height-role:getContentSize().height/2) then
            y=y+3
        else
            flags.flag=true
        end
    else
        if y>role:getContentSize().height/2 then

            y=y-3
        else
            flags.flag=false
        end
    end


    local my= (math.sin((((x+rand*5)%360)*3.14)/180))*2

    role:setPosition(x,y+my)
    x=x+1

    return flags

end


--两个盒子的碰撞检测
function ZMath.ifRam( x1,y1,width1,height1,x2,y2,width2,height2)
    if x1<=(x2+width2) and y1<=(y2+height2) and (x1+width1)>=x2 and (y1+height1)>=y2 then
        return true
    end
    return false
end

--[[--
判断盒子是否出界
@function [parent=#src.zframework.utils.ZMath] ifRam
@param box userdata 视图盒子
--]]

function ZMath.ifRam(x,y,w,h)
    if w/2>x or h/2>y or (display.height-h/2)<y or (display.width-w/2)<x then
        return false
    end
    return true
end
--[[
function ZMath.ifRam(vx,vy,w,h)
    local x,y,w,h=  ZMath.getPosAndSize(box)
    if w/2>x or h/2>y or (display.height-h/2)<y or (display.width-w/2)<x then
        return false
    end
    return true
end
--]]

-----------------------
--获取盒子的坐标与大小
--@param box userdata 盒子
--
function ZMath.getPosAndSize(box)
    
    local x,y=box:getPosition()
    local size= box:getContentSize()
    local w,h=size.width,size.height
    
   return x,y,w,h
end

--计算开火的角度
function ZMath.getFireAngle(heroX,heroY,enemyX,enemyY)
--    print("heroX,heroY"..heroX.."   "..heroY)
--    print("enemyX,enemyY"..enemyX.."   ")
    local value=math.atan2(enemyY-heroY,enemyX-heroX)
    return -value*180/math.pi+90
end


---------------------------
--从右边往左边开始查找
--@param input string 需要操作的字符串
--@param str string  需要查找的字符串
--@return #int 所在的位置
function ZMath.rIndexof(input,str)
    local pos = string.len(input)
    local spos = string.len(str)
    pos=pos-spos
    while pos > 0 do
        local st,sp=string.find(input, str, pos, true)
--        print(st,sp)
        if st and sp then
            return st,sp
        end
        pos = pos - 1
    end
    return 0,0
end
---------------------------
--以某个下标分割字符串
--@param input string 需要操作的字符串
--@param index integer 下标
--@return string,string
function ZMath.subscriptSplit(input,index)
    local start=string.sub(input,1,index-1)
    local ends=string.sub(input,index)
    return start,ends
end

return ZMath