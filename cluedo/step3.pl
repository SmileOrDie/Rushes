lancer :- resoudre(Resultat), nl, afficherEnsemble(Resultat).

valide([homme]).
valide([homme, loup]).
valide([homme, chevre]).
valide([homme, chou]).

invalide(Groupe) :- \+ member(homme, Groupe), member(loup, Groupe), member(chevre, Groupe).
invalide(Groupe) :- \+ member(homme, Groupe), member(chevre, Groupe), member(chou, Groupe).
possible(Groupe) :- \+ invalide(Groupe).

afficherEnsemble([]).
afficherEnsemble([H|List]) :- write(H),nl, afficherEnsemble(List).

resoudre(Resultat) :- Gauche = [homme, loup, chevre, chou], Droite = [], Mouvements = [], States = [Gauche], resoudre(Gauche, Droite, Mouvements, States, Resultat).
resoudre([], _, Mouvements, _, Resultat) :- reverse(Mouvements, Resultat).
resoudre(Gauche, Droite, Mouvements, States, Resultat) :- deplacement(Gauche, Droite, Nouveau_Gauche, Nouveau_Droite, Mouvement), \+ member(Nouveau_Gauche, States), resoudre(Nouveau_Gauche, Nouveau_Droite, [Mouvement|Mouvements], [Nouveau_Gauche|States], Resultat).

deplacement(Gauche, Droite, Nouveau_Gauche, Nouveau_Droite, mouvement_Droite(Passager)) :- valide(Passager), supprimer(Passager, Gauche, Nouveau_Gauche), possible(Nouveau_Gauche), ajouter(Passager, Droite, Nouveau_Droite).
deplacement(Gauche, Droite, Nouveau_Gauche, Nouveau_Droite, mouvement_Gauche(Passager)) :- valide(Passager), supprimer(Passager, Droite, Nouveau_Droite), possible(Nouveau_Droite), ajouter(Passager, Gauche, Nouveau_Gauche).

supprimer(X, Gauche, Nouveau_Gauche) :- mergeLists(X, Nouveau_Gauche, Gauche).

ajouter(X, Gauche, Nouveau_Gauche) :- mergeLists(X, Gauche, Nouveau_Gauche), mergeLists(Nouveau_Gauche, _, [homme, loup, chevre, chou]).

mergeLists([], [], []).
mergeLists([H|A], B, [H|C]) :- mergeLists(A, B, C).
mergeLists(A, [H|B], [H|C]) :- mergeLists(A, B, C).
