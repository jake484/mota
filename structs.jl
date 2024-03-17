abstract type ItemType end

Base.@kwdef struct Monster <: ItemType
    name::String = "绿头怪"
    health::Int = 50
    attack::Int = 20
    defense::Int = 1
    gold::Int = 1
    exper::Int = 1
end

struct YellowDoor <: ItemType end
struct BlueDoor <: ItemType end
struct RedDoor <: ItemType end

Base.@kwdef struct YellowKey <: ItemType
    value::Int = 1
end

Base.@kwdef struct RedKey <: ItemType
    value::Int = 1
end

Base.@kwdef struct BlueKey <: ItemType
    value::Int = 1
end
struct Key2 <: ItemType end
struct Key18 <: ItemType end

Base.@kwdef struct Water <: ItemType
    value::Int = 300
end

Base.@kwdef struct MoneyPie <: ItemType
    value::Int = 300
end

Base.@kwdef struct AttackStone <: ItemType
    value::Int = 3
end

Base.@kwdef struct DefenseStone <: ItemType
    value::Int = 3
end

Base.@kwdef struct Mall <: ItemType
    health::Int = 800
    attack::Int = 4
    defense::Int = 4
    price::Int = 25
end

Base.@kwdef struct ExprMall <: ItemType
    level::Int = 1
    attack::Int = 5
    defense::Int = 5
    priceL::Int = 100
    price::Int = 30
end

Base.@kwdef struct AdvanceMall <: ItemType
    health::Int = 4000
    attack::Int = 20
    defense::Int = 20
    price::Int = 100
end

Base.@kwdef struct AdvanceExprMall <: ItemType
    level::Int = 3
    attack::Int = 17
    defense::Int = 17
    priceL::Int = 270
    price::Int = 95
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
