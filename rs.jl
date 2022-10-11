module rs
push!(LOAD_PATH, pwd()) 
import  ts 

export prog

function prog(dims::Tuple,R::Integer)
    sample = []
    dim = length(dims)
    N = dims[1]
    for r = 1:R
        M = rand([0,1],dims) 
        while !(ts.check(M))
            M = rand([0,1],dims) 
        end
        push!(sample,M)
    end
    return sample
end

end


