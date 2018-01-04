
-------------------------
--class view 这是一个视图类继承display
--方法工厂
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-17

local view =class("view",display)
--[[
----------------------------
--添加图像帧
--@param fileName string 图像路径
--@param rect_table rect_table
-- @usage#        实例:
--                      view.addSpriteFrames("hero.png",,cc.rect(x=10,10,20,20))
--                   将此图片切割成4张图片缓存，图片缓存的名字为：hero1_1.png,hero1_2.png,hero2_1.png,hero2_2.png
function view.addSpriteFrames(fileName,rect_table)
local  sfc =cc.SpriteFrameCache:getInstance()
local rows=rect_table.height/rect_table.y
local cols=rect_table.width/rect_table.x
local pos,sp=  ZMath.rIndexof(fileName,".")
local basename=string.sub(fileName,1,pos-1)
local extname=string.sub(fileName,pos)
local frameName=basename.."%d_%d"..extname
for row=1, rows do
for col=1, cols do
local x=(col-1)*rect_table.x
local y=(row-1)*rect_table.y
local sf= cc.SpriteFrame:create(fileName,cc.rect(x ,y,rect_table.x,rect_table.y))
print("string.format(frameName,row,col):"..string.format(frameName,row,col))
sfc:addSpriteFrame(sf,string.format(frameName,row,col))
end
end
end
--]]

----------------------------
--将指定的 Sprite Sheets 材质文件及其数据文件载入图像帧缓存。对display.addSpriteFrames()进行了一个扩展
-- @function [parent=#view] addSpriteFrames
-- 
--@param fileNameOrPlistFilename:string               图像路径|数据文件名
--@param colsOrImage             integer|string      需要切割的列|材质文件名
--@param rowsOrHandler           integer|function    需要切割的行|异步加载纹理的函数
--@usage#  view.addSpriteFrames("hero.png",2,2)
--               将此图片切割成4张图片缓存，图片缓存的名字为：hero1_1.png,hero1_2.png,hero2_1.png,hero2_2.png
--          view.addSpriteFrames("hero.png",2,1)
--               将此图片切割成4张图片缓存，图片缓存的名字为：hero1_1.png,hero1_2.png
--     将指定的 Sprite Sheets 材质文件及其数据文件载入图像帧缓存。
--      view.addSpriteFrames(数据文件名, 材质文件名)
--
--~~~ lua
--
---- 同步加载纹理
--view.addSpriteFrames("Sprites.plist", "Sprites.png")
--
---- 异步加载纹理
--local cb = function(plist, image)
--    -- do something
--end
--view.addSpriteFrames("Sprites.plist", "Sprites.png", cb)
--
--
--Sprite Sheets 通俗一点解释就是包含多张图片的集合。Sprite Sheets 材质文件由多张图片组成，而数据文件则记录了图片在材质文件中的位置等信息。
--
--@see Sprite Sheets
function view.addSpriteFrames(fileNameOrPlistFilename,colsOrImage,rowsOrHandler)
    --    local fileName,cols,rows=fileNameOrPlistFilename,colsOrImage,rowsOrHandler
  
    local pos,sp=  ZMath.rIndexof(fileNameOrPlistFilename,".")
--    print(pos,sp)
    if(string.sub(fileNameOrPlistFilename,pos)==".plist") then 
        view.super.addSpriteFrames(fileNameOrPlistFilename,colsOrImage,rowsOrHandler) 
        local pos=  ZMath.rIndexof(colsOrImage,".")
        local basename,extname=ZMath.subscriptSplit(colsOrImage,pos)
        return basename,extname
    end
    if not colsOrImage then
        colsOrImage=1
    end
    if not rowsOrHandler then
        rowsOrHandler=1
    end
    local  sfc =cc.SpriteFrameCache:getInstance()
    local sprite = display.newSprite(fileNameOrPlistFilename)
    local ssize=sprite:getContentSize()
    sprite:removeSelf()
    local size_table=cc.size(ssize.width/colsOrImage,ssize.height/rowsOrHandler)
    local pos,sp=  ZMath.rIndexof(fileNameOrPlistFilename,".")
    local basename,extname=ZMath.subscriptSplit(fileNameOrPlistFilename,pos)
    local frameName=basename.."%d_%d"..extname
    for row=1, rowsOrHandler do
        for col=1, colsOrImage do
            local x=(col-1)*size_table.width
            local y=(row-1)*size_table.height
            local sf= cc.SpriteFrame:create(fileNameOrPlistFilename,cc.rect(x ,y,size_table.width,size_table.height))
            --            print("string.format(frameName,row,col):"..string.format(frameName,row,col))
            sfc:addSpriteFrame(sf,string.format(frameName,row,col))
        end     
    end
    
    return basename,extname
end

----------------------------
--以特定模式创建一个包含多个图像帧对象的数组。对display.newFrames()进行了一个扩展
-- @function [parent=#view] newFrames
--@param pattern string 模式字符串
--@param begin integer 起始索引
--@param length integer 长度
--@param isReversed boolean 是否是递减索引
--@return #table 图像帧数组
-- @usage#        实例:
--                  display.newFrames("hero%d.png" ,0,5,true)
--                  将此模式的图片加入缓存中，并返回图像帧数组
function view.newFrames(pattern ,begin,length,isReversed)
    local  sfc =cc.SpriteFrameCache:getInstance()
    local frameName=string.format(pattern,begin)

    local frame = sfc:getSpriteFrame(frameName)
    if frame then frameName="#"..frameName end
    local sprite = view.newSprite(frameName)
    local size_table=sprite:getContentSize()
    sprite:removeSelf()
    local frames = {}
    local step = 1
    local last = begin + length - 1
    if isReversed then
        last, begin = begin, last
        step = -1
    end
    for index = begin, last, step do
        frameName = string.format(pattern, index)
--        print(frameName)
        frame = sfc:getSpriteFrame(frameName)
        if not frame then
            local  sf= cc.SpriteFrame:create(frameName,cc.rect(0 ,0,size_table.width,size_table.height))
            --            print(string.format(frameName,index))
            sfc:addSpriteFrame(sf,frameName)
            frame=sf
        end
        if not frame then
            printError("display.newFrames() - invalid frame, name %s", tostring(frameName))
            return
        end
        frames[#frames + 1] = frame
    end
    return frames
end


----------------------------
--以特定模式创建一个包含多个图像帧对象的数组。将此模式图像帧 合成帧动画，并存入缓存
-- @function [parent=#view] newAnimation
--@param pattern string 模式字符串
--@param begin integer 起始索引
--@param length integer 长度
--@return #Animation 帧动画
-- @usage#        实例:
--                  view.addAnimationCache("hero%d.png" ,1,5,"run")
--                  将此模式图像帧 合成帧动画，并存入缓存
function view.newFramesAnimation(pattern,begin,length)
    local frames = view.newFrames(pattern,begin,length )
    local animation = view.super.newAnimation( frames, 1 / 5 ) 
    return animation
end

return view