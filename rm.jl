module rm
push!(LOAD_PATH, pwd());
import  ts;

export prog

function prog(R::Integer,N::Integer)
    sample = [];
    for r = 1:R
        M = rand([0,1],(N,N));
        while !(ts.check(M))
            M = rand([0,1],(N,N));
        end
        push!(sample,M)
    end
    return sample
end

end


