using LinearAlgebra, JuMP, Gurobi, COPT

function rand_full_rank(n)
    A = randn(n, n)  # 生成一个n×n的随机矩阵，元素来自标准正态分布  
    while det(A) ≈ 0  # 检查行列式是否为零（使用≈来避免浮点误差）  
        A = randn(n, n)  # 如果行列式为零，重新生成矩阵  
    end
    return A * A'  # 返回满秩矩阵  
end

N = 3000
model = Model(COPT.Optimizer)
set_silent(model)
full_rank_matrix = rand_full_rank(N)
@variable(model, x[1:N], Bin)
# 生成一个3×3的满秩矩阵

@time @objective(model, Min, sum(x' * full_rank_matrix * x))

@time optimize!(model)
