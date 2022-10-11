# MC

"Monte-carlo"

- [![Generic badge](https://img.shields.io/badge/with--made-julia-informational.svg)](https://shields.io/)

- [![Generic badge](https://img.shields.io/badge/with--made-python-informational.svg)](https://shields.io/)

## Introduction

The subject of study is a statistical physics subject on the Ising model. We observe networks of size N and in dimension d. For example in dimension 1, it is a vector $N$, then in dimension two, it is a matrix $N \times N$, in dimension 3, it is an array in 3 dimensions $N \times N \times N$, etc $\cdots$ . Each network is composed of sites and on each site can live a particle, we talk about configuration. In this model, the particles are so big that they take two places, there can't be two neighboring particles, we talk about admissible configuration. In this study the objective is to determine the average density of gas on the admissible configurations by using several methods.


### Notation

- $N$ is a integer
- $d$ is a integer
- $R$ is as integer

subject to :

- $N > 0$
- $d > 0$
- $R > 0$

## to get started
change the value before run program
### julia
in ```Main.jl```
```julia
begin
    N = 3
    d = 2
    R = 10
    dims = Tuple([N for i in 1:N])
end
```

### python

in ```program.py``` in directory ```OLD```
```python
if __name__=='__main__':
    N = 10
    R = 1000
```


## pre-requisites

### julia

- [![Generic badge](https://img.shields.io/badge/julia-1.8.1-brightgreen.svg)](https://shields.io)

### python

- [![Generic badge](https://img.shields.io/badge/python-3.7.3-brightgreen.svg)](https://shields.io)

the use of program progmanopt requires :  

- [![Generic badge](https://img.shields.io/badge/numpy-1.6-brithtgreen.svg)](https://shields.io)
- [![Generic badge](https://img.shields.io/badge/time--brithtgreen.svg)](https://shields.io)
- [![Generic badge](https://img.shields.io/badge/matplotlib--brithtgreen.svg)](https://shields.io)

- [![Generic badge](https://img.shields.io/badge/copy--brithtgreen.svg)](https://shields.io)

if the packages are not installed. you can install them the command in directory ```OLD```:

```
pip install -r requirements.txt
```


if the command did not work, you can install the packages one by one with the command  
```
pip install [package]
```

## Contributor

- **Loik johan ACAKPO-ADDRA** _alias_ [@loik77360](https://github.com/loik77360/PSD)

- **Lilian TEL** _alias_ [@lil-tel](https://github.com/lil-tel)

## Links

### packages

#### python
- **[numpy](https://numpy.org/)**
- **[time](https://docs.python.org/3/library/time.html)**
- **[copy](https://docs.python.org/3/library/copy.html)**
- **[matplotlib](https://matplotlib.org/)**

### Documentation
- Recueil de modèles aléatoires by Djalil Chafai and Florent Malrieu
- Sheldon M.Ross Simulation, Fifth Edition 2012




