include("items.jl")

using JuMP
# using AmplNLWriter, Couenne_jll
# using SCIP
using COPT, Gurobi
using CSV, DataFrames

const NITEM = length(ITEMS)
const NACTION = NITEM + 1
const MON_INDEX = findall(x -> x.type isa Monster, ITEMS)
const NMONSTER = length(MON_INDEX)
const YellowKey_INDEX = findall(x -> x.type isa YellowKey, ITEMS)
const RedKey_INDEX = findall(x -> x.type isa RedKey, ITEMS)
const BlueKey_INDEX = findall(x -> x.type isa BlueKey, ITEMS)
const YellowDoor_INDEX = findall(x -> x.type isa YellowDoor, ITEMS)
const BlueDoor_INDEX = findall(x -> x.type isa BlueDoor, ITEMS)
const RedDoor_INDEX = findall(x -> x.type isa RedDoor, ITEMS)
const AttackStone_INDEX = findall(x -> x.type isa AttackStone, ITEMS)
const DefenseStone_INDEX = findall(x -> x.type isa DefenseStone, ITEMS)
const Water_INDEX = findall(x -> x.type isa Water, ITEMS)
const NWATER = length(Water_INDEX)

_ref(model, str::AbstractString, t::Int) = variable_by_name(model, join((str, "[", t, "]")))
_ref(model, str::AbstractString, id, t::Int) = variable_by_name(model, join((str, id, "[", t, "]")))

function add_variable!(model)
    # @variable(model, 0 <= level[1:NACTION] <= 1000000, Int)
    @variable(model, 0 <= healthValue[1:NACTION] <= 1000000, Int)
    @variable(model, 0 <= attackValue[1:NACTION] <= 1000000, Int)
    @variable(model, 0 <= defenseValue[1:NACTION] <= 1000000, Int)
    @variable(model, 0 <= goldValue[1:NACTION] <= 1000000, Int)
    @variable(model, 0 <= experValue[1:NACTION] <= 1000000, Int)
    @variable(model, 0 <= yellowKeyNum[1:NACTION] <= 1000, Int)
    # @variable(model, 0 <= redKeyNum[1:NACTION] <= 1000, Int)
    @variable(model, 0 <= blueKeyNum[1:NACTION] <= 1000, Int)
    # @variable(model, key2Num[1:NACTION], Bin)
    # @variable(model, key18Num[1:NACTION], Bin)
    map(item -> add_variable!(model, item, item.type), ITEMS)
    return nothing
end

function add_variable!(model, item, ::Monster)
    @variable(model, [1:NACTION], base_name = "go2_" * item.id, binary = true)
    @variable(model, [1:NACTION], base_name = "isAlive_" * item.id, binary = true)
    @variable(model, [1:NACTION], base_name = "roundNum_" * item.id, integer = true)
    @variable(model, [1:NACTION], base_name = "hurtValue_" * item.id, integer = true)
    return nothing
end

function add_variable!(model, item, ::ItemType)
    @variable(model, [1:NACTION], base_name = "go2_" * item.id, binary = true)
    @variable(model, [1:NACTION], base_name = "isAlive_" * item.id, binary = true)
    return nothing
end

function add_constraint!(model)
    # 初始状态约束
    # @constraint(model, variable_by_name(model, "level[1]") == 1)
    @constraint(model, variable_by_name(model, "healthValue[1]") == 1000)
    # map(i -> @constraint(model, variable_by_name(model, "attackValue[$i]") == 10), 1:NACTION)
    # map(i -> @constraint(model, variable_by_name(model, "defenseValue[$i]") == 10), 1:NACTION)
    @constraint(model, variable_by_name(model, "attackValue[1]") == 10)
    @constraint(model, variable_by_name(model, "defenseValue[1]") == 10)
    @constraint(model, variable_by_name(model, "goldValue[1]") == 0)
    @constraint(model, variable_by_name(model, "experValue[1]") == 0)
    @constraint(model, variable_by_name(model, "yellowKeyNum[1]") == 1)
    # @constraint(model, variable_by_name(model, "redKeyNum[1]") == 1)
    # @constraint(model, variable_by_name(model, "blueKeyNum[1]") == 1)
    map(item -> @constraint(model, variable_by_name(model, "isAlive_$(item.id)[1]") == 1), ITEMS)

    for t in 1:NACTION
        for item in ITEMS
            # 可行动的先后关系
            n = length(item.prefix)
            if n > 0
                go2_ref = _ref(model, "go2_", item.id, t)
                prefix_isAlive = (_ref(model, "isAlive_", item.prefix[i], t) for i in 1:n)
                @constraint(model, go2_ref + sum(prefix_isAlive) <= n)
            end
            isAlive = _ref(model, "isAlive_", item.id, t)
            go2 = _ref(model, "go2_", item.id, t)
            # 存活可以行动
            @constraint(model, go2 <= isAlive)
            if t < NACTION
                # 存活状态转移
                isAlive_next = _ref(model, "isAlive_", item.id, t + 1)
                @constraint(model, isAlive_next + go2 == isAlive)
            end
            # 特殊约束
            add_constraint!(model, item, t, item.type)
        end
        # 每次行动单次动作约束
        @constraint(model, sum(_ref(model, "go2_", i, t) for i in 1:NITEM) <= 1)
        # 特殊约束
        if t < NACTION
            add_constraint!(model, t, Monster())
            # add_constraint!(model, t, YellowKey())
            add_constraint!(model, t, YellowDoor())
            add_constraint!(model, t, BlueDoor())
            add_constraint!(model, t, RedDoor())
            add_constraint!(model, t, Water())
            add_constraint!(model, t, AttackStone())
            add_constraint!(model, t, DefenseStone())
        end
    end
end

function add_constraint!(model, t, ::Monster)
    # 喝药水后生命值增加
    go2s_water = [_ref(model, "go2_", i, t) for i in Water_INDEX]
    vals_water = [ITEMS[i].type.value for i in Water_INDEX]
    # 生命值约束
    he = _ref(model, "healthValue", t)
    go2s = [_ref(model, "go2_", i, t) for i in MON_INDEX]
    hurts = [_ref(model, "hurtValue_", i, t) for i in MON_INDEX]
    @constraint(model, sum(go2s[i] * hurts[i] for i in 1:NMONSTER) <= he - 1)
    # 攻击生命值状态转移
    he_next = _ref(model, "healthValue", t + 1)
    @constraint(model, he_next + sum(go2s[i] * hurts[i] for i in 1:NMONSTER) == he + sum(go2s_water[i] * vals_water[i] for i in 1:NWATER)) # 
    # 经验状态转移
    exper = _ref(model, "experValue", t)
    exper_next = _ref(model, "experValue", t + 1)
    expers = [ITEMS[i].type.exper for i in MON_INDEX]
    @constraint(model, exper_next == exper + sum(go2s .* expers))
    # 金币状态转移
    gold = _ref(model, "goldValue", t)
    gold_next = _ref(model, "goldValue", t + 1)
    golds = [ITEMS[i].type.gold for i in MON_INDEX]
    @constraint(model, gold_next == gold + sum(go2s .* golds))
    return nothing
end

function add_constraint!(model, item, t::Int, ::Monster)
    monster = item.type
    at = _ref(model, "attackValue", t)
    go2 = _ref(model, "go2_", item.id, t)
    ro = _ref(model, "roundNum_", item.id, t)
    hurt = _ref(model, "hurtValue_", item.id, t)
    de = _ref(model, "defenseValue", t)
    # 攻击大于防御可攻击
    @constraint(model, at >= (monster.defense + 1) * go2)
    # 回合数约束
    @constraint(model, ro * at - ro * monster.defense * go2 >= monster.health)
    @constraint(model, (ro - 1) * at - (ro - 1) * go2 * monster.defense <= monster.health)
    @constraint(model, ro * monster.attack - ro * de == hurt)
end

function add_constraint!(model, t, ::YellowDoor)
    # 开黄门
    yellowKeyNum = _ref(model, "yellowKeyNum", t)
    go2s = [_ref(model, "go2_", i, t) for i in YellowDoor_INDEX]
    @constraint(model, sum(go2s) <= yellowKeyNum)
    # 拿黄钥匙，开黄门后黄钥匙数减一
    go2s_key = [_ref(model, "go2_", i, t) for i in YellowKey_INDEX]
    vals_key = [ITEMS[i].type.value for i in YellowKey_INDEX]
    yellowKeyNum_next = _ref(model, "yellowKeyNum", t + 1)
    @constraint(model, yellowKeyNum_next == yellowKeyNum + sum(go2s_key .* vals_key) - sum(go2s))
end

# function add_constraint!(model, t, ::BlueDoor)
#     # 开蓝门
#     blueKeyNum = _ref(model, "blueKeyNum", t)
#     go2s = [_ref(model, "go2_", i, t) for i in BlueDoor_INDEX]
#     @constraint(model, sum(go2s) <= blueKeyNum)
#     # 开蓝门后蓝钥匙数减一
#     go2s_key = [_ref(model, "go2_", i, t) for i in BlueKey_INDEX]
#     vals_key = [ITEMS[i].type.value for i in BlueKey_INDEX]
#     blueKeyNum_next = _ref(model, "blueKeyNum", t + 1)
#     @constraint(model, blueKeyNum_next == blueKeyNum + sum(go2s_key .* vals_key) - sum(go2s))
# end

# function add_constraint!(model, t, ::RedDoor)
#     # 开红门
#     redKeyNum = _ref(model, "redKeyNum", t)
#     go2s = [_ref(model, "go2_", i, t) for i in RedDoor_INDEX]
#     @constraint(model, sum(go2s) <= redKeyNum)
#     # 开红门后红钥匙数减一
#     redKeyNum_next = _ref(model, "redKeyNum", t + 1)
#     @constraint(model, redKeyNum_next == redKeyNum - sum(go2s))
# end

function add_constraint!(model, t, ::AttackStone)
    # 攻击宝石增加攻击力
    attackValue = _ref(model, "attackValue", t)
    go2s = [_ref(model, "go2_", i, t) for i in AttackStone_INDEX]
    vals = [ITEMS[i].type.value for i in AttackStone_INDEX]
    attackValue_next = _ref(model, "attackValue", t + 1)
    @constraint(model, attackValue_next == attackValue + sum(go2s .* vals))
end

function add_constraint!(model, t, ::DefenseStone)
    # 防御宝石增加防御力
    defenseValue = _ref(model, "defenseValue", t)
    go2s = [_ref(model, "go2_", i, t) for i in DefenseStone_INDEX]
    vals = [ITEMS[i].type.value for i in DefenseStone_INDEX]
    defenseValue_next = _ref(model, "defenseValue", t + 1)
    @constraint(model, defenseValue_next == defenseValue + sum(go2s .* vals))
end

function add_constraint!(model, item, t::Int, ::ItemType)

end

function add_constraint!(model, t, ::ItemType)

end

add_objective!(model, ::Val{1}) = @objective(model, Min, variable_by_name(model, "healthValue[$NACTION]")) # 最小化生命值
add_objective!(model, ::Val{2}) = @objective(model, Min, sum(variable_by_name(model, "isAlive_5[$i]") for i in 1:NACTION)) # 尽力开门
add_objective!(model, ::Val{3}) = @objective(model, Max, sum(variable_by_name(model, "go2_5[$i]") for i in 1:NACTION-1)) # 尽力开门
add_objective!(model, ::Val{4}) = @objective(model, Min, variable_by_name(model, "yellowKeyNum[$NACTION]")) # 尽力拿钥匙
add_objective!(model, ::Val{5}) = @objective(model, Max, variable_by_name(model, "experValue[$NACTION]")) # 尽力拿经验
add_objective!(model, ::Val{6}) = @objective(model, Max, variable_by_name(model, "goldValue[$NACTION]")) # 尽力拿金币
add_objective!(model, ::Val{7}) = @objective(model, Max, variable_by_name(model, "attackValue[$NACTION]")) # 尽力提升攻击力

function build!()
    # model = Model(() -> AmplNLWriter.Optimizer(Couenne_jll.amplexe))
    model = Model(Gurobi.Optimizer)
    set_silent(model)
    # set_attribute(model, "display/verblevel", 0)
    add_variable!(model)
    add_constraint!(model)
    add_objective!(model, Val(7))
    optimize!(model)
    @info termination_status(model)
    @info objective_value(model)
    return model
end

function model_show(model)
    names = [
        # "level",
        "healthValue",
        "attackValue",
        "defenseValue",
        "goldValue",
        "experValue",
        "yellowKeyNum",
        # "redKeyNum",
        # "blueKeyNum"
    ]
    append!(names, ["go2_" * item.id for item in ITEMS])
    append!(names, ["isAlive_" * item.id for item in ITEMS])
    df = DataFrame(name=names)
    for i in 1:NACTION
        df = hcat(df, DataFrame("step$i" => [value(variable_by_name(model, name * "[$i]")) for name in names]))
    end
    CSV.write("result.csv", df, index=true)
    # 导出路线
    open("route.txt", "w") do io
        for t in 1:NACTION
            for item in ITEMS
                go2 = value(_ref(model, "go2_", item.id, t))
                if go2 >= 1.0
                    println(io, join(("Step", t, ": go to ", item.id, "_", item.type.name)))
                    break
                end
            end
        end
    end
end

model = build!();

model_show(model)


# model = Model()
# @variable(model, [1:NACTION], base_name = "item" * "10", Int)
# @constraint(model, variable_by_name(model, "item10[1]") >= 0)

# variable_by_name(model, "item10[1]")


# abstract type father end

# struct son <: father end
# struct son_1 <: father end

# test(::son) = println("son")

# test(::father) = println("father")

