resoudre(X) :- deplacer(X,gauche,droite,centre).
deplacer(1,X,Y,_) :- write('deplacer disque du haut de '), write(X), write(' vers '), write(Y), nl. 
deplacer(N,X,Y,Z) :- N>1, M is N-1, deplacer(M,X,Z,Y), deplacer(1,X,Y,_), deplacer(M,Z,Y,X). 