--------------------------
--类工厂，这是一个配置文件，如需使用该配置文件，需要在app根目录创建 classContext.lua即可，table编写格式与此类一样即可
-- @author 郑灶生      zss9309@qq.com
-- Creation 2014-12-17
-- 
----beans 是一个记录所有类的工厂
--@field #table id 记录了每个类的id，key值是自己给定的,value关联 @field bean所对应的key。 用于获取类、实例化，继承所用(仅限于自己编写的类,app目录下的所有类)
--@field #table bean 记录每个类的的名字,key值是类名,value关联 @field package[1]所对应的key用于需找上级目录(所在包)
--@field #table package 记录每一级的包名,package[1]的key值是包名,value关联 @field package[2]所对应的key用于需找上级目录(所在包),package[1]为最里层包，以此类推package[#package]为最外层包,
---------------------------------------
----beans 是一个记录所有类的工厂
--@field #table id 记录了每个类的id，key值是自己给定的,value关联 @field bean所对应的key。 用于获取类、实例化，继承所用(仅限于自己编写的类,app目录下的所有类)
--@field #table bean 记录每个类的的名字,key值是类名,value关联 @field package[1]所对应的key用于需找上级目录(所在包)
--@field #table package 记录每一级的包名,package[1]的key值是包名,value关联 @field package[2]所对应的key用于需找上级目录(所在包),package[1]为最里层包，以此类推package[#package]为最外层包,
local beans={}
 ---[[
 beans={
    id={
        ["appBase"]="_appBase",
        ["modelBase"]="_modelBase",
        ["viewBase"]="_viewBase",
    },
    bean={
        ["_appBase"]={"AppBase",1,"_mvc"},
        ["_modelBase"]={"ModelBase",1,"_mvc"},
        ["_viewBase"]={"ViewBase",1,"_mvc"},
    },
    package={
        [1]={
            ["_mvc"]={"mvc",2,"_base"},
        },
        [2]={["_base"]={"base",3,"_zf"}},
        [3]={["_zf"]={"zframework"}}
    }

}
--]]
--------------------------------------
--以下这种也是可行的，但请不要混合使用。
--bean={[id]=class}

--[[
beans={
    ["appBase"]="zframework.base.mvc.AppBase",
    ["modelBase"]="zframework.base.mvc.ModelBase",
    ["viewBase"]="zframework.base.mvc.ViewBase",
}
--]]

---------------------------
--@param id string 包id
--@return package 包
function beans.getPackage(key,id)
    if not key then
        return ""
    end
    local p=beans.package[key][id]
    return beans.getPackage(p[2],p[3])..p[1].."."

end

---------------------------
--@param id string 类id
--@return class 类
function beans.getClass(id)
    if beans[id] then
        print(beans[id])
        return beans[id]
    end
    local bid=beans.id[id]
--    if not bid then
--        printError("bean \"%s\" Not found",id)
--    end
    assert(bid ~= nil , string.format("bean \"%s\" Not found",id))
    local bean=beans.bean[bid]
    local package= beans.getPackage(bean[2],bean[3])
    local cls=package..bean[1]
--    print(cls)
    return cls

end

return beans