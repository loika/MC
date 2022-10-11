module mcmc
push!(LOAD_PATH, pwd()) 
import  ts 

export prog

function prog(dims::Tuple,R::Integer,X0::AbstractArray)
    chain = []
    dim = length(dims)
    N = dims[1]
    push!(chain,X0)
    M = copy(X0)   
    for r = 1:R
        pos = Tuple(rand(1:N,dim))
        M[CartesianIndex(pos)] = 1 - M[CartesianIndex(pos)]
        neighbour = ts.neigh(pos,N,"forward")
        if M[CartesianIndex(pos)] == 1 && ts.particle_presence(M,neighbour)
            M[CartesianIndex(pos)] = 0
        end
        push!(chain,copy(M))
    end
    return chain
end

end


