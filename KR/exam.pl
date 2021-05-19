

arc(1, 2).
arc(1, 3).
arc(4, 2).
arc(3, 4).
conn(X, X).
conn(X, Z):- arc(X,Y), conn(Y, Z).