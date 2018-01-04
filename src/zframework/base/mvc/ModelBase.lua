--------------------------
--class ModelBase 这个类与官方提供的没什么多大的区别吧
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-16
-- 
local ModelBase = class("ModelBase")
ModelBase.idkey="id"

ModelBase.attr = {
    id = {"string","player"},
    viewType = {"number",1},--视图类型，默认为1 普通精灵。 取值现有1：普通精灵,2：骨骼动画精灵,3:帧动画
    roleType = {"number",1} --角色类型，默认为1 玩家 。取值需要按需求读取配置，测试取值 1:玩家,2:小怪,3:boss。角色类型由玩家给定，按配置提取
}

ModelBase.fields={"id","viewType"}
local function filterProperties(properties, filter)
    for i, field in ipairs(filter) do
        properties[field] = nil
    end
end

function ModelBase:ctor(properties)
    cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()

    self.isModelBase_ = true
    if type(properties) ~= "table" then properties = {} end
    self:setProperties(properties)
    self:init()
end

function ModelBase:init()
--    print("ModelBase:init()")
end
function ModelBase:getId()
    local id = self[self.class.idkey]
    assert(id ~= nil, string.format("%s:getId() - invalid id", self.class.__cname))
    return id
end

function ModelBase:isValidId()
    local id = self[self.class.idkey]
    return type(id) == "string" and id ~= ""
end

---------------------------
--获取角色视图类型
--@param
--@return
function ModelBase:getViewType()
     local viewType = self.viewType
    
    assert(viewType ~= nil, string.format("%s:getViewType() - invalid viewType", self.class.__cname))
    return viewType
end

---------------------------
--获取玩家类型
--@param
--@return
function ModelBase:getRoleType()
    local roleType = self.roleType
    assert(roleType ~= nil, string.format("%s:getRoleType() - invalid roleType", self.class.__cname))
    return roleType
end

function ModelBase:setProperties(properties)
    assert(type(properties) == "table", string.format("%s:setProperties() - invalid properties", self.class.__cname))
    for field, attr in pairs(self.class.attr) do
        local typ, def = attr[1], attr[2]
        local propname = field
        local val = properties[field]
        if val ~= nil then
            if typ == "number" then val = tonumber(val) end
            assert(type(val) == typ, string.format("%s:setProperties() - type mismatch, %s expected %s, actual is %s", self.class.__cname, field, typ, type(val)))
            self[propname] = val
        elseif self[propname] == nil and def ~= nil then
            if type(def) == "table" then
                val = clone(def)
            elseif type(def) == "function" then
                val = def()
            else
                val = def
            end
            self[propname] = val
        end
    end

    return self
end

function ModelBase:getProperties(fields, filter)
    local schema = self.class.attr
    if type(fields) ~= "table" then fields = self.class.fields end

    local properties = {}
    for i, field in ipairs(fields) do
        local propname = field
        local typ = schema[field][1]
        local val = self[propname]
        assert(type(val) == typ, string.format("%s:getProperties() - type mismatch, %s expected %s, actual is %s", self.class.__cname, field, typ, type(val)))
        properties[field] = val
    end

    if type(filter) == "table" then
        filterProperties(properties, filter)
    end

    return properties
end

return ModelBase
