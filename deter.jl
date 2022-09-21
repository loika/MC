module deter
push!(LOAD_PATH, pwd());
import  ts;

export prog

function prog(dim::Integer,N::Integer)
    A = Set() #admissible
    start = Tuple(ones(Integer,dim))
    final = Tuple(N * ones(Integer,dim)) #final == dims
    PILE = [(zeros(Integer,final),start)]

    while !(length(PILE) == 0)
        M,pos = pop!(PILE)

        if pos == final 
            push!(A,M)
            continue
        end

        neighbour = neigh(pos,N,"forward")

        for next in neighbour
            push!(PILE,(M,next))
        end

        if cond_neigh(M,pos,neigh(pos,N,"backward"))
            M[CartesianIndex(pos)] = 1
            for next in neighbour
                push!(PILE,(M,next))
            end
        end



    end
    
    return A

end

end