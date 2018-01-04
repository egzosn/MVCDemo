local MainScene =newScene("MainScene")


---------------------------
--@param
--@return
function MainScene:createScene()
    local scene = display.newScene("MainScene")
    -- 'layer' is an autorelease object
    --cc.c4b(255,255,255,255)
    local layer = MainScene.create(cc.c4b(255,255,255,255))
    --add layer as a child to scene
    scene:addChild(layer);
    --return the scene
    return scene
end

function MainScene:ctor()
    newClass("playDuelController"):addTo(self)
    audio.playMusic("bgMusic_level_1.ogg",true)
    --    audio.setSoundsVolume(1.0)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
