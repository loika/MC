import numpy as np
from copy import deepcopy

f = lambda sigma: np.sum(sigma) / np.size(sigma)


def verifier(sigma):
    # teste si la configuration est admise
    N = sigma.shape[0]
    N_1 = N - 1
    for i in range(N_1):
        j = 0
        ii = i + 1  # ligne suivant
        while j < N_1:
            if sigma[i][j] == 0:
                j += 1
                continue
            if sigma[i][j + 1] == 1 or sigma[ii][j] == 1:
                return 0
            j += 2

        if sigma[i][N_1] == 1 and sigma[ii][N_1] == 1:
            return 0

    j = 0
    while j < N_1:
        if sigma[N_1][j] == 0:
            j += 1
            continue
        if sigma[N_1][j + 1] == 1:
            return 0
        j += 2

    return 1


def verifier2(sigma):  # teste si la configuration est admise
    N = sigma.shape[0]
    N_1 = N - 1
    for i in range(N):
        for j in range(N_1):
            jj = j + 1
            if sigma[j][i] * sigma[jj][i] == 1 or sigma[i][j] * sigma[i][jj] == 1:
                return 0
    return 1


def admis_1D(N):
    PILE = [np.array([0]), np.array([1])]
    if N == 1:
        return PILE
    ens = []

    while not (len(PILE) == 0):
        elem = PILE.pop()
        n = elem.shape[0]
        if n == N:
            ens.append(elem.copy())
            continue
        if elem[-1] == 0:
            PILE.append(np.concatenate((elem, np.array([1]))))
        PILE.append(np.concatenate((elem, np.array([0]))))

    return ens


def admis_2D(N):
    combi = admis_1D(N)
    combi_ = [C.reshape((1, N)) for C in combi]
    PILE = deepcopy(combi_)
    if N == 1:
        return PILE
    ens = []

    while not (len(PILE) == 0):
        elem = PILE.pop()
        n = elem.shape[0]

        if n == N:
            ens.append(elem.copy())
            continue

        for C in combi_:
            var = True
            for i in range(N):
                if elem[-1][i] == 1 and C[0][i] == 1:
                    var = False
                    break
            if var:
                PILE.append(np.concatenate((elem, C)))
    return ens


def methode_rejet(N, K):
    # l'estimation de gaz
    k = 0
    sample = []
    while k < K:
        sigma = np.random.randint(2, size=(N, N))
        if verifier(sigma):
            sample.append(sigma.copy())
            k += 1

    return sample


def Xt(N):
    N_1 = N - 1
    sigma = np.random.randint(2, size=(N, N))
    k = 1
    while verifier(sigma) == 0:
        sigma = np.random.randint(2, size=(N, N))
        k += 1

    return sigma, k


def site(i, j, N):
    V = []
    if 1 < i < N:
        V.append((i - 1, j))
    if -1 < i < (N - 1):
        V.append((i + 1, j))
    if 1 < j < N:
        V.append((i, j - 1))
    if -1 < j < (N - 1):
        V.append((i, j + 1))

    return V


def particule_presence(sigma, i, j, N):
    # vérifie dans les sites (voisinage) de i,j si on de trouve pas des 1

    V = site(i, j, N)

    for (ii, jj) in V:
        if sigma[ii][jj] == 1:
            return 1

    return 0


def Xt_2(N, s):
    # une matrice alé par l'algorithme de métropolise hasting
    sigma = np.zeros((N, N))
    N_1 = N - 1
    P = 0
    while not (P == s):
        i, j = np.random.randint(N, size=(2,))
        sigma[i][j] = 1 - sigma[i][j]
        if sigma[i][j] == 1:
            if particule_presence(sigma, i, j, N) == 1:
                sigma[i][j] = 0
            else:
                P += 1
        else:
            P -= 1

    return sigma


def mh(sigma0, K, N):
    # construction de la chaine de markov par la méthode de monté-carlo en utilisant l'algorithme
    # de métropolis-hasting
    # le if est le teste d'accepatation
    # plus le nombre de particule
    # la chaine commence a sigma_1 et le calcule de la densité commence sigma_0

    N2, N_1 = N * N, N - 1
    MC = [sigma0.copy()]
    sigma = sigma0

    for k in range(K):
        i, j = np.random.randint(N, size=(2,))
        sigma[i][j] = 1 - sigma[i][j]

        if sigma[i][j] == 1:
            if particule_presence(sigma, i, j, N) == 1:
                sigma[i][j] = 0

        MC.append(sigma.copy())
    return MC


def echiquier(N):
    # renvoie une matrice en configuration échiquier
    return np.fromfunction(lambda i, j: 1 - ((i + j) % 2), (N, N), dtype=int)


def choix(chaine, N):
    switcher = {
        "nulle": np.zeros((N, N)),
        "échiquier": echiquier(N),
        "aléa": Xt_2(N, np.random.randint((N * N) // 2 + (N % 2), size=(1,)[0])),
    }
    return switcher.get(chaine, np.eye(N))
