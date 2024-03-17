function 黄门(; id, prefix=String[])
    return Item(id=id, type=YellowDoor(), prefix=prefix)
end

function 蓝门(; id, prefix=String[])
    return Item(id=id, type=BlueDoor(), prefix=prefix)
end

function 红门(; id, prefix=String[])
    return Item(id=id, type=RedDoor(), prefix=prefix)
end

function 黄钥匙(; id, prefix=String[], value=1)
    return Item(id=id, type=YellowKey(value=value), prefix=prefix)
end

function 蓝钥匙(; id, prefix=String[], value=1)
    return Item(id=id, type=BlueKey(value=value), prefix=prefix)
end

function 红钥匙(; id, prefix=String[], value=1)
    return Item(id=id, type=RedKey(value=value), prefix=prefix)
end

function 红宝石(; id, prefix=String[], value=3)
    return Item(id=id, type=AttackStone(value=value), prefix=prefix)
end

function 蓝宝石(; id, prefix=String[], value=3)
    return Item(id=id, type=DefenseStone(value=value), prefix=prefix)
end

function 药水(; id, prefix=String[], value=300)
    return Item(id=id, type=Water(value=value), prefix=prefix)
end

function 绿头怪(; id, prefix=String[])
    m = Monster(name="绿头怪", health=50, attack=20, 
        defense=1, gold=1, exper=1)
    return Item(id=id, type=m, prefix=prefix)
end

function 红头怪(; id, prefix=String[])
    m = Monster(name="红头怪", health=70, attack=15, 
        defense=2, gold=2, exper=2)
    return Item(id=id, type=m, prefix=prefix)
end

function 小蝙蝠(; id, prefix=String[])
    m = Monster(name="小蝙蝠", health=100, attack=20, 
        defense=5, gold=3, exper=3)
    return Item(id=id, type=m, prefix=prefix)
end

function 骷髅人(; id, prefix=String[])
    m = Monster(name="骷髅人", health=110, attack=25, 
        defense=5, gold=5, exper=4)
    return Item(id=id, type=m, prefix=prefix)
end

function 青头怪(; id, prefix=String[])
    m = Monster(name="青头怪", health=200, attack=35, 
        defense=10, gold=5, exper=5)
    return Item(id=id, type=m, prefix=prefix)
end

function 骷髅士兵(; id, prefix=String[])
    m = Monster(name="骷髅士兵", health=150, attack=40, 
        defense=20, gold=8, exper=6)
    return Item(id=id, type=m, prefix=prefix)
end

function 初级法师(; id, prefix=String[])
    m = Monster(name="初级法师", health=125, attack=50, 
        defense=25, gold=10, exper=7)
    return Item(id=id, type=m, prefix=prefix)
end

function 大蝙蝠(; id, prefix=String[])
    m = Monster(name="大蝙蝠", health=150, attack=65, 
        defense=30, gold=10, exper=8)
    return Item(id=id, type=m, prefix=prefix)
end

function 兽面人(; id, prefix=String[])
    m = Monster(name="兽面人", health=300, attack=75, 
        defense=45, gold=13, exper=10)
    return Item(id=id, type=m, prefix=prefix)
end

function 骷髅队长(; id, prefix=String[])
    m = Monster(name="骷髅队长", health=400, attack=90, 
        defense=50, gold=15, exper=12)
    return Item(id=id, type=m, prefix=prefix)
end

function 石头怪人(; id, prefix=String[])
    m = Monster(name="石头怪人", health=500, attack=115, 
        defense=65, gold=15, exper=15)
    return Item(id=id, type=m, prefix=prefix)
end

function 麻衣法师(; id, prefix=String[])
    m = Monster(name="麻衣法师", health=250, attack=120, 
        defense=70, gold=20, exper=17)
    return Item(id=id, type=m, prefix=prefix)
end

function 初级卫兵(; id, prefix=String[])
    m = Monster(name="初级卫兵", health=450, attack=150, 
        defense=90, gold=22, exper=19)
    return Item(id=id, type=m, prefix=prefix)
end

function 红蝙蝠(; id, prefix=String[])
    m = Monster(name="红蝙蝠", health=550, attack=160, 
        defense=90, gold=25, exper=20)
    return Item(id=id, type=m, prefix=prefix)
end

function 高级法师(; id, prefix=String[])
    m = Monster(name="高级法师", health=100, attack=200, 
        defense=110, gold=30, exper=25)
    return Item(id=id, type=m, prefix=prefix)
end

function 怪王(; id, prefix=String[])
    m = Monster(name="怪王", health=700, attack=250, 
        defense=125, gold=32, exper=30)
    return Item(id=id, type=m, prefix=prefix)
end

function 白衣武士(; id, prefix=String[])
    m = Monster(name="白衣武士", health=1300, attack=300, 
        defense=150, gold=40, exper=35)
    return Item(id=id, type=m, prefix=prefix)
end

function 金卫士(; id, prefix=String[])
    m = Monster(name="金卫士", health=850, attack=350, 
        defense=200, gold=45, exper=40)
    return Item(id=id, type=m, prefix=prefix)
end

function 红衣法师(; id, prefix=String[])
    m = Monster(name="红衣法师", health=500, attack=400, 
        defense=260, gold=47, exper=45)
    return Item(id=id, type=m, prefix=prefix)
end

function 兽面武士(; id, prefix=String[])
    m = Monster(name="兽面武士", health=900, attack=450, 
        defense=330, gold=50, exper=50)
    return Item(id=id, type=m, prefix=prefix)
end

function 冥卫兵(; id, prefix=String[])
    m = Monster(name="冥卫兵", health=1250, attack=500, 
        defense=400, gold=55, exper=55)
    return Item(id=id, type=m, prefix=prefix)
end

function 高级卫兵(; id, prefix=String[])
    m = Monster(name="高级卫兵", health=1500, attack=560, 
        defense=460, gold=60, exper=60)
    return Item(id=id, type=m, prefix=prefix)
end

function 双手剑士(; id, prefix=String[])
    m = Monster(name="双手剑士", health=1200, attack=620, 
        defense=520, gold=65, exper=75)
    return Item(id=id, type=m, prefix=prefix)
end

function 冥战士(; id, prefix=String[])
    m = Monster(name="冥战士", health=2000, attack=680, 
        defense=590, gold=70, exper=65)
    return Item(id=id, type=m, prefix=prefix)
end

function 金队长(; id, prefix=String[])
    m = Monster(name="金队长", health=900, attack=750, 
        defense=650, gold=77, exper=70)
    return Item(id=id, type=m, prefix=prefix)
end

function 灵法师(; id, prefix=String[])
    m = Monster(name="灵法师", health=1500, attack=830, 
        defense=730, gold=80, exper=70)
    return Item(id=id, type=m, prefix=prefix)
end

function 冥队长(; id, prefix=String[])
    m = Monster(name="冥队长", health=2500, attack=900, 
        defense=850, gold=84, exper=75)
    return Item(id=id, type=m, prefix=prefix)
end

function 灵武士(; id, prefix=String[])
    m = Monster(name="灵武士", health=1200, attack=980, 
        defense=900, gold=88, exper=75)
    return Item(id=id, type=m, prefix=prefix)
end

function 影子战士(; id, prefix=String[])
    m = Monster(name="影子战士", health=3100, attack=1150, 
        defense=1050, gold=92, exper=80)
    return Item(id=id, type=m, prefix=prefix)
end

function 红衣魔王_16层(; id, prefix=String[])
    m = Monster(name="红衣魔王_16层", health=15000, attack=1000, 
        defense=1000, gold=100, exper=100)
    return Item(id=id, type=m, prefix=prefix)
end

function 红衣魔王_19层(; id, prefix=String[])
    m = Monster(name="红衣魔王_19层", health=20000, attack=1333, 
        defense=1333, gold=133, exper=133)
    return Item(id=id, type=m, prefix=prefix)
end

function 冥灵魔王_19层(; id, prefix=String[])
    m = Monster(name="冥灵魔王_19层", health=30000, attack=1700, 
        defense=1500, gold=250, exper=220)
    return Item(id=id, type=m, prefix=prefix)
end

function 冥队长(; id, prefix=String[])
    m = Monster(name="冥队长", health=3333, attack=1200, 
        defense=1133, gold=112, exper=100)
    return Item(id=id, type=m, prefix=prefix)
end

function 灵武士(; id, prefix=String[])
    m = Monster(name="灵武士", health=1600, attack=1306, 
        defense=1200, gold=117, exper=100)
    return Item(id=id, type=m, prefix=prefix)
end

function 灵武士(; id, prefix=String[])
    m = Monster(name="灵武士", health=2400, attack=2612, 
        defense=2400, gold=146, exper=125)
    return Item(id=id, type=m, prefix=prefix)
end

function 冥灵魔王_21层(; id, prefix=String[])
    m = Monster(name="冥灵魔王_21层", health=45000, attack=2550, 
        defense=2250, gold=312, exper=275)
    return Item(id=id, type=m, prefix=prefix)
end

function 灵法师_21层(; id, prefix=String[])
    m = Monster(name="灵法师_21层", health=2000, attack=1106, 
        defense=973, gold=106, exper=93)
    return Item(id=id, type=m, prefix=prefix)
end

function 红衣魔王(; id, prefix=String[])
    m = Monster(name="红衣魔王", health=30000, attack=2666, 
        defense=2666, gold=166, exper=166)
    return Item(id=id, type=m, prefix=prefix)
end

function 灵法师_23_24层(; id, prefix=String[])
    m = Monster(name="灵法师_23_24层", health=3000, attack=2212, 
        defense=1946, gold=132, exper=116)
    return Item(id=id, type=m, prefix=prefix)
end

function 冥灵魔王_23_24层(; id, prefix=String[])
    m = Monster(name="冥灵魔王_23_24层", health=60000, attack=3400, 
        defense=3000, gold=390, exper=343)
    return Item(id=id, type=m, prefix=prefix)
end

function 血影(; id, prefix=String[])
    m = Monster(name="血影", health=99999, attack=5000, 
        defense=4000, gold=0, exper=0)
    return Item(id=id, type=m, prefix=prefix)
end

function 魔龙(; id, prefix=String[])
    m = Monster(name="魔龙", health=99999, attack=9999, 
        defense=5000, gold=0, exper=0)
    return Item(id=id, type=m, prefix=prefix)
end

