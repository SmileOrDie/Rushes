                                                                                    in_mind([b,o,u,g,i,e]).

start:- write('4 gars ds 1 grote fermé. ya 1 bougie o fon 2 la grote. keski fon ? Eppelez la réponse.'),read(X),
in_mind([X|T]),write('OK. '),guess(T), nl.

guess([]):- write('Félicitation! La réponse est '),in_mind(W),write(W), nl, !.
guess(L):-  repeat,write('Lettre suivante'),read(X),
((L=[X|T1],write('OK. '),guess(T1));
(write('Faux! Réessayez '),guess(L))), nl.