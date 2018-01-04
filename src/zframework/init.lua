

zf=zf or {}
local CURRENT_MODULE_NAME = ...
zf.PACKAGE_NAME = string.sub(CURRENT_MODULE_NAME, 1, -6)
print("CURRENT_MODULE_NAME:"..zf.PACKAGE_NAME )
zf.VERSION = "0.0.1"
zf.FRAMEWORK_NAME = "cocos2d-x Factory"
zf.SRC_PATH = "app"
roleConfig=require(zf.SRC_PATH..".roleConfig")--加载角色配置类
zf.mvc=require(zf.PACKAGE_NAME..".base.mvc.init")
require(zf.PACKAGE_NAME..".base.init")--加载基础类
display =require(zf.PACKAGE_NAME..".display")
functions =require(zf.PACKAGE_NAME..".functions")
require(zf.PACKAGE_NAME..".utils.init")--加载工具类

