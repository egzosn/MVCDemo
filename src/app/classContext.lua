---------------------------------------
----beans 是一个记录所有类的工厂
--@field #table id 记录了每个类的id，key值是自己给定的,value关联 @field bean所对应的key。 用于获取类、实例化，继承所用(仅限于自己编写的类,app目录下的所有类)
--@field #table bean 记录每个类的的名字,key值是类名,value关联 @field package[1]所对应的key用于需找上级目录(所在包)
--@field #table package 记录每一级的包名,package[1]的key值是包名,value关联 @field package[2]所对应的key用于需找上级目录(所在包),package[1]为最里层包，以此类推package[#package]为最外层包,

local beans={}
---[[
beans={
    id={
        ["playDuelController"]=1,
        
        ["actor"]=2,
        ["actorView"]=3,
        
        ["hero"]=4,
        ["weapon"]=8,
        
        ["heroView"]=5,
        ["background"]=6,
        ["exhaust"]=9,
        ["bulletView"]=10,
        ["armatureView"]=11,
        
        ["gameService"]=7,
    },
    bean={
        [1]={"PlayDuelController",1,1},
        
        [2]={"Actor",1,2},
        [3]={"ActorView",1,3},
        
        [4]={"Hero",1,2},
        [8]={"Weapon",1,2},
        
        [5]={"HeroView",1,3},
        [6]={"BackGround",1,3},
        [9]={"Exhaust",1,3},
        [10]={"BulletView",1,3},
        [11]={"ArmatureView",1,3},
        [7]={"GameService",1,4},
    },
    package={
        [1]={
            [1]={"controllers",2,1},
            [2]={"models",2,1},
            [3]={"view",2,1},
            [4]={"service",2,1},
        },
        [2]={[1]={"app"}}
    }

}
--]]

--------------------------------------
--以下这种也是可行的，但请不要混合使用。
--bean={[id]=class}

--[[
beans={
    ["playDuelController"]="app.controllers.PlayDuelController",
    ["actor"]="app.models.Actor",
    ["hero"]="app.models.Hero",
    ["heroView"]="app.view.HeroView"
}
--]]
return beans