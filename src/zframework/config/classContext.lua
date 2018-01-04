-----------------------------
--这是一个模板，可直接拷贝到app根目录下
--
---------------------------------------
----beans 是一个记录所有类的工厂
--@field #table id 记录了每个类的id，key值是自己给定的,value关联 @field bean所对应的key。 用于获取类、实例化，继承所用(仅限于自己编写的类,app目录下的所有类)
--@field #table bean 记录每个类的的名字,key值是类名,value关联 @field package[1]所对应的key用于需找上级目录(所在包)
--@field #table package 记录每一级的包名,package[1]的key值是包名,value关联 @field package[2]所对应的key用于需找上级目录(所在包),package[1]为最里层包，以此类推package[#package]为最外层包,

--[[
local beans={
    id={
        ["playDuelController"]=1,
        ["hero"]=2,
        ["heroView"]=3,
    },
    bean={
        [1]={"PlayDuelController",1,1},
        [2]={"Hero",1,2},
        [3]={"HeroView",1,3}
    },
    package={
        [1]={
            [1]={"controllers",2,1},
            [2]={"models",2,1},
            [3]={"view",2,1}
        },
        [2]={[1]={"app"}}
    }

}
--]]

--------------------------------------
--以下这种也是可行的，但请不要混合使用。
--bean={[id]=class}

---[[
local beans={
    ["playDuelController"]="app.controllers.PlayDuelController",
    ["hero"]="app.models.Hero",
    ["heroView"]="app.view.HeroView"
}
--]]
return beans