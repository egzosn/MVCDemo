----------------------------
--class ZConfig 这是一个配置类解析工具
-- @author 郑灶生
-- Creation 2014-12-17
-- 
local M = {}


function M.getConfig(__tablename)

        local __Config = require("app.config."..__tablename)

    return __Config
end

function M.getValTabByid(__table,_id)
    assert(_id ~= nil , string.format("ZConfig:getValTabByid() - invalid _id"))
    local valTab=__table[_id]
    
    if not valTab then
        valTab={}
        for k,v in pairs(__table) do        
            if tostring(v["id"])==tostring(_id) then
           	    valTab=v
           	    break
           end
        end
    end
    return valTab
end





function M.getValTabByName(__table,__name,__val)
    assert(__name ~= nil and __val ~= nil, "ZConfig:getValTabByName() - invalid __name or __val")
    local valTab  =  {}

    if __name == "id" then
        return M.getValTabByid(__table,__val)
    end

    for k,v in pairs(__table) do        
        if tostring(v[tostring(__name)])  == tostring(__val) then 
            table.insert(valTab, v)
        end
    end

    return valTab
end




return M