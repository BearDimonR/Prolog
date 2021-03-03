% Завдання. Функції, елементарні за Кальманом
  %
  %Описати наступні функції
  %
  %Ціла частина та остача від ділення

  evklid(X, Y, Div, Rem) :- findDiv(X, Y, Div, 1), Rem is X - (Y * Div).
  findDiv(X, Y, Index, Index) :- X < Y * (Index + 1), !.
  findDiv(X, Y, Div, Index) :- NI is Index + 1, findDiv(X, Y, Div, NI).

  %Піднесення до степеню

  logpow(_, 0, 1) :- !.
  logpow(1, _, 1) :- !.
  % if y mod 2 == 0 then new_base = base * base
  logpow(X, Y, Z) :- Y mod 2 =:= 0, NY is Y / 2, NX is X * X, logpow(NX, NY, Z).
  % else just mult by base
  logpow(X, Y, Z) :- NY is Y - 1, logpow(X, NY, NZ), Z is NZ * X.

  %Ціла частина квадратного кореня

  roundsqr(X, Y) :- findsqr(X, Y, 0).
  findsqr(X, Res, Index) :- NIndex is Index + 1, X < (NIndex * NIndex), res(X, Res, Index, NIndex), !.
  findsqr(X, Y, Index):- NIndex is Index + 1, findsqr(X, Y, NIndex).
  res(X, Index, Index, NIndex) :- (X - (Index*Index)) < ((NIndex*NIndex) - X), !.
  res(_, NIndex, _, NIndex) :- !.
