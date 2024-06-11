using CSV, DataFrames

function readCSV(file)
    data = CSV.read(file, DataFrame)
    return data
end

function parse(data)
    str = """
    function 黄门(; id, prefix=String[])
        return Item(id=id, type=YellowDoor(), prefix=prefix)
    end\n
    function 蓝门(; id, prefix=String[])
        return Item(id=id, type=BlueDoor(), prefix=prefix)
    end\n
    function 红门(; id, prefix=String[])
        return Item(id=id, type=RedDoor(), prefix=prefix)
    end\n
    function 第二层特殊门(; id, prefix=String[])
        return Item(id=id, type=Door2(), prefix=prefix)
    end\n
    function 黄钥匙(; id, prefix=String[], value=1)
        return Item(id=id, type=YellowKey(value=value), prefix=prefix)
    end\n
    function 蓝钥匙(; id, prefix=String[], value=1)
        return Item(id=id, type=BlueKey(value=value), prefix=prefix)
    end\n
    function 红钥匙(; id, prefix=String[], value=1)
        return Item(id=id, type=RedKey(value=value), prefix=prefix)
    end\n
    function 钥匙2(; id, prefix=String[], value=1)
        return Item(id=id, type=Key2(value=value), prefix=prefix)
    end\n
    function 红宝石(; id, prefix=String[], value=3)
        return Item(id=id, type=AttackStone(value=value), prefix=prefix)
    end\n
    function 蓝宝石(; id, prefix=String[], value=3)
        return Item(id=id, type=DefenseStone(value=value), prefix=prefix)
    end\n
    function 药水(; id, prefix=String[], value=300)
        return Item(id=id, type=Water(value=value), prefix=prefix)
    end\n
    function 金币饼(; id, prefix=String[], value=300)
        return Item(id=id, type=MoneyPie(value=value), prefix=prefix)
    end\n
    function 金币商城(; id, prefix=String[])
        return Item(id=id, type=Mall(), prefix=prefix)
    end\n
    function 经验商城(; id, prefix=String[])
        return Item(id=id, type=ExprMall(), prefix=prefix)
    end\n
    function 高级金币商城(; id, prefix=String[])
        return Item(id=id, type=AdvanceMall(), prefix=prefix)
    end\n
    function 高级经验商城(; id, prefix=String[])
        return Item(id=id, type=AdvanceExprMall(), prefix=prefix)
    end\n
    function 钥匙商城(; id, prefix=String[])
        return Item(id=id, type=KeyMall(), prefix=prefix)
    end\n
    function 钥匙回收商城(; id, prefix=String[])
        return Item(id=id, type=SellKeyMall(), prefix=prefix)
    end\n
    """
    for r in eachrow(data)
        str *= """
        function $(r[1])(; id, prefix=String[])
            m = Monster(name="$(r[1])", health=$(r[2]), attack=$(r[3]), 
                defense=$(r[4]), gold=$(r[5]), exper=$(r[6]))
            return Item(id=id, type=m, prefix=prefix)
        end\n
        """
    end
    return str
end

function writeFile(name, str)
    open(name, "w") do f
        write(f, str)
    end
    @info "File created!"
    return nothing
end

function main()
    data = readCSV("monster_info.csv") |> parse
    writeFile("monster_func.jl", data)
    return nothing
end

main()

