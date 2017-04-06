%Targaryen Males
male("Aegon V Targaryen").
male("Aerion Targaryen").
male("Aemon Targaryen").
male("Duncan Targaryen").
male("Aerys II Targaryen").
male("Daeron Targaryen").
male("Rhaegar Targaryen").
male("Viserys Targaryen").
male("Aegon Targaryen").
male("Rhaego").
male("Drogo").

%Stark Males
male("Rickard Stark").
male("Brandon Stark").
male("Eddard Stark").
male("Benjen Stark").
male("Robb Stark").
male("Tyrion Lannister").	
male("Ramsay Bolton").
male("Bran Stark").	
male("Rickon Stark").
male("Jon Snow").

%Targaryen Females
female("Rhaenys Targaryen").
female("Rhaella Targaryen").
female("Elia Martell").
female("Daenerys Targaryen").

%Stark Females
female("Catelyn Stark").
female("Lyanna Stark").
female("Lyarra Stark").
female("Talisa Stark").
female("Sansa Stark").
female("Arya Stark").	


%% Sibling
    %Targaryen Sibling
    %sibling("Aegon V Targaryen","Aerion Targaryen").
    %sibling("Aemon Targaryen","Aegon V Targaryen").

    %sibling("Duncan Targaryen","Aerys II Targaryen").
    %sibling("Aerys II Targaryen","Rhaella Targaryen").
    %sibling("Rhaella Targaryen","Daeron Targaryen").

    %sibling("Rhaegar Targaryen","Viserys Targaryen").
    %sibling("Viserys Targaryen","Daenerys Targaryen").

    %sibling("Rhaenys Targaryen","Aegon Targaryen").

    %Stark Sibling
    %sibling("Brandon Stark","Eddard Stark").
    %sibling("Eddard Stark","Lyanna Stark").
    %sibling("Lyanna Stark","Benjen Stark").

    %sibling("Robb Stark","Sansa Stark").
    %sibling("Sansa Stark","Arya Stark").
    %sibling("Arya Stark","Bran Stark").
    %sibling("Bran Stark","Rickon Stark").
%%

%Targaryen Parent
child("Duncan Targaryen","Aegon V Targaryen").
child("Aerys II Targaryen","Aegon V Targaryen").
child("Rhaella Targaryen","Aegon V Targaryen").
child("Daeron Targaryen","Aegon V Targaryen").
child("Rhaegar Targaryen","Aerys II Targaryen").
child("Viserys Targaryen","Aerys II Targaryen").
child("Daenerys Targaryen","Aerys II Targaryen").
child("Rhaegar Targaryen","Rhaella Targaryen").
child("Viserys Targaryen","Rhaella Targaryen").
child("Daenerys Targaryen","Rhaella Targaryen").
child("Rhaenys Targaryen","Rhaegar Targaryen").
child("Aegon Targaryen","Rhaegar Targaryen").
child("Rhaenys Targaryen","Elia Martell").
child("Aegon Targaryen","Elia Martell").
child("Rhaego","Daenerys Targaryen").
child("Rhaego","Drogo").

%Stark Parent
child("Brandon Stark","Rickard Stark").
child("Eddard Stark","Rickard Stark").
child("Lyanna Stark","Rickard Stark").
child("Benjen Stark","Rickard Stark").

child("Brandon Stark","Lyarra Stark").
child("Eddard Stark","Lyarra Stark").
child("Lyanna Stark","Lyarra Stark").
child("Benjen Stark","Lyarra Stark").

child("Robb Stark","Eddard Stark").
child("Sansa Stark","Eddard Stark").
child("Arya Stark","Eddard Stark").
child("Bran Stark","Eddard Stark").
child("Rickon Stark","Eddard Stark").
% Controversial
child("Jon Snow","Eddard Stark").

child("Robb Stark","Catelyn Stark").
child("Sansa Stark","Catelyn Stark").
child("Arya Stark","Catelyn Stark").
child("Bran Stark","Catelyn Stark").
child("Rickon Stark","Catelyn Stark").

%Targaryen Couples
couple("Aerys II Targaryen","Rhaella Targaryen").
couple("Daenerys Targaryen","Drogo").
couple("Elia Martell","Rhaegar Targaryen").

%Stark Couples
couple("Rickard Stark","Lyarra Stark").
couple("Eddard Stark","Catelyn Stark").
couple("Robb Stark","Talisa Stark").
couple("Tyrion Lannister","Sansa Stark").
couple("Ramsay Bolton","Sansa Stark").


%Rules

married(A,B) :- couple(B,A).
married(A,B) :- couple(A,B).

% Why not working?
sibling(A,B) :- child(A,C),child(B,C),male(C),married(C,D),child(A,D),child(B,D),A\=B.

%sibling(A,B) :- child(A,C),child(B,C),child(A,D),child(B,D),A\=B,C\=D.

parent(A,B) :- child(B,A).

father(A,B) :- child(B,A),male(A).
mother(A,B) :- child(B,A),female(A).

wife(A,B) :- married(A,B),female(A),male(B).
husband(A,B) :- married(A,B),male(A),female(B).

son(A,B) :- child(A,B),male(A).
daughter(A,B) :- child(A,B),female(A).

brother(A,B) :- male(A),sibling(A,B).
sister(A,B) :- female(A),sibling(A,B).

bastard(A,B) :- child(A,B),married(B,C),not(child(A,C)).

grandfather(A,B) :- child(B,C) , child(C,A), male(A).
grandmother(A,B) :- child(B,C) , child(C,A), female(A).

granddaughter(A,B) :- grandfather(B,A),female(A).
granddaughter(A,B) :- grandmother(B,A),female(A).

grandson(A,B) :- grandmother(B,A),male(A).
grandson(A,B) :- grandfather(B,A),male(A).

brother_in_law(A,B) :- male(A),sister(C,B),married(A,C).
sister_in_law(A,B) :- female(A),brother(C,B),married(A,C).

in_law(A,B) :- sibling(C,B),married(A,C).

uncle(A,B) :- male(A),child(B,C) , sibling(A,C).
uncle(A,B) :- male(A),child(B,C) , in_law(A,C).
aunt(A,B) :- female(A),child(B,C) , sibling(A,C).
aunt(A,B) :- female(A),child(B,C) , in_law(A,C).

grandparent(A,B) :- grandfather(A,B).
grandparent(A,B) :- grandmother(A,B).

ancestor(A,B):- grandparent(A,B).
ancestor(A,B):- parent(C,B), ancestor(A,C).

first_cousin(A,B) :- parent(C,A),sibling(C,D),parent(D,B).

nephew(A,B) :- male(A),parent(C,A),sibling(C,B).
nephew(A,B) :- male(A),parent(C,A),in_law(C,B).
neice(A,B) :- female(A),parent(C,A),sibling(C,B).
neice(A,B) :- female(A),parent(C,A),in_law(C,B).