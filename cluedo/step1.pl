homme(X) :- member(X, [marc, luc, jean, jules, leon, loic, gerard, jacques, herve, paul]).
femme(X) :- member(X, [anne, betty, lisa, sylvie, eve, julie, valerie]).
enfant_de(X, Y) :- member([Z, A], [[[jean, jules, leon], [marc, anne]], [[lisa, loic, gerard], [luc, betty]], [[jacques], [jules, lisa]], [[herve, julie], [leon, sylvie]], [[paul, valerie], [loic, eve]]]) , member(X, Z), member(Y, A).
femme_de(X, Y) :- member([X, Y], [[anne, marc], [betty, luc], [lisa, jules], [sylvie, leon], [eve, loic], [julie, paul]]).
mari_de(X, Y) :- femme_de(Y, X).
conjoint(X,Y) :- mari_de(X, Y) ; femme_de(X, Y).
beaupere_de(X, Y) :- conjoint(Y, Z) , enfant_de(Z, X).
bellemere_de(X,Y) :- beaupere_de(Z, Y) , femme_de(X, Z).
ancetre_de(X, Y) :- enfant_de(Y, X).
ancetre_de(X, Y) :- enfant_de(Z, X) , ancetre_de(Z ,Y). 
