abstract type ItemType end
abstract type MALL <: ItemType end

Base.@kwdef struct Monster <: ItemType
    name::String = "绿头怪"
    health::Int = 50
    attack::Int = 20
    defense::Int = 1
    gold::Int = 1
    exper::Int = 1
end

Base.@kwdef struct YellowDoor <: ItemType
    name::String = "黄门"
end
Base.@kwdef struct BlueDoor <: ItemType
    name::String = "蓝门"
end
Base.@kwdef struct RedDoor <: ItemType
    name::String = "红门"
end
Base.@kwdef struct Door2 <: ItemType
    name::String = "第二层特殊门"
end

Base.@kwdef struct YellowKey <: ItemType
    name::String = "黄钥匙"
    value::Int = 1
end

Base.@kwdef struct RedKey <: ItemType
    name::String = "红钥匙"
    value::Int = 1
end

Base.@kwdef struct BlueKey <: ItemType
    name::String = "蓝钥匙"
    value::Int = 1
end

Base.@kwdef struct Key2 <: ItemType
    name::String = "钥匙2"
    value::Int = 1
end

struct Key18 <: ItemType end

Base.@kwdef struct Water <: ItemType
    name::String = "药水"
    value::Int = 300
end

Base.@kwdef struct MoneyPie <: ItemType
    name::String = "金币饼"
    value::Int = 300
end

Base.@kwdef struct AttackStone <: ItemType
    name::String = "攻击(红)宝石"
    value::Int = 3
end

Base.@kwdef struct DefenseStone <: ItemType
    name::String = "防御(蓝)宝石"
    value::Int = 3
end

Base.@kwdef struct Mall <: ItemType
    name::String = "金币商城"
    health::Int = 800
    attack::Int = 4
    defense::Int = 4
    price::Int = 25
end

Base.@kwdef struct ExprMall <: ItemType
    name::String = "经验商城"
    level::Int = 1
    attack::Int = 5
    defense::Int = 5
    priceL::Int = 100
    price::Int = 30
end

Base.@kwdef struct AdvanceMall <: ItemType
    name::String = "高级金币商城"
    health::Int = 4000
    attack::Int = 20
    defense::Int = 20
    price::Int = 100
end

Base.@kwdef struct AdvanceExprMall <: ItemType
    name::String = "高级经验商城"
    level::Int = 3
    attack::Int = 17
    defense::Int = 17
    priceL::Int = 270
    price::Int = 95
end

Base.@kwdef struct KeyMall <: ItemType
    name::String = "钥匙商城"
    redKey_price::Int = 100
    blueKey_price::Int = 50
    yellowKey_price::Int = 10
end

Base.@kwdef struct SellKeyMall <: ItemType
    name::String = "钥匙商城"
    redKey_price::Int = 70
    blueKey_price::Int = 35
    yellowKey_price::Int = 7
end

Base.@kwdef struct Item
    id::String = ""
    type::ItemType = Monster()
    prefix::Vector{String} = String[]
end

# yellow_attack::Int = 0
# red_attack::Int = 0
# blue_attack::Int = 0
# key_2_attack::Int = 0
# key_18_attack::Int = 0

include("monster_func.jl")
