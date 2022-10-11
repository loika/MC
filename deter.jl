module deter

export prog

function forward(pos::Tuple,dims::Tuple)
    neighbour = []
    var = collect(pos)
    dim = length(dims)
    N = dims[1]
    for d in 2:dim
        p = pos[d]
        if p < N
            var[d] = p + 1
            push!(neighbour,Tuple(var))
            var[d] = p 
        end
    end
    return neighbour
end

function check(M::AbstractArray,A::AbstractArray,dims::Tuple)
    dim = length(dims)
    dims_M = size(M)
    dim = length(dims_M)
    pos_init = ones(Integer,dim)
    pos_init[1] = dims_M[1]
    pos_init = Tuple(pos_init)
    
    PILE = []
    push!(PILE,pos_init)
    save = []
    var = true
    while !(length(PILE) == 0)
        posM = pop!(PILE)
        push!(save,posM)
        posA = Tuple(vcat(1,[posM[d] for d in 2:dim]))
        if M[CartesianIndex(posM)] == 1 && A[CartesianIndex(posA)] == 1
            var = false
            break
        end
        for next in forward(posM,dims)
            if !(next in save)
                push!(PILE,next)
            end
        end
    end
    return var
end

function combine(combi::Any,dim::Integer,N::Integer)
    Admissible = []
    dims = Tuple([N for i in 1:dim])
    over_dims = Tuple(vcat(1,[N for d in 2:dim])) #dims[d] = N
    combi_ = [ reshape(C,over_dims) for C in combi]
    PILE = deepcopy(combi_)
    while !(length(PILE) == 0)
        M = pop!(PILE)
        dims_M = size(M)
        if dims_M == dims
            push!(Admissible,copy(M))
            continue
        end
        for C in combi_
            if check(M,C,dims)
                push!(PILE,vcat(M,C))
            end
        end


    end

    return Admissible

end

function prog(dims::Tuple)

    if dims == ()
        return []   
    end
    
    dim = length(dims)
    N = dims[1]

    Admissible = combine([zeros(Integer,1),ones(Integer,1)],1,N)
    for d in 2:dim
        Admissible = combine(Admissible,d,N)
    end
    
    return Admissible

end

end