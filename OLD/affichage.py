import matplotlib.pyplot as plt
from matplotlib import animation


def visualisation(sigma):
    # permet de visualiser sigma
    plt.imshow(sigma, cmap="Greys")
    plt.show()
    return None


def visualisation_animation(omega):  #
    # animation sympathique d'un sous ensemble de OMEGA
    # omega un sous ensemble  d'OMEGA
    # ATTENTION si l'animation ne se lance pas
    # c'est pas par ce que le premier élément est la matrice nulle
    def animate(i):
        im.set_data(omega[i])
        return (im,)

    im = plt.imshow(omega[0], cmap="Reds")
    fig = plt.gcf()
    anim = animation.FuncAnimation(
        fig, animate, frames=len(omega), interval=500, repeat=False
    )
    plt.show()

    return None
