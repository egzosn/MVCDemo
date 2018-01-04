--------------------------
--class baseLayer 这个类还需要进行扩展
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16
--
local l=class("baseLayer", function(...)
    local layer =nil
--    for key, var in pairs(...) do
--   	    print(key,var)
--   end
    if  (... == nil) or( not checktableKey(...,"r") and not checktableKey(...,"g") and not checktableKey(...,"b")) then

        layer = display.newLayer(...)
    else
        layer=  display.newColorLayer(...)
    end


    layer:setNodeEventEnabled(true)
    return layer
end)

return l