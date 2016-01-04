                                                                                    in_mind([c,o,u,t,e,a,u]).

start:- write('La pomme 2 rome. coment on lapel ? Eppelez la réponse.'),read(X),
in_mind([X|T]),write('OK. '),guess(T), nl.

guess([]):- write('Félicitation! La réponse est '),in_mind(W),write(W), nl, !.
guess(L):-  repeat,write('Lettre suivante'),read(X),
((L=[X|T1],write('OK. '),guess(T1));
(write('Faux! Réessayez '),guess(L))), nl.