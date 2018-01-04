-----------------------------------------------------------------------------------------------
--@field viewType   integet  视图类型，默认为1 普通精灵。 取值现有1：普通精灵(SimpleView),2：骨骼动画精灵(ArmatureView),3:帧动画(FramesArmatureView)
--@field roleType   integet 角色类型，默认为1 玩家 。取值需要按需求读取配置，测试取值 1:玩家,2:小怪,3:boss。角色类型由玩家给定。
--以下三个下标对应视图类型的下标
--                  [1]
--                       { string  角色图像} "player1-2-1.png"
--                  [2]
--                       @field action string  骨骼动画对应工程的名字   "Hero"   CocosStudio 生成后的文件名   "Hero/Hero" -->"Hero/"存放目录
--                       @field actionName table {sring 动作存储数组用于调用动作，默认为1正常动作 ，现有取值 1:正常动作(loading),2:跑,走(run),3:攻击(attack),4:受攻击(smitten),5:死(death) }
--                  [3]
--                       @field action     table  动作，默认为子节点为loading 正常动作 ，每个动作对应一张动作序列图与动画帧数。现有取值 loading:正常动作,run:跑,走,attack:攻击,smitten:受攻击,death:死亡
--                       @field actionName integet 动作存储数组用于调用动作，默认为1正常动作 ，现有取值 1:正常动作(loading),2:跑,走(run),3:攻击(attack),4:受攻击(smitten),5:死(death)



local roleConfig={
    viewType={
        --[[
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
        [3]={action="Hero/Hero"},
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
        ["death"]={"Hero_image.png",2,5},--动作的名字以第一个actionName为准
        },
        actionName={"death","loading","joyful","movel","mover"}
        },

        [3]={
        action={
        ["loading"]={"arrowActionR.png",6},
        ["run"]={"role.plist","role.png",6},
        ["attack"]={"player1-2-%d.png",4,["isGroup"]=true},--["isGroup"]=true 这个用于表示此模式是一个图片组
        ["death"]={"arrow_die.png",7}
        },
        actionName={"loading","run","attack","death"}
        },
        }


        },
        --]]

        [2]= {
            roleType={
                [1]={action="No1_Boss/Lv1_Boss",actionName={"penhuo","root","Transformers","Shoot1","Shoot2","end"}},
                [2]={action="plane_hero/plane_hero4",actionName={"Transformers_C","Transformers_STAR","N_L","N_L_1","N_L_2","N_R_1","N_R","N_R_2","N","Transformers_END","Y_L_1","Y_L","Y_L_2"}},

            }
        },
        [3]= {
            roleType={
                [1]={
                    action={
                        ["loading"]={"bullet.png",2},
                        ["d"]={"bullet1.plist","bullet1.png",3},
                    },
                    actionName={"loading","d"},

                },
                [2]={
                    action={
                        ["yellow"]={"yellow.plist","yellow.png",4},
                    },
                    actionName={"yellow"},

                },
                [3]={
                    action={
                        ["wpbullet"]={"wpbullet.png"},
                    },
                    actionName={"wpbullet"},

                },
            }
        },

    }

}
return roleConfig