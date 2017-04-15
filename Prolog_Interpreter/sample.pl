male(suyash).
male(suman).
female(foo).
boy(X) :- male(X).

couple(shun,dan).

married(A,B) :- couple(B,A).
married(A,B) :- couple(A,B).

parent(A,B) :- child(B,A).

father(A,B) :- child(B,A),male(A).
mother(A,B) :- child(B,A),female(A).

wife(A,B) :- married(A,B),female(A),male(B).
husband(A,B) :- married(A,B),male(A),female(B).

son(A,B) :- child(A,B),male(A).
daughter(A,B) :- child(A,B),female(A).

brother(A,B) :- male(A),sibling(A,B).
sister(A,B) :- female(A),sibling(A,B).