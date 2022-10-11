module rjmcmc
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
        save = []
        M[CartesianIndex(pos)] = 1 - M[CartesianIndex(pos)]
        if M[CartesianIndex(pos)] == 1 && ts.particle_presence(M,ts.neigh(pos,N,"ward"))
            push!(save,pos)
        end
        
        while !(length(save) == 0)
            pos = Tuple(rand(1:N,dim))
            M[CartesianIndex(pos)] = 1 - M[CartesianIndex(pos)]
            if M[CartesianIndex(pos)] == 1 
                if ts.particle_presence(M,ts.neigh(pos,N,"ward"))
                    push!(save,pos)
                end
            else
               save = [pos_ for pos_ in save if M[CartesianIndex(pos_)] == 1 && ts.particle_presence(M,ts.neigh(pos_,N,"ward")) ]
            end
        end
        push!(chain,copy(M))
    end
    return chain
end

end