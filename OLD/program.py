from time import *

from affichage import *
from algo import *

if __name__ == "__main__":
    """partie informatif
    N = 6 le programe de la partie déterministe crache "processus arreté"
    pour mh :
    à N = 100 ça rame et N = 150 c'est lent pour K = 1000
    à N = 50 c'est lent pour K = 10000
    """

    N = 3  # la taille de la matrice
    R = 100  # nombre de répétition

    sigma0 = choix("id", N)
    MC = mh(sigma0, R, N)
    RS = methode_rejet(N, R)
    visualisation_animation(MC)
