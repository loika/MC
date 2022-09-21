push!(LOAD_PATH, pwd())

import rm
import ts
import deter

begin
    N = 3;
    R = 10;
    dim = 2;
end

#print("*************** \n")
#sample = rm.prog(R,N)
#X = map(ts.f,sample);
#print("sample",X,"\n");
#print("mean : ", ts.mean(X),"\n");
#print("var : ", ts.var(X),"\n");



#print(ts.neigh((2,2),N),"\n")
#ens = ts.neigh((2,2,2),N,"ward")
#alea = rand(ens,6)
#print(ens,"\n")
#print("**********\n")
#print(ens,"\n")
#print(ts.gravity(ens,N,"ward"),"\n")
#print("hello_world\n")
deter.prog(dim,N)