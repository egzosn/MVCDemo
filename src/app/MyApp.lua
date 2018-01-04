require("config")
require("framework.init")
require("zframework.init")
local MyApp = class("MyApp", zf.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)

end




function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
--    self:loading()
--    self:enterScene("MainScene")
    self:replaceScene("MainScene")
end

function MyApp:loading()
--    display.addSpriteFrames("tree.png",2,2)
end

return MyApp
