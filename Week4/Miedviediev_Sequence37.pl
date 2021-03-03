
%Визначити предикати для диференціювання тригонометричних функцій sin, cos, tg та ctg) та експоненти (e^Х).

% тестування
%  d(sin(x) + cos(x), x, Y).
%  Y =  (cos(x)*1)+(-sin(x)*1).

%  d(ctg(5*x)+2*tg(x), x, Y).
%  Y = 1/cos(x)^2*ctg(5*x)+2+((- (5*1)/sin(5*x)^2)+0)*tg(x).

% d(pow(e, 5*x) + ctg(x^3), x, Y).
% Y =  (e^(5*x)*(5*1))+(- (3*x^(3-1)*1)/sin(x^3)^2).


% dsin(U) / dx -> cos(U)*dU/dx
d(sin(U), X, cos(U)*W) :- d(U, X, W), !.

% dcos(U) / dx -> -sin(U)*dU/dx
d(cos(U), X, -sin(U)*W) :- d(U, X, W), !.

% dtg(U) / dx -> W / (cos(U))^2
d(tg(U), X, W / (cos(U)^2)) :- d(U, X, W), !.

% dctg(U) / dx -> -(W) / sin(U)^2
d(ctg(U), X, -(W) / (sin(U))^2) :- d(U, X, W), !.

% de^U / dx -> e^U * (dU / dx)
d(pow(e, U), X, e^(U) * W) :- d(U, X, W), !.




% Правила з файлу-прикладу


:-op(10,yfx,+).
:-op(9,fx,-).

% dx/dx->1
d(X,X,1) :- !.

% dc/dx ->0
d(C,_,0):-atomic(C), !.

% d(-U)/dx ->-(dU/dx)
d(-U,X,-A):-d(U,X,A), !.

% d(U+V)/dx -> dU/dx+dV/dx
d(U+V,X,A+B):-d(U,X,A),d(V,X,B), !.

% d(U-V)/dx -> dU/dx-dV/dx
d(U-V,X,A-B):-d(U,X,A),d(V,X,B), !.

% d(cU)/dx -> c(dU/dx)
d(C*U,X,C*A):-atomic(C),C\=X,d(U,X,A),!.

% d(UV)/dx -> U(dV/dx)+V(dU/dx)
d(U*V,X,B*U+A*V):-d(U,X,A),d(V,X,B), !.

%d(U/V)/dx -> d(UV^-1)/dx
d(U/V,X,A):-d(U*V^(-1),X,A), !.

%d(U^c)/dx -> cU^(c-1)(dU/dx)
d(U^C,X,C*U^(C-1)*W):-atomic(C),C\=X,d(U,X,W), !.

%d(lnU)/dx -> U^(-1)(dU/dx)
d(log(U),X,A*U^(-1)):-d(U,X,A), !.

% d(U(V))/dx -> (dV/dU)*dU/dx
d(U_V_X,X,DV*DU):-
	U_V_X=..[U,V_X],
	d(U_V_X,V_X,DU),
	d(V_X,X,DV), !.