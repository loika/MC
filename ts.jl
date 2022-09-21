module ts

export f,check,rm,mean,var,neigh,gravity

f(M) = sum(M)/length(M)


function neigh(pos::Tuple,N::Integer,str::AbstractString)
    if !(str == "forward" || str == "backward" || str == "ward")
        error("str is undefined | str = '{$str}' \n")
    end
    neighbour = []
    dim = length(pos)
    var = collect(pos)
    for d in 1:dim
        p = pos[d]
        if p < N &&  (str == "forward" || str == "ward")
            var[d] = p+1
            push!(neighbour,Tuple(var))
        end
        if p > 1 &&  (str == "backward" || str == "ward")
            var[d] = p-1
            push!(neighbour,Tuple(var))
        end
        var[d] = p
    end
    return neighbour
    
end

function gravity(ens::Any,N::Integer,str::AbstractString)
    bool = nothing
    for pos in neigh(ens[1],N,str)
        var = neigh(pos,N,str)
        if length(var) == length(ens)
            bool = true
            for v in var
                if !(v in ens)
                    bool = false
                    break
                end
            end
            if bool
                return pos
            end
        end
    end    
end

function cond_neigh(M::AbstractArray,pos::Tuple,neighbour::Any)
    if M[CartesianIndex(pos)] == 1
        for next in neighbour #next door
            if M[CartesianIndex(next)] == 1
                return false
            end
        end
    end
    return true
end

function check(M::AbstractArray)
    dims = size(M)
    dim = length(dims)
    N = dims[1]
    PILE = [Tuple(ones(Integer,dim))]
    save = []
    while !(length(PILE) == 0)
        pos = pop!(PILE)
        if pos in save
            continue
        end
        neighbour = neigh(pos,N,"forward")
        if !cond_neigh(M,pos,neighbour)
            return false
        end
        append!(PILE,neighbour)
        push!(save,pos)
        
    end
    return true
end

mean(X) = sum(X)/length(X)
var(X) = sum(X.*X)*length(X)/(length(X)-1)

end