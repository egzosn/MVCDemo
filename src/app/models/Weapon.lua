
local Weapon = class("Weapon",zf.mvc.ModelBase)
Weapon.attr=clone( zf.mvc.ModelBase.attr)
function Weapon:ctor(properties)
    Weapon.super.ctor(self,properties)
--   print(...)
end

function Weapon:onEnter()

end

function Weapon:onEnter()
end

function Weapon:onExit()
end

return Weapon
