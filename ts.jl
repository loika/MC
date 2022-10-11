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

function particle_presence(M::AbstractArray,neighbour::Any)
    for next in neighbour #next door
        if M[CartesianIndex(next)] == 1
            return true
        end
    end
    
    return false
end

function check(M::AbstractArray)
    dims = size(M)
    dim = length(dims)
    N = dims[1]
    PILE = [Tuple(ones(Integer,dim))]
    save = []
    while !(length(PILE) == 0)
        pos = pop!(PILE)
        push!(save,pos)
        if pos in save
            continue
        end
        neighbour = neigh(pos,N,"forward")
        if M[CartesianIndex(pos)] == 1 && particle_presence(M,neighbour)
            return false
        end
        for next in neighbour
            if !(next in save)
                push!(PILE,next)
            end
        end
        
    end
    return true
end

function chessboard(dims::Tuple)
    dim = length(dims)
    N = dims[1]
    PILE = [Tuple(ones(Integer,dim))]
    save = []
    M = zeros(Integer,dims)
    while !(length(PILE) == 0)
        pos = pop!(PILE)
        push!(save,pos)
        neighbour = neigh(pos,N,"forward")
        if (sum(pos) % 2) == 1
            M[CartesianIndex(pos)] = 1
        end
        for next in neighbour
            if !(next in save)
                push!(PILE,next)
            end
        end
        
    end
    return M

end

mean(X) = sum(X)/length(X)
var(X) = sum(X.*X)*length(X)/(length(X)-1)

end