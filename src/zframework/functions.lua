--------------------------
-- @author 郑灶生
-- Creation 2014-12-17

local folders={}    --存储类所属命名空间
local files={}      --用于存储类名字
local folderKey=1   --记录命名空间最大的key,初始化为1
local classContext=require(zf.PACKAGE_NAME..".classContext")
table.merge(classContext,require(zf.SRC_PATH..".classContext"))

--[[
---------------------------
--获取文件相对于项目绝对目录与文件名
--@param path lua文件的存放路径
--@return folder, file  文件目录与文件名
-- @usage#        实例:
--  strippath(D:\cocos\base\src\app\scenes\MainScene.lua) 得到scenes  MainScene
local function strippath(filename)
--    return string.match(filename, "[app]\\(%w*)\\([^\\]*)%.lua$")
return string.match(filename, "[app]/(%w*)/([^\\]*)%.lua$")

end
--]]


function checktableKey(table,key)
    for k, v in pairs(table) do
        if k==key then
        	return true
        end
    end
    return false
end






---------------------------
-- 设置类所属命名空间
--@param folder 文件目录
--@param file 文件名
------ @usage#        实例:
--  setFolders("scenes", "MainScene")
local function setFolders(folder,file)
    if type(folder)=="nil" or type(file)=="nil" then
        return
    end
    if folder ~=folders[folderKey-1] then
        table.insert( folders,folderKey,folder)
        folderKey=folderKey+1
    end
    files[file]=folderKey-1
    --    print(folder,file)
end

---------------------------
--构建宏
--@param __TYPE__ userdata 对象
--
function CREATE_FUNC(__TYPE__)
    function  __TYPE__.create(...)
        local  pRet =  __TYPE__.new(...)
        if pRet and pRet:init(...) then
            return pRet
        else
            pRet = nil;
            return nil;
        end
    end
end


---------------------------
--得到一个类
--@param classId 类名
--@return 类
--@usage#        实例:
-- getClass("MainScene") 返回app.scene.MainScene
function getClass(classId)
    print(classId)
    assert( type(classId) ~= "nil" , string.format("classId '%s' not found", classId))
    --    if classId then
    print(classContext.getClass(classId))
    return require(classContext.getClass(classId))
        --      else
        --        printError("classId '%s' not found", classId)
        --     end
end


---------------------------
--得到一个类对象
--@param classId string 类名
--@param ... table 类的初始化参数
--@return 类对象
--@usage#        实例:
--B:newClass("MainScene") 返回 MainScene对象
function newClass(classId,...)
    local cls = getClass(classId)
    assert( type(cls) == "table" , string.format("module '%s' not found", classId))
    --    if type(cls)=="table" then
    return cls.new(...)
        --    else
        --        cls=view.func[className]
        --        if cls~=nil then
        --            return cls.new(...)
        --        else
        --        printError("module '%s' not found", classId)
        --        end
        --    end
end
--[[--
----------------------------------------
继承
@param classname string  类名
@param super string  父类名
@return class 类

--]]
function extends(classname, super)
    local cls=getClass(super)
    assert( type(cls) == "table" , string.format("super module '%s' not found", super))
    --    if type(cls)=="table" then
    return class(classname,cls)
        --    else
        --        cls=view.func[super]
        --        if cls~=nil then
        --            return class(classname,cls)
        --        else
        --        printError("super module '%s' not found", super)
        --        end
        --    end

end

