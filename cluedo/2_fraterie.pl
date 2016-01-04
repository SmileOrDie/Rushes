fraterie(X) :- 
member(X, [sylvie, tom, jules]).

membre_fraterie(X) :- 
fraterie(X), 
write(X), nl.