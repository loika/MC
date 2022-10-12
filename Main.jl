push!(LOAD_PATH, pwd())

import rs
import ts
import deter
import mcmc
import rjmcmc

begin
    N = 3 
    R = 100
    dim = 2 
    dims = Tuple([N for i in 1:dim])
end



sample = rs.prog(dims,R)
chain1 = rjmcmc.prog(dims,R,ts.chessboard(dims))
chain2 = mcmc.prog(dims,R,ts.chessboard(dims))
A = deter.prog(dims)
X = map(ts.f,A)
m = ts.mean(X)
print("average gas density : $m \n")
