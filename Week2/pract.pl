

fill(-1) :- !.
fill(X):-asserta(d(X)),X1 is X-1,fill(X1).

gen3(X):-d(A),
	 A>0,
	 1 is A mod 2,
	 d(B),
	 1 is B mod 2,
	 d(C),
	 1 is C mod 2,
	 X is A*100+B*10 +C,
	 0 is X mod (A*10+C).

gen4(X):-d(A),
	 A>0,
	 d(B),
         X is A*1000+A*100 + B*10 + B,
         Y is round(sqrt(X)),
         X is Y*Y.



