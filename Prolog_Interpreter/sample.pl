male(suyash).
male(suman).
male(sun).
male(suma).
female(foo).
boy(X) :- male(X).
couple(shun,dan).
couple(shun,shun).

married(A,B) :- couple(B,A),not(A\=B).
married(A,B) :- couple(A,B),not(A\=B).

dit(A,B) :- couple(A,B),not(A=B).

sibling(A,B) :- child(A,C),child(B,C),male(C),married(C,D),child(A,D),child(B,D),A\=B.

parent(A,B) :- child(B,A).

father(A,B) :- child(B,A),male(A).
mother(A,B) :- child(B,A),female(A).

wife(A,B) :- married(A,B),female(A),male(B).
husband(A,B) :- married(A,B),male(A),female(B).

son(A,B) :- child(A,B),male(A).
daughter(A,B) :- child(A,B),female(A).

brother(A,B) :- male(A),sibling(A,B).
sister(A,B) :- female(A),sibling(A,B).