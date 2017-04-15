couple(shun,dan).
couple(shun,shun).
dit(A,B) :- couple(A,B),not(A=B).
