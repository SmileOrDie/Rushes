individus(0, []) :- !.
individus(N, [(_NAT, _COU, _BOI, _CIG, _ANI)| T]) :- N1 is N-1, individus(N1,T).
individu(1, [H|_], H) :- !.
individu(N, [_|T], R) :- N1 is N-1, individu(N1, T, R).
indice1([(anglais, rouge, _, _, _)|_]).
indice1([_|T]) :- indice1(T).
indice2([(suedois, _, _, _, chiens)|_]).
indice2([_|T]) :- indice2(T).
indice3([(danois, _, the, _, _)|_]).
indice3([_|T]) :- indice3(T).
indice4([(_, vert, _, _, _),(_, blanche, _, _, _)|_]).
indice4([_|T]) :- indice4(T).
indice5([(_, vert, cafe, _, _)|_]).
indice5([_|T]) :- indice5(T).
indice6([(_, _, _, pallmall, oiseaux)|_]).
indice6([_|T]) :- indice6(T).
indice7([(_, jaune, _, dunhill, _)|_]).
indice7([_|T]) :- indice7(T).
indice8(X) :- individu(3,X, (_, _, lait, _, _)).
indice9(X) :- individu(1,X, (norvegien, _, _, _, _)).
indice10([(_, _, _, blend, _),(_, _, _, _, chats)|_]).
indice10([(_, _, _, _, chats),(_, _, _, blend, _)|_]).
indice10([_|T]) :- indice10(T).
indice11([(_, _, _, dunhill, _),(_, _, _, _, cheval)|_]).
indice11([(_, _, _, _, cheval),(_, _, _, dunhill, _)|_]).
indice11([_|T]) :- indice11(T).
indice12([(_, _, biere, bluemaster, _)|_]).
indice12([_|T]) :- indice12(T).
indice13([(allemand, _, _, prince, _)|_]).
indice13([_|T]) :- indice13(T).
indice14([(norvegien, _, _, _, _),(_, bleue, _, _, _)|_]).
indice14([(_, bleu, _, _, _),(norvegien, _, _, _, _)|_]).
indice14([_|T]) :- indice14(T).
indice15([(_, _, _, blend, _),(_, _, eau, _, _)|_]).
indice15([(_, _, eau, _, _),(_, _, _, blend, _)|_]).
indice15([_|T]) :- indice15(T).
question([(_, _, _, _, poisson)|_]).
question([_|T]) :- question(T).
solution(X) :- individus(5, X), indice1(X), indice2(X), indice3(X), indice4(X), indice5(X), indice6(X), indice7(X), indice8(X), indice9(X), indice10(X), indice11(X), indice12(X), indice13(X), indice14(X), indice15(X), question(X).