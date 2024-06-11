# mota

针对魔塔游戏进行优化问题建模和求解——大规模混合整数非线性规划问题。

## 文件结构

```shell
├── buildFunc.jl # 构建优化问题
├── data # 数据文件夹
    ├── mota-data.docx # 魔塔游戏图鉴
    └── mota-data.pptx # 魔塔第一层怪物信息及拓扑结构
├── generator.jl # 代码生成器：生成魔塔游戏中物品（怪物）对象的函数
├── items.jl
├── monster_func.jl # 生成的函数，生成魔塔游戏中的物品（怪物）对象的函数
├── monster_info.csv # 魔塔怪物信息
├── result.csv # 优化结果
└── structs.jl # 定义魔塔游戏中的物品（怪物）对象的结构体
```

## 相关变量设计

```julia
# 勇士状态值
healthValue # 生命值
attackValue # 攻击力
defenseValue # 防御力
goldValue # 金币
experValue # 经验
yellowKeyNum # 黄钥匙
redKeyNum # 红钥匙
blueKeyNum # 蓝钥匙
# 其他状态值
go2_i[j] # 勇士在第j个动作是否去第i个对象 
isAlive_i[j] # 第i个对象在第j个动作是否存活
roundNum_i[j] # 第i个对象在第j个动作的回合数
hurtValue_i[j] # 第i个对象在第j个动作对勇士造成的伤害
```

引入`roundNum_i`可以把怪物伤害计算函数的非线性部分黑盒函数部分（包括取整）转为JuMP可建模的乘积非线性，同时可以凸显整数变量的特点。

## 日志

`2024-3-17`：模型可拓展可解，架构统一。第一层求解测试，添加11个对象后，求解时间过长。无法继续。Archive

`2024-3-20`：通过引入“伤害值”变量，将“扣血量”三次项降维成二次项。问题非严格凸，COPT无法求解，采用Gurobi求解。Unarchived

`2024-3-22`：变量数量与目标数成二次方级增长，到第三层求解一次已经达小时级别。Archive

