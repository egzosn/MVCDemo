-----------------------------
--这是一个模板，可直接拷贝到app根目录下

-----------------------------------------------------------------------------------------------
--@field viewType   integet  视图类型，默认为1 普通精灵。 取值现有1：普通精灵,2：骨骼动画精灵,3:帧动画
--@field roleType   integet 角色类型，默认为1 玩家 。取值需要按需求读取配置，测试取值 1:玩家,2:小怪,3:boss。角色类型由玩家给定。
--以下三个下标对应视图类型的下标
--                  [1]
--                       { string  角色图像} "player1-2-1.png"
--                  [2]
--                       @field action string  骨骼动画对应工程的名字   "Hero"   CocosStudio 生成后的文件名   "Hero/Hero" -->"Hero/"存放目录
--                       @field actionName table {sring 动作存储数组用于调用动作，默认为1正常动作 ，现有取值 1:正常动作(loading),2:跑,走(run),3:攻击(attack),4:受攻击(smitten),5:死(death) 动作名字以制作时定义的为准}
--                  [3]
--                       @field action     table  动作，默认为子节点为loading 正常动作 ，每个动作对应一张动作序列图与动画帧数。现有取值 loading:正常动作,run:跑,走,attack:攻击,smitten:受攻击,death:死亡
--                       @field actionName integet 动作存储数组用于调用动作，默认为1正常动作 ，现有取值 1:正常动作(loading),2:跑,走(run),3:攻击(attack),4:受攻击(smitten),5:死(death)
roleConfig={
    viewType={
        [1]= {
            roleType={
                [1]={"player1-2-1.png"},
                [2]={"player1-2-1.png"},
                [3]={"player1-2-1.png"}
            },
        },
        
        [2]= {
            roleType={
                [1]={action="Hero/Hero",actionName={"loading","run","death"}},
                [2]={action="Gliding",actionName={"loading","run","death"}},
            }
        },
        
        [3]= {
            roleType={
                [1]={
                    action={
                        ["loading"]={"arrowActionR.png",6},
                        ["run"]={"allow_walkRight.png",11},
                        ["death"]={"arrow_die.png",7}
                    },
                    actionName={"loading","run","death"},
                    
                },
                [2]={
                    action={
                        ["loading"]={"tortoise.png",2,3},--这里的 ["loading"]必须等于 actionName[1]，   tortoise.png 是一组动作图像 有3组动作，每组2帧。
                    },
                    actionName={"loading","run","death"}--这里写每组动作的名字
                },
                [3]={
                    action={
                        ["loading"]={"arrowActionR.png",6},--这里 arrowActionR.png是一组6帧动作
                        ["run"]={"role.plist","role.png",6},--这里的规则 role.plist里的缓存图像必须以role1_%d 为准
                        ["attack"]={"player1-2-%d.png",4,["isGroup"]=true},--["isGroup"]=true 这个用于表示此模式是一个图片组
                        ["death"]={"arrow_die.png",7} 
                    },
                    actionName={"loading","run","attack","death"}
                },

            }

        },

    }

}
