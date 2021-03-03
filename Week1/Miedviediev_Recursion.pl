%Реалізувати обчислювані предикати:
%


% Ділення з остачею (лише для додатніх цілих чисел)- ціла частина та остача від ділення
%             (не використовувати вбудовані функції!).
% Використовувати оператори віднімання (-)

mod(X, Y, Div, Rem) :- modF(X, Y, Div, Rem, 0).
modF(X, Y, Res, X, Res) :- X < Y, !.
modF(X, Y, Div, Rem, Res) :- K is Res + 1, N is X - Y, modF(N, Y, Div, Rem, K).


% Піднесення до степеню (лінійне та логарифмічне)  - (не використовувати вбудовані функції!).
% Використовувати оператори (*, +, -, mod)

pow(_, 0, 1) :- !.
pow(1, _, 1) :- !.
pow(X, Y, Z) :- NY is Y - 1, pow(X, NY, NZ), Z is NZ * X.

logpow(_, 0, 1) :- !.
logpow(1, _, 1) :- !.
% if y mod 2 == 0 then new_base = base * base
logpow(X, Y, Z) :- Y mod 2 =:= 0, NY is Y / 2, NX is X * X, logpow(NX, NY, Z).
% else just mult by base
logpow(X, Y, Z) :- NY is Y - 1, logpow(X, NY, NZ), Z is NZ * X.


% Числа Фібоначчі (рекурсія)
fibonnachi(0, 1) :- !.
fibonnachi(1, 1) :- !.
fibonnachi(X, Y) :- fib(X, Y, 0, 1).
fib(2, Cur, _, Cur) :- !.
fib(X, Y, Pred, Cur) :- Next is Pred + Cur, I is X - 1, fib(I, Y, Cur, Next).


% Розклад числа на прості множники (виведення всіх простих множників числа)
% must be > 1
simplesplit(X) :- X =:= 1, write('end'), !.
simplesplit(X) :- findsplit(X, Y, 2), write(Y), write(','), NY is X/Y, simplesplit(NY).
findsplit(X, Z, Z) :- X mod Z =:= 0, !.
findsplit(X, Y, Z) :- NZ is Z + 1, findsplit(X, Y, NZ).


% Обрахувати сумму 1/1! + 1/2! + 1/3! + ... 1/n! за допомогою рекурентних співвідношень
sumfactorial(X, Y) :- makestep(X, Y, 1, 0, 0).
makestep(X, Sum, _, Index, Sum) :- Index >= X, !.
makestep(X, Y, Pred, Index, Sum) :- NIndex is Index + 1,
                                    NPred is Pred / NIndex,
                                    NSum is Sum + NPred,
                                    makestep(X,Y,NPred, NIndex, NSum).

% Алгоритм Евкліда (пошуку НСД).
nsd(X, Y, X) :- X =:= Y, !.
nsd(X, Y, NZ) :- X > Y, NX is X - Y, nsd(NX, Y, NZ).
nsd(X, Y, NZ) :- NY is Y - X, nsd(X, NY, NZ).
